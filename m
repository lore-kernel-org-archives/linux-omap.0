From: adharmap@codeaurora.org
Subject: [PATCH v2 1/4] GIC: Disable unused interrupts
Date: Thu, 28 Jan 2010 23:06:01 -0800
Message-ID: <1264748764-5319-2-git-send-email-adharmap@codeaurora.org>
References: <1264748764-5319-1-git-send-email-adharmap@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1264748764-5319-1-git-send-email-adharmap@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Abhijeet Dharmapurikar <adharmap@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, linux-arm-msm@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Abhijeet Dharmapurikar <adharmap@quicinc.com>

Disable all interrupts of a gic in distributor initialization function.
This way interrupts beyond NR_IRQS stay disabled.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
---
 arch/arm/common/gic.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 337741f..cd92ce0 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -175,6 +175,11 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 	set_irq_chained_handler(irq, gic_handle_cascade_irq);
 }
 
+/*
+ * In case of multiple cascaded GICs, order calls to gic_dist_init with
+ * ascending irq_start
+ */
+
 void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 			  unsigned int irq_start)
 {
@@ -200,11 +205,10 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 
 	/*
 	 * The GIC only supports up to 1020 interrupt sources.
-	 * Limit this to either the architected maximum, or the
-	 * platform maximum.
+	 * Limit this to either the architected maximum
 	 */
-	if (max_irq > max(1020, NR_IRQS))
-		max_irq = max(1020, NR_IRQS);
+	if (max_irq > 1020)
+		max_irq = 1020;
 
 	/*
 	 * Set all global interrupts to be level triggered, active low.
-- 
1.5.6.3
