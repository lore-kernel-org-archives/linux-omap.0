From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 16/23] USB: MUSB: checkpatch.pl fixes to omap2430.c
Date: Fri, 11 Apr 2008 11:28:29 +0300
Message-ID: <1207902516-6374-17-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-9-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-10-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-11-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-12-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-13-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-14-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-15-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-16-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40298 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757502AbYDKIaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:17 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8WXp5001306
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 03:32:34 -0500
In-Reply-To: <1207902516-6374-16-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index c21d93a..e092393 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -32,8 +32,8 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/clk.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
-- 
1.5.5.23.g2a5fe

