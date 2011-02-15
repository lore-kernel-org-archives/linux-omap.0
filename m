From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 05/15] arm: omap: cbus: add IDs for Retu and Tahvo
Date: Tue, 15 Feb 2011 10:45:52 +0200
Message-ID: <1297759562-25682-6-git-send-email-balbi@ti.com>
References: <1297759562-25682-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:53281 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752559Ab1BOIqk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:46:40 -0500
Received: by mail-yi0-f52.google.com with SMTP id 30so3885161yie.25
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:46:39 -0800 (PST)
In-Reply-To: <1297759562-25682-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Each driver is defining it's own ID. Defining it
on the generic header will allow to pass those
via platform_data.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/include/plat/cbus.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cbus.h b/arch/arm/plat-omap/include/plat/cbus.h
index 1f0e8be..e7ace57 100644
--- a/arch/arm/plat-omap/include/plat/cbus.h
+++ b/arch/arm/plat-omap/include/plat/cbus.h
@@ -22,6 +22,9 @@
 #ifndef __PLAT_CBUS_H
 #define __PLAT_CBUS_H
 
+#define CBUS_RETU_DEVICE_ID	0x01
+#define CBUS_TAHVO_DEVICE_ID	0x02
+
 struct cbus_host_platform_data {
 	int	dat_gpio;
 	int	clk_gpio;
-- 
1.7.4.rc2

