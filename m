From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 04/14] irqchip: crossbar: fix kerneldoc warning
Date: Tue, 3 Jun 2014 13:12:56 +0530
Message-ID: <1401781386-4982-5-git-send-email-r.sricharan@ti.com>
References: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58761 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932186AbaFCHpf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jun 2014 03:45:35 -0400
In-Reply-To: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, tglx@linutronix.de, linux@arm.linux.org.uk, r.sricharan@ti.com

From: Nishanth Menon <nm@ti.com>

kernel doc style is wrong in code. fix it to squelch
kerneldoc warnings:
Warning(drivers/irqchip/irq-crossbar.c:27): missing initial short description on line:
 * struct crossbar_device: crossbar device description
Info(drivers/irqchip/irq-crossbar.c:27): Scanning doc for struct
Warning(drivers/irqchip/irq-crossbar.c:39): No description found for parameter 'write'
Warning(drivers/irqchip/irq-crossbar.c:42): missing initial short description on line:
 * struct crossbar_data: Platform specific data
Info(drivers/irqchip/irq-crossbar.c:42): Scanning doc for struct
Warning(drivers/irqchip/irq-crossbar.c:50): No description found for parameter 'safe_map'
4 warnings

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/irqchip/irq-crossbar.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 58790d4..7d4db07 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -23,11 +23,13 @@
 #define IRQ_SKIP	-3
 #define GIC_IRQ_START	32
 
-/*
+/**
+ * struct crossbar_device - crossbar device descriptio
  * @int_max: maximum number of supported interrupts
  * @irq_map: array of interrupts to crossbar number mapping
  * @crossbar_base: crossbar base address
  * @register_offsets: offsets for each irq number
+ * @write: register write function pointer
  */
 struct crossbar_device {
 	uint int_max;
@@ -39,9 +41,10 @@ struct crossbar_device {
 };
 
 /**
- * struct crossbar_data: Platform specific data
+ * struct crossbar_data - Platform specific data
  * @irqs_unused: array of irqs that cannot be used because of hw erratas
  * @size: size of the irqs_unused array
+ * @safe_map: safe value to write to crossbar register
  */
 struct crossbar_data {
 	const uint *irqs_unused;
-- 
1.7.9.5

