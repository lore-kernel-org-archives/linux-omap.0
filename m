From: George Cherian <george.cherian@ti.com>
Subject: [PATCH v5 1/6] usb: musb: core: Handle Babble condition only in HOST mode
Date: Thu, 22 May 2014 11:59:36 +0530
Message-ID: <1400740181-31213-2-git-send-email-george.cherian@ti.com>
References: <1400740181-31213-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400740181-31213-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: gregkh@linuxfoundation.org, balbi@ti.com, zonque@gmail.com, b-liu@ti.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

BABBLE and RESET share the same interrupt. The interrupt
is considered to be RESET if MUSB is in peripheral mode and
as a BABBLE if MUSB is in HOST mode.

Handle babble condition iff MUSB is in HOST mode.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/usb/musb/musb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 61da471..eff3c5c 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -849,7 +849,7 @@ b_host:
 	}
 
 	/* handle babble condition */
-	if (int_usb & MUSB_INTR_BABBLE)
+	if (int_usb & MUSB_INTR_BABBLE && is_host_active(musb))
 		schedule_work(&musb->recover_work);
 
 #if 0
-- 
1.8.3.1
