From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: [PATCH 2/3] OMAP3: EVM: KEYPAD: Fix Kconfig dependency
Date: Wed, 25 Jun 2008 14:20:24 -0600
Message-ID: <4862A888.2070808@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:59279 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727AbYFYUQd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jun 2008 16:16:33 -0400
Received: from [200.122.155.113] (helo=[192.168.10.40])
	by mail.navvo.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <miguel.aguilar@ridgerun.com>)
	id 1KBawk-0003vJ-F9
	for linux-omap@vger.kernel.org; Wed, 25 Jun 2008 14:46:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add twl4030 keypad driver support to OMAP3 EVM

Signed-off-by: Miguel Angel Aguilar <miguel.aguilar@ridgerun.com> 
---
 drivers/input/keyboard/Kconfig                 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/reference_kernel/drivers/input/keyboard/Kconfig b/linux-2.6.26/drivers/input/keyboard/Kconfig
index 0f96a30..cf86a7b 100644
--- a/reference_kernel/drivers/input/keyboard/Kconfig
+++ b/linux-2.6.26/drivers/input/keyboard/Kconfig
@@ -261,7 +261,7 @@ config KEYBOARD_OMAP
 
 config KEYBOARD_TWL4030
 	tristate "TI TWL4030 keypad support"
-	depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP_3430SDP)
+	depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP_3430SDP || MACH_OMAP3EVM)
 	help
 	  Say Y here if you want to use the OMAP TWL4030 keypad.
