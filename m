From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Fri, 21 Oct 2016 11:25:30 +0200
Message-ID: <20161021092530.GO2765@localhost>
References: <20161020153749.GC12413@localhost>
 <20161021070848.rum7wrlihjayqdbh@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161021070848.rum7wrlihjayqdbh-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 21, 2016 at 12:08:49AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161020 08:38]:
> > Hi Tony,
> > 
> > I'm getting the splat below when booting 4.9-rc1 on a BBB and
> > tracked it down to 65b3f50ed6fa ("usb: musb: Add PM runtime support for
> > MUSB DSPS glue layer") which added a synchronous RPM get in a timer
> > callback:
> 
> OK, sorry to hear about that. Care to email me your .config and how
> to reproduce and what do you have connected like a hub? Also do
> you use built-in gadgets or configure them via configfs?

It happens even with no devices connected to the host port, and with no
gadgets configured (or the peripheral port simply disabled). Whenever
the glue timer fires and calls pm_runtime_get_sync() I get the splat.
For some reason the might_sleep() in get_sync() does not trigger the
first time, which means that I see this four seconds after probe, and
then every other second when the timer fires.

Attaching my defconfig.

> > [    6.466226] BUG: sleeping function called from invalid context at /home/johan/work/omicron/src/linux/drivers/base/power/runtime.c:955
> > [    6.478850] in_atomic(): 1, irqs_disabled(): 0, pid: 59, name: grep
> > [    6.485434] 1 lock held by grep/59:
> > [    6.489102]  #0: [    6.490966]  (
> > ((&glue->timer))[    6.494206] ){+.-...}
> > , at: [    6.497194] [<c0191084>] call_timer_fn+0x0/0x41c
> > [    6.502048] Preemption disabled at:[    6.505540] [<c01015e0>] __do_softirq+0x80/0x594
> > [    6.510393] 
> > [    6.511974] CPU: 0 PID: 59 Comm: grep Not tainted 4.9.0-rc1 #46
> > [    6.518190] Hardware name: Generic AM33XX (Flattened Device Tree)
> > [    6.524613] [<c01116e4>] (unwind_backtrace) from [<c010dec0>] (show_stack+0x20/0x24)
> > [    6.532753] [<c010dec0>] (show_stack) from [<c0364f1c>] (dump_stack+0x24/0x28)
> > [    6.540351] [<c0364f1c>] (dump_stack) from [<c015ea58>] (___might_sleep+0x1d8/0x2c4)
> > [    6.548486] [<c015ea58>] (___might_sleep) from [<c015ebb4>] (__might_sleep+0x70/0xa8)
> > [    6.556720] [<c015ebb4>] (__might_sleep) from [<c0413d60>] (__pm_runtime_resume+0x9c/0xa0)
> > [    6.565404] [<c0413d60>] (__pm_runtime_resume) from [<c04d0bc4>] (otg_timer+0x3c/0x254)
> > [    6.573813] [<c04d0bc4>] (otg_timer) from [<c0191180>] (call_timer_fn+0xfc/0x41c)
> > [    6.581675] [<c0191180>] (call_timer_fn) from [<c01915c0>] (expire_timers+0x120/0x210)
> > [    6.589990] [<c01915c0>] (expire_timers) from [<c0191acc>] (run_timer_softirq+0xa4/0xdc)
> > [    6.598487] [<c0191acc>] (run_timer_softirq) from [<c010168c>] (__do_softirq+0x12c/0x594)
> > [    6.607079] [<c010168c>] (__do_softirq) from [<c01384cc>] (irq_exit+0xf4/0x130)
> > [    6.614766] [<c01384cc>] (irq_exit) from [<c017d910>] (__handle_domain_irq+0x84/0xec)
> > [    6.622991] [<c017d910>] (__handle_domain_irq) from [<c0101500>] (omap_intc_handle_irq+0x44/0xa0)
> > [    6.632306] [<c0101500>] (omap_intc_handle_irq) from [<c010ee78>] (__irq_usr+0x58/0x80)
> > [    6.640716] Exception stack(0xcf669fb0 to 0xcf669ff8)
> > [    6.646028] 9fa0:                                     b6fd5050 0012ebb0 b6e71058 b6e1c088
> > [    6.654614] 9fc0: b6e07000 00000001 b6e1cb10 b6fd5000 00000001 00000000 b6fd38e8 bec32a54
> > [    6.663198] 9fe0: b6e1c870 bec32990 b6fb0a20 b6fb9758 20030010 ffffffff
> > 
> > Setting the irq_safe flag seems to do the trick, but not sure that's
> > what you intended to do.
> 
> That's what we want to avoid as it keep the parent device permanently
> enabled. To avoid that we want to just queue things and deal with them
> from pm_runtime_resume.

I figured, so then that pm_runtime_get_sync() in the dsps timer callback
needs to go.

> > I saw you posted some regression fixes lately, but they did not look
> > related to this at first glance at least.
> 
> Yeah this seems different. Can you still try v4.9-rc + patches from
> thread "[PATCH 0/2] Fixes for two more musb regressions"?

As expected, those two fixes makes no difference.

Thanks,
Johan

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=defconfig

CONFIG_COMPILE_TEST=y
CONFIG_DEFAULT_HOSTNAME="omicron"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_FHANDLE is not set
CONFIG_USELIB=y
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_EXPERT=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_SLAB=y
CONFIG_PROFILING=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_LBDAF is not set
# CONFIG_BLK_DEV_BSG is not set
CONFIG_PARTITION_ADVANCED=y
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_OMAP_RESET_CLOCKS=y
CONFIG_OMAP_MUX_DEBUG=y
CONFIG_ARCH_OMAP3=y
CONFIG_SOC_AM33XX=y
# CONFIG_SOC_OMAP3430 is not set
# CONFIG_SOC_TI81XX is not set
# CONFIG_MACH_OMAP3517EVM is not set
# CONFIG_MACH_OMAP3_PANDORA is not set
CONFIG_ARM_THUMBEE=y
# CONFIG_CACHE_L2X0 is not set
CONFIG_ARM_ERRATA_720789=y
CONFIG_ARM_ERRATA_754322=y
CONFIG_ARM_ERRATA_775420=y
CONFIG_PCI=y
CONFIG_HAVE_ARM_ARCH_TIMER=y
CONFIG_PREEMPT=y
CONFIG_HZ_1000=y
# CONFIG_HIGHPTE is not set
# CONFIG_COMPACTION is not set
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_ARM_APPENDED_DTB=y
CONFIG_CMDLINE="root=/dev/nfs ip=dhcp debug"
CONFIG_CMDLINE_EXTEND=y
# CONFIG_COREDUMP is not set
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_DIAG is not set
# CONFIG_IPV6 is not set
CONFIG_IRDA=m
CONFIG_IRCOMM=m
# CONFIG_WIRELESS is not set
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
CONFIG_FW_LOADER=m
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_NAND=y
CONFIG_MTD_NAND_ECC_BCH=y
CONFIG_MTD_NAND_OMAP2=y
CONFIG_MTD_UBI=y
CONFIG_OF_ALL_DTBS=y
CONFIG_OF_OVERLAY=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set
CONFIG_BLK_DEV_SD=y
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_NETDEVICES=y
CONFIG_NETCONSOLE=m
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_CADENCE is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CIRRUS is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_FARADAY is not set
# CONFIG_NET_VENDOR_HISILICON is not set
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_NET_PACKET_ENGINE is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_SMSC911X=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_TI_CPSW=y
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_SMSC_PHY=y
CONFIG_USB_USBNET=y
# CONFIG_USB_NET_AX8817X is not set
# CONFIG_USB_NET_AX88179_178A is not set
CONFIG_USB_NET_CDC_EEM=y
# CONFIG_USB_NET_NET1080 is not set
CONFIG_USB_NET_RNDIS_HOST=y
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_WLAN is not set
# CONFIG_INPUT_LEDS is not set
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_KEYBOARD_LM8323=m
# CONFIG_INPUT_MOUSE is not set
# CONFIG_VT is not set
CONFIG_LEGACY_PTY_COUNT=4
CONFIG_SERIAL_OMAP=y
CONFIG_SERIAL_OMAP_CONSOLE=y
# CONFIG_HW_RANDOM is not set
CONFIG_I2C_CHARDEV=y
# CONFIG_I2C_BRCMSTB is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_UNIPHIER is not set
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_TEGRA=y
CONFIG_GPIO_TWL4030=y
CONFIG_POWER_SUPPLY=y
# CONFIG_HWMON is not set
CONFIG_WATCHDOG=y
CONFIG_OMAP_WATCHDOG=y
CONFIG_TWL4030_WATCHDOG=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_TPS65217=y
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_PBIAS=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TWL4030=y
# CONFIG_HID is not set
# CONFIG_USB_HID is not set
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
CONFIG_USB_MON=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_ACM=m
CONFIG_USB_STORAGE=y
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_DSPS=y
CONFIG_USB_TI_CPPI41_DMA=y
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_F81232=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_METRO=m
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
CONFIG_USB_SERIAL_WISHBONE=m
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_DEBUG=m
CONFIG_NOP_USB_XCEIV=y
CONFIG_AM335X_PHY_USB=y
CONFIG_USB_GADGET=y
CONFIG_USB_DUMMY_HCD=m
CONFIG_USB_G_SERIAL=m
CONFIG_MMC=y
CONFIG_MMC_OMAP_HS=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_TWL4030=y
# CONFIG_RTC_DRV_SPEAR is not set
CONFIG_RTC_DRV_OMAP=y
CONFIG_DMADEVICES=y
CONFIG_DMA_OMAP=y
CONFIG_TI_EDMA=y
# CONFIG_SH_DMAE_BASE is not set
# CONFIG_COMMON_CLK_XGENE is not set
# CONFIG_CLK_BCM_KONA is not set
# CONFIG_ARM_ARCH_TIMER_EVTSTREAM is not set
# CONFIG_IOMMU_SUPPORT is not set
CONFIG_SOC_TI=y
# CONFIG_ARM_SCPI_POWER_DOMAIN is not set
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_UBIFS_FS=y
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_UTF8=y
CONFIG_PRINTK_TIME=y
CONFIG_DYNAMIC_DEBUG=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_DEBUG_KMEMLEAK=y
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_RCU_EQS_DEBUG=y
CONFIG_STACK_TRACER=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_TRACING_EVENTS_GPIO is not set
CONFIG_DEBUG_LL=y
CONFIG_EARLY_PRINTK=y
# CONFIG_CRYPTO_ECHAINIV is not set
# CONFIG_CRYPTO_HW is not set

--2oS5YaxWCcQjTEyO--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
