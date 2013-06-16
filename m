From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 2/5] USB: OMAP1: add extcon to platform data
Date: Sun, 16 Jun 2013 16:35:09 +0300
Message-ID: <1371389712-29516-3-git-send-email-aaro.koskinen@iki.fi>
References: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:39338 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206Ab3FPNfu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Jun 2013 09:35:50 -0400
In-Reply-To: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Add extcon field to platform data.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/linux/platform_data/usb-omap1.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/usb-omap1.h b/include/linux/platform_data/usb-omap1.h
index 8c7764d..43b5ce1 100644
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
1.8.3.1

