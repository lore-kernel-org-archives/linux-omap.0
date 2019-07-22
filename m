From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 13/14] mfd: palmas: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:20 +0200
Message-ID: <20190722172623.4166-14-wsa+renesas@sang-engineering.com>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/mfd/palmas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 6818ff34837c..f5b3fa973b13 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -549,12 +549,12 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 			palmas->i2c_clients[i] = i2c;
 		else {
 			palmas->i2c_clients[i] =
-					i2c_new_dummy(i2c->adapter,
+					i2c_new_dummy_device(i2c->adapter,
 							i2c->addr + i);
-			if (!palmas->i2c_clients[i]) {
+			if (IS_ERR(palmas->i2c_clients[i])) {
 				dev_err(palmas->dev,
 					"can't attach client %d\n", i);
-				ret = -ENOMEM;
+				ret = PTR_ERR(palmas->i2c_clients[i]);
 				goto err_i2c;
 			}
 			palmas->i2c_clients[i]->dev.of_node = of_node_get(node);
-- 
2.20.1
