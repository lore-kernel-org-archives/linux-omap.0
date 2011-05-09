From: sricharan <r.sricharan@ti.com>
Subject: [PATCH] omap3: l3: Temporary fix to avoid the kernel hang with beagle board.
Date: Mon, 9 May 2011 20:15:52 +0530
Message-ID: <1304952352-27837-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55823 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881Ab1EIOqQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 May 2011 10:46:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sricharan <r.sricharan@ti.com>, Paul Wamsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Paul Walmsley reported a kernel hang issue with beagle board during
boot. This is an intermittent bug and the execution was found to be
stuck at the l3 interrupt handler.

This was due to a dss initiator agent timeout occuring during
the boot even when there is no actual interconnect access made by the
dss. since the reason for the dss timeout is not root caused yet,
the time out feature is disabled at the interconnect level.
Note that this is a temporary fix that should be removed once
the dss interconnect agent timeout issue is resolved.

Thanks to Paul Walmsley for reporting and helping in reproducing
this issue.

Signed-off-by: sricharan <r.sricharan@ti.com>
Cc: Paul Wamsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_l3_smx.c |   11 +++++++++++
 arch/arm/mach-omap2/omap_l3_smx.h |    2 ++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index 4321e79..4ea7dcd 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -248,6 +248,17 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	/*
+	 * FIX ME: dss interconnect timeout error.
+	 * Disable the l3 timeout reporting feature for all modules.
+	 * Also reset the dss initiator agent with which the error is seen
+	 * to clear the interrupt. This is a temporary fix and should be
+	 * removed after root causing the issue.
+	 */
+	omap3_l3_writell(l3->rt, L3_RT_NETWORK_CONTROL, 0x0);
+	omap3_l3_writell(l3->rt + L3_DSS_IA_CONTROL, L3_AGENT_CONTROL, 0x1);
+	omap3_l3_writell(l3->rt + L3_DSS_IA_CONTROL, L3_AGENT_CONTROL, 0x0);
+
 	l3->debug_irq = platform_get_irq(pdev, 0);
 	ret = request_irq(l3->debug_irq, omap3_l3_app_irq,
 		IRQF_DISABLED | IRQF_TRIGGER_RISING,
diff --git a/arch/arm/mach-omap2/omap_l3_smx.h b/arch/arm/mach-omap2/omap_l3_smx.h
index ba2ed9a..96fff9d 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.h
+++ b/arch/arm/mach-omap2/omap_l3_smx.h
@@ -35,6 +35,8 @@
 #define L3_ERROR_LOG_SECONDARY		(1 << 30)
 
 #define L3_ERROR_LOG_ADDR		0x060
+#define L3_RT_NETWORK_CONTROL		0x078
+#define L3_DSS_IA_CONTROL		0x5400
 
 /* Register definitions for Sideband Interconnect */
 #define L3_SI_CONTROL			0x020
-- 
1.7.0.4

