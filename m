From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 08/10] 34XX: PM: Workaround to disable mmc
Date: Fri, 16 May 2008 14:05:12 +0300
Message-ID: <1210935912-28059-1-git-send-email-jouni.hogander@nokia.com>
References: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48240 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbYEPLFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 07:05:19 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GB4tHQ019849
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 14:05:17 +0300
In-Reply-To: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

Current hsmmc is not pm friendly. Disable it because it prevents omap3
retention

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 9e4af26..4239b25 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -966,7 +966,7 @@ CONFIG_USB_ZERO=y
 # CONFIG_USB_G_SERIAL is not set
 # CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_USB_G_PRINTER is not set
-CONFIG_MMC=y
+# CONFIG_MMC is not set
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
 
-- 
1.5.5

