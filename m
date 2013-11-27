From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v7] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 27 Nov 2013 14:56:11 +0100
Message-ID: <1385560571-3939-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:39750 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab3K0N4T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 08:56:19 -0500
Received: by mail-ea0-f171.google.com with SMTP id h10so4773906eak.16
        for <linux-omap@vger.kernel.org>; Wed, 27 Nov 2013 05:56:18 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nsekhar@ti.com, linux-omap@vger.kernel.org, joelf@ti.com, gururaja.hebbar@ti.com, balajitk@ti.com
Cc: s.neumann@raumfeld.com, Russ.Dill@ti.com, nm@ti.com, vaibhav.bedia@gmail.com, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, Daniel Mack <zonque@gmail.com>

This patch makes the edma driver resume correctly after suspend. Tested
on an AM33xx platform with cyclic audio streams and omap_hsmmc.

All information can be reconstructed by already known runtime
information.

As we now use some functions that were previously only used from __init
context, annotations had to be dropped.

[nm@ti.com: added error handling for runtime + suspend_late/early_resume]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Daniel Mack <zonque@gmail.com>
Tested-by: Joel Fernandes <joelf@ti.com>
Acked-by: Joel Fernandes <joelf@ti.com>
---
v6 -> v7:

 * Addressed comments from Sekhar Nori:

   * pm_runtime_get_sync() returns negative errors, so do not use
     IS_ERR_VALUE()
   * Several style fixes


 arch/arm/common/edma.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 41bca32..dece66d 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -239,6 +239,8 @@ struct edma {
 	/* list of channels with no even trigger; terminated by "-1" */
 	const s8	*noevent;
 
+	struct edma_soc_info *info;
+
 	/* The edma_inuse bit for each PaRAM slot is clear unless the
 	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
 	 */
@@ -290,13 +292,13 @@ static void map_dmach_queue(unsigned ctlr, unsigned ch_no,
 			~(0x7 << bit), queue_no << bit);
 }
 
-static void __init map_queue_tc(unsigned ctlr, int queue_no, int tc_no)
+static void map_queue_tc(unsigned ctlr, int queue_no, int tc_no)
 {
 	int bit = queue_no * 4;
 	edma_modify(ctlr, EDMA_QUETCMAP, ~(0x7 << bit), ((tc_no & 0x7) << bit));
 }
 
-static void __init assign_priority_to_queue(unsigned ctlr, int queue_no,
+static void assign_priority_to_queue(unsigned ctlr, int queue_no,
 		int priority)
 {
 	int bit = queue_no * 4;
@@ -315,7 +317,7 @@ static void __init assign_priority_to_queue(unsigned ctlr, int queue_no,
  * included in that particular EDMA variant (Eg : dm646x)
  *
  */
-static void __init map_dmach_param(unsigned ctlr)
+static void map_dmach_param(unsigned ctlr)
 {
 	int i;
 	for (i = 0; i < EDMA_MAX_DMACH; i++)
@@ -1785,15 +1787,102 @@ static int edma_probe(struct platform_device *pdev)
 			edma_write_array2(j, EDMA_DRAE, i, 1, 0x0);
 			edma_write_array(j, EDMA_QRAE, i, 0x0);
 		}
+		edma_cc[j]->info = info[j];
 		arch_num_cc++;
 	}
 
 	return 0;
 }
 
+static int edma_pm_suspend(struct device *dev)
+{
+	int j, r;
+
+	r = pm_runtime_get_sync(dev);
+	if (r < 0) {
+		dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
+		return r;
+	}
+
+	for (j = 0; j < arch_num_cc; j++) {
+		struct edma *ecc = edma_cc[j];
+
+		disable_irq(ecc->irq_res_start);
+		disable_irq(ecc->irq_res_end);
+	}
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+static int edma_pm_resume(struct device *dev)
+{
+	int i, j, r;
+
+	r = pm_runtime_get_sync(dev);
+	if (r < 0) {
+		dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
+		return r;
+	}
+
+	for (j = 0; j < arch_num_cc; j++) {
+		struct edma *cc = edma_cc[j];
+
+		s8 (*queue_priority_mapping)[2];
+		s8 (*queue_tc_mapping)[2];
+
+		queue_tc_mapping = cc->info->queue_tc_mapping;
+		queue_priority_mapping = cc->info->queue_priority_mapping;
+
+		/* Event queue to TC mapping */
+		for (i = 0; queue_tc_mapping[i][0] != -1; i++)
+			map_queue_tc(j, queue_tc_mapping[i][0],
+				     queue_tc_mapping[i][1]);
+
+		/* Event queue priority mapping */
+		for (i = 0; queue_priority_mapping[i][0] != -1; i++)
+			assign_priority_to_queue(j,
+						 queue_priority_mapping[i][0],
+						 queue_priority_mapping[i][1]);
+
+		/*
+		 * Map the channel to param entry if channel mapping logic
+		 * exist
+		 */
+		if (edma_read(j, EDMA_CCCFG) & CHMAP_EXIST)
+			map_dmach_param(j);
+
+		for (i = 0; i < cc->num_channels; i++) {
+			if (test_bit(i, cc->edma_inuse)) {
+				/* ensure access through shadow region 0 */
+				edma_or_array2(j, EDMA_DRAE, 0, i >> 5,
+					       BIT(i & 0x1f));
+
+				setup_dma_interrupt(i,
+						    cc->intr_data[i].callback,
+						    cc->intr_data[i].data);
+			}
+		}
+
+		enable_irq(cc->irq_res_start);
+		enable_irq(cc->irq_res_end);
+	}
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops edma_pm_ops = {
+	.suspend_late	= edma_pm_suspend,
+	.resume_early	= edma_pm_resume,
+};
+
 static struct platform_driver edma_driver = {
 	.driver = {
 		.name	= "edma",
+		.pm	= &edma_pm_ops,
 		.of_match_table = edma_of_ids,
 	},
 	.probe = edma_probe,
-- 
1.8.4.2

