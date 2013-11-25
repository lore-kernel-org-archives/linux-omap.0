From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 3/4] usb: musb: dsps: add {tx,rx}_mode to wrapper
Date: Mon, 25 Nov 2013 22:26:42 +0100
Message-ID: <1385414803-13212-4-git-send-email-zonque@gmail.com>
References: <1385414803-13212-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385414803-13212-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

rx_mode and tx_mode need to be read at suspend time and restored on
resume for dsps platforms. So add it to the wrapper struct first, and
initialize the values.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 1901f6f..e57d712 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -83,6 +83,8 @@ struct dsps_musb_wrapper {
 	u16	coreintr_status;
 	u16	phy_utmi;
 	u16	mode;
+	u16	tx_mode;
+	u16	rx_mode;
 
 	/* bit positions for control */
 	unsigned	reset:5;
@@ -605,6 +607,8 @@ static const struct dsps_musb_wrapper am33xx_driver_data = {
 	.coreintr_status	= 0x34,
 	.phy_utmi		= 0xe0,
 	.mode			= 0xe8,
+	.tx_mode		= 0x70,
+	.rx_mode		= 0x74,
 	.reset			= 0,
 	.otg_disable		= 21,
 	.iddig			= 8,
-- 
1.8.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
