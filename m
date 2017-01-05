From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] pinctrl: core: Make dt_free_map optional
Date: Thu,  5 Jan 2017 10:54:13 -0800
Message-ID: <20170105185414.27247-2-tony@atomide.com>
References: <20170105185414.27247-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170105185414.27247-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Gary Bisson <gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

If the pin controller driver is using devm_kzalloc, there may not be
anything to do for dt_free_map. Let's make it optional to avoid
unncessary boilerplate code.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/pinctrl/core.c       | 3 ---
 drivers/pinctrl/devicetree.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1913,9 +1913,6 @@ static int pinctrl_check_ops(struct pinctrl_dev *pctldev)
 	    !ops->get_group_name)
 		return -EINVAL;
 
-	if (ops->dt_node_to_map && !ops->dt_free_map)
-		return -EINVAL;
-
 	return 0;
 }
 
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -42,7 +42,8 @@ static void dt_free_map(struct pinctrl_dev *pctldev,
 {
 	if (pctldev) {
 		const struct pinctrl_ops *ops = pctldev->desc->pctlops;
-		ops->dt_free_map(pctldev, map, num_maps);
+		if (ops->dt_free_map)
+			ops->dt_free_map(pctldev, map, num_maps);
 	} else {
 		/* There is no pctldev for PIN_MAP_TYPE_DUMMY_STATE */
 		kfree(map);
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
