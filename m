From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: move platform_device_register under
 mach-omap2
Date: Fri, 27 Mar 2009 17:30:14 +0200 (EET)
Message-ID: <20090327.173014.190372579.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E2349AE08@dlee03.ent.ti.com>
	<20090325.151129.02294438.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E2357E193@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41088 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbZC0Pao (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2009 11:30:44 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2357E193@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, 2ameya@gmail.com

Hi Hari,

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE: move platform_device_register under mach-omap2
Date: Fri, 27 Mar 2009 14:42:18 +0100

> Hi Doyu-San,
> 
> > > I am still going through the patch, but one quick question regarding
> > > this. One of the requirements of DSP memory pool is that it should
> > > be physically contiguous and non-cacheable. I hope the below patch
> > > is taking care of this requirement.
> > 
> > This patch reserves a *contigious* physical memory area and passes
> > this physical address to the bridge driver through
> > ldm(platform_data). Then this area is ioremap()'ed in
> > "MEM_ExtPhysPoolInit()". So it should be non-cachable and contigious.
> 
> -- We validated your patch with TI's internal test suite and it looks good.

Thank you for your effort.

> The only comment I have is with this patch now we would require 2
> modules to insert for DSP Bridge to work. I think it would be nice
> if we compile these 2 modules into 1 module so that we have only
> DSPBridge module. 

Hm..then, how about the following?

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1ed6621..d427c90 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -35,7 +35,9 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 obj-$(CONFIG_OMAP_PM_SRF)		+=  resource34xx.o
 
-obj-$(CONFIG_MPU_BRIDGE)		+= dspbridge.o
+
+dspbridge-$(CONFIG_MPU_BRIDGE)		:= dspbridge.o
+obj-y					+= $(dspbridge-m) $(drpbridge-y)
 
 # DSP
 obj-$(CONFIG_OMAP_MMU_FWK)	+= mmu_mach.o

