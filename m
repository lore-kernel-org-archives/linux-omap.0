From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 2/2] of/clk: use "clkops-clocks" to specify clocks handled by clock_ops domain
Date: Thu, 12 Jun 2014 19:53:43 +0300
Message-ID: <1402592023-13416-3-git-send-email-grygorii.strashko@ti.com>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
 <1402592023-13416-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1402592023-13416-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: geert+renesas@glider.be
Cc: laurent.pinchart@ideasonboard.com, ulf.hansson@linaro.org, khilman@linaro.org, grant.likely@secretlab.ca, mturquette@linaro.org, tomasz.figa@gmail.com, ben.dooks@codethink.co.uk, horms@verge.net.au, magnus.damm@gmail.com, rjw@rjwysocki.net, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Use "clkops-clocks" property to specify clocks handled by
clock_ops domain PM domain. Only clocks defined in "clkops-clocks"
set of clocks will be handled by Runtime PM through clock_ops
Pm domain.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/of/of_clk.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_clk.c b/drivers/of/of_clk.c
index 35f5e9f..5f9b90e 100644
--- a/drivers/of/of_clk.c
+++ b/drivers/of/of_clk.c
@@ -86,11 +86,8 @@ int of_clk_register_runtime_pm_clocks(struct device_node *np,
 	struct clk *clk;
 	int error;
 
-	for (i = 0; (clk = of_clk_get(np, i)) && !IS_ERR(clk); i++) {
-		if (!clk_may_runtime_pm(clk)) {
-			clk_put(clk);
-			continue;
-		}
+	for (i = 0; (clk = of_clk_get_from_set(np, "clkops", i)) &&
+		     !IS_ERR(clk); i++) {
 
 		error = of_clk_register(dev, clk);
 		if (error) {
-- 
1.7.9.5

