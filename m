From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] Fix compile error in usb-musb.c
Date: Fri, 16 Jan 2009 00:18:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B88@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53074 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754256AbZAOSsd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 13:48:33 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>

From: Anand Gadiyar <gadiyar@ti.com>

Fix this compile error

  CC      arch/arm/mach-omap2/usb-musb.o
arch/arm/mach-omap2/usb-musb.c:47: error: 'INT_243X_HS_USB_MC' undeclared here (not in a function)
arch/arm/mach-omap2/usb-musb.c:51: error: 'INT_243X_HS_USB_DMA' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/usb-musb.o] Error 1

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Reported-by: David Brownell <david-b@pacbell.net>
---
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 61c5709..5d79f89 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -28,6 +28,7 @@
 #include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/pm.h>
 #include <mach/mux.h>
 #include <mach/usb.h>
