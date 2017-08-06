From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v2 1/2] ARM: OMAP3+: PRM: fix of_irq_get() result check
Date: Sun, 06 Aug 2017 18:14:21 +0300
Message-ID: <20170806151710.416156875@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline;
 filename=ARM-OMAP3-PRM-fix-of_irq_get-result-check-v2.patch
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

of_irq_get() may return 0 as well as a nagative error number on failure
(and never on success), however omap3xxx_prm_late_init() regards 0 as a
valid IRQ -- fix this.

Fixes: 1e037794f7f ("ARM: OMAP3+: PRM: register interrupt information from DT")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes ion version 2:
- rebased to the 'omap-for-v4.13/fixes' branch;
- fixed Rajendra Nayak's email;
- added + to OMAP3 in the patch subject.

 arch/arm/mach-omap2/prm3xxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap/arch/arm/mach-omap2/prm3xxx.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/prm3xxx.c
+++ linux-omap/arch/arm/mach-omap2/prm3xxx.c
@@ -706,7 +706,7 @@ static int omap3xxx_prm_late_init(void)
 	np = of_find_matching_node(NULL, omap3_prm_dt_match_table);
 	if (np) {
 		irq_num = of_irq_get(np, 0);
-		if (irq_num >= 0)
+		if (irq_num > 0)
 			omap3_prcm_irq_setup.irq = irq_num;
 	}
