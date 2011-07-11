From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [PATCH] TPS6507X: define MFD dependencies for touch and regulator
 unit
Date: Mon, 11 Jul 2011 10:59:10 +0200
Message-ID: <4E1ABB5E.8070406@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:60784 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667Ab1GKI7T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 04:59:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

both touchscreen and regulator units are only working if
mfd device is activated. So if mfd support is enabled,
select TPS6507X mfd support automatically.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/input/touchscreen/Kconfig |    3 ++-
 drivers/regulator/Kconfig         |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/input/touchscreen/Kconfig
===================================================================
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -716,7 +716,8 @@
 
 config TOUCHSCREEN_TPS6507X
 	tristate "TPS6507x based touchscreens"
-	depends on I2C
+	depends on I2C && MFD_SUPPORT
+	select TPS6507X
 	help
 	  Say Y here if you have a TPS6507x based touchscreen
 	  controller.
Index: b/drivers/regulator/Kconfig
===================================================================
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -242,7 +242,8 @@
 
 config REGULATOR_TPS6507X
 	tristate "TI TPS6507X Power regulators"
-	depends on I2C
+	depends on I2C && MFD_SUPPORT
+	select TPS6507X
 	help
 	  This driver supports TPS6507X voltage regulator chips. TPS6507X provides
 	  three step-down converters and two general-purpose LDO voltage regulators.

