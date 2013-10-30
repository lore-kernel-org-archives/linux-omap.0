From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 30 Oct 2013 21:21:08 +0100
Message-ID: <1383164468-4610-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:33561 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab3J3UVR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Oct 2013 16:21:17 -0400
Received: by mail-bk0-f49.google.com with SMTP id w14so777284bkz.8
        for <linux-omap@vger.kernel.org>; Wed, 30 Oct 2013 13:21:16 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, joelf@ti.com, gururaja.hebbar@ti.com, balajitk@ti.com
Cc: s.neumann@raumfeld.com, mporter@ti.com, nsekhar@ti.com, Russ.Dill@ti.com, linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>

This patch makes the edma driver resume correctly after suspend. Tested
on an AM33xx platform with cyclic audio streams and omap_hsmmc.

All information can be reconstructed by already known runtime
information.

As we now use some functions that were previously only used from __init
context, annotations had to be dropped.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
There was actually only a v3 ever, I made a mistake when formating the
first version of this patch. To prevent confusion though, I named this
one v4.

v3 -> v4:
	* dropped extra allocations, and reconstruct register values
	  from already known driver states.



Hi Joel, Gururaja, Balaji,

thanks a lot for your feedback. I successfully tested this version with
davinci mcasp as well as omap_hsmmc. I'd appreciate another round of
reviews :)


Thanks,
Daniel

 arch/arm/common/edma.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 8e1a024..f15cdb9 100644
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
@@ -1785,15 +1787,89 @@ static int edma_probe(struct platform_device *pdev)
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
+	int j;
+
+	pm_runtime_get_sync(dev);
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
+	int i, j;
+
+	pm_runtime_get_sync(dev);
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
+					queue_tc_mapping[i][1]);
+
+		/* Event queue priority mapping */
+		for (i = 0; queue_priority_mapping[i][0] != -1; i++)
+			assign_priority_to_queue(j,
+						queue_priority_mapping[i][0],
+						queue_priority_mapping[i][1]);
+
+		/* Map the channel to param entry if channel mapping logic
+		 * exist
+		 */
+		if (edma_read(j, EDMA_CCCFG) & CHMAP_EXIST)
+			map_dmach_param(j);
+
+		for (i = 0; i < cc->num_channels; i++)
+			if (test_bit(i, cc->edma_inuse)) {
+				/* ensure access through shadow region 0 */
+				edma_or_array2(j, EDMA_DRAE, 0, i >> 5,
+						BIT(i & 0x1f));
+
+				setup_dma_interrupt(i,
+						    cc->intr_data[i].callback,
+						    cc->intr_data[i].data);
+			}
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
+static SIMPLE_DEV_PM_OPS(edma_pm_ops, edma_pm_suspend, edma_pm_resume);
+
 static struct platform_driver edma_driver = {
 	.driver = {
 		.name	= "edma",
+		.pm	= &edma_pm_ops,
 		.of_match_table = edma_of_ids,
 	},
 	.probe = edma_probe,
-- 
1.8.3.1

