From: Tero Kristo <t-kristo@ti.com>
Subject: [RESEND PATCHv2 04/28] ARM: OMAP2+: hwmod: use new ti_clk_get API to
 search for clock handles
Date: Mon, 13 Jun 2016 22:04:38 +0300
Message-ID: <1465844702-12200-5-git-send-email-t-kristo@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The new API avoids the need to add clock aliases for most of the clocks,
should use of it is preferred. Many of the existing clock aliases are
only created because of hwmod data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 83cb527..0ea869c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -786,7 +786,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 	if (!oh->main_clk)
 		return 0;
 
-	oh->_clk = clk_get(NULL, oh->main_clk);
+	oh->_clk = ti_clk_get(oh->main_clk);
 	if (IS_ERR(oh->_clk)) {
 		pr_warn("omap_hwmod: %s: cannot clk_get main_clk %s\n",
 			oh->name, oh->main_clk);
@@ -831,7 +831,7 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 		if (!os->clk)
 			continue;
 
-		c = clk_get(NULL, os->clk);
+		c = ti_clk_get(os->clk);
 		if (IS_ERR(c)) {
 			pr_warn("omap_hwmod: %s: cannot clk_get interface_clk %s\n",
 				oh->name, os->clk);
@@ -868,7 +868,7 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 	int ret = 0;
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++) {
-		c = clk_get(NULL, oc->clk);
+		c = ti_clk_get(oc->clk);
 		if (IS_ERR(c)) {
 			pr_warn("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
 				oh->name, oc->clk);
-- 
1.9.1
