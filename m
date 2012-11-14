From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Wed, 14 Nov 2012 10:53:35 -0800
Message-ID: <20121114185335.GU6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24169 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423016Ab2KNSxj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 13:53:39 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Dave Martin <dave.martin@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Looks like enabling CONFIG_ARM_ERRATA_751472 causes omap4 blaze
to not boot when enabled. The ARM core on it is an earlier r1p2:

CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d

Unfortunately I don't have the details of errata 751472, but I'm
guessing we need to disable it for r1p*.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Can somebody with access to the errata check if it has more
info on which revisions this should be set on? Maybe it's just
r2p* - r3p0?

--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -236,6 +236,8 @@ __v7_setup:
 	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 #endif
 #if defined(CONFIG_ARM_ERRATA_751472) && defined(CONFIG_SMP)
+	teq	r5, #0x00100000			@ fails at least on r1p2
+	beq	1f
 	ALT_SMP(cmp r6, #0x30)			@ present prior to r3p0
 	ALT_UP_B(1f)
 	mrclt	p15, 0, r10, c15, c0, 1		@ read diagnostic register
