From: adharmap@codeaurora.org
Subject: [PATCH v2 3/4] GIC: Add callback for mask_ack
Date: Thu, 28 Jan 2010 23:06:03 -0800
Message-ID: <1264748764-5319-4-git-send-email-adharmap@codeaurora.org>
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

Add gic_mask_ack for faster processing of interrupts.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
---
 arch/arm/common/gic.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 8a2bfae..240f6b6 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -108,6 +108,15 @@ static void gic_unmask_irq(unsigned int irq)
 	spin_unlock(&irq_controller_lock);
 }
 
+static void gic_mask_ack_irq(unsigned int irq)
+{
+	u32 mask = 1 << (irq % 32);
+	spin_lock(&irq_controller_lock);
+	writel(mask, gic_dist_base(irq) + GIC_DIST_ENABLE_CLEAR + (gic_irq(irq) / 32) * 4);
+	writel(gic_irq(irq), gic_cpu_base(irq) + GIC_CPU_EOI);
+	spin_unlock(&irq_controller_lock);
+}
+
 #ifdef CONFIG_SMP
 static int gic_set_cpu(unsigned int irq, const struct cpumask *mask_val)
 {
@@ -160,6 +169,7 @@ static struct irq_chip gic_chip = {
 	.name		= "GIC",
 	.ack		= gic_ack_irq,
 	.mask		= gic_mask_irq,
+	.mask_ack	= gic_mask_ack_irq,
 	.unmask		= gic_unmask_irq,
 #ifdef CONFIG_SMP
 	.set_affinity	= gic_set_cpu,
-- 
1.5.6.3
