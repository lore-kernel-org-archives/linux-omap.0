From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/19] AM35xx: Update irq.h for AM35xx IPSS module interrupts
Date: Thu, 11 Feb 2010 16:51:43 -0800
Message-ID: <20100212005143.24958.92584.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51709 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769Ab0BLAvB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:51:01 -0500
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/irqs.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index c0ab7c8..90d8370 100644
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

