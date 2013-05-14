From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: configs: omap2plus_defconfig: enable USB bits which work
Date: Tue, 14 May 2013 04:23:20 +0300
Message-ID: <1368494600-18953-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38054 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755856Ab3ENBXm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 May 2013 21:23:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kevin.hilman@linaro.org, Roger Quadros <rogerq@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

those USB bits work fine, so we can enable them
safely. Plus, without USB_PHY EHCI wouldn't work
and it would take quite a few bogus error reports
until all users got the new changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

comiple tested only. Would be great to have someone
testing on actual HW. Right now I don't have access
to my HW.

cheers

 arch/arm/configs/omap2plus_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c1ef64b..a1fc0ca 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -74,6 +74,7 @@ CONFIG_CMA=y
 CONFIG_CONNECTOR=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_OMAP_OCP2SCP=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
@@ -206,10 +207,18 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_SUSPEND=y
 CONFIG_USB_MON=y
+CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_WDM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_LIBUSUAL=y
+CONFIG_USB_DWC3=m
+CONFIG_USB_DWC3_DEBUG=y
+CONFIG_USB_DWC3_VERBOSE=y
 CONFIG_USB_TEST=y
+CONFIG_USB_PHY=y
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_OMAP_USB2=y
+CONFIG_OMAP_USB3=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
-- 
1.8.2.1

