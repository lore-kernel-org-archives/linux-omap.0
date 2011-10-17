From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/4] cbus: move device IDs to local header
Date: Mon, 17 Oct 2011 23:50:42 +0300
Message-ID: <1318884643-4137-3-git-send-email-balbi@ti.com>
References: <1318884643-4137-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:44245 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754115Ab1JQUuw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Oct 2011 16:50:52 -0400
Received: by mail-bw0-f51.google.com with SMTP id zs8so5211634bkb.38
        for <linux-omap@vger.kernel.org>; Mon, 17 Oct 2011 13:50:51 -0700 (PDT)
In-Reply-To: <1318884643-4137-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

there's no need to show that to the world.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/cbus.h                |    3 +++
 include/linux/platform_data/cbus.h |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/cbus.h b/drivers/cbus/cbus.h
index c1c3bd6..5380d173 100644
--- a/drivers/cbus/cbus.h
+++ b/drivers/cbus/cbus.h
@@ -23,6 +23,9 @@
 #ifndef __DRIVERS_CBUS_CBUS_H
 #define __DRIVERS_CBUS_CBUS_H
 
+#define CBUS_RETU_DEVICE_ID	0x01
+#define CBUS_TAHVO_DEVICE_ID	0x02
+
 extern int cbus_read_reg(struct device *, unsigned dev, unsigned reg);
 extern int cbus_write_reg(struct device *, unsigned dev, unsigned reg,
 		unsigned val);
diff --git a/include/linux/platform_data/cbus.h b/include/linux/platform_data/cbus.h
index 09809c7..5bd9211 100644
--- a/include/linux/platform_data/cbus.h
+++ b/include/linux/platform_data/cbus.h
@@ -22,9 +22,6 @@
 #ifndef __INCLUDE_LINUX_CBUS_H
 #define __INCLUDE_LINUX_CBUS_H
 
-#define CBUS_RETU_DEVICE_ID	0x01
-#define CBUS_TAHVO_DEVICE_ID	0x02
-
 struct cbus_host_platform_data {
 	int	dat_gpio;
 	int	clk_gpio;
-- 
1.7.7

