From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 2/7] tty: add support for "tty slave" devices
Date: Sat, 13 Aug 2016 05:14:33 +0200
Message-ID: <1471058078-5579-3-git-send-email-sre@kernel.org>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471058078-5579-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Ville Tervo <ville.tervo@iki.fi>, =?UTF-8?q?Filip=20Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neilb@suse.de>

A "tty slave" is a device connected via UART.  It may need a driver to,
for example, power the device on when the tty is opened, and power it
off when the tty is released.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/serial/8250.txt | 4 ++++
 drivers/tty/tty_io.c                              | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index f5561ac7e17e..ecb74730f71b 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -46,6 +46,10 @@ Optional properties:
   line respectively. It will use specified GPIO instead of the peripheral
   function pin for the UART feature. If unsure, don't specify this property.
 
+Optional child node:
+- a device connected to the uart can be specified as child node with
+  compatible value.
+
 Note:
 * fsl,ns16550:
   ------------
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 734a635e7363..39ff5dcdfd50 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -95,6 +95,7 @@
 #include <linux/seq_file.h>
 #include <linux/serial.h>
 #include <linux/ratelimit.h>
+#include <linux/of_platform.h>
 
 #include <linux/uaccess.h>
 
@@ -3317,6 +3318,11 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 	retval = device_register(dev);
 	if (retval)
 		goto error;
+	if (device && device->of_node)
+		/* Children are platform devices and will be
+		 * runtime_pm managed by this tty.
+		 */
+		of_platform_populate(device->of_node, NULL, NULL, dev);
 
 	return dev;
 
-- 
2.8.1
