From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCH 1/2] twl4030: Do not dereference null pointer in error path
Date: Wed, 30 Sep 2009 18:11:54 +0300
Message-ID: <1254323515-30866-1-git-send-email-ilkka.koskinen@nokia.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754704AbZI3PLb@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, sameo@linux.intel.com
Cc: linux-omap@vger.kernel.org, ilkka.koskinen@nokia.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
---
 drivers/mfd/twl4030-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index e424cf6..8cf0a02 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -792,7 +792,7 @@ twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			twl->client = i2c_new_dummy(client->adapter,
 					twl->address);
 			if (!twl->client) {
-				dev_err(&twl->client->dev,
+				dev_err(&client->dev,
 					"can't attach client %d\n", i);
 				status = -ENOMEM;
 				goto fail;
-- 
1.6.0.4
