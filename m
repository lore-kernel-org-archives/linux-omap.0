From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 9/9] OMAP3430SDP: Enable config options CONFIG_OMAP_RESET_CLOCKS and CONFIG_SUSPEND
Date: Fri, 16 May 2008 13:58:27 +0300
Message-ID: <1210935507-27742-1-git-send-email-jouni.hogander@nokia.com>
References: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58405 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbYEPK6c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 06:58:32 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GAwAxW029216
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 13:58:30 +0300
In-Reply-To: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 0fef29d..9e4af26 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -168,7 +168,7 @@ CONFIG_ARCH_OMAP3=y
 # OMAP Feature Selections
 #
 CONFIG_OMAP_DEBUG_SRAM_PATCH=y
-# CONFIG_OMAP_RESET_CLOCKS is not set
+CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_BOOT_TAG=y
 CONFIG_OMAP_BOOT_REASON=y
 # CONFIG_OMAP_COMPONENT_VERSION is not set
@@ -308,7 +308,7 @@ CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
-# CONFIG_SUSPEND is not set
+CONFIG_SUSPEND=y
 # CONFIG_APM_EMULATION is not set
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 
-- 
1.5.5

