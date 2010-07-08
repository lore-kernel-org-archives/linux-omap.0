From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/13] omap: Use omap_get_die_id() to get the DIE ids
Date: Thu, 08 Jul 2010 16:55:11 +0300
Message-ID: <20100708135511.26276.34207.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56330 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab0GHNzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:55:14 -0400
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Kan-Ru Chen <kanru@0xlab.org>

From: Kan-Ru Chen <kanru@0xlab.org>

Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index d079ccf..fd1904b 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -118,24 +118,22 @@ static void __init omap24xx_check_revision(void)
 	u32 idcode, prod_id;
 	u16 hawkeye;
 	u8  dev_type, rev;
+	struct omap_die_id odi;
 
 	idcode = read_tap_reg(OMAP_TAP_IDCODE);
 	prod_id = read_tap_reg(tap_prod_id);
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0x0f;
 	dev_type = (prod_id >> 16) & 0x0f;
+	omap_get_die_id(&odi);
 
 	pr_debug("OMAP_TAP_IDCODE 0x%08x REV %i HAWKEYE 0x%04x MANF %03x\n",
 		 idcode, rev, hawkeye, (idcode >> 1) & 0x7ff);
-	pr_debug("OMAP_TAP_DIE_ID_0: 0x%08x\n",
-		 read_tap_reg(OMAP_TAP_DIE_ID_0));
+	pr_debug("OMAP_TAP_DIE_ID_0: 0x%08x\n", odi.id_0);
 	pr_debug("OMAP_TAP_DIE_ID_1: 0x%08x DEV_REV: %i\n",
-		 read_tap_reg(OMAP_TAP_DIE_ID_1),
-		 (read_tap_reg(OMAP_TAP_DIE_ID_1) >> 28) & 0xf);
-	pr_debug("OMAP_TAP_DIE_ID_2: 0x%08x\n",
-		 read_tap_reg(OMAP_TAP_DIE_ID_2));
-	pr_debug("OMAP_TAP_DIE_ID_3: 0x%08x\n",
-		 read_tap_reg(OMAP_TAP_DIE_ID_3));
+		 odi.id_1, (odi.id_1 >> 28) & 0xf);
+	pr_debug("OMAP_TAP_DIE_ID_2: 0x%08x\n", odi.id_2);
+	pr_debug("OMAP_TAP_DIE_ID_3: 0x%08x\n", odi.id_3);
 	pr_debug("OMAP_TAP_PROD_ID_0: 0x%08x DEV_TYPE: %i\n",
 		 prod_id, dev_type);
 

