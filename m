From: Nishanth Menon <nm@ti.com>
Subject: [PM][PATCH 4/4] OMAP3: Serial: kill dev_attr_sleep_timeout sparse warn
Date: Thu,  8 Apr 2010 12:54:09 -0500
Message-ID: <1270749249-14041-5-git-send-email-nm@ti.com>
References: <1270749249-14041-1-git-send-email-nm@ti.com>
 <1270749249-14041-2-git-send-email-nm@ti.com>
 <1270749249-14041-3-git-send-email-nm@ti.com>
 <1270749249-14041-4-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45732 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932965Ab0DHRyV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 13:54:21 -0400
In-Reply-To: <1270749249-14041-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>

Remove the following sparse warnings by declaring attr as static:
arch/arm/mach-omap2/serial.c:627:1: warning: symbol 'dev_attr_sleep_timeout' was not declared. Should it be static?

Cc: Govindraj R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/serial.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c7b2326..cea0a9e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -624,7 +624,8 @@ static ssize_t sleep_timeout_store(struct device *dev,
 	return n;
 }
 
-DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
+static DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show,
+		sleep_timeout_store);
 #define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
 #else
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
-- 
1.6.3.3

