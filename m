From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 13/23] USB: MUSB: checkpatch.pl fixed to musb_procfs.c
Date: Fri, 11 Apr 2008 11:28:26 +0300
Message-ID: <1207902516-6374-14-git-send-email-felipe.balbi@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26600 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757506AbYDKIaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:10 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TpF6021901
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:08 +0300
In-Reply-To: <1207902516-6374-13-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_procfs.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
index bd282da..e6e050c 100644
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -35,7 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <asm/uaccess.h>	/* FIXME remove procfs writes */
+#include <linux/uaccess.h>	/* FIXME remove procfs writes */
 #include <asm/arch/hardware.h>
 
 #include "musb_core.h"
@@ -189,7 +189,7 @@ static int dump_ep(struct musb_ep *ep, char *buffer, unsigned max)
 			max -= code;
 			break;
 		}
-		list_for_each_entry (req, &ep->req_list, list) {
+		list_for_each_entry(req, &ep->req_list, list) {
 			code = snprintf(buf, max, "\treq %p, %s%s%d/%d\n",
 					req,
 					req->zero ? "zero, " : "",
@@ -201,7 +201,7 @@ static int dump_ep(struct musb_ep *ep, char *buffer, unsigned max)
 			buf += code;
 			max -= code;
 		}
-	} while(0);
+	} while (0);
 	return buf - buffer;
 }
 #endif
@@ -700,7 +700,7 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
 		}
 		break;
 
-#if (MUSB_DEBUG>0)
+#if (MUSB_DEBUG > 0)
 		/* set/read debug level */
 	case 'D':{
 			if (count > 1) {
-- 
1.5.5.23.g2a5fe

