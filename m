From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 87/97] ARM: l2c: omap2+: get rid of redundant cache
 replacement policy setting
Date: Mon, 28 Apr 2014 20:33:36 +0100
Message-ID: <E1WerJ2-0001Zc-HI@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:55848 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932433AbaD1Tdi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 15:33:38 -0400
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.ifradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>
To: linux-arm-kernel@lists.ifradead.org

L2 cache initialization for OMAP4 redundantly sets the cache policy to
Round-Robin. This is not needed since thats the PL310 default anyway.

Removing this reduces the number of platform specific aux control
settings.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap4-common.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index df3f53195c57..6927d5b120fe 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -213,16 +213,15 @@ static int __init omap_l2_cache_init(void)
 		return -ENOMEM;
 
 	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
-	aux_ctrl = L310_AUX_CTRL_CACHE_REPLACE_RR |
-		   L2C_AUX_CTRL_SHARED_OVERRIDE |
+	aux_ctrl = L2C_AUX_CTRL_SHARED_OVERRIDE |
 		   L310_AUX_CTRL_DATA_PREFETCH |
 		   L310_AUX_CTRL_INSTR_PREFETCH;
 
 	outer_cache.write_sec = omap4_l2c310_write_sec;
 	if (of_have_populated_dt())
-		l2x0_of_init(aux_ctrl, 0xcd9fffff);
+		l2x0_of_init(aux_ctrl, 0xcf9fffff);
 	else
-		l2x0_init(l2cache_base, aux_ctrl, 0xcd9fffff);
+		l2x0_init(l2cache_base, aux_ctrl, 0xcf9fffff);
 
 	return 0;
 }
-- 
1.8.3.1

