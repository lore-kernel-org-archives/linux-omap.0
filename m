From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/5] ARM: OMAP2+: omap_device: create clock alias purely from
 DT data
Date: Thu, 30 Jun 2016 16:14:59 +0300
Message-ID: <1467292503-4376-2-git-send-email-t-kristo@ti.com>
References: <1467292503-4376-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467292503-4376-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This avoids the need to add most of the clock aliases under
drivers/clk/ti/clk-xyz.c files.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_device.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index f7ff3b9..b32d7c8 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -63,7 +63,22 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 		return;
 	}
 
-	rc = clk_add_alias(clk_alias, dev_name(&od->pdev->dev), clk_name, NULL);
+	r = clk_get_sys(NULL, clk_name);
+
+	if (IS_ERR(r) && of_have_populated_dt()) {
+		struct of_phandle_args clkspec;
+
+		clkspec.np = of_find_node_by_name(NULL, clk_name);
+
+		r = of_clk_get_from_provider(&clkspec);
+
+		rc = clk_register_clkdev(r, clk_alias,
+					 dev_name(&od->pdev->dev));
+	} else {
+		rc = clk_add_alias(clk_alias, dev_name(&od->pdev->dev),
+				   clk_name, NULL);
+	}
+
 	if (rc) {
 		if (rc == -ENODEV || rc == -ENOMEM)
 			dev_err(&od->pdev->dev,
-- 
1.9.1
