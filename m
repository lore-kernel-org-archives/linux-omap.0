From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 14/14] mfd: twl-core: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:21 +0200
Message-ID: <20190722172623.4166-15-wsa+renesas@sang-engineering.com>
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

 drivers/mfd/twl-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 448d9397ff04..20cf8cfe4f3b 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1141,12 +1141,12 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (i == 0) {
 			twl->client = client;
 		} else {
-			twl->client = i2c_new_dummy(client->adapter,
+			twl->client = i2c_new_dummy_device(client->adapter,
 						    client->addr + i);
-			if (!twl->client) {
+			if (IS_ERR(twl->client)) {
 				dev_err(&client->dev,
 					"can't attach client %d\n", i);
-				status = -ENOMEM;
+				status = PTR_ERR(twl->client);
 				goto fail;
 			}
 		}
-- 
2.20.1
