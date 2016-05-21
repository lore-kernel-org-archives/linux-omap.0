From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0104/1529] Fix typo
Date: Sat, 21 May 2016 13:50:07 +0200
Message-ID: <20160521115007.4767-1-andrea.gelmini@gelma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: andrea.gelmini@gelma.net
Cc: tony@atomide.com, linux-omap@vger.kernel.org, trivial@kernel.org, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap2/cm3xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 187fa43..d91ae82 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -649,7 +649,7 @@ void omap3_cm_save_scratchpad_contents(u32 *ptr)
 	/*
 	 * As per erratum i671, ROM code does not respect the PER DPLL
 	 * programming scheme if CM_AUTOIDLE_PLL..AUTO_PERIPH_DPLL == 1.
-	 * Then,  in anycase, clear these bits to avoid extra latencies.
+	 * Then,  in any case, clear these bits to avoid extra latencies.
 	 */
 	*ptr++ = omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE) &
 		~OMAP3430_AUTO_PERIPH_DPLL_MASK;
-- 
2.8.2.534.g1f66975
