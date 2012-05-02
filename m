From: Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH] omap-usb-host: include <plat/cpu.h>
Date: Wed, 02 May 2012 10:36:44 -0400
Message-ID: <4FA1467C.8030005@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56409 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754480Ab2EBOgs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 10:36:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Guillaume GARDET <guillaume.gardet@opensuse.org>

omap-usb-host calls cpu_is_omap3430, which is defined in plat/cpu.h.

Reported-by: Guillaume GARDET <guillaume.gardet@opensuse.org>
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 drivers/mfd/omap-usb-host.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -26,6 +26,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
 #include <plat/usb.h>
+#include <plat/cpu.h>
 #include <linux/pm_runtime.h>
 
 #define USBHS_DRIVER_NAME	"usbhs_omap"

-- 
Jeff Mahoney
SUSE Labs
