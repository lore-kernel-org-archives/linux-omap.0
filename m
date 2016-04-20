From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/2] mfd: twl6040: Disable and unprepare clk32k in twl6040_power() error path
Date: Wed, 20 Apr 2016 11:16:37 -0400
Message-ID: <1461165398-12289-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

The clk32k clock is prepared and enabled in twl6040_power() but the clock
is left enabled in case of an error while it should be disable/unprepared.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/mfd/twl6040.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 08a693cd38cc..4de92c16dfb8 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -300,6 +300,7 @@ int twl6040_power(struct twl6040 *twl6040, int on)
 			/* use automatic power-up sequence */
 			ret = twl6040_power_up_automatic(twl6040);
 			if (ret) {
+				clk_disable_unprepare(twl6040->clk32k);
 				twl6040->power_count = 0;
 				goto out;
 			}
@@ -307,6 +308,7 @@ int twl6040_power(struct twl6040 *twl6040, int on)
 			/* use manual power-up sequence */
 			ret = twl6040_power_up_manual(twl6040);
 			if (ret) {
+				clk_disable_unprepare(twl6040->clk32k);
 				twl6040->power_count = 0;
 				goto out;
 			}
-- 
2.5.5
