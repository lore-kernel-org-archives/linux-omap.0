From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 1/2] serio: Amstrad Delta: no longer select AMS_DELTA_FIQ from serio Kconfig
Date: Fri, 5 Nov 2010 01:29:02 +0100
Message-ID: <201011050129.04456.jkrzyszt@tis.icnet.pl>
References: <201011050126.01426.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:32993 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab0KEA3d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Nov 2010 20:29:33 -0400
In-Reply-To: <201011050126.01426.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org

The AMS_DELTA_FIQ config option is going to be dropped and the functionality 
required by the ams-delta-serio driver always built for Amstrad Delta. Then, 
the option must no longer be selected from the serio Kconfig entry.

Created against linux-2.6.37-rc1.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---

 drivers/input/serio/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.37-rc1/drivers/input/serio/Kconfig.orig	2010-11-01 22:41:51.000000000 +0100
+++ linux-2.6.37-rc1/drivers/input/serio/Kconfig	2010-11-04 21:28:55.000000000 +0100
@@ -214,7 +214,6 @@ config SERIO_AMS_DELTA
 	tristate "Amstrad Delta (E3) mailboard support"
 	depends on MACH_AMS_DELTA
 	default y
-	select AMS_DELTA_FIQ
 	---help---
 	  Say Y here if you have an E3 and want to use its mailboard,
 	  or any standard AT keyboard connected to the mailboard port.
