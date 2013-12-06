From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v4 2/4] USB: OMAP1: add extcon to platform data
Date: Fri,  6 Dec 2013 16:13:05 +0200
Message-ID: <1386339187-28466-3-git-send-email-aaro.koskinen@iki.fi>
References: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:47841 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758079Ab3LFOQf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 09:16:35 -0500
In-Reply-To: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Add extcon field to platform data.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/linux/platform_data/usb-omap1.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/usb-omap1.h b/include/linux/platform_data/usb-omap1.h
index 8c7764ddd284..43b5ce139c37 100644
--- a/include/linux/platform_data/usb-omap1.h
+++ b/include/linux/platform_data/usb-omap1.h
@@ -23,6 +23,8 @@ struct omap_usb_config {
 	unsigned	register_dev:1;
 	u8		otg;	/* port number, 1-based:  usb1 == 2 */
 
+	const char	*extcon;	/* extcon device for OTG */
+
 	u8		hmc_mode;
 
 	/* implicitly true if otg:  host supports remote wakeup? */
-- 
1.8.4.4

