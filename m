From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] ARM: configs: Select USB PHY for AM335x SoC
Date: Thu, 12 Dec 2013 12:14:29 -0300
Message-ID: <1386861269-28949-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55266 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751452Ab3LLPOU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 10:14:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Enable this option as it's required to use USB on AM335x SoC.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 12c848e..e427b95 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -223,6 +223,7 @@ CONFIG_USB_TEST=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_OMAP_USB2=y
 CONFIG_OMAP_USB3=y
+CONFIG_AM335X_PHY_USB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
-- 
1.8.1.5

