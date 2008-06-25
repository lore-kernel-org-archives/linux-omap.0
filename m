From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 1/7] 34XX: PM: Workaround to build omap hsmmc as a module
Date: Wed, 25 Jun 2008 12:13:40 +0300
Message-ID: <1214385220-25576-1-git-send-email-jouni.hogander@nokia.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58236 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbYFYJNz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 05:13:55 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5P9Dn0R007544
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 12:13:53 +0300
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5P9DeN5001455
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 12:13:40 +0300
In-Reply-To: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Current omap hsmmc driver is not pm friendly. Build it as a module
because it prevents omap3 retention.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 947c25f..5672a6e 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1058,7 +1058,7 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 #
 # MMC/SD Host Controller Drivers
 #
-CONFIG_MMC_OMAP_HS=y
+CONFIG_MMC_OMAP_HS=m
 # CONFIG_MMC_SPI is not set
 # CONFIG_NEW_LEDS is not set
 CONFIG_RTC_LIB=y
-- 
1.5.5

