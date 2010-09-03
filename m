From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Thu, 2 Sep 2010 18:39:41 -0700
Message-ID: <20100903013940.GH11597@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100817135205.GC20325@n2100.arm.linux.org.uk>
 <20100817141210.GJ12184@atomide.com>
 <20100817154035.GD20325@n2100.arm.linux.org.uk>
 <20100819073810.GR12184@atomide.com>
 <20100902133301.GI26319@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CNK/L7dwKXQ4Ub8J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51082 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab0ICBjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 21:39:54 -0400
Content-Disposition: inline
In-Reply-To: <20100902133301.GI26319@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 06:25]:
> On Thu, Aug 19, 2010 at 10:38:11AM +0300, Tony Lindgren wrote:
> > --- a/arch/arm/kernel/head.S
> > +++ b/arch/arm/kernel/head.S
> > @@ -346,8 +346,10 @@ __fixup_smp:
> >  	bne	smp_on_up		@ no, assume UP
> >  	mrc	p15, 0, r0, c0, c0, 5	@ read MIDR
> >  	movs	r0, r0, lsr #30
> > -	teqne	r0, #3			@ check top two bits 00 or 11
> > -	moveq	pc, lr
> > +	teq	r0, #0			@ check two top bits 00
> > +	beq	smp_on_up		@ yes, assume UP
> > +	teq	r0, #3			@ check top two bits 11
> > +	movne	pc, lr			@ no, running on SMP hw
> 
> This should be:
> 
> 	movs	r0, r0, lsr #30
> 	teqne	r0, #3
> 	movne	pc, lr
> 
> so that 0 or 3 avoids the return.

Actually should also handle value of 1:

31	30
0	0	Not using new register, assume not SMP
0	1	Not using new register, assume not SMP
1	0	Using new register, SMP
1	1	Using new register, UP

So we should return early only if it's 2.

Regards,

Tony

--CNK/L7dwKXQ4Ub8J
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fix-assembly-smp-detection.patch"

>From 22aaafd2659b95dc1434c5d6dbb7403329d51b90 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 2 Sep 2010 17:51:42 -0700
Subject: [PATCH] Fix smp_on_up detection

This is needed to detect UP properly on older ARMv7 like Cortex-A8.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 0b4a626..86aa36d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -346,8 +346,8 @@ __fixup_smp:
 	bne	smp_on_up		@ no, assume UP
 	mrc	p15, 0, r0, c0, c0, 5	@ read MIDR
 	movs	r0, r0, lsr #30
-	teqne	r0, #3			@ check top two bits 00 or 11
-	movne	pc, lr
+	teq	r0, #2			@ check top two bits, 10 for SMP
+	moveq	pc, lr
 
 smp_on_up:
 	adr	r0, 1f

--CNK/L7dwKXQ4Ub8J--
