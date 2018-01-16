From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/4] mfd/tps65910: Delete an error message for a failed memory
 allocation in tps65910_parse_dt()
Date: Tue, 16 Jan 2018 12:59:01 +0100
Message-ID: <c6d936d4-a3b3-43ba-24af-9688aa538780@users.sourceforge.net>
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
Date: Tue, 16 Jan 2018 11:14:40 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/tps65910.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 8263605f6d2f..555bd394efc3 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -395,10 +395,8 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 
 	board_info = devm_kzalloc(&client->dev, sizeof(*board_info),
 			GFP_KERNEL);
-	if (!board_info) {
-		dev_err(&client->dev, "Failed to allocate pdata\n");
+	if (!board_info)
 		return NULL;
-	}
 
 	ret = of_property_read_u32(np, "ti,vmbch-threshold", &prop);
 	if (!ret)
-- 
2.15.1
