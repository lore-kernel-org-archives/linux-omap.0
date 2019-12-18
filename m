From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 13/18] mfd: menelaus: Make it explicitly non-modular
Date: Wed, 18 Dec 2019 15:48:52 -0500
Message-ID: <1576702137-25905-14-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MENELAUS
drivers/mfd/Kconfig:    bool "TI TWL92330/Menelaus PM chip"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_i2c_driver() uses the same init level priority as
builtin_i2c_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/menelaus.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index b64d3315a5e1..65a268d11aaa 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -18,7 +18,7 @@
  * Copyright (C) 2005, 2006 Nokia Corporation
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
@@ -1222,33 +1222,17 @@ static int menelaus_probe(struct i2c_client *client,
 	return err;
 }
 
-static int menelaus_remove(struct i2c_client *client)
-{
-	struct menelaus_chip	*menelaus = i2c_get_clientdata(client);
-
-	free_irq(client->irq, menelaus);
-	flush_work(&menelaus->work);
-	the_menelaus = NULL;
-	return 0;
-}
-
 static const struct i2c_device_id menelaus_id[] = {
 	{ "menelaus", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, menelaus_id);
 
 static struct i2c_driver menelaus_i2c_driver = {
 	.driver = {
-		.name		= DRIVER_NAME,
+		.name			= DRIVER_NAME,
+		.suppress_bind_attrs	= true,
 	},
 	.probe		= menelaus_probe,
-	.remove		= menelaus_remove,
 	.id_table	= menelaus_id,
 };
-
-module_i2c_driver(menelaus_i2c_driver);
-
-MODULE_AUTHOR("Texas Instruments, Inc. (and others)");
-MODULE_DESCRIPTION("I2C interface for Menelaus.");
-MODULE_LICENSE("GPL");
+builtin_i2c_driver(menelaus_i2c_driver);
-- 
2.7.4
