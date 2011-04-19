From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] cbus: tahvo: Select USB_OTG_UTILS
Date: Tue, 19 Apr 2011 11:19:38 +0300
Message-ID: <1303201178-11482-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64623 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab1DSIRq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 04:17:46 -0400
Received: by eyx24 with SMTP id 24so1619314eyx.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 01:17:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>

tahvo-usb.c is using otg_set_transceiver which is built only if
CONFIG_USB_OTG_UTILS is set.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 drivers/cbus/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/Kconfig b/drivers/cbus/Kconfig
index 2667dff..d845a7e 100644
--- a/drivers/cbus/Kconfig
+++ b/drivers/cbus/Kconfig
@@ -23,6 +23,7 @@ config CBUS_TAHVO
 
 config CBUS_TAHVO_USB
 	depends on CBUS_TAHVO && USB
+	select USB_OTG_UTILS
 	tristate "Support for Tahvo USB transceiver"
 	---help---
 	  If you want Tahvo support for USB transceiver, say Y or M here.
-- 
1.7.4.1

