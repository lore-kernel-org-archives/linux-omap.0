From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V2 10/19] irqchip: crossbar: DRA7: Fix unused crossbar list
Date: Thu, 12 Jun 2014 17:23:18 +0530
Message-ID: <1402574007-13987-11-git-send-email-r.sricharan@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nm@ti.com, linux@arm.linux.org.uk, jason@lakedaemon.net, tony@atomide.com, rnayak@ti.com, r.sricharan@ti.com, santosh.shilimkar@ti.com, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

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
