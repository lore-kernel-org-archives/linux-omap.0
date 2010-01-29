From: adharmap@codeaurora.org
Subject: [PATCH v2 2/4] GIC: Prevent gic from crossing NR_IRQS
Date: Thu, 28 Jan 2010 23:06:02 -0800
Message-ID: <1264748764-5319-3-git-send-email-adharmap@codeaurora.org>
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

Prevent gic code from initializing interrupts beyon NR_IRQS.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
---
 arch/arm/common/gic.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index cd92ce0..8a2bfae 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -237,7 +237,8 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 	/*
 	 * Setup the Linux IRQ subsystem.
 	 */
-	for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq; i++) {
+	for (i = irq_start;
+		i < NR_IRQS && i < gic_data[gic_nr].irq_offset + max_irq; i++) {
 		set_irq_chip(i, &gic_chip);
 		set_irq_chip_data(i, &gic_data[gic_nr]);
 		set_irq_handler(i, handle_level_irq);
-- 
1.5.6.3
