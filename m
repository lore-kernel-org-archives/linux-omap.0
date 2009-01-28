From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/9] ARM: OMAP: fix fault in enter_full_retention()
Date: Wed, 28 Jan 2009 10:33:26 -0800
Message-ID: <20090128183326.21007.78004.stgit@localhost>
References: <20090128181931.21007.73744.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63956 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbZA1Sd3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 13:33:29 -0500
In-Reply-To: <20090128181931.21007.73744.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

In omap24xx_cpu_suspend assembly routine, the r2 register which holds
the address of the SDRC_POWER reg is set to zero before the value is
written back triggering a fault due to writing to address zero.

It's hard to tell where this change was introduced since this file
has been moved and merged.

While this fix prevents a crash, suspend on my n810 is broken with
current kernels.  I never come out of suspend.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sleep24xx.S |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep24xx.S b/arch/arm/mach-omap2/sleep24xx.S
index 43336b9..bf9e961 100644
--- a/arch/arm/mach-omap2/sleep24xx.S
+++ b/arch/arm/mach-omap2/sleep24xx.S
@@ -93,9 +93,8 @@ ENTRY(omap24xx_cpu_suspend)
 	orr	r4, r4, #0x40		@ enable self refresh on idle req
 	mov	r5, #0x2000		@ set delay (DPLL relock + DLL relock)
 	str	r4, [r2]		@ make it so
-	mov	r2, #0
 	nop
-	mcr	p15, 0, r2, c7, c0, 4	@ wait for interrupt
+	mcr	p15, 0, r3, c7, c0, 4	@ wait for interrupt
 	nop
 loop:
 	subs	r5, r5, #0x1		@ awake, wait just a bit

