From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 1/9] ARM: OMAP2+: omap_device: create clock alias purely from DT data
Date: Fri, 18 Dec 2015 15:58:53 +0200
Message-ID: <1450447141-29936-2-git-send-email-t-kristo@ti.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This avoids the need to add most of the clock aliases under
drivers/clk/ti/clk-xyz.c files.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_device.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 72ebc4c..3389ce7 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -62,6 +62,18 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 		return;
 	}
 
+	r = clk_get_sys(NULL, clk_name);
+
+	if (IS_ERR(r) && of_have_populated_dt()) {
+		struct of_phandle_args clkspec;
+
+		clkspec.np = of_find_node_by_name(NULL, clk_name);
+
+		r = of_clk_get_from_provider(&clkspec);
+
+		clk_register_clkdev(r, clk_name, NULL);
+	}
+
 	rc = clk_add_alias(clk_alias, dev_name(&od->pdev->dev), clk_name, NULL);
 	if (rc) {
 		if (rc == -ENODEV || rc == -ENOMEM)
-- 
1.7.9.5

