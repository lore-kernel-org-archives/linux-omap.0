From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v1 08/16] OMAP3: clock data: change dss driver name
Date: Wed,  6 Oct 2010 16:44:51 +0530
Message-ID: <1286363699-9614-9-git-send-email-svadivu@ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
 <1286363699-9614-2-git-send-email-svadivu@ti.com>
 <1286363699-9614-3-git-send-email-svadivu@ti.com>
 <1286363699-9614-4-git-send-email-svadivu@ti.com>
 <1286363699-9614-5-git-send-email-svadivu@ti.com>
 <1286363699-9614-6-git-send-email-svadivu@ti.com>
 <1286363699-9614-7-git-send-email-svadivu@ti.com>
 <1286363699-9614-8-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60271 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758883Ab0JFLPW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 07:15:22 -0400
In-Reply-To: <1286363699-9614-8-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Change the dss driver name from omapdss to dss_dss
in the clock database.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index c73906d..4e85d03 100644
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
+	CLK("dss_dss",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
+	CLK("dss_dss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2 | CK_AM35XX),
+	CLK("dss_dss",	"tv_fck",	&dss_tv_fck,	CK_3XXX),
+	CLK("dss_dss",	"video_fck",	&dss_96m_fck,	CK_3XXX),
+	CLK("dss_dss",	"dss2_fck",	&dss2_alwon_fck, CK_3XXX),
+	CLK("dss_dss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
+	CLK("dss_dss",	"ick",		&dss_ick_3430es2,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
 	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
 	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_343X),
-- 
1.6.3.3

