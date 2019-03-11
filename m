From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH] arch: arm: Kconfig: pedantic formatting
Date: Mon, 11 Mar 2019 14:59:15 +0100
Message-ID: <0dac5f92d578a5a54f9664124421b2e3fdf8bf16.camel@v3.sk>
References: <1552312598-25574-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552312598-25574-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: andrew@aj.id.au, hsweeten@visionengravers.com, alexander.sverdlin@gmail.com, kaloz@openwrt.org, khalasa@piap.pl, aaro.koskinen@iki.fi, tony@atomide.com, baohua@kernel.org, kgene@kernel.org, krzk@kernel.org, linux@prisktech.co.nz, mcuos.com@gmail.com, matthias.bgg@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2019-03-11 at 14:56 +0100, Enrico Weigelt, metux IT consult
wrote:
> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  arch/arm/Kconfig              | 24 +++++++++++-----------
>  arch/arm/mach-aspeed/Kconfig  | 10 ++++-----
>  arch/arm/mach-ep93xx/Kconfig  |  8 ++++----
>  arch/arm/mach-hisi/Kconfig    | 14 ++++++-------
>  arch/arm/mach-ixp4xx/Kconfig  | 32 ++++++++++++++---------------
>  arch/arm/mach-mmp/Kconfig     |  2 +-
>  arch/arm/mach-omap1/Kconfig   | 36 ++++++++++++++++----------------
>  arch/arm/mach-omap2/Kconfig   | 12 +++++------
>  arch/arm/mach-prima2/Kconfig  |  6 +++---
>  arch/arm/mach-s3c24xx/Kconfig | 32 ++++++++++++++---------------
>  arch/arm/mach-s3c64xx/Kconfig | 16 +++++++--------
>  arch/arm/mach-sa1100/Kconfig  |  4 ++--
>  arch/arm/mach-vt8500/Kconfig  |  6 +++---
>  arch/arm/mach-w90x900/Kconfig |  6 +++---
>  arch/arm/mm/Kconfig           | 48 +++++++++++++++++++++----------------------
>  arch/arm/plat-samsung/Kconfig | 26 +++++++++++------------
>  16 files changed, 140 insertions(+), 142 deletions(-)

Acked-by: Lubomir Rintel <lkundrak@v3.sk> (mach-mmp)

Thanks
Lubo

> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5085a1e..c89f683 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1115,14 +1115,14 @@ config ARM_ERRATA_764369
>  	  in the diagnostic control register of the SCU.
>  
>  config ARM_ERRATA_775420
> -       bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
> -       depends on CPU_V7
> -       help
> -	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
> -	 r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
> -	 operation aborts with MMU exception, it might cause the processor
> -	 to deadlock. This workaround puts DSB before executing ISB if
> -	 an abort may occur on cache maintenance.
> +	bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
> +	depends on CPU_V7
> +	help
> +	  This option enables the workaround for the 775420 Cortex-A9 (r2p2,
> +	  r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
> +	  operation aborts with MMU exception, it might cause the processor
> +	  to deadlock. This workaround puts DSB before executing ISB if
> +	  an abort may occur on cache maintenance.
>  
>  config ARM_ERRATA_798181
>  	bool "ARM errata: TLBI/DSB failure on Cortex-A15"
> @@ -1650,12 +1650,12 @@ config HW_PERF_EVENTS
>  	depends on ARM_PMU
>  
>  config SYS_SUPPORTS_HUGETLBFS
> -       def_bool y
> -       depends on ARM_LPAE
> +	def_bool y
> +	depends on ARM_LPAE
>  
>  config HAVE_ARCH_TRANSPARENT_HUGEPAGE
> -       def_bool y
> -       depends on ARM_LPAE
> +	def_bool y
> +	depends on ARM_LPAE
>  
>  config ARCH_WANT_GENERAL_HUGETLB
>  	def_bool y
> diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> index 2d5570e..f6eaf05 100644
> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -18,9 +18,9 @@ config MACH_ASPEED_G4
>  	select CPU_ARM926T
>  	select PINCTRL_ASPEED_G4
>  	help
> -	 Say yes if you intend to run on an Aspeed ast2400 or similar
> -	 fourth generation BMCs, such as those used by OpenPower Power8
> -	 systems.
> +	  Say yes if you intend to run on an Aspeed ast2400 or similar
> +	  fourth generation BMCs, such as those used by OpenPower Power8
> +	  systems.
>  
>  config MACH_ASPEED_G5
>  	bool "Aspeed SoC 5th Generation"
> @@ -28,7 +28,7 @@ config MACH_ASPEED_G5
>  	select CPU_V6
>  	select PINCTRL_ASPEED_G5
>  	help
> -	 Say yes if you intend to run on an Aspeed ast2500 or similar
> -	 fifth generation Aspeed BMCs.
> +	  Say yes if you intend to run on an Aspeed ast2500 or similar
> +	  fifth generation Aspeed BMCs.
>  
>  endif
> diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
> index c095236..597ea24 100644
> --- a/arch/arm/mach-ep93xx/Kconfig
> +++ b/arch/arm/mach-ep93xx/Kconfig
> @@ -125,10 +125,10 @@ config MACH_MICRO9S
>  	  Contec Micro9-Slim board.
>  
>  config MACH_SIM_ONE
> -        bool "Support Simplemachines Sim.One board"
> -        help
> -          Say 'Y' here if you want your kernel to support the
> -          Simplemachines Sim.One board.
> +	bool "Support Simplemachines Sim.One board"
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  Simplemachines Sim.One board.
>  
>  config MACH_SNAPPER_CL15
>  	bool "Support Bluewater Systems Snapper CL15 Module"
> diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
> index 65a048f..4850f8b 100644
> --- a/arch/arm/mach-hisi/Kconfig
> +++ b/arch/arm/mach-hisi/Kconfig
> @@ -24,13 +24,13 @@ config ARCH_HI3xxx
>  	  Support for Hisilicon Hi36xx SoC family
>  
>  config ARCH_HIP01
> -       bool "Hisilicon HIP01 family"
> -       depends on ARCH_MULTI_V7
> -       select HAVE_ARM_SCU if SMP
> -       select HAVE_ARM_TWD if SMP
> -       select ARM_GLOBAL_TIMER
> -       help
> -         Support for Hisilicon HIP01 SoC family
> +	bool "Hisilicon HIP01 family"
> +	depends on ARCH_MULTI_V7
> +	select HAVE_ARM_SCU if SMP
> +	select HAVE_ARM_TWD if SMP
> +	select ARM_GLOBAL_TIMER
> +	help
> +	  Support for Hisilicon HIP01 SoC family
>  
>  config ARCH_HIP04
>  	bool "Hisilicon HiP04 Cortex A15 family"
> diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
> index fea00812..7b47a3c 100644
> --- a/arch/arm/mach-ixp4xx/Kconfig
> +++ b/arch/arm/mach-ixp4xx/Kconfig
> @@ -22,9 +22,9 @@ config MACH_AVILA
>  	  see <file:Documentation/arm/IXP4xx>.
>  
>  config MACH_LOFT
> -    bool "Loft"
> -    depends on MACH_AVILA
> -    help
> +	bool "Loft"
> +	depends on MACH_AVILA
> +	help
>  	  Say 'Y' here if you want your kernel to support the Giant
>  	  Shoulder Inc Loft board (a minor variation on the standard
>  	  Gateworks Avila Network Platform).
> @@ -33,7 +33,7 @@ config ARCH_ADI_COYOTE
>  	bool "Coyote"
>  	select FORCE_PCI
>  	help
> -	  Say 'Y' here if you want your kernel to support the ADI 
> +	  Say 'Y' here if you want your kernel to support the ADI
>  	  Engineering Coyote Gateway Reference Platform. For more
>  	  information on this platform, see <file:Documentation/arm/IXP4xx>.
>  
> @@ -56,8 +56,8 @@ config MACH_WG302V2
>  config ARCH_IXDP425
>  	bool "IXDP425"
>  	help
> -	  Say 'Y' here if you want your kernel to support Intel's 
> -	  IXDP425 Development Platform (Also known as Richfield).  
> +	  Say 'Y' here if you want your kernel to support Intel's
> +	  IXDP425 Development Platform (Also known as Richfield).
>  	  For more information on this platform, see <file:Documentation/arm/IXP4xx>.
>  
>  config MACH_IXDPG425
> @@ -88,12 +88,12 @@ config MACH_KIXRP435
>  	  For more information on this platform, see <file:Documentation/arm/IXP4xx>.
>  
>  #
> -# IXCDP1100 is the exact same HW as IXDP425, but with a different machine 
> -# number from the bootloader due to marketing monkeys, so we just enable it 
> +# IXCDP1100 is the exact same HW as IXDP425, but with a different machine
> +# number from the bootloader due to marketing monkeys, so we just enable it
>  # by default if IXDP425 is enabled.
>  #
>  config ARCH_IXCDP1100
> -	bool 
> +	bool
>  	depends on ARCH_IXDP425
>  	default y
>  
> @@ -200,14 +200,14 @@ config IXP4XX_INDIRECT_PCI
>  	bool "Use indirect PCI memory access"
>  	depends on PCI
>  	help
> -          IXP4xx provides two methods of accessing PCI memory space:
> +	  IXP4xx provides two methods of accessing PCI memory space:
>  
> -          1) A direct mapped window from 0x48000000 to 0x4BFFFFFF (64MB).
> -             To access PCI via this space, we simply ioremap() the BAR
> -             into the kernel and we can use the standard read[bwl]/write[bwl]
> -             macros. This is the preferred method due to speed but it
> -             limits the system to just 64MB of PCI memory. This can be
> -             problematic if using video cards and other memory-heavy devices.
> +	  1) A direct mapped window from 0x48000000 to 0x4BFFFFFF (64MB).
> +	     To access PCI via this space, we simply ioremap() the BAR
> +	     into the kernel and we can use the standard read[bwl]/write[bwl]
> +	     macros. This is the preferred method due to speed but it
> +	     limits the system to just 64MB of PCI memory. This can be
> +	     problematic if using video cards and other memory-heavy devices.
>  
>  	  2) If > 64MB of memory space is required, the IXP4xx can be
>  	     configured to use indirect registers to access the whole PCI
> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> index 94500be..144036e 100644
> --- a/arch/arm/mach-mmp/Kconfig
> +++ b/arch/arm/mach-mmp/Kconfig
> @@ -149,7 +149,7 @@ config CPU_MMP2
>  	  Select code specific to MMP2. MMP2 is ARMv7 compatible.
>  
>  config USB_EHCI_MV_U2O
> -        bool "EHCI support for PXA USB OTG controller"
> +	bool "EHCI support for PXA USB OTG controller"
>  	depends on USB_EHCI_MV
>  	help
>  	  Enables support for OTG controller which can be switched to host mode.
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index c4694f2..2e7d733 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -55,7 +55,7 @@ config OMAP_MUX_WARNINGS
>  	default y
>  	help
>  	  Choose Y here to warn whenever driver initialization logic needs
> -	  to change the pin multiplexing setup.	 When there are no warnings
> +	  to change the pin multiplexing setup. When there are no warnings
>  	  printed, it's safe to deselect OMAP_MUX for your product.
>  
>  comment "OMAP Board Type"
> @@ -65,20 +65,20 @@ config MACH_OMAP_INNOVATOR
>  	bool "TI Innovator"
>  	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX)
>  	help
> -          TI OMAP 1510 or 1610 Innovator board support. Say Y here if you
> -          have such a board.
> +	  TI OMAP 1510 or 1610 Innovator board support. Say Y here if you
> +	  have such a board.
>  
>  config MACH_OMAP_H2
>  	bool "TI H2 Support"
>  	depends on ARCH_OMAP1 && ARCH_OMAP16XX
> -    	help
> +	help
>  	  TI OMAP 1610/1611B H2 board support. Say Y here if you have such
>  	  a board.
>  
>  config MACH_OMAP_H3
>  	bool "TI H3 Support"
>  	depends on ARCH_OMAP1 && ARCH_OMAP16XX
> -    	help
> +	help
>  	  TI OMAP 1710 H3 board support. Say Y here if you have such
>  	  a board.
>  
> @@ -91,14 +91,14 @@ config MACH_HERALD
>  config MACH_OMAP_OSK
>  	bool "TI OSK Support"
>  	depends on ARCH_OMAP1 && ARCH_OMAP16XX
> -    	help
> +	help
>  	  TI OMAP 5912 OSK (OMAP Starter Kit) board support. Say Y here
> -          if you have such a board.
> +	  if you have such a board.
>  
>  config OMAP_OSK_MISTRAL
>  	bool "Mistral QVGA board Support"
>  	depends on MACH_OMAP_OSK
> -    	help
> +	help
>  	  The OSK supports an optional add-on board with a Quarter-VGA
>  	  touchscreen, PDA-ish buttons, a resume button, bicolor LED,
>  	  and camera connector.  Say Y here if you have this board.
> @@ -106,14 +106,14 @@ config OMAP_OSK_MISTRAL
>  config MACH_OMAP_PERSEUS2
>  	bool "TI Perseus2"
>  	depends on ARCH_OMAP1 && ARCH_OMAP730
> -    	help
> +	help
>  	  Support for TI OMAP 730 Perseus2 board. Say Y here if you have such
>  	  a board.
>  
>  config MACH_OMAP_FSAMPLE
>  	bool "TI F-Sample"
>  	depends on ARCH_OMAP1 && ARCH_OMAP730
> -    	help
> +	help
>  	  Support for TI OMAP 850 F-Sample board. Say Y here if you have such
>  	  a board.
>  
> @@ -130,10 +130,10 @@ config MACH_OMAP_PALMZ71
>  	bool "Palm Zire71"
>  	depends on ARCH_OMAP1 && ARCH_OMAP15XX
>  	help
> -	 Support for the Palm Zire71 PDA. To boot the kernel,
> -	 you'll need a PalmOS compatible bootloader; check out
> -	 http://hackndev.com/palm/z71 for more information.
> -	 Say Y here if you have such a PDA, say N otherwise.
> +	  Support for the Palm Zire71 PDA. To boot the kernel,
> +	  you'll need a PalmOS compatible bootloader; check out
> +	  http://hackndev.com/palm/z71 for more information.
> +	  Say Y here if you have such a PDA, say N otherwise.
>  
>  config MACH_OMAP_PALMTT
>  	bool "Palm Tungsten|T"
> @@ -179,10 +179,10 @@ config MACH_OMAP_GENERIC
>  	bool "Generic OMAP board"
>  	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX)
>  	help
> -          Support for generic OMAP-1510, 1610 or 1710 board with
> -          no FPGA. Can be used as template for porting Linux to
> -          custom OMAP boards. Say Y here if you have a custom
> -          board.
> +	  Support for generic OMAP-1510, 1610 or 1710 board with
> +	  no FPGA. Can be used as template for porting Linux to
> +	  custom OMAP boards. Say Y here if you have a custom
> +	  board.
>  
>  endmenu
>  
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 5e33d1a..4db9516d 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -174,16 +174,16 @@ config SOC_TI81XX
>  	default y
>  
>  config OMAP_PACKAGE_CBC
> -       bool
> +	bool
>  
>  config OMAP_PACKAGE_CBB
> -       bool
> +	bool
>  
>  config OMAP_PACKAGE_CUS
> -       bool
> +	bool
>  
>  config OMAP_PACKAGE_CBP
> -       bool
> +	bool
>  
>  comment "OMAP Legacy Platform Data Board Type"
>  	depends on ARCH_OMAP2PLUS
> @@ -208,10 +208,10 @@ config MACH_OMAP3_PANDORA
>  	select OMAP_PACKAGE_CBB
>  
>  config MACH_NOKIA_N810
> -       bool
> +	bool
>  
>  config MACH_NOKIA_N810_WIMAX
> -       bool
> +	bool
>  
>  config MACH_NOKIA_N8X0
>  	bool "Nokia N800/N810"
> diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
> index 7426211..458c02f 100644
> --- a/arch/arm/mach-prima2/Kconfig
> +++ b/arch/arm/mach-prima2/Kconfig
> @@ -21,7 +21,7 @@ config ARCH_ATLAS6
>  	default y
>  	select SIRF_IRQ
>  	help
> -          Support for CSR SiRFSoC ARM Cortex A9 Platform
> +	  Support for CSR SiRFSoC ARM Cortex A9 Platform
>  
>  config ARCH_ATLAS7
>  	bool "CSR SiRFSoC ATLAS7 ARM Cortex A7 Platform"
> @@ -31,7 +31,7 @@ config ARCH_ATLAS7
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_SMP
>  	help
> -          Support for CSR SiRFSoC ARM Cortex A7 Platform
> +	  Support for CSR SiRFSoC ARM Cortex A7 Platform
>  
>  config ARCH_PRIMA2
>  	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
> @@ -40,7 +40,7 @@ config ARCH_PRIMA2
>  	select ZONE_DMA
>  	select PRIMA2_TIMER
>  	help
> -          Support for CSR SiRFSoC ARM Cortex A9 Platform
> +	  Support for CSR SiRFSoC ARM Cortex A9 Platform
>  
>  config SIRF_IRQ
>  	bool
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index 686f0bb..bcc6ce4 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -17,8 +17,6 @@ config PLAT_S3C24XX
>  	help
>  	  Base platform code for any Samsung S3C24XX device
>  
> -
> -
>  menu "SAMSUNG S3C24XX SoCs Support"
>  
>  comment "S3C24XX SoCs"
> @@ -138,11 +136,11 @@ config S3C2410_IOTIMING
>  	  and s3c2440/s3c2442 cpu frequency support.
>  
>  config S3C2410_CPUFREQ_UTILS
> -       bool
> -       depends on ARM_S3C24XX_CPUFREQ
> -       help
> -         Internal node to select timing code that is common to the s3c2410
> -         and s3c2440/s3c244 cpu frequency support.
> +	bool
> +	depends on ARM_S3C24XX_CPUFREQ
> +	help
> +	  Internal node to select timing code that is common to the s3c2410
> +	  and s3c2440/s3c244 cpu frequency support.
>  
>  # cpu frequency support common to s3c2412, s3c2413 and s3c2442
>  
> @@ -280,7 +278,7 @@ config MACH_VR1000
>  	help
>  	  Say Y here if you are using the Thorcom VR1000 board.
>  
> -endif	# CPU_S3C2410
> +endif # CPU_S3C2410
>  
>  config S3C2412_PM_SLEEP
>  	bool
> @@ -354,7 +352,7 @@ config MACH_VSTMS
>  	help
>  	  Say Y here if you are using an VSTMS board
>  
> -endif	# CPU_S3C2412
> +endif # CPU_S3C2412
>  
>  if CPU_S3C2416
>  
> @@ -402,7 +400,7 @@ config MACH_S3C2416_DT
>  	  Note: This is under development and not all peripherals can be supported
>  	  with this machine file.
>  
> -endif	# CPU_S3C2416
> +endif # CPU_S3C2416
>  
>  if CPU_S3C2440 || CPU_S3C2442
>  
> @@ -528,7 +526,7 @@ config SMDK2440_CPU2440
>  	default y if ARCH_S3C2440
>  	select S3C2440_XTAL_16934400
>  
> -endif	# CPU_S3C2440
> +endif # CPU_S3C2440
>  
>  if CPU_S3C2442
>  
> @@ -548,7 +546,7 @@ config MACH_NEO1973_GTA02
>  	select S3C24XX_PWM
>  	select S3C_DEV_USB_HOST
>  	help
> -	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
> +	  Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
>  
>  config MACH_RX1950
>  	bool "HP iPAQ rx1950"
> @@ -560,9 +558,9 @@ config MACH_RX1950
>  	select S3C24XX_PWM
>  	select S3C_DEV_NAND
>  	help
> -	   Say Y here if you're using HP iPAQ rx1950
> +	  Say Y here if you're using HP iPAQ rx1950
>  
> -endif	# CPU_S3C2442
> +endif # CPU_S3C2442
>  
>  if CPU_S3C2443 || CPU_S3C2416
>  
> @@ -571,7 +569,7 @@ config S3C2443_SETUP_SPI
>  	help
>  	  Common setup code for SPI GPIO configurations
>  
> -endif	# CPU_S3C2443 || CPU_S3C2416
> +endif # CPU_S3C2443 || CPU_S3C2416
>  
>  if CPU_S3C2443
>  
> @@ -584,7 +582,7 @@ config MACH_SMDK2443
>  	help
>  	  Say Y here if you are using an SMDK2443
>  
> -endif	# CPU_S3C2443
> +endif # CPU_S3C2443
>  
>  config PM_H1940
>  	bool
> @@ -593,4 +591,4 @@ config PM_H1940
>  
>  endmenu	# SAMSUNG S3C24XX SoCs Support
>  
> -endif	# ARCH_S3C24XX
> +endif # ARCH_S3C24XX
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index 5700822..f6b05277 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -100,7 +100,7 @@ config S3C64XX_SETUP_SDHCI_GPIO
>  config S3C64XX_SETUP_SPI
>  	bool
>  	help
> -	 Common setup code for SPI GPIO configurations
> +	  Common setup code for SPI GPIO configurations
>  
>  config S3C64XX_SETUP_USB_PHY
>  	bool
> @@ -110,7 +110,7 @@ config S3C64XX_SETUP_USB_PHY
>  # S36400 Macchine support
>  
>  config MACH_SMDK6400
> -       bool "SMDK6400"
> +	bool "SMDK6400"
>  	depends on ATAGS
>  	select CPU_S3C6400
>  	select S3C64XX_SETUP_SDHCI
> @@ -202,7 +202,7 @@ config SMDK6410_SD_CH0
>  	bool "Use channel 0 only"
>  	depends on MACH_SMDK6410
>  	help
> -          Select CON7 (channel 0) as the MMC/SD slot, as
> +	  Select CON7 (channel 0) as the MMC/SD slot, as
>  	  at least some SMDK6410 boards come with the
>  	  resistors fitted so that the card detects for
>  	  channels 0 and 1 are the same.
> @@ -211,7 +211,7 @@ config SMDK6410_SD_CH1
>  	bool "Use channel 1 only"
>  	depends on MACH_SMDK6410
>  	help
> -          Select CON6 (channel 1) as the MMC/SD slot, as
> +	  Select CON6 (channel 1) as the MMC/SD slot, as
>  	  at least some SMDK6410 boards come with the
>  	  resistors fitted so that the card detects for
>  	  channels 0 and 1 are the same.
> @@ -257,7 +257,7 @@ config MACH_NCP
>  	select S3C_DEV_HSMMC1
>  	select S3C_DEV_I2C1
>  	help
> -          Machine support for the Samsung NCP
> +	  Machine support for the Samsung NCP
>  
>  config MACH_HMT
>  	bool "Airgoo HMT"
> @@ -289,21 +289,21 @@ config MACH_SMARTQ
>  	select SAMSUNG_DEV_PWM
>  	select SAMSUNG_DEV_TS
>  	help
> -	    Shared machine support for SmartQ 5/7
> +	  Shared machine support for SmartQ 5/7
>  
>  config MACH_SMARTQ5
>  	bool "SmartQ 5"
>  	depends on ATAGS
>  	select MACH_SMARTQ
>  	help
> -	    Machine support for the SmartQ 5
> +	  Machine support for the SmartQ 5
>  
>  config MACH_SMARTQ7
>  	bool "SmartQ 7"
>  	depends on ATAGS
>  	select MACH_SMARTQ
>  	help
> -	    Machine support for the SmartQ 7
> +	  Machine support for the SmartQ 7
>  
>  config MACH_WLF_CRAGG_6410
>  	bool "Wolfson Cragganmore 6410"
> diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
> index ce41c67..b1c092c 100644
> --- a/arch/arm/mach-sa1100/Kconfig
> +++ b/arch/arm/mach-sa1100/Kconfig
> @@ -91,8 +91,8 @@ config SA1100_JORNADA720
>  	select SA1111
>  	help
>  	  Say Y here if you want to build a kernel for the HP Jornada 720
> -	  handheld computer.  See 
> -	  <http://h10025.www1.hp.com/ewfrf/wc/product?product=61677&cc=us&lc=en&dlc=en&product=61677#> 
> +	  handheld computer.  See
> +	  <http://h10025.www1.hp.com/ewfrf/wc/product?product=61677&cc=us&lc=en&dlc=en&product=61677#>
>  
>  config SA1100_JORNADA720_SSP
>  	bool "HP Jornada 720 Extended SSP driver"
> diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
> index 8841199..6343961 100644
> --- a/arch/arm/mach-vt8500/Kconfig
> +++ b/arch/arm/mach-vt8500/Kconfig
> @@ -10,9 +10,9 @@ config ARCH_VT8500
>  
>  config ARCH_WM8505
>  	bool "VIA/Wondermedia 85xx and WM8650"
> - 	depends on ARCH_MULTI_V5
> - 	select ARCH_VT8500
> - 	select CPU_ARM926T
> +	depends on ARCH_MULTI_V5
> +	select ARCH_VT8500
> +	select CPU_ARM926T
>  
>  config ARCH_WM8750
>  	bool "WonderMedia WM8750"
> diff --git a/arch/arm/mach-w90x900/Kconfig b/arch/arm/mach-w90x900/Kconfig
> index b16ffc0..1fb3a3b 100644
> --- a/arch/arm/mach-w90x900/Kconfig
> +++ b/arch/arm/mach-w90x900/Kconfig
> @@ -23,7 +23,7 @@ config MACH_W90P910EVB
>  	default y
>  	select CPU_W90P910
>  	help
> -	   Say Y here if you are using the Nuvoton W90P910EVB
> +	  Say Y here if you are using the Nuvoton W90P910EVB
>  
>  endmenu
>  
> @@ -33,7 +33,7 @@ config MACH_W90P950EVB
>  	bool "Nuvoton NUC950 Evaluation Board"
>  	select CPU_NUC950
>  	help
> -	   Say Y here if you are using the Nuvoton NUC950EVB
> +	  Say Y here if you are using the Nuvoton NUC950EVB
>  
>  endmenu
>  
> @@ -43,7 +43,7 @@ config MACH_W90N960EVB
>  	bool "Nuvoton NUC960 Evaluation Board"
>  	select CPU_NUC960
>  	help
> -	   Say Y here if you are using the Nuvoton NUC960EVB
> +	  Say Y here if you are using the Nuvoton NUC960EVB
>  
>  endmenu
>  
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index b169e58..23e75a1 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -123,13 +123,13 @@ config CPU_ARM925T
>  	select CPU_PABRT_LEGACY
>  	select CPU_THUMB_CAPABLE
>  	select CPU_TLB_V4WBI if MMU
> - 	help
> - 	  The ARM925T is a mix between the ARM920T and ARM926T, but with
> +	help
> +	  The ARM925T is a mix between the ARM920T and ARM926T, but with
>  	  different instruction and data caches. It is used in TI's OMAP
> - 	  device family.
> +	  device family.
>  
> - 	  Say Y if you want support for the ARM925T processor.
> - 	  Otherwise, say N.
> +	  Say Y if you want support for the ARM925T processor.
> +	  Otherwise, say N.
>  
>  # ARM926T
>  config CPU_ARM926T
> @@ -829,19 +829,19 @@ config HARDEN_BRANCH_PREDICTOR
>  	depends on CPU_SPECTRE
>  	default y
>  	help
> -	   Speculation attacks against some high-performance processors rely
> -	   on being able to manipulate the branch predictor for a victim
> -	   context by executing aliasing branches in the attacker context.
> -	   Such attacks can be partially mitigated against by clearing
> -	   internal branch predictor state and limiting the prediction
> -	   logic in some situations.
> +	  Speculation attacks against some high-performance processors rely
> +	  on being able to manipulate the branch predictor for a victim
> +	  context by executing aliasing branches in the attacker context.
> +	  Such attacks can be partially mitigated against by clearing
> +	  internal branch predictor state and limiting the prediction
> +	  logic in some situations.
>  
> -	   This config option will take CPU-specific actions to harden
> -	   the branch predictor against aliasing attacks and may rely on
> -	   specific instruction sequences or control bits being set by
> -	   the system firmware.
> +	  This config option will take CPU-specific actions to harden
> +	  the branch predictor against aliasing attacks and may rely on
> +	  specific instruction sequences or control bits being set by
> +	  the system firmware.
>  
> -	   If unsure, say Y.
> +	  If unsure, say Y.
>  
>  config TLS_REG_EMUL
>  	bool
> @@ -983,14 +983,14 @@ if CACHE_L2X0
>  config PL310_ERRATA_588369
>  	bool "PL310 errata: Clean & Invalidate maintenance operations do not invalidate clean lines"
>  	help
> -	   The PL310 L2 cache controller implements three types of Clean &
> -	   Invalidate maintenance operations: by Physical Address
> -	   (offset 0x7F0), by Index/Way (0x7F8) and by Way (0x7FC).
> -	   They are architecturally defined to behave as the execution of a
> -	   clean operation followed immediately by an invalidate operation,
> -	   both performing to the same memory location. This functionality
> -	   is not correctly implemented in PL310 prior to r2p0 (fixed in r2p0)
> -	   as clean lines are not invalidated as a result of these operations.
> +	  The PL310 L2 cache controller implements three types of Clean &
> +	  Invalidate maintenance operations: by Physical Address
> +	  (offset 0x7F0), by Index/Way (0x7F8) and by Way (0x7FC).
> +	  They are architecturally defined to behave as the execution of a
> +	  clean operation followed immediately by an invalidate operation,
> +	  both performing to the same memory location. This functionality
> +	  is not correctly implemented in PL310 prior to r2p0 (fixed in r2p0)
> +	  as clean lines are not invalidated as a result of these operations.
>  
>  config PL310_ERRATA_727915
>  	bool "PL310 errata: Background Clean & Invalidate by Way operation can cause data corruption"
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 53da57f..1946c3d 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -39,12 +39,12 @@ config SAMSUNG_ATAGS
>  	def_bool n
>  	depends on ATAGS
>  	help
> -	   This option enables ATAGS based boot support code for
> -	   Samsung platforms, including static platform devices, legacy
> -	   clock, timer and interrupt initialization, etc.
> +	  This option enables ATAGS based boot support code for
> +	  Samsung platforms, including static platform devices, legacy
> +	  clock, timer and interrupt initialization, etc.
>  
> -	   Platforms that support only DT based boot need not to select
> -	   this option.
> +	  Platforms that support only DT based boot need not to select
> +	  this option.
>  
>  if SAMSUNG_ATAGS
>  
> @@ -98,7 +98,7 @@ config S3C_DEV_HSMMC3
>  config S3C_DEV_HWMON
>  	bool
>  	help
> -	    Compile in platform device definitions for HWMON
> +	  Compile in platform device definitions for HWMON
>  
>  config S3C_DEV_I2C1
>  	bool
> @@ -202,7 +202,7 @@ config S3C64XX_DEV_SPI2
>  config SAMSUNG_DEV_TS
>  	bool
>  	help
> -	    Common in platform device definitions for touchscreen device
> +	  Common in platform device definitions for touchscreen device
>  
>  config SAMSUNG_DEV_KEYPAD
>  	bool
> @@ -247,13 +247,13 @@ config SAMSUNG_PM_DEBUG
>  	  for more information.
>  
>  config S3C_PM_DEBUG_LED_SMDK
> -       bool "SMDK LED suspend/resume debugging"
> -       depends on PM && (MACH_SMDK6410)
> -       help
> -         Say Y here to enable the use of the SMDK LEDs on the baseboard
> -	 for debugging of the state of the suspend and resume process.
> +	bool "SMDK LED suspend/resume debugging"
> +	depends on PM && (MACH_SMDK6410)
> +	help
> +	  Say Y here to enable the use of the SMDK LEDs on the baseboard
> +	  for debugging of the state of the suspend and resume process.
>  
> -	 Note, this currently only works for S3C64XX based SMDK boards.
> +	  Note, this currently only works for S3C64XX based SMDK boards.
>  
>  config SAMSUNG_PM_CHECK
>  	bool "S3C2410 PM Suspend Memory CRC"
