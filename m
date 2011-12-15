From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] OMAP2+: mcbsp: Restructure clk reparenting code
Date: Thu, 15 Dec 2011 11:37:38 +0200
Message-ID: <1323941859-7946-2-git-send-email-peter.ujfalusi@ti.com>
References: <1323941859-7946-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:54141 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758718Ab1LOJiC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 04:38:02 -0500
Received: by lami14 with SMTP id i14so885161lam.20
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 01:37:59 -0800 (PST)
In-Reply-To: <1323941859-7946-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

In OMAP4 we have different clk names compared to OMAP2/3.
To be able to support OMAP4 clock reparenting the set_clk_src
function need to be separated into two function.
One for selecting the platform's clock names, the other
will do the reparenting.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c |   37 ++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 857860b..9129003 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -65,25 +65,16 @@ static int omap2_mcbsp1_mux_rx_clk(struct device *dev, const char *signal,
 	return 0;
 }
 
-/* McBSP CLKS source switching function */
-static int omap2_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
-				   const char *src)
+static int omap2_mcbsp_reparent_clk(struct device *dev, struct clk *clk,
+				    char *fck_src_name)
 {
 	struct clk *fck_src;
-	char *fck_src_name;
 	int r;
 
-	if (!strcmp(src, "clks_ext"))
-		fck_src_name = "pad_fck";
-	else if (!strcmp(src, "clks_fclk"))
-		fck_src_name = "prcm_fck";
-	else
-		return -EINVAL;
-
 	fck_src = clk_get(dev, fck_src_name);
 	if (IS_ERR_OR_NULL(fck_src)) {
-		pr_err("omap-mcbsp: %s: could not clk_get() %s\n", "clks",
-		       fck_src_name);
+		dev_err(dev, "clk reparent: could not clk_get() %s\n",
+			fck_src_name);
 		return -EINVAL;
 	}
 
@@ -91,8 +82,8 @@ static int omap2_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
 
 	r = clk_set_parent(clk, fck_src);
 	if (IS_ERR_VALUE(r)) {
-		pr_err("omap-mcbsp: %s: could not clk_set_parent() to %s\n",
-		       "clks", fck_src_name);
+		dev_err(dev, "clk reparent: could not clk_set_parent() to %s\n",
+			fck_src_name);
 		clk_put(fck_src);
 		return -EINVAL;
 	}
@@ -104,6 +95,22 @@ static int omap2_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
 	return 0;
 }
 
+/* McBSP CLKS source switching for OMAP2/3 */
+static int omap2_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
+				   const char *src)
+{
+	char *fck_src_name;
+
+	if (!strcmp(src, "clks_ext"))
+		fck_src_name = "pad_fck";
+	else if (!strcmp(src, "clks_fclk"))
+		fck_src_name = "prcm_fck";
+	else
+		return -EINVAL;
+
+	return omap2_mcbsp_reparent_clk(dev, clk, fck_src_name);
+}
+
 static int omap3_enable_st_clock(unsigned int id, bool enable)
 {
 	unsigned int w;
-- 
1.7.8

