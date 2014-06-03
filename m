From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 05/14] irqchip: crossbar: DRA7: Fix unused crossbar list
Date: Tue, 3 Jun 2014 13:12:57 +0530
Message-ID: <1401781386-4982-6-git-send-email-r.sricharan@ti.com>
References: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37082 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932186AbaFCHpn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jun 2014 03:45:43 -0400
In-Reply-To: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, tglx@linutronix.de, linux@arm.linux.org.uk, r.sricharan@ti.com

From: Rajendra Nayak <rnayak@ti.com>

On DRA7 compatible IRQ crossbar, IRQ 10 default mapped to L3_APP_IRQ,
IRQ133 is default mapped to NMI pin, 139 and 140 crossbars are
unused(not routed). Mark these as unused crossbar IRQs.

Technical Reference Manual documentation update expected
DRA72x-TRMINC00067 is being used to track the update.

Reported-by: Nishanth Menon <nm@ti.com>
Reported-by: Sricharan R <r.sricharan@ti.com>
Reported-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/irqchip/irq-crossbar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 7d4db07..42a2e62 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -253,8 +253,8 @@ err1:
 	return -ENOMEM;
 }
 
-/* irq number 10 cannot be used because of hw bug */
-static int dra_irqs_unused[] = { 10 };
+/* irq number 10,133,139 and 140 cannot be used because of hw bug */
+static int dra_irqs_unused[] = { 10 , 133, 139, 140 };
 static struct crossbar_data cb_dra_data = { dra_irqs_unused,
 				     ARRAY_SIZE(dra_irqs_unused), 0 };
 
-- 
1.7.9.5

