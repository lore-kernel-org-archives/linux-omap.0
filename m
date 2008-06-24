From: Miguel Angel Aguilar Ulloa <miguel.aguilar@ridgerun.com>
Subject: [PATCH 2/3] OMAP3: EVM: KEYPAD: Fix Kconfig dependency
Date: Tue, 24 Jun 2008 07:59:52 -0600
Message-ID: <4860FDD8.1000601@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:38401 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035AbYFXN4G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2008 09:56:06 -0400
Received: from [200.122.155.113] (helo=[192.168.10.40])
	by mail.navvo.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <miguel.aguilar@ridgerun.com>)
	id 1KB8X1-0006d9-UY
	for linux-omap@vger.kernel.org; Tue, 24 Jun 2008 08:26:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add twl4030 keypad driver support to OMAP3 EVM

Signed-off-by: Miguel Angel Aguilar <miguel.aguilar@ridgerun.com>

--- a/drivers/input/keyboard/Kconfig    2008-06-23 15:06:17.000000000 -0600
+++ b/drivers/input/keyboard/Kconfig    2008-06-23 14:32:29.000000000 -0600
@@ -261,7 +261,7 @@ config KEYBOARD_OMAP

config KEYBOARD_TWL4030
    tristate "TI TWL4030 keypad support"
-    depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP_3430SDP)
+    depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP_3430SDP || MACH_OMAP3EVM)
    help
      Say Y here if you want to use the OMAP TWL4030 keypad.
