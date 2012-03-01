From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: OMAP: hwmod: Use sysc_fields->srst_shift and get rid of hardcoded SYSC_TYPE2_SOFTRESET_MASK
Date: Thu, 1 Mar 2012 19:17:54 +0530
Message-ID: <1330609674-20826-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54382 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758103Ab2CANsR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Mar 2012 08:48:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Balaji TK <balajitk@ti.com>

This is useful when we have broken type2 compliant IPs' where
the softreset shift is not the same as SYSC_TYPE2_SOFTRESET_SHIFT
and hence is overridden using sysc_fields->srst_shift.

We have atleast one such instance now with onchip keypad on OMAP5
which has a different softreset shift as compared to other type2
IPs'.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Balaji TK  <balajitk@ti.com>
Tested-by: Sourav Poddar <sourav.poddar@ti.com>
---
Paul,

I based the patch on top of your reset/data cleanup series
for hwmod. So its based on 'hwmod_data_cleanup_3.4' branch.

regards,
Rajendra

 arch/arm/mach-omap2/omap_hwmod.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3462dc5..6aadba2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1524,7 +1524,7 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
  */
 static int _ocp_softreset(struct omap_hwmod *oh)
 {
-	u32 v;
+	u32 v, softrst_mask;
 	int c = 0;
 	int ret = 0;
 
@@ -1559,11 +1559,13 @@ static int _ocp_softreset(struct omap_hwmod *oh)
 						    oh->class->sysc->syss_offs)
 				   & SYSS_RESETDONE_MASK),
 				  MAX_MODULE_SOFTRESET_WAIT, c);
-	else if (oh->class->sysc->sysc_flags & SYSC_HAS_RESET_STATUS)
+	else if (oh->class->sysc->sysc_flags & SYSC_HAS_RESET_STATUS) {
+		softrst_mask = (0x1 << oh->class->sysc->sysc_fields->srst_shift);
 		omap_test_timeout(!(omap_hwmod_read(oh,
 						     oh->class->sysc->sysc_offs)
-				   & SYSC_TYPE2_SOFTRESET_MASK),
+				   & softrst_mask),
 				  MAX_MODULE_SOFTRESET_WAIT, c);
+	}
 
 	if (c == MAX_MODULE_SOFTRESET_WAIT)
 		pr_warning("omap_hwmod: %s: softreset failed (waited %d usec)\n",
-- 
1.7.1

