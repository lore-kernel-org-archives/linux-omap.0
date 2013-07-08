From: George Cherian <george.cherian@ti.com>
Subject: [PATCH 1/5] usb: musb: dsps: enable dual instance support for am33xx platform
Date: Mon, 8 Jul 2013 16:13:17 +0530
Message-ID: <1373280201-31785-2-git-send-email-george.cherian@ti.com>
References: <1373280201-31785-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373280201-31785-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: balbi@ti.com, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, kishon@ti.com, bigeasy@linutronix.de, Ravi Babu <ravibabu@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Ravi Babu <ravibabu@ti.com>

The dsps am33xx platform has two instances of musb controller,
enable the support for dual musb instances

Signed-off-by: Ravi Babu <ravibabu@ti.com>
---
 drivers/usb/musb/musb_dsps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index e1b661d..41f135a 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -747,7 +747,7 @@ static const struct dsps_musb_wrapper ti81xx_driver_data = {
 	.rxep_bitmap		= (0xfffe << 16),
 	.musb_core_offset	= 0x400,
 	.poll_seconds		= 2,
-	.instances		= 1,
+	.instances		= 2,
 };
 
 static const struct platform_device_id musb_dsps_id_table[] = {
-- 
1.8.1.4
