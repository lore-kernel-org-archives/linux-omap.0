From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 7/8] 34XX: PM: Workaround to disable mmc
Date: Tue, 17 Jun 2008 10:31:11 +0300
Message-ID: <1213687871-30038-1-git-send-email-jouni.hogander@nokia.com>
References: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63937 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbYFQHbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 03:31:25 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5H7VBPr018660
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 02:31:23 -0500
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5H7VB8U013903
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 10:31:12 +0300
In-Reply-To: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Current hsmmc is not pm friendly. Disable it because it prevents omap3
retention

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 947c25f..ee902ae 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1043,7 +1043,7 @@ CONFIG_USB_ZERO=y
 # CONFIG_USB_G_SERIAL is not set
 # CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_USB_G_PRINTER is not set
-CONFIG_MMC=y
+# CONFIG_MMC is not set
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
 
-- 
1.5.5

