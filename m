From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 06/20] net: ethernet: ti: cpsw: drop pinctrl_pm_select_default_state call
Date: Fri, 26 Apr 2019 20:12:28 +0300
Message-ID: <1556298762-8632-7-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Drop pinctrl_pm_select_default_state call from probe as default
pinctrl state is set by DD core.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index cd85bb7c4700..e771e4269af8 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3507,9 +3507,6 @@ static int cpsw_probe(struct platform_device *pdev)
 	 */
 	pm_runtime_enable(dev);
 
-	/* Select default pin state */
-	pinctrl_pm_select_default_state(dev);
-
 	/* Need to enable clocks with runtime PM api to access module
 	 * registers
 	 */
-- 
2.17.1
