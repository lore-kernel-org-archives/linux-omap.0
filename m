From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] omap: rx51_defconfig: Remove duplicate phonet
Date: Mon, 19 Apr 2010 16:52:09 +0300
Message-ID: <1271685130-19118-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:62745 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab0DSNvs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 09:51:48 -0400
Received: by ewy20 with SMTP id 20so1449912ewy.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Apr 2010 06:51:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Felipe Balbi <felipe.balbi@nokia.com>

Phonet is enabled by the commit bce54fed941e03695ab557100a4bd1e457abca42
and this duplicate gives a warning when doing make rx51_defconfig.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/configs/rx51_defconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index 45135ff..cc6a32a 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -480,7 +480,6 @@ CONFIG_BT_HIDP=m
 # CONFIG_BT_HCIBFUSB is not set
 # CONFIG_BT_HCIVHCI is not set
 # CONFIG_AF_RXRPC is not set
-# CONFIG_PHONET is not set
 CONFIG_WIRELESS=y
 CONFIG_CFG80211=y
 # CONFIG_CFG80211_REG_DEBUG is not set
-- 
1.7.0

