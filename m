From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/4] mfd/tps65910: Move an assignment in tps65910_sleepinit()
Date: Tue, 16 Jan 2018 13:02:30 +0100
Message-ID: <ecbcfe5a-ed61-9a8a-72ce-d495c2e59763@users.sourceforge.net>
References: <a524388f-a56d-c2f3-9ec3-fd6343062aad@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a524388f-a56d-c2f3-9ec3-fd6343062aad@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 Jan 2018 12:22:28 +0100

Move the assignment for the local variable "dev" so that its setting
will be performed after a configuration check by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/tps65910.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 7e7d3d1642c6..bf16cbe6fd88 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -315,11 +315,11 @@ static int tps65910_sleepinit(struct tps65910 *tps65910,
 	struct device *dev;
 	int ret;
 
-	dev = tps65910->dev;
-
 	if (!pmic_pdata->en_dev_slp)
 		return 0;
 
+	dev = tps65910->dev;
+
 	/* enabling SLEEP device state */
 	ret = tps65910_reg_set_bits(tps65910, TPS65910_DEVCTRL,
 				DEVCTRL_DEV_SLP_MASK);
-- 
2.15.1
