From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/22] OMAPDSS: HDMI: fix setting REFSEL
Date: Wed, 12 Nov 2014 13:52:16 +0200
Message-ID: <1415793144-11723-15-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53622 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbaKLLxG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:53:06 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Only OMAP5+ has REFSEL field, but at the moment it's set also on OMAP4.

Fix this by adding a "has_refsel" field, and setting the REFSEL based on
that.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h     | 8 --------
 drivers/video/fbdev/omap2/dss/hdmi_pll.c | 8 ++++----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 262771b9b76b..4bbc9d206f4a 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -101,13 +101,6 @@ enum hdmi_core_hdmi_dvi {
 	HDMI_HDMI = 1
 };
 
-enum hdmi_clk_refsel {
-	HDMI_REFSEL_PCLK = 0,
-	HDMI_REFSEL_REF1 = 1,
-	HDMI_REFSEL_REF2 = 2,
-	HDMI_REFSEL_SYSCLK = 3
-};
-
 enum hdmi_packing_mode {
 	HDMI_PACK_10b_RGB_YUV444 = 0,
 	HDMI_PACK_24b_RGB_YUV444_YUV422 = 1,
@@ -199,7 +192,6 @@ struct hdmi_pll_info {
 	u16 regm2;
 	u16 regsd;
 	u16 dcofreq;
-	enum hdmi_clk_refsel refsel;
 };
 
 struct hdmi_audio_format {
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index 6d92bb32fe51..b28d41a08a8f 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -24,6 +24,7 @@
 #define HDMI_DEFAULT_REGM2 1
 
 struct hdmi_pll_features {
+	bool has_refsel;
 	bool sys_reset;
 	/* this is a hack, need to replace it with a better computation of M2 */
 	bool bound_dcofreq;
@@ -96,9 +97,6 @@ void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin, int phy)
 	pi->dcofreq = phy > 1000 * 100;
 	pi->regsd = ((pi->regm * clkin / 10) / (pi->regn * 250) + 5) / 10;
 
-	/* Set the reference clock to sysclk reference */
-	pi->refsel = HDMI_REFSEL_SYSCLK;
-
 	DSSDBG("M = %d Mf = %d\n", pi->regm, pi->regmf);
 	DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
 }
@@ -122,7 +120,8 @@ static int hdmi_pll_config(struct hdmi_pll_data *pll)
 	r = FLD_MOD(r, 0x0, 12, 12);	/* PLL_HIGHFREQ divide by 2 */
 	r = FLD_MOD(r, 0x1, 13, 13);	/* PLL_REFEN */
 	r = FLD_MOD(r, 0x0, 14, 14);	/* PHY_CLKINEN de-assert during locking */
-	r = FLD_MOD(r, fmt->refsel, 22, 21);	/* REFSEL */
+	if (pll_feat->has_refsel)
+		r = FLD_MOD(r, 0x3, 22, 21);	/* REFSEL = SYSCLK */
 
 	if (fmt->dcofreq)
 		r = FLD_MOD(r, 0x4, 3, 1);	/* 1000MHz and 2000MHz */
@@ -222,6 +221,7 @@ static const struct hdmi_pll_features omap44xx_pll_feats = {
 };
 
 static const struct hdmi_pll_features omap54xx_pll_feats = {
+	.has_refsel		=	true,
 	.sys_reset		=	true,
 	.bound_dcofreq		=	true,
 	.fint_min		=	620000,
-- 
2.1.3

