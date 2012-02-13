From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 1/2] ARM: OMAP2+: id: Add am33xx SoC type detection
Date: Mon, 13 Feb 2012 11:44:45 +0530
Message-ID: <1329113685-7500-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52309 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166Ab2BMGbd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Feb 2012 01:31:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hvaibhav@ti.com, nsekhar@ti.com, Afzal Mohammed <afzal@ti.com>

Determine SoC type, i.e. whether GP or HS

Note: cpu_is_34xx() is true for am33xx also. Doing
cpu_is_am33xx() check after cpu_is_34xx() will not
achieve what we want due to the above reason.
Hence cpu_is_am33xx() is done before cpu_is_34xx()

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---

v2: Use OMAP naming conventions for subject

 arch/arm/mach-omap2/control.h |    5 +++++
 arch/arm/mach-omap2/id.c      |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index 0ba68d3..96c4bcc 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -339,6 +339,11 @@
 #define AM35XX_VPFE_PCLK_SW_RST		BIT(4)
 
 /*
+ * CONTROL AM33XX STATUS register
+ */
+#define AM33XX_CONTROL_STATUS		0x040
+
+/*
  * CONTROL OMAP STATUS register to identify OMAP3 features
  */
 #define OMAP3_CONTROL_OMAP_STATUS	0x044c
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 92e4d55..2879c7b 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -44,6 +44,8 @@ int omap_type(void)
 
 	if (cpu_is_omap24xx()) {
 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
+	} else if (cpu_is_am33xx()) {
+		val = omap_ctrl_readl(AM33XX_CONTROL_STATUS);
 	} else if (cpu_is_omap34xx()) {
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
 	} else if (cpu_is_omap44xx()) {
-- 
1.7.1

