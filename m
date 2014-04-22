From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 2/3] ARM: OMAP2+: L2 cache: git rid of redundant cache replacement policy setting
Date: Tue, 22 Apr 2014 13:58:02 +0530
Message-ID: <8bcc6d587cd1f320b59806dbdee9018b76c04e4f.1398149526.git.nsekhar@ti.com>
References: <cover.1398149526.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40321 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040AbaDVI2k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 04:28:40 -0400
In-Reply-To: <cover.1398149526.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>

L2 cache initialization for OMAP4 redundantly sets the
cache policy to Round-Robin. This is not needed since
thats the PL310 default anyway.

Removing this reduces the number of platform specific
aux control settings.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 1230975..c41ff8b 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -206,16 +206,15 @@ int __init omap_l2_cache_init(void)
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
1.7.10.1

