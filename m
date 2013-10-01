From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ARM: omap: edma: add suspend suspend/resume hooks
Date: Tue,  1 Oct 2013 15:51:33 +0200
Message-ID: <1380635493-31040-2-git-send-email-zonque@gmail.com>
References: <1380635493-31040-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:51066 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3JANvq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Oct 2013 09:51:46 -0400
In-Reply-To: <1380635493-31040-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: s.neumann@raumfeld.com, mporter@ti.com, nsekhar@ti.com, alsa-devel@alsa-project.org, gururaja.hebbar@ti.com, linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>

This patch makes the edma driver resume correctly after suspend. Tested
on an AM33xx platform with cyclic audio streams.

The code was shamelessly taken from an ancient BSP tree.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/common/edma.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 2a72169..d787f14 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -258,6 +258,20 @@ struct edma {
 				void *data);
 		void *data;
 	} intr_data[EDMA_MAX_DMACH];
+
+	struct {
+		struct edmacc_param *prm_set;
+		unsigned int *ch_map;               /* 64 registers */
+		unsigned int *que_num;              /* 8 registers */
+		unsigned int sh_esr;
+		unsigned int sh_esrh;
+		unsigned int sh_eesr;
+		unsigned int sh_eesrh;
+		unsigned int sh_iesr;
+		unsigned int sh_iesrh;
+		unsigned int que_tc_map;
+		unsigned int que_pri;
+	} context;
 };
 
 static struct edma *edma_cc[EDMA_MAX_CC];
@@ -1655,6 +1669,16 @@ static int edma_probe(struct platform_device *pdev)
 			memcpy_toio(edmacc_regs_base[j] + PARM_OFFSET(i),
 					&dummy_paramset, PARM_SIZE);
 
+		/* resume context */
+		edma_cc[j]->context.prm_set =
+			kzalloc((sizeof(struct edmacc_param) *
+				 edma_cc[j]->num_slots), GFP_KERNEL);
+		edma_cc[j]->context.ch_map =
+			kzalloc((sizeof(unsigned int) *
+				 edma_cc[j]->num_channels), GFP_KERNEL);
+		edma_cc[j]->context.que_num =
+			kzalloc((sizeof(unsigned int) * 8), GFP_KERNEL);
+
 		/* Mark all channels as unused */
 		memset(edma_cc[j]->edma_unused, 0xff,
 			sizeof(edma_cc[j]->edma_unused));
@@ -1762,6 +1786,114 @@ static int edma_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int edma_pm_suspend(struct device *dev)
+{
+	int i, j;
+
+	pm_runtime_get_sync(dev);
+
+	for (i = 0; i < arch_num_cc; i++) {
+		struct edma *ecc = edma_cc[i];
+
+		/* backup channel data */
+		for (j = 0; j < ecc->num_channels; j++)
+			ecc->context.ch_map[j] =
+				edma_read_array(i, EDMA_DCHMAP, j);
+
+		/* backup DMA Queue Number */
+		for (j = 0; j < 8; j++)
+			ecc->context.que_num[j] =
+				edma_read_array(i, EDMA_DMAQNUM, j);
+
+		/* backup DMA shadow Event Set data */
+		ecc->context.sh_esr = edma_shadow0_read_array(i, SH_ESR, 0);
+		ecc->context.sh_esrh = edma_shadow0_read_array(i, SH_ESR, 1);
+
+		/* backup DMA Shadow Event Enable Set data */
+		ecc->context.sh_eesr =
+			edma_shadow0_read_array(i, SH_EER, 0);
+		ecc->context.sh_eesrh =
+			edma_shadow0_read_array(i, SH_EER, 1);
+
+		/* backup DMA Shadow Interrupt Enable Set data */
+		ecc->context.sh_iesr =
+			edma_shadow0_read_array(i, SH_IER, 0);
+		ecc->context.sh_iesrh =
+			edma_shadow0_read_array(i, SH_IER, 1);
+
+		ecc->context.que_tc_map = edma_read(i, EDMA_QUETCMAP);
+
+		/* backup DMA Queue Priority data */
+		ecc->context.que_pri = edma_read(i, EDMA_QUEPRI);
+
+		/* backup paramset */
+		for (j = 0; j < ecc->num_slots; j++)
+			memcpy_fromio(&ecc->context.prm_set[j],
+				      edmacc_regs_base[i] + PARM_OFFSET(j),
+				      PARM_SIZE);
+	}
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+static int edma_pm_resume(struct device *dev)
+{
+	int i, j;
+
+	pm_runtime_get_sync(dev);
+
+	for (i = 0; i < arch_num_cc; i++) {
+		struct edma *ecc = edma_cc[i];
+
+		/* restore channel data */
+		for (j = 0; j < ecc->num_channels; j++) {
+			edma_write_array(i, EDMA_DCHMAP, j,
+					 ecc->context.ch_map[j]);
+		}
+
+		/* restore DMA Queue Number */
+		for (j = 0; j < 8; j++) {
+			edma_write_array(i, EDMA_DMAQNUM, j,
+					 ecc->context.que_num[j]);
+		}
+
+		/* restore DMA shadow Event Set data */
+		edma_shadow0_write_array(i, SH_ESR, 0, ecc->context.sh_esr);
+		edma_shadow0_write_array(i, SH_ESR, 1, ecc->context.sh_esrh);
+
+		/* restore DMA Shadow Event Enable Set data */
+		edma_shadow0_write_array(i, SH_EESR, 0,
+					 ecc->context.sh_eesr);
+		edma_shadow0_write_array(i, SH_EESR, 1,
+					 ecc->context.sh_eesrh);
+
+		/* restore DMA Shadow Interrupt Enable Set data */
+		edma_shadow0_write_array(i, SH_IESR, 0,
+					 ecc->context.sh_iesr);
+		edma_shadow0_write_array(i, SH_IESR, 1,
+					 ecc->context.sh_iesrh);
+
+		edma_write(i, EDMA_QUETCMAP, ecc->context.que_tc_map);
+
+		/* restore DMA Queue Priority data */
+		edma_write(i, EDMA_QUEPRI, ecc->context.que_pri);
+
+		/* restore paramset */
+		for (j = 0; j < ecc->num_slots; j++) {
+			memcpy_toio(edmacc_regs_base[i] + PARM_OFFSET(j),
+				    &ecc->context.prm_set[j], PARM_SIZE);
+		}
+	}
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(edma_pm_ops, edma_pm_suspend, edma_pm_resume);
+
 static const struct of_device_id edma_of_ids[] = {
 	{ .compatible = "ti,edma3", },
 	{}
@@ -1770,6 +1902,7 @@ static const struct of_device_id edma_of_ids[] = {
 static struct platform_driver edma_driver = {
 	.driver = {
 		.name	= "edma",
+		.pm	= &edma_pm_ops,
 		.of_match_table = edma_of_ids,
 	},
 	.probe = edma_probe,
-- 
1.8.3.1

