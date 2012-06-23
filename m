From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 1/1] ARM: OMAP: omap2plus_defconfig: Enable EXT4 support
Date: Sun, 24 Jun 2012 00:18:59 +0200
Message-ID: <1340489939-5390-1-git-send-email-javier@dowhile0.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51389 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094Ab2FWWTW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Jun 2012 18:19:22 -0400
Received: by wgbdr13 with SMTP id dr13so2886521wgb.1
        for <linux-omap@vger.kernel.org>; Sat, 23 Jun 2012 15:19:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@dowhile0.org>

On OMAP boards that includes an SD card slot, an EXT4 partition could
be used to store the root file system. So, the kernel should have
built-in support for EXT4 to be able to mount the VFS root on boot.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9854ff4..f3087cb 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -197,6 +197,7 @@ CONFIG_RTC_DRV_TWL4030=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
 CONFIG_QUOTA=y
 CONFIG_QFMT_V2=y
 CONFIG_MSDOS_FS=y
-- 
1.7.7.6

