From: Luciano Coelho <coelho@ti.com>
Subject: [PATCH] arm: omap2plus: add wl12xx support in omap4plus_defconfig
Date: Wed, 20 Apr 2011 20:23:22 +0300
Message-ID: <1303320202-21241-1-git-send-email-coelho@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45951 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750947Ab1DTRVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 13:21:09 -0400
Received: by mail-ey0-f177.google.com with SMTP id 6so321239eyh.8
        for <linux-omap@vger.kernel.org>; Wed, 20 Apr 2011 10:21:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Many omap2plus-based boards include wireless chips supported by the
wl12xx driver (eg. WL1271 on Blaze and Panda) or can get an extension
that includes such chips (eg. the WLAN daugther card for Beagle).  To
get out-of-the-box support for the wl12xx-based chips on such boards,
this patch adds the wl12xx driver as modules in omap2plus_defconfig.

Signed-off-by: Luciano Coelho <coelho@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 076db52..cfc343e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -108,6 +108,11 @@ CONFIG_MAC80211=m
 CONFIG_MAC80211_RC_PID=y
 CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_MAC80211_LEDS=y
+CONFIG_WL12XX_MENU=m
+CONFIG_WL12XX=m
+CONFIG_WL12XX_HT=y
+CONFIG_WL12XX_SDIO=m
+CONFIG_WL12XX_PLATFORM_DATA=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
-- 
1.7.1

