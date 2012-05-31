From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 9/9] TEMP: ARM: OMAP3: prevent dpll4 manual enable / disable
 + prevent core clkdm idle
Date: Thu, 31 May 2012 16:29:02 +0300
Message-ID: <1338470942-20185-10-git-send-email-t-kristo@ti.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

DPLL4 (PER DPLL) disable can cause issues on omap3, thus prevent
disable / enable by setting the clkops as core_dpll_ops. Also, prevent
l3 / l4 core clkdomain manual transitions as these can cause issues also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c        |    2 +-
 arch/arm/mach-omap2/clockdomains3xxx_data.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index ca0de28..bbc1a36 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -611,7 +611,7 @@ static struct dpll_data dpll4_dd_3630 __initdata = {
 
 static struct clk dpll4_ck = {
 	.name		= "dpll4_ck",
-	.ops		= &clkops_omap3_noncore_dpll_ops,
+	.ops		= &clkops_omap3_core_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll4_dd,
 	.round_rate	= &omap2_dpll_round_rate,
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index 0dae4c8..52bf48c 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -232,7 +232,7 @@ static struct clockdomain d2d_clkdm = {
 static struct clockdomain core_l3_3xxx_clkdm = {
 	.name		= "core_l3_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
+	.flags		= CLKDM_CAN_HWSUP | CLKDM_SKIP_MANUAL_TRANS,
 	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L3_MASK,
 };
@@ -245,7 +245,7 @@ static struct clockdomain core_l3_3xxx_clkdm = {
 static struct clockdomain core_l4_3xxx_clkdm = {
 	.name		= "core_l4_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
+	.flags		= CLKDM_CAN_HWSUP | CLKDM_SKIP_MANUAL_TRANS,
 	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L4_MASK,
 };
-- 
1.7.4.1
