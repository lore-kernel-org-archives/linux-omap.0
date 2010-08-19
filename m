From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Thu, 19 Aug 2010 10:38:11 +0300
Message-ID: <20100819073810.GR12184@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100817135205.GC20325@n2100.arm.linux.org.uk>
 <20100817141210.GJ12184@atomide.com>
 <20100817154035.GD20325@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2hMgfIw2X+zgXrFs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57116 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab0HSHiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 03:38:20 -0400
Content-Disposition: inline
In-Reply-To: <20100817154035.GD20325@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100817 18:33]:
> On Tue, Aug 17, 2010 at 05:12:11PM +0300, Tony Lindgren wrote:
> > Great, will give it a try hopefully tomorrow. Sounds like that's the way
> > to deal with fixing up things when booting up older UP ARMv6 without the
> > 32v6 support :)
> 
> What I've also been debating about is adding another word to the
> smpalt structure, that being a set of flags which denote the situation
> where the alternative should be used.
> 
> That means we can use it to do individual word replacements for SMP vs
> UP, ARMv6 vs ARMv6k etc.

Sounds good to me. Maybe it should then be called cpualt instead of smpalt?

Tried booting your patch and needed the following fix for Cortex-A8 UP.

Now it boots to the following error:

Machine configuration botched (nr -1073741824), unable to continue.

Does some struct size need to be changed or something?

Regards,

Tony

--2hMgfIw2X+zgXrFs
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="smp-on-up-fix.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 19 Aug 2010 10:22:23 +0300
Subject: [PATCH] Fix smp_on_up detection

This is needed to detect UP properly on older ARMv7 like Cortex-A8.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -346,8 +346,10 @@ __fixup_smp:
 	bne	smp_on_up		@ no, assume UP
 	mrc	p15, 0, r0, c0, c0, 5	@ read MIDR
 	movs	r0, r0, lsr #30
-	teqne	r0, #3			@ check top two bits 00 or 11
-	moveq	pc, lr
+	teq	r0, #0			@ check two top bits 00
+	beq	smp_on_up		@ yes, assume UP
+	teq	r0, #3			@ check top two bits 11
+	movne	pc, lr			@ no, running on SMP hw
 
 smp_on_up:
 	adr	r0, 1f

--2hMgfIw2X+zgXrFs--
