From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] ARM: Do not call test_for_ipi or test_for_ltrirq on UP
 systems
Date: Thu, 2 Sep 2010 09:21:24 -0700
Message-ID: <20100902162124.GN11597@atomide.com>
References: <20100817141210.GJ12184@atomide.com>
 <20100817154035.GD20325@n2100.arm.linux.org.uk>
 <20100819073810.GR12184@atomide.com>
 <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com>
 <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56583 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab0IBQVe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 12:21:34 -0400
Content-Disposition: inline
In-Reply-To: <20100902161659.GJ11597@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

>From f80d3cc85327ba84748646bb44a0c45103ef66bc Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 1 Sep 2010 20:40:47 -0700
Subject: [PATCH 4/6] ARM: Do not call test_for_ipi or test_for_ltrirq on UP systems

Do not call test_for_ipi or test_for_ltrirq on UP systems.

Note that we can't put test_for_ltriq into SMP statement as
it's inlined into the code and the remaining lines of the
macro would still run before UP macro line.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/kernel/entry-armv.S |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index bb2ef60..b8c1ec7 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -40,6 +40,11 @@
 	bne	asm_do_IRQ
 
 #ifdef CONFIG_SMP
+#ifdef CONFIG_SMP_ON_UP
+	adr	lr, BSYM(2f)	@ set lr to end of macro for early return
+	SMP(nop)		@ continue on SMP hardware
+	UP(mov	pc, lr)		@ return early on UP
+#endif
 	/*
 	 * XXX
 	 *
@@ -57,6 +62,7 @@
 	adrne	lr, BSYM(1b)
 	bne	do_local_timer
 #endif
+2:
 #endif
 
 	.endm
-- 
1.7.1

