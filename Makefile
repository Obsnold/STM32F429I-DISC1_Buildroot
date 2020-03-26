system_image = stm32f769i-disco_system.uImage
dir_configs = configs
dir_buildroot = buildroot

build:
	cp $(dir_configs)/buildroot $(dir_buildroot)/.config
	make -j$(nproc) -C $(dir_buildroot)

flash:
	cd $(dir_buildroot)/output/build/host-openocd-0.10.0/tcl && ../../../host/usr/bin/openocd \
	-f board/stm32f429disc1.cfg \
	-c "init" \
	-c "reset init" \
	-c "flash probe 0" \
	-c "flash info 0" \
	-c "flash write_image erase ../../../images/stm32f429i-disco.bin 0x08000000" \
	-c "flash write_image erase ../../../images/stm32f429-disc1.dtb 0x08004000" \
	-c "flash write_image erase ../../../images/xipImage 0x08008000" \
	-c "reset run" -c shutdown

clean:
	make clean -C $(dir_buildroot)
