From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Updates to omap3_evm_defconfig.
Date: Thu, 14 Aug 2008 16:37:28 +0300
Message-ID: <20080814133727.GF9226@atomide.com>
References: <premi@ti.com> <1218646333-18689-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56946 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbYHNNfw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2008 09:35:52 -0400
Content-Disposition: inline
In-Reply-To: <1218646333-18689-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [080813 19:52]:
> This patch updates the defconfig to 2.6.27-rc2 tag.
> The updates are based on omap_3430sdp_defconfig.
> 
> Fixes the build issue reported earlier:
> 
>       LD      init/built-in.o
>       LD      .tmp_vmlinux1
>     arm-none-linux-gnueabi-ld: no machine record defined
>     arm-none-linux-gnueabi-ld: no machine record defined
>     make: *** [.tmp_vmlinux1] Error 1

Pushing today.

Tony

> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/configs/omap3_evm_defconfig |  282 ++++++++++++++++++++++++++++++----
>  1 files changed, 254 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
> index 718c914..ebeaef3 100644
> --- a/arch/arm/configs/omap3_evm_defconfig
> +++ b/arch/arm/configs/omap3_evm_defconfig
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.26-rc1-omap1
> -# Thu May  8 08:18:45 2008
> +# Linux kernel version: 2.6.26-rc7-omap1
> +# Tue Aug 12 20:28:50 2008
>  #
>  CONFIG_ARM=y
>  CONFIG_SYS_SUPPORTS_APM_EMULATION=y
> @@ -170,15 +170,18 @@ CONFIG_ARCH_OMAP3=y
>  #
>  # OMAP Feature Selections
>  #
> -CONFIG_OMAP_DEBUG_SRAM_PATCH=y
>  # CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
>  # CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
> -# CONFIG_OMAP_RESET_CLOCKS is not set
> +CONFIG_OMAP_SMARTREFLEX=y
> +# CONFIG_OMAP_SMARTREFLEX_TESTING is not set
> +CONFIG_OMAP_RESET_CLOCKS=y
>  CONFIG_OMAP_BOOT_TAG=y
>  CONFIG_OMAP_BOOT_REASON=y
>  # CONFIG_OMAP_COMPONENT_VERSION is not set
>  # CONFIG_OMAP_GPIO_SWITCH is not set
> -# CONFIG_OMAP_MUX is not set
> +CONFIG_OMAP_MUX=y
> +# CONFIG_OMAP_MUX_DEBUG is not set
> +CONFIG_OMAP_MUX_WARNINGS=y
>  # CONFIG_OMAP_MCBSP is not set
>  # CONFIG_OMAP_MMU_FWK is not set
>  # CONFIG_OMAP_MBOX_FWK is not set
> @@ -189,12 +192,14 @@ CONFIG_OMAP_DM_TIMER=y
>  CONFIG_OMAP_LL_DEBUG_UART1=y
>  # CONFIG_OMAP_LL_DEBUG_UART2 is not set
>  # CONFIG_OMAP_LL_DEBUG_UART3 is not set
> +CONFIG_OMAP_SERIAL_WAKE=y
>  CONFIG_ARCH_OMAP34XX=y
>  CONFIG_ARCH_OMAP3430=y
>  
>  #
>  # OMAP Board Type
>  #
> +# CONFIG_MACH_OMAP_LDP is not set
>  # CONFIG_MACH_OMAP_3430SDP is not set
>  CONFIG_MACH_OMAP3EVM=y
>  # CONFIG_MACH_OMAP3_BEAGLE is not set
> @@ -297,7 +302,7 @@ CONFIG_FPE_NWFPE=y
>  # CONFIG_FPE_FASTFPE is not set
>  CONFIG_VFP=y
>  CONFIG_VFPv3=y
> -# CONFIG_NEON is not set
> +CONFIG_NEON=y
>  
>  #
>  # Userspace binary formats
> @@ -311,7 +316,9 @@ CONFIG_BINFMT_MISC=y
>  #
>  CONFIG_PM=y
>  # CONFIG_PM_DEBUG is not set
> -# CONFIG_SUSPEND is not set
> +CONFIG_PM_SLEEP=y
> +CONFIG_SUSPEND=y
> +CONFIG_SUSPEND_FREEZER=y
>  # CONFIG_APM_EMULATION is not set
>  CONFIG_ARCH_SUSPEND_POSSIBLE=y
>  
> @@ -416,16 +423,19 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
>  # CONFIG_CONNECTOR is not set
>  CONFIG_MTD=y
>  # CONFIG_MTD_DEBUG is not set
> -# CONFIG_MTD_CONCAT is not set
> -# CONFIG_MTD_PARTITIONS is not set
> +CONFIG_MTD_CONCAT=y
> +CONFIG_MTD_PARTITIONS=y
> +# CONFIG_MTD_REDBOOT_PARTS is not set
> +CONFIG_MTD_CMDLINE_PARTS=y
> +# CONFIG_MTD_AFS_PARTS is not set
> +# CONFIG_MTD_AR7_PARTS is not set
>  
>  #
>  # User Modules And Translation Layers
>  #
> -# CONFIG_MTD_CHAR is not set
> -# CONFIG_MTD_BLKDEVS is not set
> -# CONFIG_MTD_BLOCK is not set
> -# CONFIG_MTD_BLOCK_RO is not set
> +CONFIG_MTD_CHAR=y
> +CONFIG_MTD_BLKDEVS=y
> +CONFIG_MTD_BLOCK=y
>  # CONFIG_FTL is not set
>  # CONFIG_NFTL is not set
>  # CONFIG_INFTL is not set
> @@ -436,8 +446,10 @@ CONFIG_MTD=y
>  #
>  # RAM/ROM/Flash chip drivers
>  #
> -# CONFIG_MTD_CFI is not set
> +CONFIG_MTD_CFI=y
>  # CONFIG_MTD_JEDECPROBE is not set
> +CONFIG_MTD_GEN_PROBE=y
> +# CONFIG_MTD_CFI_ADV_OPTIONS is not set
>  CONFIG_MTD_MAP_BANK_WIDTH_1=y
>  CONFIG_MTD_MAP_BANK_WIDTH_2=y
>  CONFIG_MTD_MAP_BANK_WIDTH_4=y
> @@ -448,6 +460,10 @@ CONFIG_MTD_CFI_I1=y
>  CONFIG_MTD_CFI_I2=y
>  # CONFIG_MTD_CFI_I4 is not set
>  # CONFIG_MTD_CFI_I8 is not set
> +CONFIG_MTD_CFI_INTELEXT=y
> +# CONFIG_MTD_CFI_AMDSTD is not set
> +# CONFIG_MTD_CFI_STAA is not set
> +CONFIG_MTD_CFI_UTIL=y
>  # CONFIG_MTD_RAM is not set
>  # CONFIG_MTD_ROM is not set
>  # CONFIG_MTD_ABSENT is not set
> @@ -456,6 +472,9 @@ CONFIG_MTD_CFI_I2=y
>  # Mapping drivers for chip access
>  #
>  # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> +# CONFIG_MTD_PHYSMAP is not set
> +# CONFIG_MTD_ARM_INTEGRATOR is not set
> +# CONFIG_MTD_OMAP_NOR is not set
>  # CONFIG_MTD_PLATRAM is not set
>  
>  #
> @@ -481,6 +500,7 @@ CONFIG_MTD_ONENAND_VERIFY_WRITE=y
>  CONFIG_MTD_ONENAND_OMAP2=y
>  # CONFIG_MTD_ONENAND_OTP is not set
>  # CONFIG_MTD_ONENAND_2X_PROGRAM is not set
> +# CONFIG_MTD_ONENAND_SIM is not set
>  
>  #
>  # UBI - Unsorted block images
> @@ -492,6 +512,7 @@ CONFIG_BLK_DEV=y
>  CONFIG_BLK_DEV_LOOP=y
>  # CONFIG_BLK_DEV_CRYPTOLOOP is not set
>  # CONFIG_BLK_DEV_NBD is not set
> +# CONFIG_BLK_DEV_UB is not set
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_COUNT=16
>  CONFIG_BLK_DEV_RAM_SIZE=16384
> @@ -499,6 +520,9 @@ CONFIG_BLK_DEV_RAM_SIZE=16384
>  # CONFIG_CDROM_PKTCDVD is not set
>  # CONFIG_ATA_OVER_ETH is not set
>  # CONFIG_MISC_DEVICES is not set
> +# CONFIG_EEPROM_93CX6 is not set
> +# CONFIG_OMAP_STI is not set
> +# CONFIG_ENCLOSURE_SERVICES is not set
>  CONFIG_HAVE_IDE=y
>  # CONFIG_IDE is not set
>  
> @@ -573,8 +597,16 @@ CONFIG_SMC911X=y
>  #
>  # CONFIG_WLAN_PRE80211 is not set
>  # CONFIG_WLAN_80211 is not set
> -# CONFIG_IWLWIFI is not set
>  # CONFIG_IWLWIFI_LEDS is not set
> +
> +#
> +# USB Network Adapters
> +#
> +# CONFIG_USB_CATC is not set
> +# CONFIG_USB_KAWETH is not set
> +# CONFIG_USB_PEGASUS is not set
> +# CONFIG_USB_RTL8150 is not set
> +# CONFIG_USB_USBNET is not set
>  # CONFIG_WAN is not set
>  # CONFIG_PPP is not set
>  # CONFIG_SLIP is not set
> @@ -595,7 +627,7 @@ CONFIG_INPUT=y
>  #
>  # CONFIG_INPUT_MOUSEDEV is not set
>  # CONFIG_INPUT_JOYDEV is not set
> -# CONFIG_INPUT_EVDEV is not set
> +CONFIG_INPUT_EVDEV=y
>  # CONFIG_INPUT_EVBUG is not set
>  
>  #
> @@ -608,9 +640,9 @@ CONFIG_INPUT_KEYBOARD=y
>  # CONFIG_KEYBOARD_XTKBD is not set
>  # CONFIG_KEYBOARD_NEWTON is not set
>  # CONFIG_KEYBOARD_STOWAWAY is not set
> -CONFIG_KEYBOARD_TWL4030=m
> +CONFIG_KEYBOARD_TWL4030=y
>  # CONFIG_KEYBOARD_LM8323 is not set
> -# CONFIG_KEYBOARD_GPIO is not set 
> +# CONFIG_KEYBOARD_GPIO is not set
>  # CONFIG_INPUT_MOUSE is not set
>  # CONFIG_INPUT_JOYSTICK is not set
>  # CONFIG_INPUT_TABLET is not set
> @@ -628,6 +660,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
>  # CONFIG_TOUCHSCREEN_TSC2102 is not set
>  # CONFIG_TOUCHSCREEN_TSC210X is not set
>  # CONFIG_TOUCHSCREEN_UCB1400 is not set
> +# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
>  # CONFIG_INPUT_MISC is not set
>  
>  #
> @@ -686,6 +719,7 @@ CONFIG_I2C_OMAP=y
>  # CONFIG_I2C_SIMTEC is not set
>  # CONFIG_I2C_TAOS_EVM is not set
>  # CONFIG_I2C_STUB is not set
> +# CONFIG_I2C_TINY_USB is not set
>  # CONFIG_I2C_PCA_PLATFORM is not set
>  
>  #
> @@ -721,7 +755,7 @@ CONFIG_SPI_MASTER=y
>  # SPI Master Controller Drivers
>  #
>  # CONFIG_SPI_BITBANG is not set
> -CONFIG_SPI_OMAP24XX=m
> +CONFIG_SPI_OMAP24XX=y
>  
>  #
>  # SPI Protocol Masters
> @@ -753,7 +787,19 @@ CONFIG_HAVE_GPIO_LIB=y
>  # CONFIG_W1 is not set
>  # CONFIG_POWER_SUPPLY is not set
>  # CONFIG_HWMON is not set
> -# CONFIG_WATCHDOG is not set
> +CONFIG_WATCHDOG=y
> +CONFIG_WATCHDOG_NOWAYOUT=y
> +
> +#
> +# Watchdog Device Drivers
> +#
> +# CONFIG_SOFT_WATCHDOG is not set
> +CONFIG_OMAP_WATCHDOG=y
> +
> +#
> +# USB-based Watchdog Cards
> +#
> +# CONFIG_USBPCWATCHDOG is not set
>  
>  #
>  # Sonics Silicon Backplane
> @@ -778,17 +824,19 @@ CONFIG_SSB_POSSIBLE=y
>  #
>  # CONFIG_VIDEO_DEV is not set
>  # CONFIG_DVB_CORE is not set
> +# CONFIG_VIDEO_MEDIA is not set
>  
>  #
>  # Multimedia drivers
>  #
>  CONFIG_DAB=y
> +# CONFIG_USB_DABUSB is not set
>  
>  #
>  # Graphics support
>  #
>  # CONFIG_VGASTATE is not set
> -# CONFIG_VIDEO_OUTPUT_CONTROL is not set
> +CONFIG_VIDEO_OUTPUT_CONTROL=m
>  CONFIG_FB=y
>  # CONFIG_FIRMWARE_EDID is not set
>  # CONFIG_FB_DDC is not set
> @@ -801,7 +849,6 @@ CONFIG_FB_CFB_IMAGEBLIT=y
>  # CONFIG_FB_SYS_IMAGEBLIT is not set
>  # CONFIG_FB_FOREIGN_ENDIAN is not set
>  # CONFIG_FB_SYS_FOPS is not set
> -CONFIG_FB_DEFERRED_IO=y
>  # CONFIG_FB_SVGALIB is not set
>  # CONFIG_FB_MACMODES is not set
>  # CONFIG_FB_BACKLIGHT is not set
> @@ -830,15 +877,190 @@ CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
>  # CONFIG_VGA_CONSOLE is not set
>  CONFIG_DUMMY_CONSOLE=y
>  # CONFIG_FRAMEBUFFER_CONSOLE is not set
> -# CONFIG_LOGO is not set
> +# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
> +# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> +# CONFIG_FONTS is not set
> +CONFIG_FONT_8x8=y
> +CONFIG_FONT_8x16=y
> +CONFIG_LOGO=y
> +CONFIG_LOGO_LINUX_MONO=y
> +CONFIG_LOGO_LINUX_VGA16=y
> +CONFIG_LOGO_LINUX_CLUT224=y
>  
>  #
>  # Sound
>  #
>  # CONFIG_SOUND is not set
> -# CONFIG_HID_SUPPORT is not set
> -# CONFIG_USB_SUPPORT is not set
> -# CONFIG_MMC is not set
> +CONFIG_HID_SUPPORT=y
> +CONFIG_HID=y
> +# CONFIG_HID_DEBUG is not set
> +# CONFIG_HIDRAW is not set
> +
> +#
> +# USB Input Devices
> +#
> +CONFIG_USB_HID=y
> +# CONFIG_USB_HIDINPUT_POWERBOOK is not set
> +# CONFIG_HID_FF is not set
> +# CONFIG_USB_HIDDEV is not set
> +CONFIG_USB_SUPPORT=y
> +CONFIG_USB_ARCH_HAS_HCD=y
> +CONFIG_USB_ARCH_HAS_OHCI=y
> +CONFIG_USB_ARCH_HAS_EHCI=y
> +CONFIG_USB=y
> +# CONFIG_USB_DEBUG is not set
> +CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> +
> +#
> +# Miscellaneous USB options
> +#
> +CONFIG_USB_DEVICEFS=y
> +# CONFIG_USB_DEVICE_CLASS is not set
> +# CONFIG_USB_DYNAMIC_MINORS is not set
> +CONFIG_USB_SUSPEND=y
> +CONFIG_USB_OTG=y
> +# CONFIG_USB_OTG_WHITELIST is not set
> +# CONFIG_USB_OTG_BLACKLIST_HUB is not set
> +
> +#
> +# USB Host Controller Drivers
> +#
> +# CONFIG_USB_C67X00_HCD is not set
> +CONFIG_USB_EHCI_HCD=m
> +CONFIG_OMAP_EHCI_PHY_MODE=y
> +# CONFIG_OMAP_EHCI_TLL_MODE is not set
> +# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> +# CONFIG_USB_EHCI_TT_NEWSCHED is not set
> +# CONFIG_USB_ISP116X_HCD is not set
> +# CONFIG_USB_ISP1760_HCD is not set
> +# CONFIG_USB_OHCI_HCD is not set
> +# CONFIG_USB_SL811_HCD is not set
> +# CONFIG_USB_R8A66597_HCD is not set
> +CONFIG_USB_MUSB_HDRC=y
> +CONFIG_USB_MUSB_SOC=y
> +
> +#
> +# OMAP 343x high speed USB support
> +#
> +# CONFIG_USB_MUSB_HOST is not set
> +# CONFIG_USB_MUSB_PERIPHERAL is not set
> +CONFIG_USB_MUSB_OTG=y
> +CONFIG_USB_GADGET_MUSB_HDRC=y
> +CONFIG_USB_MUSB_HDRC_HCD=y
> +# CONFIG_MUSB_PIO_ONLY is not set
> +CONFIG_USB_INVENTRA_DMA=y
> +# CONFIG_USB_TI_CPPI_DMA is not set
> +CONFIG_USB_MUSB_LOGLEVEL=1
> +
> +#
> +# USB Device Class drivers
> +#
> +# CONFIG_USB_ACM is not set
> +# CONFIG_USB_PRINTER is not set
> +# CONFIG_USB_WDM is not set
> +
> +#
> +# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
> +#
> +
> +#
> +# may also be needed; see USB_STORAGE Help for more information
> +#
> +CONFIG_USB_STORAGE=y
> +# CONFIG_USB_STORAGE_DEBUG is not set
> +# CONFIG_USB_STORAGE_DATAFAB is not set
> +# CONFIG_USB_STORAGE_FREECOM is not set
> +# CONFIG_USB_STORAGE_ISD200 is not set
> +# CONFIG_USB_STORAGE_DPCM is not set
> +# CONFIG_USB_STORAGE_USBAT is not set
> +# CONFIG_USB_STORAGE_SDDR09 is not set
> +# CONFIG_USB_STORAGE_SDDR55 is not set
> +# CONFIG_USB_STORAGE_JUMPSHOT is not set
> +# CONFIG_USB_STORAGE_ALAUDA is not set
> +# CONFIG_USB_STORAGE_ONETOUCH is not set
> +# CONFIG_USB_STORAGE_KARMA is not set
> +# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
> +# CONFIG_USB_LIBUSUAL is not set
> +
> +#
> +# USB Imaging devices
> +#
> +# CONFIG_USB_MDC800 is not set
> +# CONFIG_USB_MICROTEK is not set
> +CONFIG_USB_MON=y
> +
> +#
> +# USB port drivers
> +#
> +# CONFIG_USB_SERIAL is not set
> +
> +#
> +# USB Miscellaneous drivers
> +#
> +# CONFIG_USB_EMI62 is not set
> +# CONFIG_USB_EMI26 is not set
> +# CONFIG_USB_ADUTUX is not set
> +# CONFIG_USB_AUERSWALD is not set
> +# CONFIG_USB_RIO500 is not set
> +# CONFIG_USB_LEGOTOWER is not set
> +# CONFIG_USB_LCD is not set
> +# CONFIG_USB_BERRY_CHARGE is not set
> +# CONFIG_USB_LED is not set
> +# CONFIG_USB_CYPRESS_CY7C63 is not set
> +# CONFIG_USB_CYTHERM is not set
> +# CONFIG_USB_PHIDGET is not set
> +# CONFIG_USB_IDMOUSE is not set
> +# CONFIG_USB_FTDI_ELAN is not set
> +# CONFIG_USB_APPLEDISPLAY is not set
> +# CONFIG_USB_SISUSBVGA is not set
> +# CONFIG_USB_LD is not set
> +# CONFIG_USB_TRANCEVIBRATOR is not set
> +# CONFIG_USB_IOWARRIOR is not set
> +CONFIG_USB_TEST=y
> +# CONFIG_USB_ISIGHTFW is not set
> +CONFIG_USB_GADGET=y
> +# CONFIG_USB_GADGET_DEBUG is not set
> +# CONFIG_USB_GADGET_DEBUG_FILES is not set
> +CONFIG_USB_GADGET_SELECTED=y
> +# CONFIG_USB_GADGET_AMD5536UDC is not set
> +# CONFIG_USB_GADGET_ATMEL_USBA is not set
> +# CONFIG_USB_GADGET_FSL_USB2 is not set
> +# CONFIG_USB_GADGET_NET2280 is not set
> +# CONFIG_USB_GADGET_PXA2XX is not set
> +# CONFIG_USB_GADGET_M66592 is not set
> +# CONFIG_USB_GADGET_PXA27X is not set
> +# CONFIG_USB_GADGET_GOKU is not set
> +# CONFIG_USB_GADGET_LH7A40X is not set
> +# CONFIG_USB_GADGET_OMAP is not set
> +# CONFIG_USB_GADGET_S3C2410 is not set
> +# CONFIG_USB_GADGET_AT91 is not set
> +# CONFIG_USB_GADGET_DUMMY_HCD is not set
> +CONFIG_USB_GADGET_DUALSPEED=y
> +CONFIG_USB_ZERO=y
> +# CONFIG_USB_ZERO_HNPTEST is not set
> +# CONFIG_USB_ETH is not set
> +# CONFIG_USB_GADGETFS is not set
> +# CONFIG_USB_FILE_STORAGE is not set
> +# CONFIG_USB_G_SERIAL is not set
> +# CONFIG_USB_MIDI_GADGET is not set
> +# CONFIG_USB_G_PRINTER is not set
> +CONFIG_MMC=y
> +# CONFIG_MMC_DEBUG is not set
> +# CONFIG_MMC_UNSAFE_RESUME is not set
> +
> +#
> +# MMC/SD Card Drivers
> +#
> +CONFIG_MMC_BLOCK=y
> +CONFIG_MMC_BLOCK_BOUNCE=y
> +# CONFIG_SDIO_UART is not set
> +# CONFIG_MMC_TEST is not set
> +
> +#
> +# MMC/SD Host Controller Drivers
> +#
> +CONFIG_MMC_OMAP_HS=m
> +# CONFIG_MMC_SPI is not set
>  # CONFIG_NEW_LEDS is not set
>  CONFIG_RTC_LIB=y
>  # CONFIG_RTC_CLASS is not set
> @@ -920,11 +1142,15 @@ CONFIG_JFFS2_FS_WRITEBUFFER=y
>  # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
>  # CONFIG_JFFS2_SUMMARY is not set
>  # CONFIG_JFFS2_FS_XATTR is not set
> -# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
> +CONFIG_JFFS2_COMPRESSION_OPTIONS=y
>  CONFIG_JFFS2_ZLIB=y
>  # CONFIG_JFFS2_LZO is not set
>  CONFIG_JFFS2_RTIME=y
>  # CONFIG_JFFS2_RUBIN is not set
> +# CONFIG_JFFS2_CMODE_NONE is not set
> +CONFIG_JFFS2_CMODE_PRIORITY=y
> +# CONFIG_JFFS2_CMODE_SIZE is not set
> +# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
>  # CONFIG_CRAMFS is not set
>  # CONFIG_VXFS_FS is not set
>  # CONFIG_MINIX_FS is not set
> @@ -1031,7 +1257,7 @@ CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_KERNEL=y
>  # CONFIG_DEBUG_SHIRQ is not set
>  CONFIG_DETECT_SOFTLOCKUP=y
> -CONFIG_SCHED_DEBUG=y
> +# CONFIG_SCHED_DEBUG is not set
>  # CONFIG_SCHEDSTATS is not set
>  # CONFIG_TIMER_STATS is not set
>  # CONFIG_DEBUG_OBJECTS is not set
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
