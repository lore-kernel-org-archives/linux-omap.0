From: Felipe Balbi <balbi@ti.com>
Subject: Re: Latest config warning
Date: Fri, 7 Jan 2011 21:22:38 +0200
Message-ID: <20110107192238.GD2272@legolas.emea.dhcp.ti.com>
References: <20110107113506.GK1198@n2100.arm.linux.org.uk>
 <20110107164748.GC880@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024829AE8C@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:42875 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862Ab1AGTWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 14:22:43 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024829AE8C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>

Hi,

On Fri, Jan 07, 2011 at 11:13:40PM +0530, Premi, Sanjeev wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110107 03:34]:
> > > warning: (ARCH_STMP3XXX && <choice> || ARCH_OMAP3 && 
> > ARCH_OMAP2PLUS) selects USB_ARCH_HAS_EHCI which has unmet 
> > direct dependencies (USB_SUPPORT)
> > > 
> > > This didn't happen with 2.6.37.  Maybe a missing select USB_SUPPORT
> > > somewhere?
> > 
> 
> I had come across this while building the "minimal kernel" for omap3evm.
> Here is my local patch:
> 
> >From bd4efa15ec96116b359d18913c91bcbb45b46ee1 Mon Sep 17 00:00:00 2001
> From: Sanjeev Premi <premi@ti.com>
> Date: Tue, 4 Jan 2011 18:37:39 +0530
> Subject: [PATCH] omap3: fix Kconfig dependency on USB_SUPPORT
> 
> This patch fixes the following warning due to unmet dependency:
> 
> warning: (ARCH_STMP3XXX && <choice> || ARCH_OMAP3 && ARCH_OMAP
> 2PLUS) selects USB_ARCH_HAS_EHCI which has unmet direct depend
> encies (USB_SUPPORT)
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 310b759..3d67b9b 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -33,7 +33,7 @@ config ARCH_OMAP3
>  	depends on ARCH_OMAP2PLUS
>  	default y
>  	select CPU_V7
> -	select USB_ARCH_HAS_EHCI
> +	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
>  	select ARCH_HAS_OPP if PM
>   	select PM_OPP if PM
> -- 
> 1.7.2.2
> 
> If this is a real solution, I can submit it as formal patch

This is one way to do it, but I believe the real fix would be to change
drivers/usb/Kconfig to something like:

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 5a7c8f1..558cf4d 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -10,8 +10,6 @@ menuconfig USB_SUPPORT
          This option adds core support for Universal Serial Bus (USB).
          You will also need drivers from the following menu to make use of it.
 
-if USB_SUPPORT
-
 # Host-side USB depends on having a host controller
 # NOTE:  dummy_hcd is always an option, but it's ignored here ...
 # NOTE:  SL-811 option should be board-specific ...
@@ -70,6 +68,8 @@ config USB_ARCH_HAS_EHCI
        default y if ARCH_CNS3XXX
        default PCI
 
+if USB_SUPPORT
+
 # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
 config USB
        tristate "Support for Host-side USB"

The idea is that ARCHs can select USB_ARCH_HAS_* without having to
enable USB_SUPPORT. Currently, there's a big mess of conditional default
values on all USB_ARCH_HAS_* entries:

config USB_ARCH_HAS_EHCI
	boolean
	default y if PPC_83xx
	default y if PPC_MPC512x
	default y if SOC_AU1200
	default y if ARCH_IXP4XX
	default y if ARCH_W90X900
	default y if ARCH_AT91SAM9G45
	default y if ARCH_MXC
	default y if ARCH_OMAP3
	default y if ARCH_CNS3XXX
	default PCI

IMHO it's much better to have something like:

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 5a7c8f1..ac137d1 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -10,8 +10,6 @@ menuconfig USB_SUPPORT
          This option adds core support for Universal Serial Bus (USB).
          You will also need drivers from the following menu to make use of it.
 
-if USB_SUPPORT
-
 # Host-side USB depends on having a host controller
 # NOTE:  dummy_hcd is always an option, but it's ignored here ...
 # NOTE:  SL-811 option should be board-specific ...
@@ -59,16 +57,9 @@ config USB_ARCH_HAS_OHCI
 # some non-PCI hcds implement EHCI
 config USB_ARCH_HAS_EHCI
        boolean
-       default y if PPC_83xx
-       default y if PPC_MPC512x
-       default y if SOC_AU1200
-       default y if ARCH_IXP4XX
-       default y if ARCH_W90X900
-       default y if ARCH_AT91SAM9G45
-       default y if ARCH_MXC
-       default y if ARCH_OMAP3
-       default y if ARCH_CNS3XXX
-       default PCI
+       default n
+
+if USB_SUPPORT
 
 # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
 config USB

and expect ARCH Kconfigs to select the features they have.

Greg, what do you think ?

-- 
balbi
