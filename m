From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/5] omap2/3/4: serial: kill dev_attr_sleep_timeout sparse warn
Date: Tue, 22 Jun 2010 23:17:52 -0500
Message-ID: <1277266674-5906-4-git-send-email-nm@ti.com>
References: <1277266674-5906-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49959 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883Ab0FWESH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jun 2010 00:18:07 -0400
In-Reply-To: <1277266674-5906-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Deepak K <deepak.k@ti.com>, Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>

Remove the following sparse warnings by declaring attr as static:
arch/arm/mach-omap2/serial.c:627:1: warning: symbol 'dev_attr_sleep_timeout' was not declared. Should it be static?

Cc: Deepak K <deepak.k@ti.com>
Cc: Govindraj R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/serial.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 9476c1c..584a2ed 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -558,7 +558,8 @@ static ssize_t sleep_timeout_store(struct device *dev,
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

