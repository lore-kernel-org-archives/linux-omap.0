From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] pinctrl: single: use of_device_get_match_data() to get soc
 data
Date: Sun, 21 May 2017 01:02:17 +0900
Message-ID: <1495296137-6461-1-git-send-email-yamada.masahiro@socionext.com>
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
To: linux-gpio@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Use of_device_get_match_data() instead of of_match_device().
It allows us to remove the forward declaration of pcs_of_match.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/pinctrl-single.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 9c267dc..b8b3d93 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1270,8 +1270,6 @@ static void pcs_free_resources(struct pcs_device *pcs)
 #endif
 }
 
-static const struct of_device_id pcs_of_match[];
-
 static int pcs_add_gpio_func(struct device_node *node, struct pcs_device *pcs)
 {
 	const char *propname = "pinctrl-single,gpio-range";
@@ -1637,15 +1635,14 @@ static int pcs_quirk_missing_pinctrl_cells(struct pcs_device *pcs,
 static int pcs_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct pcs_pdata *pdata;
 	struct resource *res;
 	struct pcs_device *pcs;
 	const struct pcs_soc_data *soc;
 	int ret;
 
-	match = of_match_device(pcs_of_match, &pdev->dev);
-	if (!match)
+	soc = of_device_get_match_data(&pdev->dev);
+	if (WARN_ON(!soc))
 		return -EINVAL;
 
 	pcs = devm_kzalloc(&pdev->dev, sizeof(*pcs), GFP_KERNEL);
@@ -1658,7 +1655,6 @@ static int pcs_probe(struct platform_device *pdev)
 	raw_spin_lock_init(&pcs->lock);
 	mutex_init(&pcs->mutex);
 	INIT_LIST_HEAD(&pcs->gpiofuncs);
-	soc = match->data;
 	pcs->flags = soc->flags;
 	memcpy(&pcs->socdata, soc, sizeof(*soc));
 
-- 
2.7.4
