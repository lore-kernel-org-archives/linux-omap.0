From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Fix mailbox compile for 24xx (Re: OMAP2 build
	errors)
Date: Sat, 28 Mar 2009 10:57:33 -0700
Message-ID: <20090328175732.GC5291@atomide.com>
References: <20090328124823.GB4550@n2100.arm.linux.org.uk> <20090328173552.GB5291@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53956 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbZC1R5i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Mar 2009 13:57:38 -0400
Content-Disposition: inline
In-Reply-To: <20090328173552.GB5291@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Tony Lindgren <tony@atomide.com> [090328 10:36]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090328 05:48]:
> > The result of building an OMAP2 configuration for merged mainline, master
> > and devel branches is:
> > 
> >   CC      arch/arm/mach-omap2/devices.o
> > arch/arm/mach-omap2/devices.c:160: error: ■OMAP34XX_MAILBOX_BASE■ undeclared here (not in a function)
> > 
> > Please resolve ASAP - if I don't have a patch by this evening, I will
> > commit the work-around below:
> > 
> > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> > index d6b4b2f..d16d880 100644
> > --- a/arch/arm/mach-omap2/devices.c
> > +++ b/arch/arm/mach-omap2/devices.c
> > @@ -156,6 +156,7 @@ static struct resource omap2_mbox_resources[] = {
> >  };
> >  
> >  static struct resource omap3_mbox_resources[] = {
> > +#ifdef CONFIG_ARCH_OMAP3
> >  	{
> >  		.start		= OMAP34XX_MAILBOX_BASE,
> >  		.end		= OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
> > @@ -165,6 +166,7 @@ static struct resource omap3_mbox_resources[] = {
> >  		.start		= INT_24XX_MAIL_U0_MPU,
> >  		.flags		= IORESOURCE_IRQ,
> >  	},
> > +#endif
> >  };
> >  
> >  static struct platform_device mbox_device = {
> 
> Hmm, I thought I compiled all boards both against mainline and
> omap-clks3. I'll check it and send a patch ASAP.

But did not seem to have CONFIG_OMAP_MBOX_FWK set in my 24xx configs.

Here's the fix, also in your patch system as 5434/1.

I'll also continue the header clean-up for the next merge window to get
rid of the ifdefs in the processor header files to fix things like
OMAP2_32KSYNCT_BASE, OMAP2_CM_BASE, OMAP2_PRM_BASE and OMAP2_VA_IC_BASE.

Tony
 

--dDRMvlgZJXvWKvBx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mbox-compile.patch"

>From a319737996b33cb668583b47cf38239085b7e95f Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Sat, 28 Mar 2009 10:50:05 -0700
Subject: [PATCH] ARM: OMAP: Fix mailbox compile for 24xx

OMAP34XX_MAILBOX_BASE must be defined both for 24xx and 34xx.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index 1b1c35d..ab64015 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -81,6 +81,7 @@
 #define OMAP34XX_HSUSB_HOST_BASE	(L4_34XX_BASE + 0x64000)
 #define OMAP34XX_USBTLL_BASE	(L4_34XX_BASE + 0x62000)
 
+#define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
 
 #if defined(CONFIG_ARCH_OMAP3430)
 
@@ -88,7 +89,6 @@
 #define OMAP2_CM_BASE			OMAP3430_CM_BASE
 #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
 #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
-#define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
 
 #endif
 

--dDRMvlgZJXvWKvBx--
