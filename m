From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC] [PATCH] input: export gpio-keys driven switch status over gpiolib sysfs
Date: Fri, 5 Jun 2009 00:39:39 +0200
Message-ID: <200906050039.40050.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:56406 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbZFDWkF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jun 2009 18:40:05 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org

This patch adds support for exporting status of GPIO switches, configured as
gpio-keys buttons that generate events of type EV_SW, over standard gpiolib
sysfs interface. That way, switch state can be easily accessed from userspace
via a modern sysfs API in addition to traditional ioclt API, without the need
for adding a new, usualy controversial entry to sysfs interface.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
diff -up linux-2.6.30-rc5/drivers/input/keyboard/gpio_keys.c.orig linux-2.6.30-rc5/drivers/input/keyboard/gpio_keys.c
--- linux-2.6.30-rc5/drivers/input/keyboard/gpio_keys.c.orig	2009-03-24 00:12:14.000000000 +0100
+++ linux-2.6.30-rc5/drivers/input/keyboard/gpio_keys.c	2009-06-04 21:31:19.000000000 +0200
@@ -157,6 +157,19 @@ static int __devinit gpio_keys_probe(str
 			wakeup = 1;
 
 		input_set_capability(input, type, button->code);
+
+		/* For GPIO buttons generating events of type EV_SW
+		 * (ie switches), export their status
+		 * over gpiolib sysfs interface if configured */
+#ifdef CONFIG_GPIO_SYSFS
+		if (type == EV_SW) {
+			error = gpio_export(button->gpio, false);
+			if (error)
+				pr_warning("gpio-keys: "
+					"failed to export GPIO %d, error %d\n",
+					button->gpio, error);
+		}
+#endif
 	}
 
 	error = input_register_device(input);
