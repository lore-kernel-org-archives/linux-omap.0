From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH] OMAP: EHCI: Adding back Copyright
Date: Mon, 28 Apr 2008 17:20:36 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560872F72C9E3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34985 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763195AbYD1Lwv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 07:52:51 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Adding back Copyright notice that was not carried forward by a patch from Felipe.
Copyrights should be retained without fail.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/usb-ehci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/usb-ehci.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/usb-ehci.c  2008-04-28 16:39:18.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/usb-ehci.c       2008-04-28 16:44:48.000000000 +0530
@@ -4,8 +4,11 @@
  * This file will contain the board specific details for the
  * Synopsys EHCI host controller on OMAP3430
  *
- * Copyright (C) 2008 Nokia Corporation
- * Author: Felipe Balbi <felipe.balbi@nokia.com>
+ * Copyright (C) 2007 Texas Instruments
+ * Author: Vikram Pandita <vikram.pandita@ti.com>
+ *
+ * Generalization by:
+ * Felipe Balbi <felipe.balbi@nokia.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
