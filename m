From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v4 3/4] usb: musb: dsps: add {tx,rx}_mode to wrapper
Date: Tue, 26 Nov 2013 13:31:13 +0100
Message-ID: <1385469074-19312-4-git-send-email-zonque@gmail.com>
References: <1385469074-19312-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44224 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab3KZMbY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 07:31:24 -0500
In-Reply-To: <1385469074-19312-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, Daniel Mack <zonque@gmail.com>

rx_mode and tx_mode need to be read at suspend time and restored on
resume for dsps platforms. So add it to the wrapper struct first, and
initialize the values.

Signed-off-by: Daniel Mack <zonque@gmail.com>
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

