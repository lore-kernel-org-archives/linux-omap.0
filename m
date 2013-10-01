From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 4/5] usb: musb: dsps: add {tx,rx}_mode to wrapper
Date: Tue,  1 Oct 2013 15:39:56 +0200
Message-ID: <1380634797-29541-5-git-send-email-zonque@gmail.com>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:51017 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380Ab3JANkH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Oct 2013 09:40:07 -0400
In-Reply-To: <1380634797-29541-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, Daniel Mack <zonque@gmail.com>

rx_mode and tx_mode need to be read at suspend time and restored on
resume for dsps platforms. So add it to the wrapper struct first, and
initialize the values.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/musb_dsps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 4047cbb..f3085bc 100644
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
@@ -600,6 +602,8 @@ static const struct dsps_musb_wrapper am33xx_driver_data = {
 	.coreintr_status	= 0x34,
 	.phy_utmi		= 0xe0,
 	.mode			= 0xe8,
+	.tx_mode		= 0x70,
+	.rx_mode		= 0x74,
 	.reset			= 0,
 	.otg_disable		= 21,
 	.iddig			= 8,
-- 
1.8.3.1

