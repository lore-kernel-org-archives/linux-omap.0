From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/2] gpio: omap : Add missing clk_unprepare().
Date: Tue,  1 Aug 2017 12:14:31 +0530
Message-ID: <f41f83c5a540065ca9fc1cae754b5b4d4a2749a2.1501569628.git.arvind.yadav.cs@gmail.com>
References: <e84a2b010f0632369030f92fa30572ba1e4aaaf2.1501569628.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <e84a2b010f0632369030f92fa30572ba1e4aaaf2.1501569628.git.arvind.yadav.cs@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, linus.walleij@linaro.org
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

omap_gpio_probe() can fail here and we must disable clock.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/gpio/gpio-omap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f8c550de..dbf869f 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1247,6 +1247,8 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	if (ret) {
 		pm_runtime_put_sync(dev);
 		pm_runtime_disable(dev);
+		if (bank->dbck_flag)
+			clk_unprepare(bank->dbck);
 		return ret;
 	}
 
-- 
1.9.1

