From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 01/10] arm: omap: omap2plus_defconfig: remove unwanted ethernet drivers
Date: Tue, 18 Nov 2014 12:06:59 -0600
Message-ID: <1416334028-7766-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53957 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974AbaKRSHO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2014 13:07:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

None of these drivers are known to be used on
any platform supported by omap2plus_defconfig,
by removing them we get a slight smaller kernel.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Depends on [1]

[1] http://marc.info/?l=linux-omap&m=141632534806371&w=2

 arch/arm/configs/omap2plus_defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 82dc4d6..24d6fe2 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -129,11 +129,27 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_MD=y
 CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_HISILICON is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
 CONFIG_KS8851=y
 CONFIG_KS8851_MLL=y
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
+# CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_TI_CPSW=y
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_USB_USBNET=y
-- 
2.1.0.GIT

