From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 08/11] mfd: twl-core: Move 'inuse' check early at probe time
Date: Wed, 16 Jan 2013 14:53:56 +0100
Message-ID: <1358344439-23017-9-git-send-email-peter.ujfalusi@ti.com>
References: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

We can fail earlier in case multiple instance of the twl-core is tried to
be loaded.
The twl-core by design only supports one instance.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 547fed5..1827088 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1170,6 +1170,12 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -EINVAL;
 	}
 
+	if (inuse) {
+		dev_dbg(&client->dev, "only one instance of %s allowed\n",
+			DRIVER_NAME);
+		return -EBUSY;
+	}
+
 	pdev = platform_device_alloc(DRIVER_NAME, -1);
 	if (!pdev) {
 		dev_err(&client->dev, "can't alloc pdev\n");
@@ -1188,12 +1194,6 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto free;
 	}
 
-	if (inuse) {
-		dev_dbg(&client->dev, "driver is already in use\n");
-		status = -EBUSY;
-		goto free;
-	}
-
 	if ((id->driver_data) & TWL6030_CLASS) {
 		twl_id = TWL6030_CLASS_ID;
 		twl_map = &twl6030_map[0];
-- 
1.8.1
