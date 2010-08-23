From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 06/20] DSS driver name change in clock database
Date: Mon, 23 Aug 2010 21:27:55 +0530
Message-ID: <1282579089-10487-7-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
 <1282579089-10487-4-git-send-email-svadivu@ti.com>
 <1282579089-10487-5-git-send-email-svadivu@ti.com>
 <1282579089-10487-6-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55692 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190Ab0HWP6W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:22 -0400
In-Reply-To: <1282579089-10487-6-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Change the dss driver name from omapdss to dss in clock
database against the dss related clocks

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 138646d..980daf8 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3320,13 +3320,13 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap_rng",	"ick",		&rng_ick,	CK_343X),
 	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
 	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
-	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
-	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2 | CK_AM35XX),
-	CLK("omapdss",	"tv_fck",	&dss_tv_fck,	CK_3XXX),
-	CLK("omapdss",	"video_fck",	&dss_96m_fck,	CK_3XXX),
-	CLK("omapdss",	"dss2_fck",	&dss2_alwon_fck, CK_3XXX),
-	CLK("omapdss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
-	CLK("omapdss",	"ick",		&dss_ick_3430es2,	CK_3430ES2 | CK_AM35XX),
+	CLK("dss",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
+	CLK("dss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2 | CK_AM35XX),
+	CLK("dss",	"tv_fck",	&dss_tv_fck,	CK_3XXX),
+	CLK("dss",	"video_fck",	&dss_96m_fck,	CK_3XXX),
+	CLK("dss",	"dss2_fck",	&dss2_alwon_fck, CK_3XXX),
+	CLK("dss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
+	CLK("dss",	"ick",		&dss_ick_3430es2,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
 	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
 	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_343X),
-- 
1.6.3.3

