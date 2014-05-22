From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 3/6] usb: musb: dsps: Call usb_phy(_shutdown/_init) during musb_platform_reset()
Date: Thu, 22 May 2014 11:59:38 +0530
Message-ID: <1400740181-31213-4-git-send-email-george.cherian@ti.com>
References: <1400740181-31213-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400740181-31213-1-git-send-email-george.cherian-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

For DSPS platform usb_phy_vbus(_off/_on) are NOPs.
So during musb_platform_reset() call usb_phy(_shutdown/_init)

Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 51beb13..74c4193 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -543,7 +543,11 @@ static void dsps_musb_reset(struct musb *musb)
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 
 	dsps_writel(musb->ctrl_base, wrp->control, (1 << wrp->reset));
-	udelay(100);
+	usleep_range(100, 200);
+	usb_phy_shutdown(musb->xceiv);
+	usleep_range(100, 200);
+	usb_phy_init(musb->xceiv);
+
 }
 
 static struct musb_platform_ops dsps_ops = {
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
