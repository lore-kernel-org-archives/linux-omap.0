From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] usb: musb: restore INDEX register in resume path
Date: Fri, 8 Jul 2011 15:06:13 +0530
Message-ID: <1310117773-31571-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42981 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841Ab1GHJhm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jul 2011 05:37:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>, stable@kernel.org

Restoring the missing INDEX register value in musb_restore_context().
Without this suspend resume functionality is broken with offmode
enabled.

Cc: stable@kernel.org
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index c71b037..dce7182 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2329,6 +2329,7 @@ static void musb_restore_context(struct musb *musb)
 				musb->context.index_regs[i].rxhubport);
 		}
 	}
+	musb_writeb(musb_base, MUSB_INDEX, musb->context.index);
 }
 
 static int musb_suspend(struct device *dev)
-- 
1.6.2.4

