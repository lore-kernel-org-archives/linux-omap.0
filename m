From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Mon, 30 Aug 2010 15:55:27 -0700
Message-ID: <20100830225527.GC11597@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100817135205.GC20325@n2100.arm.linux.org.uk>
 <20100817141210.GJ12184@atomide.com>
 <20100817154035.GD20325@n2100.arm.linux.org.uk>
 <20100819073810.GR12184@atomide.com>
 <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LpQ9ahxlCli8rRTG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53360 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab0H3Wzl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 18:55:41 -0400
Content-Disposition: inline
In-Reply-To: <20100820120622.GL25742@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Bryan Wu <bryan.wu@canonical.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100820 04:59]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100819 13:13]:
> > On Thu, Aug 19, 2010 at 12:57:06PM +0300, Tony Lindgren wrote:
> > > Looks like something is not quite right with smp_on_up part of __fixup_smp,
> > > returning early before smp_on_up does not produce that.
> > 
> > It's probably overwriting some register it shouldn't be.  I might be
> > able to look at this sometime during the coming week... assuming that
> > the weather is as bad as they forecast and I have 'net connectivity.

This seems to fix it.

Tony

--LpQ9ahxlCli8rRTG
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fix-smp-on-up.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Mon, 30 Aug 2010 13:52:52 -0700
Subject: [PATCH] ARM: Fix smp_on_up to not trash r1 and r2

We need to preserve r1 and r2 for __mmap_switched. So
use r3, r6, r7 instead of r1, r2, r3. We can trash
r3, r6, r7 as they get corrupted in __create_page_tables
anyways.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -353,14 +353,14 @@ __fixup_smp:
 
 smp_on_up:
 	adr	r0, 1f
-	ldmia	r0, {r1, r2, r3}
-	sub	r1, r0, r1
-	add	r2, r2, r1
-	add	r3, r3, r1
-2:	cmp	r2, r3
-	ldmia	r2!, {r0, r4}
+	ldmia	r0, {r3, r6, r7}
+	sub	r3, r0, r3
+	add	r6, r6, r3
+	add	r7, r7, r3
+2:	cmp	r6, r7
+	ldmia	r6!, {r0, r4}
 	movhs	pc, lr
-	str	r4, [r0, r1]
+	str	r4, [r0, r3]
 	b	2b
 ENDPROC(__fixup_smp)
 

--LpQ9ahxlCli8rRTG--
