From: hvaibhav@ti.com
Subject: [PATCH 3/3-V1] AM35xx: Update irq.h for AM35xx IPSS module interrupts
Date: Mon, 11 Jan 2010 11:36:21 +0530
Message-ID: <1263189981-717-4-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50791 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab0AKGG3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 01:06:29 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/plat-omap/include/plat/irqs.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 97d6c50..e0d5092 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -344,6 +344,16 @@

 #define	INT_34XX_BENCH_MPU_EMUL	3

+#define INT_35XX_HECC0_IRQ		24
+#define INT_35XX_HECC1_IRQ		28
+#define INT_35XX_EMAC_C0_RXTHRESH_IRQ	67
+#define INT_35XX_EMAC_C0_RX_PULSE_IRQ	68
+#define INT_35XX_EMAC_C0_TX_PULSE_IRQ	69
+#define INT_35XX_EMAC_C0_MISC_PULSE_IRQ	70
+#define INT_35XX_USBOTG_IRQ		71
+#define INT_35XX_CCDC_VD0_IRQ		88
+#define INT_35XX_CCDC_VD1_IRQ		92
+#define INT_35XX_CCDC_VD2_IRQ		93

 #define IRQ_GIC_START		32
 #define INT_44XX_LOCALTIMER_IRQ	29
--
1.6.2.4

