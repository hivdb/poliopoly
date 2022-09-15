build: bin/poliopoly bin/poliopoly_internal
	@docker build -t hivdb/poliopoly:latest .

release: build
	@docker push hivdb/poliopoly:latest

poliopoly-work:
	@docker volume create poliopoly-work >/dev/null 2>/dev/null || true

inspect: poliopoly-work
	@docker run --rm -it \
		--privileged \
		--mount source=poliopoly-work,target=/work \
		--mount type=bind,source=$(PWD)/local,target=/local \
		--mount type=bind,source=$(PWD)/refs,target=/refs \
		--entrypoint bash \
		hivdb/poliopoly:latest

bin/poliopoly: bin_fragment/poliopoly_argparse bin_fragment/poliopoly
	@mkdir -p bin/
	@cat bin_fragment/poliopoly_argparse > bin/poliopoly
	@cat bin_fragment/poliopoly >> bin/poliopoly
	@chmod +x bin/poliopoly

bin/poliopoly_internal: bin_fragment/poliopoly_argparse bin_fragment/poliopoly_internal
	@mkdir -p bin/
	@cat bin_fragment/poliopoly_argparse > bin/poliopoly_internal
	@cat bin_fragment/poliopoly_internal >> bin/poliopoly_internal
	@chmod +x bin/poliopoly_internal

.PHONY: build poliopoly-work inspect
