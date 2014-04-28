From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 43/97] ARM: l2c: omap2: remove explicit SMI calls to enable L2
 cache
Date: Mon, 28 Apr 2014 20:29:51 +0100
Message-ID: <E1WerFP-0001WH-K3@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:55666 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754708AbaD1T3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 15:29:53 -0400
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.ifradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Now that OMAP2 uses the write_sec method, we don't need to enable the L2
cache in OMAP2 specific code; this can be done via the normal mechanisms
in the L2C code.  Remove the OMAP2 specific code.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap4-common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index a51501ad7e83..46dac72aaa4c 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -223,11 +223,6 @@ static int __init omap_l2_cache_init(void)
 			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
 			(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT);
 
-	omap_smc1(0x109, aux_ctrl);
-
-	/* Enable PL310 L2 Cache controller */
-	omap_smc1(0x102, 0x1);
-
 	outer_cache.write_sec = omap4_l2c310_write_sec;
 	if (of_have_populated_dt())
 		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
-- 
1.8.3.1

