From: Tiago Maluta <tiago.maluta@gmail.com>
Subject: [RFC][PATCH] Allow change timing values to wait slow devices bring up
	before try register an interface to IP-Config (used on some drivers using
	Multi-purpose USB Networking Framework)
Date: Sat, 6 Feb 2010 23:30:35 +0000
Message-ID: <600adaf51002061530o700378aaq75ff83b04d977958@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:47128 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756528Ab0BFXah (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Feb 2010 18:30:37 -0500
Received: by ewy28 with SMTP id 28so1310232ewy.28
        for <linux-omap@vger.kernel.org>; Sat, 06 Feb 2010 15:30:36 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'd like to know if this patch could be considered an general use or
an particular case.

--tm

Signed-off-by: Tiago Maluta <maluta@unifei.edu.br>
---
 drivers/net/usb/Kconfig |   17 +++++++++++++++++
 net/ipv4/ipconfig.c     |    4 ++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 32d9356..5b84e57 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -127,6 +127,23 @@ config USB_USBNET
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbnet.

+
+config USB_USBNETDEVICE_DELAY_PRE
+	int "Define the friendly delay before opening net devices "
+	depends on USB_USBNET
+	default 500
+	help
+	    Some devices may not work due to a delay from hardware bring the interface
+	    up. This value added a delay before search and register the interface.
+
+config USB_USBNETDEVICE_DELAY_POST
+	int "Define the friendly delay after opening net devices "
+	depends on USB_USBNET
+	default 1
+	help
+	    Some devices may not work due to a delay from hardware bring the interface
+	    up. This value added a delay before search and register the interface.
+
 config USB_NET_AX8817X
 	tristate "ASIX AX88xxx Based USB 2.0 Ethernet Adapters"
 	depends on USB_USBNET
diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 10a6a60..3faac07 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -86,8 +86,8 @@
 #endif

 /* Define the friendly delay before and after opening net devices */
-#define CONF_PRE_OPEN		500	/* Before opening: 1/2 second */
-#define CONF_POST_OPEN		1	/* After opening: 1 second */
+#define CONF_PRE_OPEN		CONFIG_USB_USBNETDEVICE_DELAY_PRE	/* Before
opening. Default 1/2 second */
+#define CONF_POST_OPEN		CONFIG_USB_USBNETDEVICE_DELAY_POST	/* After
opening. Default 1 second */

 /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
 #define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
-- 
1.6.4.2
