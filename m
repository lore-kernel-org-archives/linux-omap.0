From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] hsi: omap_ssi_port: use normal module refcounting
Date: Wed, 04 Jun 2014 09:56:48 +0200
Message-ID: <7426698.eEpYu3o0WK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Carlos Chinea <carlos.chinea@nokia.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The ref_module() function is used for internal housekeeping of the
module code, it's not normally used by subsystems or device drivers,
and the use of ref_module in the omap_ssi_port driver causes a link
build error when modules are disabled:

hsi/controllers/omap_ssi_port.c: In function 'ssi_port_probe':
hsi/controllers/omap_ssi_port.c:1119:2: error: implicit declaration of function 'ref_module' [-Werror=implicit-function-declaration]

This changes the omap_ssi_port driver to use try_module_get()
and module_put() instead, which is the normal way to ensure that
the driver providing a device used in another module does not
go away.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Carlos Chinea <carlos.chinea@nokia.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index b8693f0..6eb7c28 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -1116,8 +1116,7 @@ static int __init ssi_port_probe(struct platform_device *pd)
 
 	dev_dbg(&pd->dev, "init ssi port...\n");
 
-	err = ref_module(THIS_MODULE, ssi->owner);
-	if (err) {
+	if (!try_module_get(ssi->owner)) {
 		dev_err(&pd->dev, "could not increment parent module refcount (err=%d)\n",
 			err);
 		return -ENODEV;
@@ -1254,6 +1253,7 @@ static int __exit ssi_port_remove(struct platform_device *pd)
 
 	omap_ssi->port[omap_port->port_id] = NULL;
 	platform_set_drvdata(pd, NULL);
+	module_put(port->owner);
 	pm_runtime_disable(&pd->dev);
 
 	return 0;
