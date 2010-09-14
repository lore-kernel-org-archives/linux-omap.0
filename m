From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
Date: Wed, 15 Sep 2010 00:47:40 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7DB@dbde02.ent.ti.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100914185907.GG8647@atomide.com> <20100914190314.GH8647@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53184 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727Ab0INTSB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 15:18:01 -0400
In-Reply-To: <20100914190314.GH8647@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Wednesday, September 15, 2010 12:33 AM
> To: Russell King - ARM Linux
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org;
> bryan.wu@canonical.com
> Subject: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
> 
> With the recent changes to core ARM kernel code, we can now
> boot SMP kernel on UP systems. Update omap3_defconfig to
> enable SMP. This allows us to remove omap_4430sdp_defconfig.
>
Not yet.
We still have some issues around Ethernet, bridge/syslink,
sensors but hopefully we should be able to fix those.
Will have a closer look at this and see if these can be
easily fixed.
> In addition to enabling SMP, we also need to disable some
> options to make the system boot:
> 
> - For some reason LOCK_STAT causes tons of
>   WARNING: at mm/percpu-vm.c:320 pcpu_alloc+0x2fc/0x888()
>   so disable it for now.
> 
> - MUSB init fails for multi-omap, disable it for now.
> 
> - LOCAL_TIMERS hangs on omap4, disable it for now.
This is expected on omap4 ES1.0 and hence not enabled
in the omap_4430sdp_defconfig.
> 
> Also disable DEBUG_LL as this should be only enabled for
> debugging.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/configs/omap3_defconfig
> b/arch/arm/configs/omap3_defconfig
> index 5db9a6b..833a9bc 100644
> --- a/arch/arm/configs/omap3_defconfig
> +++ b/arch/arm/configs/omap3_defconfig
> @@ -55,6 +55,8 @@ CONFIG_MACH_OMAP_4430SDP=y
>  CONFIG_ARM_THUMBEE=y
>  CONFIG_NO_HZ=y
>  CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_SMP=y
> +# CONFIG_LOCAL_TIMERS is not set
>  CONFIG_AEABI=y
>  CONFIG_LEDS=y
>  CONFIG_ZBOOT_ROM_TEXT=0x0
> @@ -218,9 +220,9 @@ CONFIG_USB_DEVICEFS=y
>  CONFIG_USB_SUSPEND=y
>  # CONFIG_USB_OTG_WHITELIST is not set
>  CONFIG_USB_MON=y
> -CONFIG_USB_MUSB_HDRC=y
> -CONFIG_USB_MUSB_OTG=y
> -CONFIG_USB_GADGET_MUSB_HDRC=y
> +# CONFIG_USB_MUSB_HDRC is not set
> +# CONFIG_USB_MUSB_OTG is not set
> +# CONFIG_USB_GADGET_MUSB_HDRC is not set
>  CONFIG_USB_MUSB_DEBUG=y
>  CONFIG_USB_WDM=y
>  CONFIG_USB_STORAGE=y
> @@ -276,12 +278,11 @@ CONFIG_DEBUG_KERNEL=y
>  CONFIG_SCHEDSTATS=y
>  CONFIG_TIMER_STATS=y
>  CONFIG_PROVE_LOCKING=y
> -CONFIG_LOCK_STAT=y
> +# CONFIG_LOCK_STAT is not set
>  CONFIG_DEBUG_SPINLOCK_SLEEP=y
>  # CONFIG_DEBUG_BUGVERBOSE is not set
>  CONFIG_DEBUG_INFO=y
>  # CONFIG_RCU_CPU_STALL_DETECTOR is not set
> -CONFIG_DEBUG_LL=y
>  CONFIG_SECURITY=y
>  CONFIG_CRYPTO_MICHAEL_MIC=y
>  # CONFIG_CRYPTO_ANSI_CPRNG is not set
> diff --git a/arch/arm/configs/omap_4430sdp_defconfig
> b/arch/arm/configs/omap_4430sdp_defconfig
> deleted file mode 100644
> index 14c1e18..0000000
> --- a/arch/arm/configs/omap_4430sdp_defconfig
> +++ /dev/null
> @@ -1,125 +0,0 @@
> -CONFIG_EXPERIMENTAL=y
> -CONFIG_SYSVIPC=y
> -CONFIG_BSD_PROCESS_ACCT=y
> -CONFIG_LOG_BUF_SHIFT=14
> -CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> -# CONFIG_SYSCTL_SYSCALL is not set
> -# CONFIG_ELF_CORE is not set
> -CONFIG_MODULES=y
> -CONFIG_MODULE_UNLOAD=y
> -CONFIG_MODVERSIONS=y
> -CONFIG_MODULE_SRCVERSION_ALL=y
> -# CONFIG_BLK_DEV_BSG is not set
> -CONFIG_ARCH_OMAP=y
> -CONFIG_ARCH_OMAP4=y
> -# CONFIG_ARCH_OMAP2PLUS_TYPICAL is not set
> -# CONFIG_ARCH_OMAP2 is not set
> -# CONFIG_ARCH_OMAP3 is not set
> -# CONFIG_OMAP_MUX is not set
> -CONFIG_OMAP_32K_TIMER=y
> -CONFIG_OMAP_DM_TIMER=y
> -CONFIG_MACH_OMAP_4430SDP=y
> -# CONFIG_ARM_THUMB is not set
> -CONFIG_PL310_ERRATA_588369=y
> -CONFIG_SMP=y
> -CONFIG_NR_CPUS=2
> -# CONFIG_LOCAL_TIMERS is not set
> -CONFIG_PREEMPT=y
> -CONFIG_AEABI=y
> -CONFIG_ZBOOT_ROM_TEXT=0x0
> -CONFIG_ZBOOT_ROM_BSS=0x0
> -CONFIG_CMDLINE="root=/dev/ram0 rw mem=128M console=ttyS2,115200n8
> initrd=0x81600000,20M ramdisk_size=20480"
> -CONFIG_VFP=y
> -CONFIG_NEON=y
> -CONFIG_BINFMT_MISC=y
> -CONFIG_NET=y
> -CONFIG_PACKET=y
> -CONFIG_INET=y
> -CONFIG_IP_PNP=y
> -CONFIG_IP_PNP_DHCP=y
> -CONFIG_IP_PNP_BOOTP=y
> -CONFIG_IP_PNP_RARP=y
> -# CONFIG_IPV6 is not set
> -# CONFIG_WIRELESS is not set
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> -# CONFIG_FW_LOADER is not set
> -CONFIG_BLK_DEV_LOOP=y
> -CONFIG_BLK_DEV_RAM=y
> -CONFIG_BLK_DEV_RAM_SIZE=16384
> -# CONFIG_MISC_DEVICES is not set
> -CONFIG_NETDEVICES=y
> -CONFIG_NET_ETHERNET=y
> -CONFIG_KS8851=y
> -# CONFIG_NETDEV_1000 is not set
> -# CONFIG_NETDEV_10000 is not set
> -# CONFIG_WLAN is not set
> -# CONFIG_INPUT_MOUSEDEV is not set
> -CONFIG_INPUT_EVDEV=y
> -# CONFIG_INPUT_KEYBOARD is not set
> -# CONFIG_INPUT_MOUSE is not set
> -# CONFIG_SERIO is not set
> -CONFIG_SERIAL_8250=y
> -CONFIG_SERIAL_8250_CONSOLE=y
> -CONFIG_SERIAL_8250_NR_UARTS=32
> -CONFIG_SERIAL_8250_EXTENDED=y
> -CONFIG_SERIAL_8250_MANY_PORTS=y
> -CONFIG_SERIAL_8250_SHARE_IRQ=y
> -CONFIG_SERIAL_8250_DETECT_IRQ=y
> -CONFIG_SERIAL_8250_RSA=y
> -# CONFIG_LEGACY_PTYS is not set
> -CONFIG_HW_RANDOM=y
> -CONFIG_I2C=y
> -CONFIG_I2C_CHARDEV=y
> -CONFIG_I2C_OMAP=y
> -CONFIG_SPI=y
> -CONFIG_SPI_OMAP24XX=y
> -# CONFIG_HWMON is not set
> -CONFIG_WATCHDOG=y
> -CONFIG_OMAP_WATCHDOG=y
> -CONFIG_TWL4030_CORE=y
> -CONFIG_REGULATOR=y
> -CONFIG_REGULATOR_TWL4030=y
> -# CONFIG_VGA_CONSOLE is not set
> -# CONFIG_HID_SUPPORT is not set
> -# CONFIG_USB_SUPPORT is not set
> -CONFIG_MMC=y
> -CONFIG_MMC_OMAP_HS=y
> -CONFIG_RTC_CLASS=y
> -CONFIG_RTC_DRV_TWL4030=y
> -CONFIG_EXT2_FS=y
> -CONFIG_EXT3_FS=y
> -# CONFIG_EXT3_FS_XATTR is not set
> -CONFIG_INOTIFY=y
> -CONFIG_QUOTA=y
> -CONFIG_QFMT_V2=y
> -CONFIG_MSDOS_FS=y
> -CONFIG_VFAT_FS=y
> -CONFIG_TMPFS=y
> -CONFIG_NFS_FS=y
> -CONFIG_NFS_V3=y
> -CONFIG_NFS_V3_ACL=y
> -CONFIG_NFS_V4=y
> -CONFIG_ROOT_NFS=y
> -CONFIG_PARTITION_ADVANCED=y
> -CONFIG_NLS_CODEPAGE_437=y
> -CONFIG_NLS_ISO8859_1=y
> -# CONFIG_ENABLE_WARN_DEPRECATED is not set
> -# CONFIG_ENABLE_MUST_CHECK is not set
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_DEBUG_KERNEL=y
> -# CONFIG_DETECT_SOFTLOCKUP is not set
> -CONFIG_DETECT_HUNG_TASK=y
> -# CONFIG_SCHED_DEBUG is not set
> -# CONFIG_DEBUG_PREEMPT is not set
> -# CONFIG_DEBUG_BUGVERBOSE is not set
> -CONFIG_DEBUG_INFO=y
> -# CONFIG_RCU_CPU_STALL_DETECTOR is not set
> -# CONFIG_FTRACE is not set
> -# CONFIG_ARM_UNWIND is not set
> -CONFIG_CRYPTO_ECB=m
> -CONFIG_CRYPTO_PCBC=m
> -# CONFIG_CRYPTO_ANSI_CPRNG is not set
> -CONFIG_CRC_CCITT=y
> -CONFIG_CRC_T10DIF=y
> -CONFIG_LIBCRC32C=y
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
