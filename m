From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.35 (v2) 07/11] usb: musb: omap2430: remove unused define
Date: Thu, 25 Mar 2010 13:25:24 +0200
Message-ID: <1269516328-28267-8-git-send-email-felipe.balbi@nokia.com>
References: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48774 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513Ab0CYL02 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 07:26:28 -0400
In-Reply-To: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Anand Gadiyar <gadiyar@ti.com>

get_cpu_rev() is unused in this driver. It is probably legacy
code. So remove it.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 2633049..202cafa 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -40,10 +40,6 @@
 #include "musb_core.h"
 #include "omap2430.h"
 
-#ifdef CONFIG_ARCH_OMAP3430
-#define	get_cpu_rev()	2
-#endif
-
 
 static struct timer_list musb_idle_timer;
 
-- 
1.7.0.rc0.33.g7c3932

