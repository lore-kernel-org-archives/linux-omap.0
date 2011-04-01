From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 11/13] OMAP4: PRM: VC: rename I2C configuration register: s/INSTE/MODE/
Date: Fri,  1 Apr 2011 16:41:09 -0700
Message-ID: <1301701271-22096-12-git-send-email-khilman@ti.com>
References: <1301701271-22096-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:45816 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753698Ab1DAXkz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 19:40:55 -0400
Received: by iyj12 with SMTP id 12so5427976iyj.41
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 16:40:54 -0700 (PDT)
In-Reply-To: <1301701271-22096-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Current code uses the name PRM_VC_CFG_I2C_INSTE for the VC I2C
configuration mode register.  The TRM name for the I2C configuration
mode register is PRM_VC_CFG_I2C_MODE.  Rename accordingly.

No functional changes (no current users of this register.)

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/prm44xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 048c8e5..026529f 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -713,8 +713,8 @@
 #define OMAP4430_PRM_VC_VAL_BYPASS			OMAP44XX_PRM_REGADDR(OMAP4430_PRM_DEVICE_INST, 0x00a0)
 #define OMAP4_PRM_VC_CFG_CHANNEL_OFFSET			0x00a4
 #define OMAP4430_PRM_VC_CFG_CHANNEL			OMAP44XX_PRM_REGADDR(OMAP4430_PRM_DEVICE_INST, 0x00a4)
-#define OMAP4_PRM_VC_CFG_I2C_INSTE_OFFSET		0x00a8
-#define OMAP4430_PRM_VC_CFG_I2C_INSTE			OMAP44XX_PRM_REGADDR(OMAP4430_PRM_DEVICE_INST, 0x00a8)
+#define OMAP4_PRM_VC_CFG_I2C_MODE_OFFSET		0x00a8
+#define OMAP4430_PRM_VC_CFG_I2C_MODE			OMAP44XX_PRM_REGADDR(OMAP4430_PRM_DEVICE_INST, 0x00a8)
 #define OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET			0x00ac
 #define OMAP4430_PRM_VC_CFG_I2C_CLK			OMAP44XX_PRM_REGADDR(OMAP4430_PRM_DEVICE_INST, 0x00ac)
 #define OMAP4_PRM_SRAM_COUNT_OFFSET			0x00b0
-- 
1.7.4

