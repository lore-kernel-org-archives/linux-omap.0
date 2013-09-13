From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/7] OMAPDSS: HDMI: OMAP4: Complete register definitions for DPLL
Date: Fri, 13 Sep 2013 15:59:34 +0530
Message-ID: <1379068178-17312-4-git-send-email-archit@ti.com>
References: <1379068178-17312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48381 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab3IMKak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Sep 2013 06:30:40 -0400
In-Reply-To: <1379068178-17312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>, Archit Taneja <archit@ti.com>

From: Ricardo Neri <ricardo.neri@ti.com>

Add missing register definitions for spread spectrum clocking.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 469d436..d1a2315 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -168,6 +168,8 @@
 #define PLLCTRL_CFG1				0xC
 #define PLLCTRL_CFG2				0x10
 #define PLLCTRL_CFG3				0x14
+#define PLLCTRL_SSC_CFG1			0x18
+#define PLLCTRL_SSC_CFG2			0x1C
 #define PLLCTRL_CFG4				0x20
 
 /* HDMI PHY */
-- 
1.8.1.2

