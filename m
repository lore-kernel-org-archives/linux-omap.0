From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] pinctrl: single: Remove invalid message
Date: Thu, 14 Dec 2017 08:51:15 -0800
Message-ID: <20171214165115.27150-1-tony@atomide.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pinctrl single should just show how many pins were found, the physical
address is already in the dev information. So let's remove the wrong
information that claims to show the physical address but really prints
a virtual address that is now hashed.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinctrl-single.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1774,8 +1774,7 @@ static int pcs_probe(struct platform_device *pdev)
 			dev_warn(pcs->dev, "initialized with no interrupts\n");
 	}
 
-	dev_info(pcs->dev, "%i pins at pa %p size %u\n",
-		 pcs->desc.npins, pcs->base, pcs->size);
+	dev_info(pcs->dev, "%i pins, size %u\n", pcs->desc.npins, pcs->size);
 
 	return pinctrl_enable(pcs->pctl);
 
-- 
2.15.0
