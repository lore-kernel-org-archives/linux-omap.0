From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 14/14] USB: ehci-omap: Fix autoloading of module
Date: Thu, 7 Feb 2013 18:02:54 +0200
Message-ID: <1360252974-7912-15-git-send-email-rogerq@ti.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33851 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932275Ab3BGQDr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Feb 2013 11:03:47 -0500
In-Reply-To: <1360252974-7912-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, balbi@ti.com, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, linux@arm.linux.org.uk, kishon@ti.com, mark.rutland@arm.com, rogerq@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The module alias should be "ehci-omap" and not
"omap-ehci" to match the platform device name.
The omap-ehci module should now autoload correctly.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/host/ehci-omap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index a8ce10d..a2d16c0 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -340,9 +340,10 @@ static void __exit ehci_omap_cleanup(void)
 }
 module_exit(ehci_omap_cleanup);
 
-MODULE_ALIAS("platform:omap-ehci");
+MODULE_ALIAS("platform:ehci-omap");
 MODULE_AUTHOR("Texas Instruments, Inc.");
 MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
+MODULE_AUTHOR("Roger Quadros <rogerq@ti.com");
 
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-- 
1.7.4.1

