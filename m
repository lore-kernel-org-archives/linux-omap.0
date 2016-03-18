From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/3] ARM: OMAP2+: mcbsp: Prepare the device build code for sidetone hwmod removal
Date: Fri, 18 Mar 2016 16:23:26 +0200
Message-ID: <1458311007-19168-3-git-send-email-peter.ujfalusi@ti.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The McBSP sidetone hwmods will be removed as they should not exist because
the sidetone is a sub-block of McBSP and it is the responsibility of the
McBSP driver to handle it. It has no effect or dependency on PRCM.
When the sidetone hwmod is removed the oh->dev_attr can not be used to
determine if the McBSP port has sidetone or not, but we can use the IRQ
names. If the module has IRQ named as sidetone, the McBSP has it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index b4ac3af1160c..8a3c50fa6a78 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -48,6 +48,23 @@ static int omap3_enable_st_clock(unsigned int id, bool enable)
 		return omap2_clk_allow_idle(mcbsp_iclks[id]);
 }
 
+static bool omap3_mcbsp_has_st(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_irq_info *ohii;
+	int i = 0;
+
+	if (!oh || !oh->mpu_irqs)
+		return false;
+
+	do {
+		ohii = &oh->mpu_irqs[i++];
+		if (!strcmp(ohii->name, "sidetone"))
+			return true;
+	} while (ohii->irq != -1);
+
+	return false;
+}
+
 static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 {
 	int id, count = 1;
@@ -56,6 +73,7 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	struct omap_mcbsp_platform_data *pdata = NULL;
 	struct platform_device *pdev;
 	char clk_name[11];
+	bool has_sidetone = false;
 
 	sscanf(oh->name, "mcbsp%d", &id);
 
@@ -96,11 +114,19 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	if (oh->dev_attr) {
 		oh_device[1] = omap_hwmod_lookup((
 		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
+		count++;
+
+		has_sidetone = true;
+	} else {
+		has_sidetone = omap3_mcbsp_has_st(oh);
+	}
+
+	if (has_sidetone) {
 		pdata->enable_st_clock = omap3_enable_st_clock;
 		sprintf(clk_name, "mcbsp%d_ick", id);
 		mcbsp_iclks[id] = clk_get(NULL, clk_name);
-		count++;
 	}
+
 	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
 				    sizeof(*pdata));
 	kfree(pdata);
-- 
2.7.3
