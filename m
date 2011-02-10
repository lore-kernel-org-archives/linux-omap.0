From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Thu, 10 Feb 2011 20:19:19 +0530
Message-ID: <06aa531b67f240da586a7b56238d56b2@mail.gmail.com>
References: <20110125121655.GD13300@n2100.arm.linux.org.uk>
 <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com> <20110125125656.GG13300@n2100.arm.linux.org.uk>
 <20110125130422.GH13300@n2100.arm.linux.org.uk> <20110125130611.GA15663@n2100.arm.linux.org.uk>
 <627ff975140c8e4afbad281105b29d35@mail.gmail.com> <20110204104113.GD15004@n2100.arm.linux.org.uk>
 <c703383234131695d040a1e5b8a79413@mail.gmail.com> <20110204113053.GF15004@n2100.arm.linux.org.uk>
 <247f9ef444eeb8ca59de74837a3e9c62@mail.gmail.com> <20110207101829.GA32431@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:58456 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179Ab1BJOtX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 09:49:23 -0500
Received: by mail-wy0-f182.google.com with SMTP id 19so1458108wyf.27
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 06:49:21 -0800 (PST)
In-Reply-To: <20110207101829.GA32431@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, February 07, 2011 3:48 PM
> To: Santosh Shilimkar
> Cc: catalin.marinas@arm.com; linus.ml.walleij@gmail.com; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> ccross@android.com
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
[....]

> > > 8<------
> > > Subject: [PATCH] ARM: smp: add function to set WFI low-power
> mode
> > > for SMP CPUs
> > >
> > > Add a function to set the SCU low-power mode for SMP CPUs.  This
> > > centralizes this functionality rather than having to expose the
> > > SCU register definitions to each platform.
> > >
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > ---
> > >  arch/arm/include/asm/smp_scu.h |    5 +++++
> > >  arch/arm/kernel/smp_scu.c      |   24 ++++++++++++++++++++++++
> > >  2 files changed, 29 insertions(+), 0 deletions(-)
> > >
[...]

> > > +int scu_power_mode(void __iomem *scu_base, unsigned int mode)
> > > +{
> > > +	unsigned int val;
> > > +	int cpu = smp_processor_id();
> > > +	int shift;
> > shift is unused with this version now so I am removing it.
>
> Yes, I noticed that - it's gone in the version I merged into my
> tree.

This patch will need below update so that the smp_scu.h
header can be included from assembly files. Will you
fold this into your patch or you want me to
send below as separate patch ?

diff --git a/arch/arm/include/asm/smp_scu.h
b/arch/arm/include/asm/smp_scu.h
index 800860d..8895c6c 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -5,8 +5,11 @@
 #define SCU_PM_DORMANT	2
 #define SCU_PM_POWEROFF	3

+#ifndef __ASSEMBLER__
+
 unsigned int scu_get_core_count(void __iomem *);
 void scu_enable(void __iomem *);
 int scu_power_mode(void __iomem *, unsigned int);

 #endif
+#endif
