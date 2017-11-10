From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function
Date: Fri, 10 Nov 2017 16:56:52 +0530
Message-ID: <1510313212-29660-1-git-send-email-j-keerthy@ti.com>
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
To: tony@atomide.com
Cc: rnayak@codeaurora.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Referring TRM Am335X series:
http://www.ti.com/lit/ug/spruh73p/spruh73p.pdf

The LastPowerStateEntered bitfield is present only for PM_CEFUSE
domain. This is not present in any of the other power domains. Hence
remove the generic am33xx_pwrdm_read_prev_pwrst hook which wrongly
reads the reserved bit fields for all the other power domains.

Reading the reserved bits leads to wrongly interpreting the low
power transitions for various power domains that do not have the
LastPowerStateEntered field. The pm debug counters values are wrong
currently as we are incrementing them based on the reserved bits.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/prm33xx.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index bc5df8d..dfca8d9 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -176,17 +176,6 @@ static int am33xx_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 	return v;
 }
 
-static int am33xx_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
-{
-	u32 v;
-
-	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs);
-	v &= AM33XX_LASTPOWERSTATEENTERED_MASK;
-	v >>= AM33XX_LASTPOWERSTATEENTERED_SHIFT;
-
-	return v;
-}
-
 static int am33xx_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 {
 	am33xx_prm_rmw_reg_bits(AM33XX_LOWPOWERSTATECHANGE_MASK,
@@ -386,7 +375,6 @@ struct pwrdm_ops am33xx_pwrdm_operations = {
 	.pwrdm_set_next_pwrst		= am33xx_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst		= am33xx_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst		= am33xx_pwrdm_read_pwrst,
-	.pwrdm_read_prev_pwrst		= am33xx_pwrdm_read_prev_pwrst,
 	.pwrdm_set_logic_retst		= am33xx_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst		= am33xx_pwrdm_read_logic_pwrst,
 	.pwrdm_read_logic_retst		= am33xx_pwrdm_read_logic_retst,
-- 
1.9.1
