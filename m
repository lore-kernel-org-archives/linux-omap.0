From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/4] mfd/tps65910: Delete an unnecessary variable
 initialisation in tps65910_sleepinit()
Date: Tue, 16 Jan 2018 13:01:21 +0100
Message-ID: <0e5997de-0c43-da8c-8ec6-9c3e593d9f5a@users.sourceforge.net>
References: <a524388f-a56d-c2f3-9ec3-fd6343062aad@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <a524388f-a56d-c2f3-9ec3-fd6343062aad@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 Jan 2018 12:10:49 +0100

The local variable "dev" will be reassigned by a following statement.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/tps65910.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 80ea1474c654..7e7d3d1642c6 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -312,7 +312,7 @@ static int tps65910_ck32k_init(struct tps65910 *tps65910,
 static int tps65910_sleepinit(struct tps65910 *tps65910,
 		struct tps65910_board *pmic_pdata)
 {
-	struct device *dev = NULL;
+	struct device *dev;
 	int ret;
 
 	dev = tps65910->dev;
-- 
2.15.1

