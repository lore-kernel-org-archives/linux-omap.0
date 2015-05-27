From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Subject: [PATCH v2 2/2] ARM: OMAP: enable DM9000 in omap2plus_defconfig
Date: Wed, 27 May 2015 22:00:14 +0200
Message-ID: <1432756814-2078-2-git-send-email-anthoine.bourgeois@gmail.com>
References: <1432237937-16691-1-git-send-email-anthoine.bourgeois@gmail.com>
 <1432756814-2078-1-git-send-email-anthoine.bourgeois@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35349 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbbE0UAw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2015 16:00:52 -0400
Received: by wgme6 with SMTP id e6so18941694wgm.2
        for <linux-omap@vger.kernel.org>; Wed, 27 May 2015 13:00:51 -0700 (PDT)
In-Reply-To: <1432756814-2078-1-git-send-email-anthoine.bourgeois@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Anthoine Bourgeois <anthoine.bourgeois@gmail.com>

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

