From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 1/3] ARM: OMAP2+: Add support to parse 'main_clk' info from
 DT
Date: Thu, 12 Dec 2013 17:08:27 +0530
Message-ID: <1386848309-14076-2-git-send-email-rnayak@ti.com>
References: <1386848309-14076-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386848309-14076-1-git-send-email-rnayak@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, nm@ti.com
Cc: mark.rutland@arm.com, Rajendra Nayak <rnayak@ti.com>, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

With clocks for OMAP moving to DT, its now possible to pass the 'main_clk'
data for each device from DT instead of having it in hwmod.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index dfa878b..f22bbbb 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -730,14 +730,18 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
  * functional clock pointer) if a main_clk is present.  Returns 0 on
  * success or -EINVAL on error.
  */
-static int _init_main_clk(struct omap_hwmod *oh)
+static int _init_main_clk(struct omap_hwmod *oh, struct device_node *np)
 {
 	int ret = 0;
 
-	if (!oh->main_clk)
+	if (!oh->main_clk && !of_get_property(np, "clocks", NULL))
 		return 0;
 
-	oh->_clk = clk_get(NULL, oh->main_clk);
+	if (oh->main_clk)
+		oh->_clk = clk_get(NULL, oh->main_clk);
+	else
+		oh->_clk = of_clk_get_by_name(np, "fck");
+
 	if (IS_ERR(oh->_clk)) {
 		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
 			   oh->name, oh->main_clk);
@@ -1565,19 +1569,26 @@ static int _init_clkdm(struct omap_hwmod *oh)
  * Resolves all clock names embedded in the hwmod.  Returns 0 on
  * success, or a negative error code on failure.
  */
-static int _init_clocks(struct omap_hwmod *oh, void *data)
+static int _init_clocks(struct omap_hwmod *oh, void *data,
+			int index, struct device_node *np)
 {
 	int ret = 0;
 
 	if (oh->_state != _HWMOD_STATE_REGISTERED)
 		return 0;
 
+	if (index) {
+		pr_warn("omap_hwmod: %s unable to parse clock data from %s\n",
+				oh->name, np->name);
+		np = NULL;
+	}
+
 	pr_debug("omap_hwmod: %s: looking up clocks\n", oh->name);
 
 	if (soc_ops.init_clkdm)
 		ret |= soc_ops.init_clkdm(oh);
 
-	ret |= _init_main_clk(oh);
+	ret |= _init_main_clk(oh, np);
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
 
@@ -2500,7 +2511,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 		}
 	}
 
-	r = _init_clocks(oh, NULL);
+	r = _init_clocks(oh, NULL, index, np);
 	if (r < 0) {
 		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
 		return -EINVAL;
-- 
1.7.9.5
