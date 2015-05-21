From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Subject: [PATCH 2/2] ARM: OMAP: enable DM9000 in omap2plus_defconfig
Date: Thu, 21 May 2015 21:52:17 +0200
Message-ID: <1432237937-16691-2-git-send-email-anthoine.bourgeois@gmail.com>
References: <1432237937-16691-1-git-send-email-anthoine.bourgeois@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35327 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422698AbbEUTww (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2015 15:52:52 -0400
Received: by wgfl8 with SMTP id l8so96177208wgf.2
        for <linux-omap@vger.kernel.org>; Thu, 21 May 2015 12:52:51 -0700 (PDT)
In-Reply-To: <1432237937-16691-1-git-send-email-anthoine.bourgeois@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>

This ethernet device is used on devkit8000 board.

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 8e10859..08cd89c 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -135,6 +135,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CIRRUS is not set
+CONFIG_DM9000=y
 # CONFIG_NET_VENDOR_FARADAY is not set
 # CONFIG_NET_VENDOR_HISILICON is not set
 # CONFIG_NET_VENDOR_INTEL is not set
-- 
2.0.5

