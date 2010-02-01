From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] OMAP2/3: update default defconfig, towards smaller kernel
Date: Mon, 1 Feb 2010 10:09:01 -0600
Message-ID: <001801caa358$decb37b0$544ff780@am.dhcp.ti.com>
References: <1264811216-25989-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48066 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371Ab0BAQJE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Feb 2010 11:09:04 -0500
In-Reply-To: <1264811216-25989-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, January 29, 2010 6:27 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] OMAP2/3: update default defconfig, towards smaller kernel
> 
> Update omap3_defconfig to work towards a minimal kernel by building
> most things as modules.  Some drivers that cannot currently be built
> as modules and need to be fixed:
> 
> - MMC: platform code uses MMC core regulator functions directly

The below series posted to LO by Adrian fixes this issue. The core regulator
calls are moved into the controller driver.

[PATCH V2 0/10] omap_hsmmc changes V2

Regards,
Madhu


> - ASoC: drivers call omap_ctrl_[read|write] directly
> 
> In addition some additional changes:
> 
> - use new SLUB allocator instead of SLAB (increased debugability)
> - compile with PREEMPT enabled by default
> - disable OABI_COMPAT.  We should not pretend to support this IMHO
> - disable CPUfreq: not yet supported in mainline
> - disable PM_DEBUG_VERBOSE
> - enable fb/DSS2 as modules
> - disable Kprobes
> 
> zImage size comparison
> before: 3160272
> after:  2610108
> 
> Some ideas for reducing this further:
> - fix MMC and ASoC, then build those as modules
> - disable all the kernel debug features
> - convert MTD and all flash fs to modules
> 
> Then, we should have platform specific initramfs configs so rootfs
> from flash, MMC, etc. could be done using modules in initramfs.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/configs/omap3_defconfig |  215 ++++++++++++++++++++-------------
> -----
>  1 files changed, 112 insertions(+), 103 deletions(-)
> 
> diff --git a/arch/arm/configs/omap3_defconfig
> b/arch/arm/configs/omap3_defconfig
> index 2bc80d7..247f191 100644
> --- a/arch/arm/configs/omap3_defconfig
> +++ b/arch/arm/configs/omap3_defconfig
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
>  # Linux kernel version: 2.6.33-rc5
> -# Tue Jan 26 11:05:31 2010
> +# Fri Jan 29 16:02:40 2010
>  #
>  CONFIG_ARM=y
>  CONFIG_SYS_SUPPORTS_APM_EMULATION=y
> @@ -32,6 +32,7 @@ CONFIG_CONSTRUCTORS=y
>  #
>  CONFIG_EXPERIMENTAL=y
>  CONFIG_BROKEN_ON_SMP=y
> +CONFIG_LOCK_KERNEL=y
>  CONFIG_INIT_ENV_ARG_LIMIT=32
>  CONFIG_LOCALVERSION=""
>  CONFIG_LOCALVERSION_AUTO=y
> @@ -105,16 +106,16 @@ CONFIG_AIO=y
>  # Kernel Performance Events And Counters
>  #
>  CONFIG_VM_EVENT_COUNTERS=y
> +# CONFIG_SLUB_DEBUG is not set
>  CONFIG_COMPAT_BRK=y
> -CONFIG_SLAB=y
> -# CONFIG_SLUB is not set
> +# CONFIG_SLAB is not set
> +CONFIG_SLUB=y
>  # CONFIG_SLOB is not set
>  CONFIG_PROFILING=y
>  CONFIG_TRACEPOINTS=y
> -CONFIG_OPROFILE=y
> +CONFIG_OPROFILE=m
>  CONFIG_HAVE_OPROFILE=y
> -CONFIG_KPROBES=y
> -CONFIG_KRETPROBES=y
> +# CONFIG_KPROBES is not set
>  CONFIG_HAVE_KPROBES=y
>  CONFIG_HAVE_KRETPROBES=y
>  CONFIG_HAVE_CLK=y
> @@ -125,7 +126,6 @@ CONFIG_HAVE_CLK=y
>  # CONFIG_GCOV_KERNEL is not set
>  # CONFIG_SLOW_WORK is not set
>  CONFIG_HAVE_GENERIC_DMA_COHERENT=y
> -CONFIG_SLABINFO=y
>  CONFIG_RT_MUTEXES=y
>  CONFIG_BASE_SMALL=0
>  CONFIG_MODULES=y
> @@ -251,7 +251,7 @@ CONFIG_OMAP_MUX=y
>  CONFIG_OMAP_MUX_DEBUG=y
>  CONFIG_OMAP_MUX_WARNINGS=y
>  CONFIG_OMAP_MCBSP=y
> -# CONFIG_OMAP_MBOX_FWK is not set
> +CONFIG_OMAP_MBOX_FWK=m
>  # CONFIG_OMAP_MPU_TIMER is not set
>  CONFIG_OMAP_32K_TIMER=y
>  CONFIG_OMAP_32K_TIMER_HZ=128
> @@ -354,13 +354,14 @@ CONFIG_VMSPLIT_3G=y
>  # CONFIG_VMSPLIT_2G is not set
>  # CONFIG_VMSPLIT_1G is not set
>  CONFIG_PAGE_OFFSET=0xC0000000
> -CONFIG_PREEMPT_NONE=y
> +# CONFIG_PREEMPT_NONE is not set
>  # CONFIG_PREEMPT_VOLUNTARY is not set
> -# CONFIG_PREEMPT is not set
> +CONFIG_PREEMPT=y
>  CONFIG_HZ=128
>  # CONFIG_THUMB2_KERNEL is not set
>  CONFIG_AEABI=y
> -CONFIG_OABI_COMPAT=y
> +# CONFIG_OABI_COMPAT is not set
> +CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
>  # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
>  # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
>  # CONFIG_HIGHMEM is not set
> @@ -394,21 +395,12 @@ CONFIG_ATAGS_PROC=y
>  #
>  # CPU Power Management
>  #
> -CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_TABLE=y
> -# CONFIG_CPU_FREQ_DEBUG is not set
> -CONFIG_CPU_FREQ_STAT=y
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
> -CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> +# CONFIG_CPU_FREQ is not set
> +# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
>  # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
>  # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
>  # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
>  # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> -CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> -# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
> -CONFIG_CPU_FREQ_GOV_USERSPACE=y
> -CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> -# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
>  # CONFIG_CPU_IDLE is not set
> 
>  #
> @@ -439,11 +431,10 @@ CONFIG_BINFMT_MISC=y
>  #
>  CONFIG_PM=y
>  CONFIG_PM_DEBUG=y
> -CONFIG_PM_VERBOSE=y
> +# CONFIG_PM_VERBOSE is not set
>  CONFIG_CAN_PM_TRACE=y
>  CONFIG_PM_SLEEP=y
>  CONFIG_SUSPEND=y
> -# CONFIG_PM_TEST_SUSPEND is not set
>  CONFIG_SUSPEND_FREEZER=y
>  # CONFIG_APM_EMULATION is not set
>  # CONFIG_PM_RUNTIME is not set
> @@ -539,32 +530,31 @@ CONFIG_NETFILTER_ADVANCED=y
>  # Network testing
>  #
>  # CONFIG_NET_PKTGEN is not set
> -# CONFIG_NET_TCPPROBE is not set
>  # CONFIG_NET_DROP_MONITOR is not set
>  # CONFIG_HAMRADIO is not set
>  # CONFIG_CAN is not set
>  # CONFIG_IRDA is not set
> -CONFIG_BT=y
> -CONFIG_BT_L2CAP=y
> -CONFIG_BT_SCO=y
> -CONFIG_BT_RFCOMM=y
> +CONFIG_BT=m
> +CONFIG_BT_L2CAP=m
> +CONFIG_BT_SCO=m
> +CONFIG_BT_RFCOMM=m
>  CONFIG_BT_RFCOMM_TTY=y
> -CONFIG_BT_BNEP=y
> +CONFIG_BT_BNEP=m
>  CONFIG_BT_BNEP_MC_FILTER=y
>  CONFIG_BT_BNEP_PROTO_FILTER=y
> -CONFIG_BT_HIDP=y
> +CONFIG_BT_HIDP=m
> 
>  #
>  # Bluetooth device drivers
>  #
>  # CONFIG_BT_HCIBTUSB is not set
>  # CONFIG_BT_HCIBTSDIO is not set
> -CONFIG_BT_HCIUART=y
> +CONFIG_BT_HCIUART=m
>  CONFIG_BT_HCIUART_H4=y
>  CONFIG_BT_HCIUART_BCSP=y
>  CONFIG_BT_HCIUART_LL=y
> -CONFIG_BT_HCIBCM203X=y
> -CONFIG_BT_HCIBPA10X=y
> +CONFIG_BT_HCIBCM203X=m
> +CONFIG_BT_HCIBPA10X=m
>  # CONFIG_BT_HCIBFUSB is not set
>  # CONFIG_BT_HCIVHCI is not set
>  # CONFIG_BT_MRVL is not set
> @@ -672,7 +662,6 @@ CONFIG_MTD_CFI_UTIL=y
>  # CONFIG_MTD_COMPLEX_MAPPINGS is not set
>  # CONFIG_MTD_PHYSMAP is not set
>  # CONFIG_MTD_ARM_INTEGRATOR is not set
> -CONFIG_MTD_OMAP_NOR=y
>  # CONFIG_MTD_PLATRAM is not set
> 
>  #
> @@ -770,7 +759,7 @@ CONFIG_HAVE_IDE=y
>  # SCSI device support
>  #
>  # CONFIG_RAID_ATTRS is not set
> -CONFIG_SCSI=y
> +CONFIG_SCSI=m
>  CONFIG_SCSI_DMA=y
>  # CONFIG_SCSI_TGT is not set
>  # CONFIG_SCSI_NETLINK is not set
> @@ -779,7 +768,7 @@ CONFIG_SCSI_PROC_FS=y
>  #
>  # SCSI support type (disk, tape, CD-ROM)
>  #
> -CONFIG_BLK_DEV_SD=y
> +CONFIG_BLK_DEV_SD=m
>  # CONFIG_CHR_DEV_ST is not set
>  # CONFIG_CHR_DEV_OSST is not set
>  # CONFIG_BLK_DEV_SR is not set
> @@ -844,7 +833,7 @@ CONFIG_SMC91X=y
>  # CONFIG_DM9000 is not set
>  # CONFIG_ENC28J60 is not set
>  # CONFIG_ETHOC is not set
> -# CONFIG_SMC911X is not set
> +CONFIG_SMC911X=y
>  CONFIG_SMSC911X=y
>  # CONFIG_DNET is not set
>  # CONFIG_IBM_NEW_EMAC_ZMII is not set
> @@ -872,9 +861,9 @@ CONFIG_WLAN=y
>  # CONFIG_B43LEGACY is not set
>  # CONFIG_HOSTAP is not set
>  # CONFIG_IWM is not set
> -CONFIG_LIBERTAS=y
> -CONFIG_LIBERTAS_USB=y
> -CONFIG_LIBERTAS_SDIO=y
> +CONFIG_LIBERTAS=m
> +CONFIG_LIBERTAS_USB=m
> +CONFIG_LIBERTAS_SDIO=m
>  # CONFIG_LIBERTAS_SPI is not set
>  CONFIG_LIBERTAS_DEBUG=y
>  # CONFIG_P54_COMMON is not set
> @@ -893,25 +882,25 @@ CONFIG_LIBERTAS_DEBUG=y
>  # CONFIG_USB_KAWETH is not set
>  # CONFIG_USB_PEGASUS is not set
>  # CONFIG_USB_RTL8150 is not set
> -CONFIG_USB_USBNET=y
> -CONFIG_USB_NET_AX8817X=y
> -CONFIG_USB_NET_CDCETHER=y
> +CONFIG_USB_USBNET=m
> +CONFIG_USB_NET_AX8817X=m
> +CONFIG_USB_NET_CDCETHER=m
>  # CONFIG_USB_NET_CDC_EEM is not set
>  # CONFIG_USB_NET_DM9601 is not set
>  # CONFIG_USB_NET_SMSC95XX is not set
>  # CONFIG_USB_NET_GL620A is not set
> -CONFIG_USB_NET_NET1080=y
> +CONFIG_USB_NET_NET1080=m
>  # CONFIG_USB_NET_PLUSB is not set
>  # CONFIG_USB_NET_MCS7830 is not set
>  # CONFIG_USB_NET_RNDIS_HOST is not set
> -CONFIG_USB_NET_CDC_SUBSET=y
> +CONFIG_USB_NET_CDC_SUBSET=m
>  CONFIG_USB_ALI_M5632=y
>  CONFIG_USB_AN2720=y
>  CONFIG_USB_BELKIN=y
>  CONFIG_USB_ARMLINUX=y
>  CONFIG_USB_EPSON2888=y
>  CONFIG_USB_KC2190=y
> -CONFIG_USB_NET_ZAURUS=y
> +CONFIG_USB_NET_ZAURUS=m
>  # CONFIG_USB_NET_INT51X1 is not set
>  # CONFIG_WAN is not set
>  # CONFIG_PPP is not set
> @@ -933,11 +922,11 @@ CONFIG_INPUT=y
>  #
>  # Userland interfaces
>  #
> -CONFIG_INPUT_MOUSEDEV=y
> +CONFIG_INPUT_MOUSEDEV=m
>  CONFIG_INPUT_MOUSEDEV_PSAUX=y
>  CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>  CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> -CONFIG_INPUT_JOYDEV=y
> +CONFIG_INPUT_JOYDEV=m
>  CONFIG_INPUT_EVDEV=y
>  # CONFIG_INPUT_EVBUG is not set
> 
> @@ -961,7 +950,7 @@ CONFIG_KEYBOARD_GPIO=y
>  CONFIG_KEYBOARD_TWL4030=y
>  # CONFIG_KEYBOARD_XTKBD is not set
>  CONFIG_INPUT_MOUSE=y
> -CONFIG_MOUSE_PS2=y
> +CONFIG_MOUSE_PS2=m
>  CONFIG_MOUSE_PS2_ALPS=y
>  CONFIG_MOUSE_PS2_LOGIPS2PP=y
>  CONFIG_MOUSE_PS2_SYNAPTICS=y
> @@ -978,7 +967,7 @@ CONFIG_MOUSE_PS2_TRACKPOINT=y
>  # CONFIG_INPUT_JOYSTICK is not set
>  # CONFIG_INPUT_TABLET is not set
>  CONFIG_INPUT_TOUCHSCREEN=y
> -CONFIG_TOUCHSCREEN_ADS7846=y
> +CONFIG_TOUCHSCREEN_ADS7846=m
>  # CONFIG_TOUCHSCREEN_AD7877 is not set
>  # CONFIG_TOUCHSCREEN_AD7879_I2C is not set
>  # CONFIG_TOUCHSCREEN_AD7879_SPI is not set
> @@ -1037,7 +1026,7 @@ CONFIG_DEVKMEM=y
>  #
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> -CONFIG_SERIAL_8250_NR_UARTS=32
> +CONFIG_SERIAL_8250_NR_UARTS=4
>  CONFIG_SERIAL_8250_RUNTIME_UARTS=4
>  CONFIG_SERIAL_8250_EXTENDED=y
>  CONFIG_SERIAL_8250_MANY_PORTS=y
> @@ -1055,9 +1044,9 @@ CONFIG_UNIX98_PTYS=y
>  # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
>  # CONFIG_LEGACY_PTYS is not set
>  # CONFIG_IPMI_HANDLER is not set
> -CONFIG_HW_RANDOM=y
> +CONFIG_HW_RANDOM=m
>  # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> -CONFIG_HW_RANDOM_OMAP=y
> +CONFIG_HW_RANDOM_OMAP=m
>  # CONFIG_R3964 is not set
>  # CONFIG_RAW_DRIVER is not set
>  # CONFIG_TCG_TPM is not set
> @@ -1110,7 +1099,7 @@ CONFIG_SPI_MASTER=y
>  #
>  # CONFIG_SPI_BITBANG is not set
>  # CONFIG_SPI_GPIO is not set
> -CONFIG_SPI_OMAP24XX=y
> +CONFIG_SPI_OMAP24XX=m
>  # CONFIG_SPI_XILINX is not set
>  # CONFIG_SPI_DESIGNWARE is not set
> 
> @@ -1156,7 +1145,7 @@ CONFIG_GPIO_TWL4030=y
>  #
>  # AC97 GPIO expanders:
>  #
> -CONFIG_W1=y
> +CONFIG_W1=m
>  CONFIG_W1_CON=y
> 
>  #
> @@ -1177,14 +1166,14 @@ CONFIG_W1_CON=y
>  # CONFIG_W1_SLAVE_DS2433 is not set
>  # CONFIG_W1_SLAVE_DS2760 is not set
>  # CONFIG_W1_SLAVE_BQ27000 is not set
> -CONFIG_POWER_SUPPLY=y
> +CONFIG_POWER_SUPPLY=m
>  # CONFIG_POWER_SUPPLY_DEBUG is not set
>  # CONFIG_PDA_POWER is not set
>  # CONFIG_BATTERY_DS2760 is not set
>  # CONFIG_BATTERY_DS2782 is not set
>  # CONFIG_BATTERY_BQ27x00 is not set
>  # CONFIG_BATTERY_MAX17040 is not set
> -CONFIG_HWMON=y
> +CONFIG_HWMON=m
>  # CONFIG_HWMON_VID is not set
>  # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> @@ -1264,8 +1253,8 @@ CONFIG_WATCHDOG_NOWAYOUT=y
>  # Watchdog Device Drivers
>  #
>  # CONFIG_SOFT_WATCHDOG is not set
> -CONFIG_OMAP_WATCHDOG=y
> -CONFIG_TWL4030_WATCHDOG=y
> +CONFIG_OMAP_WATCHDOG=m
> +CONFIG_TWL4030_WATCHDOG=m
> 
>  #
>  # USB-based Watchdog Cards
> @@ -1289,7 +1278,7 @@ CONFIG_MFD_CORE=y
>  # CONFIG_TPS65010 is not set
>  # CONFIG_MENELAUS is not set
>  CONFIG_TWL4030_CORE=y
> -# CONFIG_TWL4030_POWER is not set
> +CONFIG_TWL4030_POWER=y
>  CONFIG_TWL4030_CODEC=y
>  # CONFIG_MFD_TMIO is not set
>  # CONFIG_MFD_T7L66XB is not set
> @@ -1325,13 +1314,13 @@ CONFIG_REGULATOR_TWL4030=y
>  #
>  # CONFIG_VGASTATE is not set
>  # CONFIG_VIDEO_OUTPUT_CONTROL is not set
> -CONFIG_FB=y
> +CONFIG_FB=m
>  CONFIG_FIRMWARE_EDID=y
>  # CONFIG_FB_DDC is not set
>  # CONFIG_FB_BOOT_VESA_SUPPORT is not set
> -CONFIG_FB_CFB_FILLRECT=y
> -CONFIG_FB_CFB_COPYAREA=y
> -CONFIG_FB_CFB_IMAGEBLIT=y
> +CONFIG_FB_CFB_FILLRECT=m
> +CONFIG_FB_CFB_COPYAREA=m
> +CONFIG_FB_CFB_IMAGEBLIT=m
>  # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
>  # CONFIG_FB_SYS_FILLRECT is not set
>  # CONFIG_FB_SYS_COPYAREA is not set
> @@ -1354,25 +1343,38 @@ CONFIG_FB_TILEBLITTING=y
>  # CONFIG_FB_METRONOME is not set
>  # CONFIG_FB_MB862XX is not set
>  # CONFIG_FB_BROADSHEET is not set
> -CONFIG_FB_OMAP=y
>  CONFIG_FB_OMAP_LCD_VGA=y
> -# CONFIG_FB_OMAP_031M3R is not set
> -# CONFIG_FB_OMAP_048M3R is not set
> -CONFIG_FB_OMAP_079M3R=y
> -# CONFIG_FB_OMAP_092M9R is not set
> -# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
> -# CONFIG_FB_OMAP_LCD_MIPID is not set
>  # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> -CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
> -# CONFIG_OMAP2_DSS is not set
> +CONFIG_OMAP2_VRAM=y
> +CONFIG_OMAP2_VRFB=y
> +CONFIG_OMAP2_DSS=m
> +CONFIG_OMAP2_VRAM_SIZE=4
> +CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
> +# CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS is not set
> +# CONFIG_OMAP2_DSS_RFBI is not set
> +CONFIG_OMAP2_DSS_VENC=y
> +# CONFIG_OMAP2_DSS_SDI is not set
> +# CONFIG_OMAP2_DSS_DSI is not set
> +# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
> +CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0
> +CONFIG_FB_OMAP2=m
> +CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
> +# CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE is not set
> +CONFIG_FB_OMAP2_NUM_FBS=3
> +
> +#
> +# OMAP2/3 Display Device Drivers
> +#
> +CONFIG_PANEL_GENERIC=m
> +CONFIG_PANEL_SHARP_LS037V7DW01=m
>  CONFIG_BACKLIGHT_LCD_SUPPORT=y
> -CONFIG_LCD_CLASS_DEVICE=y
> +CONFIG_LCD_CLASS_DEVICE=m
>  # CONFIG_LCD_LMS283GF05 is not set
>  # CONFIG_LCD_LTV350QV is not set
>  # CONFIG_LCD_ILI9320 is not set
>  # CONFIG_LCD_TDO24M is not set
>  # CONFIG_LCD_VGG2432A4 is not set
> -CONFIG_LCD_PLATFORM=y
> +CONFIG_LCD_PLATFORM=m
>  CONFIG_BACKLIGHT_CLASS_DEVICE=y
>  CONFIG_BACKLIGHT_GENERIC=y
> 
> @@ -1390,7 +1392,7 @@ CONFIG_DISPLAY_SUPPORT=y
>  #
>  # CONFIG_VGA_CONSOLE is not set
>  CONFIG_DUMMY_CONSOLE=y
> -CONFIG_FRAMEBUFFER_CONSOLE=y
> +CONFIG_FRAMEBUFFER_CONSOLE=m
>  # CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
>  CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
>  CONFIG_FONTS=y
> @@ -1414,13 +1416,13 @@ CONFIG_SOUND_OSS_CORE_PRECLAIM=y
>  CONFIG_SND=y
>  CONFIG_SND_TIMER=y
>  CONFIG_SND_PCM=y
> -CONFIG_SND_HWDEP=y
> -CONFIG_SND_RAWMIDI=y
> +CONFIG_SND_HWDEP=m
> +CONFIG_SND_RAWMIDI=m
>  CONFIG_SND_JACK=y
>  # CONFIG_SND_SEQUENCER is not set
>  CONFIG_SND_OSSEMUL=y
> -CONFIG_SND_MIXER_OSS=y
> -CONFIG_SND_PCM_OSS=y
> +CONFIG_SND_MIXER_OSS=m
> +CONFIG_SND_PCM_OSS=m
>  CONFIG_SND_PCM_OSS_PLUGINS=y
>  # CONFIG_SND_HRTIMER is not set
>  # CONFIG_SND_DYNAMIC_MINORS is not set
> @@ -1443,7 +1445,7 @@ CONFIG_SND_DRIVERS=y
>  CONFIG_SND_ARM=y
>  CONFIG_SND_SPI=y
>  CONFIG_SND_USB=y
> -CONFIG_SND_USB_AUDIO=y
> +CONFIG_SND_USB_AUDIO=m
>  # CONFIG_SND_USB_CAIAQ is not set
>  CONFIG_SND_SOC=y
>  CONFIG_SND_OMAP_SOC=y
> @@ -1468,11 +1470,17 @@ CONFIG_HID=y
>  #
>  # USB Input Devices
>  #
> -CONFIG_USB_HID=y
> +CONFIG_USB_HID=m
>  # CONFIG_HID_PID is not set
>  # CONFIG_USB_HIDDEV is not set
> 
>  #
> +# USB HID Boot Protocol drivers
> +#
> +# CONFIG_USB_KBD is not set
> +# CONFIG_USB_MOUSE is not set
> +
> +#
>  # Special HID drivers
>  #
>  # CONFIG_HID_A4TECH is not set
> @@ -1506,7 +1514,7 @@ CONFIG_USB_SUPPORT=y
>  CONFIG_USB_ARCH_HAS_HCD=y
>  CONFIG_USB_ARCH_HAS_OHCI=y
>  CONFIG_USB_ARCH_HAS_EHCI=y
> -CONFIG_USB=y
> +CONFIG_USB=m
>  CONFIG_USB_DEBUG=y
>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> @@ -1520,7 +1528,7 @@ CONFIG_USB_SUSPEND=y
>  CONFIG_USB_OTG=y
>  # CONFIG_USB_OTG_WHITELIST is not set
>  # CONFIG_USB_OTG_BLACKLIST_HUB is not set
> -CONFIG_USB_MON=y
> +CONFIG_USB_MON=m
>  # CONFIG_USB_WUSB is not set
>  # CONFIG_USB_WUSB_CBAF is not set
> 
> @@ -1537,7 +1545,7 @@ CONFIG_USB_MON=y
>  # CONFIG_USB_SL811_HCD is not set
>  # CONFIG_USB_R8A66597_HCD is not set
>  # CONFIG_USB_HWA_HCD is not set
> -CONFIG_USB_MUSB_HDRC=y
> +CONFIG_USB_MUSB_HDRC=m
>  CONFIG_USB_MUSB_SOC=y
> 
>  #
> @@ -1558,7 +1566,7 @@ CONFIG_USB_MUSB_DEBUG=y
>  #
>  # CONFIG_USB_ACM is not set
>  # CONFIG_USB_PRINTER is not set
> -CONFIG_USB_WDM=y
> +CONFIG_USB_WDM=m
>  # CONFIG_USB_TMC is not set
> 
>  #
> @@ -1568,7 +1576,7 @@ CONFIG_USB_WDM=y
>  #
>  # also be needed; see USB_STORAGE Help for more info
>  #
> -CONFIG_USB_STORAGE=y
> +CONFIG_USB_STORAGE=m
>  # CONFIG_USB_STORAGE_DEBUG is not set
>  # CONFIG_USB_STORAGE_DATAFAB is not set
>  # CONFIG_USB_STORAGE_FREECOM is not set
> @@ -1615,10 +1623,10 @@ CONFIG_USB_LIBUSUAL=y
>  # CONFIG_USB_LD is not set
>  # CONFIG_USB_TRANCEVIBRATOR is not set
>  # CONFIG_USB_IOWARRIOR is not set
> -CONFIG_USB_TEST=y
> +CONFIG_USB_TEST=m
>  # CONFIG_USB_ISIGHTFW is not set
>  # CONFIG_USB_VST is not set
> -CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET=m
>  CONFIG_USB_GADGET_DEBUG=y
>  CONFIG_USB_GADGET_DEBUG_FILES=y
>  CONFIG_USB_GADGET_DEBUG_FS=y
> @@ -1664,8 +1672,8 @@ CONFIG_USB_OTG_UTILS=y
>  # CONFIG_USB_GPIO_VBUS is not set
>  # CONFIG_ISP1301_OMAP is not set
>  # CONFIG_USB_ULPI is not set
> -CONFIG_TWL4030_USB=y
> -CONFIG_NOP_USB_XCEIV=y
> +CONFIG_TWL4030_USB=m
> +CONFIG_NOP_USB_XCEIV=m
>  CONFIG_MMC=y
>  # CONFIG_MMC_DEBUG is not set
>  CONFIG_MMC_UNSAFE_RESUME=y
> @@ -1673,9 +1681,9 @@ CONFIG_MMC_UNSAFE_RESUME=y
>  #
>  # MMC/SD/SDIO Card Drivers
>  #
> -CONFIG_MMC_BLOCK=y
> +CONFIG_MMC_BLOCK=m
>  CONFIG_MMC_BLOCK_BOUNCE=y
> -CONFIG_SDIO_UART=y
> +CONFIG_SDIO_UART=m
>  # CONFIG_MMC_TEST is not set
> 
>  #
> @@ -1683,7 +1691,7 @@ CONFIG_SDIO_UART=y
>  #
>  # CONFIG_MMC_SDHCI is not set
>  # CONFIG_MMC_OMAP is not set
> -CONFIG_MMC_OMAP_HS=y
> +CONFIG_MMC_OMAP_HS=m
>  # CONFIG_MMC_AT91 is not set
>  # CONFIG_MMC_ATMELMCI is not set
>  # CONFIG_MMC_SPI is not set
> @@ -1719,10 +1727,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>  #
>  # CONFIG_ACCESSIBILITY is not set
>  CONFIG_RTC_LIB=y
> -CONFIG_RTC_CLASS=y
> -CONFIG_RTC_HCTOSYS=y
> -CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> -# CONFIG_RTC_DEBUG is not set
> +CONFIG_RTC_CLASS=m
> 
>  #
>  # RTC interfaces
> @@ -1747,7 +1752,7 @@ CONFIG_RTC_INTF_DEV=y
>  # CONFIG_RTC_DRV_PCF8583 is not set
>  # CONFIG_RTC_DRV_M41T80 is not set
>  # CONFIG_RTC_DRV_BQ32K is not set
> -CONFIG_RTC_DRV_TWL4030=y
> +CONFIG_RTC_DRV_TWL4030=m
>  # CONFIG_RTC_DRV_S35390A is not set
>  # CONFIG_RTC_DRV_FM3130 is not set
>  # CONFIG_RTC_DRV_RX8581 is not set
> @@ -1795,6 +1800,11 @@ CONFIG_RTC_DRV_TWL4030=y
>  # CONFIG_STAGING is not set
> 
>  #
> +# CBUS support
> +#
> +# CONFIG_CBUS is not set
> +
> +#
>  # File systems
>  #
>  CONFIG_EXT2_FS=y
> @@ -2012,8 +2022,8 @@ CONFIG_SCHED_DEBUG=y
>  CONFIG_SCHEDSTATS=y
>  CONFIG_TIMER_STATS=y
>  # CONFIG_DEBUG_OBJECTS is not set
> -# CONFIG_DEBUG_SLAB is not set
>  # CONFIG_DEBUG_KMEMLEAK is not set
> +CONFIG_DEBUG_PREEMPT=y
>  # CONFIG_DEBUG_RT_MUTEXES is not set
>  # CONFIG_RT_MUTEX_TESTER is not set
>  CONFIG_DEBUG_SPINLOCK=y
> @@ -2040,11 +2050,9 @@ CONFIG_DEBUG_INFO=y
>  # CONFIG_BOOT_PRINTK_DELAY is not set
>  # CONFIG_RCU_TORTURE_TEST is not set
>  # CONFIG_RCU_CPU_STALL_DETECTOR is not set
> -# CONFIG_KPROBES_SANITY_TEST is not set
>  # CONFIG_BACKTRACE_SELF_TEST is not set
>  # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
>  # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> -# CONFIG_LKDTM is not set
>  # CONFIG_FAULT_INJECTION is not set
>  # CONFIG_LATENCYTOP is not set
>  # CONFIG_SYSCTL_SYSCALL_CHECK is not set
> @@ -2060,6 +2068,7 @@ CONFIG_TRACING_SUPPORT=y
>  CONFIG_FTRACE=y
>  # CONFIG_FUNCTION_TRACER is not set
>  # CONFIG_IRQSOFF_TRACER is not set
> +# CONFIG_PREEMPT_TRACER is not set
>  # CONFIG_SCHED_TRACER is not set
>  # CONFIG_ENABLE_DEFAULT_TRACERS is not set
>  # CONFIG_BOOT_TRACER is not set
> --
> 1.6.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

