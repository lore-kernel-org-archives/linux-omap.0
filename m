From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Latest config warning
Date: Fri, 7 Jan 2011 23:13:40 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024829AE8C@dbde02.ent.ti.com>
References: <20110107113506.GK1198@n2100.arm.linux.org.uk>
 <20110107164748.GC880@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51048 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754396Ab1AGRnz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 12:43:55 -0500
In-Reply-To: <20110107164748.GC880@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, January 07, 2011 10:18 PM
> To: Russell King - ARM Linux; Balbi, Felipe
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Latest config warning
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110107 03:34]:
> > warning: (ARCH_STMP3XXX && <choice> || ARCH_OMAP3 && 
> ARCH_OMAP2PLUS) selects USB_ARCH_HAS_EHCI which has unmet 
> direct dependencies (USB_SUPPORT)
> > 
> > This didn't happen with 2.6.37.  Maybe a missing select USB_SUPPORT
> > somewhere?
> 

I had come across this while building the "minimal kernel" for omap3evm.
Here is my local patch:

>From bd4efa15ec96116b359d18913c91bcbb45b46ee1 Mon Sep 17 00:00:00 2001
From: Sanjeev Premi <premi@ti.com>
Date: Tue, 4 Jan 2011 18:37:39 +0530
Subject: [PATCH] omap3: fix Kconfig dependency on USB_SUPPORT

This patch fixes the following warning due to unmet dependency:

warning: (ARCH_STMP3XXX && <choice> || ARCH_OMAP3 && ARCH_OMAP
2PLUS) selects USB_ARCH_HAS_EHCI which has unmet direct depend
encies (USB_SUPPORT)

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 310b759..3d67b9b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -33,7 +33,7 @@ config ARCH_OMAP3
 	depends on ARCH_OMAP2PLUS
 	default y
 	select CPU_V7
-	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
 	select ARCH_HAS_OPP if PM
  	select PM_OPP if PM
-- 
1.7.2.2

If this is a real solution, I can submit it as formal patch

~sanjeev

> Felipe, care to take a look at this one?
> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 