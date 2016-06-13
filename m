From: Tero Kristo <t-kristo@ti.com>
Subject: [RESEND PATCHv2 02/28] clk: ti: dpll: use ti_clk_get to fetch
 ref/bypass clocks
Date: Mon, 13 Jun 2016 22:04:36 +0300
Message-ID: <1465844702-12200-3-git-send-email-t-kristo@ti.com>
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

This allows getting rid of the DT_CLK() aliases under drivers/clk/ti.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/dpll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 9fc8754..39ba010 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -220,8 +220,8 @@ struct clk *ti_clk_register_dpll(struct ti_clk *setup)
 	if (dpll->num_parents < 2)
 		return ERR_PTR(-EINVAL);
 
-	clk_ref = clk_get_sys(NULL, dpll->parents[0]);
-	clk_bypass = clk_get_sys(NULL, dpll->parents[1]);
+	clk_ref = ti_clk_get(dpll->parents[0]);
+	clk_bypass = ti_clk_get(dpll->parents[1]);
 
 	if (IS_ERR_OR_NULL(clk_ref) || IS_ERR_OR_NULL(clk_bypass))
 		return ERR_PTR(-EAGAIN);
-- 
1.9.1
