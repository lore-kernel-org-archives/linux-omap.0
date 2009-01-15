From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] Fix compile error in usb-ehci.c
Date: Fri, 16 Jan 2009 00:18:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B89@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47890 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbZAOSsa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 13:48:30 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

From: Anand Gadiyar <gadiyar@ti.com>

Fix this compile error

  CC      arch/arm/mach-omap2/usb-ehci.o
arch/arm/mach-omap2/usb-ehci.c:39: error: 'INT_34XX_EHCI_IRQ' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/usb-ehci.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index 489439d..6af0b02 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -25,6 +25,7 @@
 #include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/pm.h>
 #include <mach/usb.h>
