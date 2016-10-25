From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] pinctrl: single: Drop pointless macro
Date: Tue, 25 Oct 2016 09:09:00 -0700
Message-ID: <20161025160900.2724-3-tony@atomide.com>
References: <20161025160900.2724-1-tony@atomide.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161025160900.2724-1-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is left over from initial experiments with more properties.
It's only used in one place, so let's just get rid of it to make
the code more readable.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinctrl-single.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1471,15 +1471,6 @@ static void pcs_free_resources(struct pcs_device *pcs)
 	pcs_free_pingroups(pcs);
 }
 
-#define PCS_GET_PROP_U32(name, reg, err)				\
-	do {								\
-		ret = of_property_read_u32(np, name, reg);		\
-		if (ret) {						\
-			dev_err(pcs->dev, err);				\
-			return ret;					\
-		}							\
-	} while (0);
-
 static const struct of_device_id pcs_of_match[];
 
 static int pcs_add_gpio_func(struct device_node *node, struct pcs_device *pcs)
@@ -1824,8 +1815,13 @@ static int pcs_probe(struct platform_device *pdev)
 	pcs->flags = soc->flags;
 	memcpy(&pcs->socdata, soc, sizeof(*soc));
 
-	PCS_GET_PROP_U32("pinctrl-single,register-width", &pcs->width,
-			 "register width not specified\n");
+	ret = of_property_read_u32(np, "pinctrl-single,register-width",
+				   &pcs->width);
+	if (ret) {
+		dev_err(pcs->dev, "register width not specified\n");
+
+		return ret;
+	}
 
 	ret = of_property_read_u32(np, "pinctrl-single,function-mask",
 				   &pcs->fmask);
-- 
2.9.3
