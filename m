From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 2/2] ARM: OMAP4: PRM: fix of_irq_get() result checks
Date: Sun, 06 Aug 2017 16:38:51 +0300
Message-ID: <20170806134543.511156423@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline;
 filename=ARM-OMAP4-PRM-fix-of_irq_get-result-checks.patch
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

of_irq_get() may return 0 as well as a nagative error number on failure,
(and never on success), however omap44xx_prm_late_init() regards 0 as a
valid IRQ -- fix this.

Fixes: c5b3955828ba ("ARM: OMAP4: Fix legacy code clean-up regression")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-omap2/prm44xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/prm44xx.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/prm44xx.c
+++ linux-omap/arch/arm/mach-omap2/prm44xx.c
@@ -751,7 +751,7 @@ static int omap44xx_prm_late_init(void)
 	 * Already have OMAP4 IRQ num. For all other platforms, we need
 	 * IRQ numbers from DT
 	 */
-	if (irq_num < 0 && !(prm_init_data->flags & PRM_IRQ_DEFAULT)) {
+	if (irq_num <= 0 && !(prm_init_data->flags & PRM_IRQ_DEFAULT)) {
 		if (irq_num == -EPROBE_DEFER)
 			return irq_num;
 
@@ -760,7 +760,7 @@ static int omap44xx_prm_late_init(void)
 	}
 
 	/* Once OMAP4 DT is filled as well */
-	if (irq_num >= 0) {
+	if (irq_num > 0) {
 		omap4_prcm_irq_setup.irq = irq_num;
 		omap4_prcm_irq_setup.xlate_irq = NULL;
 	}
