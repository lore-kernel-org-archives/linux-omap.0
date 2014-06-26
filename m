From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V4 08/16] irqchip: crossbar: Fix kerneldoc warning
Date: Thu, 26 Jun 2014 12:40:26 +0530
Message-ID: <1403766634-18543-9-git-send-email-r.sricharan@ti.com>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, r.sricharan@ti.com, tglx@linutronix.de, jason@lakedaemon.net, joe@perches.com
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

Adding missing properties for kerneldoc (@write) and cleanup
of harmless warnings while we are here.

kerneldoc warnings:
Warning(drivers/irqchip/irq-crossbar.c:27): missing initial short description on line:
 * struct crossbar_device: crossbar device description
Info(drivers/irqchip/irq-crossbar.c:27): Scanning doc for struct
Warning(drivers/irqchip/irq-crossbar.c:39): No description found for parameter 'write'
2 warnings

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/irqchip/irq-crossbar.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index f7eda9f..cee556b 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -22,12 +22,14 @@
 #define IRQ_SKIP	-3
 #define GIC_IRQ_START	32
 
-/*
+/**
+ * struct crossbar_device - crossbar device description
  * @int_max: maximum number of supported interrupts
  * @safe_map: safe default value to initialize the crossbar
  * @irq_map: array of interrupts to crossbar number mapping
  * @crossbar_base: crossbar base address
  * @register_offsets: offsets for each irq number
+ * @write: register write function pointer
  */
 struct crossbar_device {
 	uint int_max;
-- 
1.7.9.5
