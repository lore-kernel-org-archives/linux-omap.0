From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.35 08/11] usb: musb: omap2430.c: remove unnecessary includes
Date: Wed, 24 Mar 2010 14:55:15 +0200
Message-ID: <1269435318-29153-9-git-send-email-felipe.balbi@nokia.com>
References: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51968 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128Ab0CXM4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:56:18 -0400
In-Reply-To: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Anand Gadiyar <gadiyar@ti.com>

We don't need mach-types and hardware.h

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 202cafa..c5cc473 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -33,8 +33,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <asm/mach-types.h>
-#include <mach/hardware.h>
 #include <plat/mux.h>
 
 #include "musb_core.h"
-- 
1.7.0.rc0.33.g7c3932

