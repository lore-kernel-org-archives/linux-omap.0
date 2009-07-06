From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] OMAP3: EHCI: Allow EHCI to work as a module again
Date: Mon, 6 Jul 2009 12:35:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305C10FA4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51710 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327AbZGFHFS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jul 2009 03:05:18 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>

From: Anand Gadiyar <gadiyar@ti.com>

OMAP3: EHCI: Allow EHCI to work as a module again

commit fc3c45ca seems to have broken EHCI as a module. Fix this.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index 0fe26f2..56fc7f4 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -27,7 +27,7 @@
 #include <mach/irqs.h>
 #include <mach/usb.h>
 
-#if defined(CONFIG_USB_EHCI_HCD) || #define(CONFIG_USB_EHCI_HCD_MODULE)
+#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
 
 static struct resource ehci_resources[] = {
 	{
