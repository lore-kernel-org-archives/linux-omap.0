From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] ARM: OMAP: USB: Fix potential resource overlap due to incorrect end address
Date: Tue, 8 Apr 2008 17:37:59 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08805C30691@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:33608 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbYDHMIH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2008 08:08:07 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m38C81VP001418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Apr 2008 07:08:06 -0500
Received: from dbde01.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m38C8060027303
	for <linux-omap@vger.kernel.org>; Tue, 8 Apr 2008 07:08:00 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

The end address for the USB memory resources were incorrectly defined as
(<start> + <size>) instead of (<start> + <size - 1>) resulting in a
potential overlap with the start address of other resources.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Acked-by: Nishant Kamat <nskamat@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp-usb.c |    2 +-
 arch/arm/mach-omap2/board-3430sdp-usb.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp-usb.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-2430sdp-usb.c	2008-04-08 17:28:40.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp-usb.c	2008-04-08 17:29:54.868278300 +0530
@@ -23,7 +23,7 @@
 static struct resource musb_resources[] = {
 	[0] = {
 		.start	= OMAP243X_HS_BASE,
-		.end	= OMAP243X_HS_BASE + SZ_8K,
+		.end	= OMAP243X_HS_BASE + SZ_8K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {	/* general IRQ */
Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp-usb.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp-usb.c	2008-04-08 17:28:40.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp-usb.c	2008-04-08 17:30:21.938407487 +0530
@@ -29,7 +29,7 @@
 static struct resource musb_resources[] = {
 	[0] = {
 		.start	= OMAP34XX_HSUSB_OTG_BASE,
-		.end	= OMAP34XX_HSUSB_OTG_BASE + SZ_8K,
+		.end	= OMAP34XX_HSUSB_OTG_BASE + SZ_8K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {	/* general IRQ */
@@ -100,7 +100,7 @@ static struct platform_device musb_devic
 static struct resource ehci_resources[] = {
 	[0] = {
 		.start   = OMAP34XX_HSUSB_HOST_BASE + 0x800,
-		.end     = OMAP34XX_HSUSB_HOST_BASE + 0x800 + SZ_1K,
+		.end     = OMAP34XX_HSUSB_HOST_BASE + 0x800 + SZ_1K - 1,
 		.flags   = IORESOURCE_MEM,
 	},
 	[1] = {         /* general IRQ */
