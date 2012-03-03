From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP totally fucked?
Date: Sat, 3 Mar 2012 13:21:02 -0800
Message-ID: <20120303212101.GF10293@atomide.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
 <20120303180428.GA10293@atomide.com>
 <20120303183225.GA17710@n2100.arm.linux.org.uk>
 <20120303190140.GB19248@atomide.com>
 <20120303192839.GB17710@n2100.arm.linux.org.uk>
 <20120303200123.GB10293@atomide.com>
 <20120303202810.GC10293@atomide.com>
 <20120303203448.GD10293@atomide.com>
 <20120303205200.GC17710@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44379 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab2CCVVH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Mar 2012 16:21:07 -0500
Content-Disposition: inline
In-Reply-To: <20120303205200.GC17710@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120303 12:20]:
> On Sat, Mar 03, 2012 at 12:34:48PM -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [120303 11:56]:
> > > * Tony Lindgren <tony@atomide.com> [120303 11:29]:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120303 10:57]:
> > > > > 
> > > > > Even with the full config, making oldconfig I get:
> > > > > 
> > > > > OMAP2420 support (SOC_OMAP2420) [Y/n] (NEW) 
> > > > > OMAP2430 support (SOC_OMAP2430) [Y/n] (NEW) 
> > > > > OMAP3430 support (SOC_OMAP3430) [Y/n] (NEW) 
> > > > > TI81XX support (SOC_OMAPTI81XX) [Y/n] (NEW) 
> > > > > AM33XX support (SOC_OMAPAM33XX) [Y/n] (NEW) 
> > > > > OMAP44XX support (SOC_OMAP44XX) [Y/n] (NEW) 
> > > > > 
> > > > > May I remind you of this mail from Linus:
> > > > > 
> > > > > 	https://lkml.org/lkml/2012/1/6/354
> > > > > 
> > > > > So really this is a rather horrid mess.
> > > > 
> > > > Hmm yes. Sounds like we need to remove the defaults and instead
> > > > add them to omap2plus_defconfig.
> > > > 
> > > > I'll do a patch to fix that.
> > > 
> > > How about the following patch after we revert commit 72b026a4?
> > > 
> > > That still leaves the randconfig not necessarily selecting
> > > any of ARCH_OMAP2/3/4 issue, but that can be dealt separately
> > > later on.
> > 
> > Grr, need to look at it more.. Now it leaves out ARCH_OMAP2/3/4
> > when doing a make oldconfig with some existing .config file.
> 
> There's also something else wrong:
> 
> *
> * OMAP Core Type
> *
> OMAP2420 support (SOC_OMAP2420) [Y/n] (NEW) n
> OMAP2430 support (SOC_OMAP2430) [Y/n] (NEW) n
> OMAP3430 support (SOC_OMAP3430) [Y/n] (NEW) n
> TI81XX support (SOC_OMAPTI81XX) [Y/n] (NEW) n
> AM33XX support (SOC_OMAPAM33XX) [Y/n] (NEW) n
> OMAP44XX support (SOC_OMAP44XX) [Y/n] (NEW) n
> *
> * OMAP Board Type
> *
> Generic OMAP2+ board (MACH_OMAP_GENERIC) [Y/?] y
> OMAP3 debugging peripherals (OMAP3_EMU) [N/y/?] (NEW) 
> Enable SDRC AC timing register changes (OMAP3_SDRC_AC_TIMING) [N/y/?] (NEW) 
> 
> Shouldn't the last two options depend on OMAP3 stuff?

Yes it should. Looks like the default n there can go too.

I think the best solution is to have the board select the
omap type. From user point of view there's really no need
to have separate menu for selecting the omap type, selecting
just the board is a bit more intuitive.

Anyways, we should revert commit 72b026a4 because of the
breakage it causes.
 
> And why do we have:
> 
> config ARCH_OMAP2PLUS
> 	select USE_OF
> 
> Do we really _need_ OF, or is it just irqdomain that's required?

Let's check, maybe the irqdomain is still enough here except
for MACH_OMAP_GENERIC to here. Eventually we'll be needing OF,
but that's still few merge cycles away.

Below is a second attempt for the Kconfig changes. Now the
CONFIG_MACH_ needs to be set in your seed .config.

Regards,

Tony


Author: Tony Lindgren <tony@atomide.com>
Date:   Sat Mar 3 12:10:29 2012 -0800

    ARM: OMAP2+: Remove default y for mach-omap2/Kconfig
    
    This can make existing .config files too greedy when running
    make oldconfig. Further default y should not be set as pointed
    out by Russell King and explained by Linus Torvalds at:
    
    https://lkml.org/lkml/2012/1/6/354
    
    Instead, let's have the selected board select the SoC it needs.
    And let's update omap2plus_defconfig with the existing
    boards as this defconfig is supposed to boot on all omap2plus
    boards.
    
    Note that we can also remove depends on ARCH_OMAP2PLUS as
    that's implied for this Kconfig file. And the default n
    line can go too.

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d5f00d7..56084fb 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -23,6 +23,44 @@ CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_ARCH_OMAP=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX_DEBUG=y
+CONFIG_MACH_OMAP_GENERIC=y
+CONFIG_ARCH_OMAP2PLUS_TYPICAL=y
+CONFIG_ARCH_OMAP2=y
+CONFIG_ARCH_OMAP3=y
+CONFIG_ARCH_OMAP4=y
+CONFIG_SOC_OMAP2420=y
+CONFIG_SOC_OMAP2430=y
+CONFIG_SOC_OMAP3430=y
+CONFIG_SOC_OMAPTI81XX=y
+CONFIG_SOC_OMAPAM33XX=y
+CONFIG_MACH_OMAP_H4=y
+CONFIG_MACH_OMAP_APOLLON=y
+CONFIG_MACH_OMAP_2430SDP=y
+CONFIG_MACH_OMAP3_BEAGLE=y
+CONFIG_MACH_DEVKIT8000=y
+CONFIG_MACH_OMAP_LDP=y
+CONFIG_MACH_OMAP3530_LV_SOM=y
+CONFIG_MACH_OMAP3_TORPEDO=y
+CONFIG_MACH_OVERO=y
+CONFIG_MACH_OMAP3EVM=y
+CONFIG_MACH_OMAP3517EVM=y
+CONFIG_MACH_OMAP3_PANDORA=y
+CONFIG_MACH_OMAP3_TOUCHBOOK=y
+CONFIG_MACH_OMAP_3430SDP=y
+CONFIG_MACH_NOKIA_N8X0=y
+CONFIG_MACH_NOKIA_RM680=y
+CONFIG_MACH_NOKIA_RX51=y
+CONFIG_MACH_OMAP_ZOOM2=y
+CONFIG_MACH_OMAP_ZOOM3=y
+CONFIG_MACH_CM_T35=y
+CONFIG_MACH_CM_T3517=y
+CONFIG_MACH_IGEP0030=y
+CONFIG_MACH_SBC3530=y
+CONFIG_MACH_OMAP_3630SDP=y
+CONFIG_MACH_TI8168EVM=y
+CONFIG_MACH_TI8148EVM=y
+CONFIG_MACH_OMAP_4430SDP=y
+CONFIG_MACH_OMAP4_PANDA=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 337f98d..7ea6c67 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -4,7 +4,6 @@ menu "TI OMAP2/3/4 Specific Features"
 
 config ARCH_OMAP2PLUS_TYPICAL
 	bool "Typical OMAP configuration"
-	default y
 	select AEABI
 	select REGULATOR
 	select PM_RUNTIME
@@ -21,16 +20,12 @@ config ARCH_OMAP2PLUS_TYPICAL
 	  Compile a kernel suitable for booting most boards
 
 config ARCH_OMAP2
-	bool "TI OMAP2"
-	depends on ARCH_OMAP2PLUS
-	default y
+	bool
 	select CPU_V6
 	select MULTI_IRQ_HANDLER
 
 config ARCH_OMAP3
-	bool "TI OMAP3"
-	depends on ARCH_OMAP2PLUS
-	default y
+	bool
 	select CPU_V7
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARCH_HAS_OPP
@@ -39,9 +34,7 @@ config ARCH_OMAP3
 	select MULTI_IRQ_HANDLER
 
 config ARCH_OMAP4
-	bool "TI OMAP4"
-	default y
-	depends on ARCH_OMAP2PLUS
+	bool
 	select CACHE_L2X0
 	select CPU_V7
 	select ARM_GIC
@@ -55,37 +48,29 @@ config ARCH_OMAP4
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_CPU_SUSPEND if PM
 
-comment "OMAP Core Type"
-	depends on ARCH_OMAP2
-
 config SOC_OMAP2420
-	bool "OMAP2420 support"
-	depends on ARCH_OMAP2
-	default y
+	bool
+	select ARCH_OMAP2
 	select OMAP_DM_TIMER
 	select ARCH_OMAP_OTG
 
 config SOC_OMAP2430
-	bool "OMAP2430 support"
-	depends on ARCH_OMAP2
-	default y
+	bool
+	select ARCH_OMAP2
 	select ARCH_OMAP_OTG
 
 config SOC_OMAP3430
-	bool "OMAP3430 support"
-	depends on ARCH_OMAP3
-	default y
+	bool
+	select ARCH_OMAP3
 	select ARCH_OMAP_OTG
 
 config SOC_OMAPTI81XX
-	bool "TI81XX support"
-	depends on ARCH_OMAP3
-	default y
+	bool
+	select ARCH_OMAP3
 
 config SOC_OMAPAM33XX
-	bool "AM33XX support"
-	depends on ARCH_OMAP3
-	default y
+	bool
+	select ARCH_OMAP3
 
 config OMAP_PACKAGE_ZAF
        bool
@@ -112,64 +97,54 @@ config OMAP_PACKAGE_CBS
        bool
 
 comment "OMAP Board Type"
-	depends on ARCH_OMAP2PLUS
 
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP2+ board"
-	depends on ARCH_OMAP2PLUS
 	select USE_OF
-	default y
 	help
 	  Support for generic TI OMAP2+ boards using Flattened Device Tree.
 	  More information at Documentation/devicetree
 
 config MACH_OMAP2_TUSB6010
 	bool
-	depends on ARCH_OMAP2 && SOC_OMAP2420
+	select SOC_OMAP2420
 	default y if MACH_NOKIA_N8X0
 
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
-	depends on SOC_OMAP2420
-	default y
+	select SOC_OMAP2420
 	select OMAP_PACKAGE_ZAF
 	select OMAP_DEBUG_DEVICES
 
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
-	depends on SOC_OMAP2420
-	default y
+	select SOC_OMAP2420
 	select OMAP_PACKAGE_ZAC
 
 config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
-	depends on SOC_OMAP2430
-	default y
+	select SOC_OMAP2430
 	select OMAP_PACKAGE_ZAC
 
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_DEVKIT8000
 	bool "DEVKIT8000 board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CUS
 
 config MACH_OMAP_LDP
 	bool "OMAP3 LDP board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3530_LV_SOM
 	bool "OMAP3 Logic 3530 LV SOM board"
-	depends on ARCH_OMAP3
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
-	default y
 	help
 	 Support for the LogicPD OMAP3530 SOM Development kit
 	 for full description please see the products webpage at
@@ -177,9 +152,8 @@ config MACH_OMAP3530_LV_SOM
 
 config MACH_OMAP3_TORPEDO
 	bool "OMAP3 Logic 35x Torpedo board"
-	depends on ARCH_OMAP3
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
-	default y
 	help
 	 Support for the LogicPD OMAP35x Torpedo Development kit
 	 for full description please see the products webpage at
@@ -187,43 +161,37 @@ config MACH_OMAP3_TORPEDO
 
 config MACH_OVERO
 	bool "Gumstix Overo board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_CRANEBOARD
 	bool "AM3517/05 CRANE board"
-	depends on ARCH_OMAP3
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config MACH_OMAP3_TOUCHBOOK
 	bool "OMAP3 Touch Book"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_NOKIA_N800
@@ -237,8 +205,7 @@ config MACH_NOKIA_N810_WIMAX
 
 config MACH_NOKIA_N8X0
 	bool "Nokia N800/N810"
-	depends on SOC_OMAP2420
-	default y
+	select SOC_OMAP2420
 	select OMAP_PACKAGE_ZAC
 	select MACH_NOKIA_N800
 	select MACH_NOKIA_N810
@@ -246,20 +213,17 @@ config MACH_NOKIA_N8X0
 
 config MACH_NOKIA_RM680
 	bool "Nokia RM-680 board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP_ZOOM2
 	bool "OMAP3 Zoom2 board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 	select SERIAL_8250
 	select SERIAL_CORE_CONSOLE
@@ -268,8 +232,7 @@ config MACH_OMAP_ZOOM2
 
 config MACH_OMAP_ZOOM3
 	bool "OMAP3630 Zoom3 board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBP
 	select SERIAL_8250
 	select SERIAL_CORE_CONSOLE
@@ -278,15 +241,13 @@ config MACH_OMAP_ZOOM3
 
 config MACH_CM_T35
 	bool "CompuLab CM-T35/CM-T3730 modules"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select MACH_CM_T3730
 	select OMAP_PACKAGE_CUS
 
 config MACH_CM_T3517
 	bool "CompuLab CM-T3517 module"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_CM_T3730
@@ -294,51 +255,43 @@ config MACH_CM_T3730
 
 config MACH_IGEP0020
 	bool "IGEP v2 board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_IGEP0030
 	bool "IGEP OMAP3 module"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 	select MACH_IGEP0020
 
 config MACH_SBC3530
 	bool "OMAP3 SBC STALKER board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CUS
 
 config MACH_OMAP_3630SDP
 	bool "OMAP3630 SDP board"
-	depends on ARCH_OMAP3
-	default y
+	select ARCH_OMAP3
 	select OMAP_PACKAGE_CBP
 
 config MACH_TI8168EVM
 	bool "TI8168 Evaluation Module"
-	depends on SOC_OMAPTI81XX
-	default y
+	select SOC_OMAPTI81XX
 
 config MACH_TI8148EVM
 	bool "TI8148 Evaluation Module"
-	depends on SOC_OMAPTI81XX
-	default y
+	select SOC_OMAPTI81XX
 
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
-	default y
-	depends on ARCH_OMAP4
+	select ARCH_OMAP4
 	select OMAP_PACKAGE_CBL
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config MACH_OMAP4_PANDA
 	bool "OMAP4 Panda Board"
-	default y
-	depends on ARCH_OMAP4
+	select ARCH_OMAP4
 	select OMAP_PACKAGE_CBL
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
@@ -354,7 +307,6 @@ config OMAP3_EMU
 config OMAP3_SDRC_AC_TIMING
 	bool "Enable SDRC AC timing register changes"
 	depends on ARCH_OMAP3
-	default n
 	help
 	  If you know that none of your system initiators will attempt to
 	  access SDRAM during CORE DVFS, select Y here.  This should boost
