From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 07/35] wl12xx: remove __init declaration from platform data setup API
Date: Wed, 15 Apr 2015 15:52:54 +0300
Message-ID: <1429102402-5276-8-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35737 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140AbbDOMwp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:45 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

With most of the OMAP hwmod data being moved to a module, this API
needs to be accessed later in the boot and can't reside under
__init section anymore.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/net/wireless/ti/wilink_platform_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wilink_platform_data.c b/drivers/net/wireless/ti/wilink_platform_data.c
index a92bd3e..55bba5a 100644
--- a/drivers/net/wireless/ti/wilink_platform_data.c
+++ b/drivers/net/wireless/ti/wilink_platform_data.c
@@ -25,7 +25,7 @@
 
 static struct wl12xx_platform_data *wl12xx_platform_data;
 
-int __init wl12xx_set_platform_data(const struct wl12xx_platform_data *data)
+int wl12xx_set_platform_data(const struct wl12xx_platform_data *data)
 {
 	if (wl12xx_platform_data)
 		return -EBUSY;
-- 
1.7.9.5

