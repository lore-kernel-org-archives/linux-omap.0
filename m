From: Kan-Ru Chen <kanru@0xlab.org>
Subject: [PATCHv2 2/3] omap: Use omap_get_die_id() to get the DIE ids
Date: Tue,  6 Jul 2010 09:10:03 +0800
Message-ID: <1278378604-15802-3-git-send-email-kanru@0xlab.org>
References: <1278378604-15802-1-git-send-email-kanru@0xlab.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cp20.secserverpros.com ([67.220.217.187]:60675 "EHLO
	cp20.secserverpros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab0GFBPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 21:15:41 -0400
Received: from 61-30-10-70.static.tfn.net.tw ([61.30.10.70] helo=kanru.info)
	by cp20.secserverpros.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kanru@kanru.info>)
	id 1OVwl4-0006mP-3u
	for linux-omap@vger.kernel.org; Tue, 06 Jul 2010 01:15:36 +0000
In-Reply-To: <1278378604-15802-1-git-send-email-kanru@0xlab.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Kan-Ru Chen <kanru@0xlab.org>, Tony Lindgren <tony@atomide.com>


Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
---
 arch/arm/mach-omap2/id.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 80bd1cd..4e11801 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -118,24 +118,22 @@ void __init omap24xx_check_revision(void)
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
 
-- 
1.7.1

