From: Tom Rini <trini@ti.com>
Subject: [PATCH] ARM: OMAP2+: omap2plus_defconfig: Enable appended DTB support
Date: Mon,  1 Jul 2013 09:13:13 -0400
Message-ID: <1372684393-19025-1-git-send-email-trini@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:59028 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab3GANNL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 09:13:11 -0400
Received: by mail-yh0-f51.google.com with SMTP id l109so2498963yhq.24
        for <linux-omap@vger.kernel.org>; Mon, 01 Jul 2013 06:13:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>

As this config must support boards which cannot support separate device
trees, enable support for appended ones.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Tom Rini <trini@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index abbe319..ec4deb9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -34,6 +34,8 @@ CONFIG_NR_CPUS=2
 CONFIG_LEDS=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200"
 CONFIG_KEXEC=y
 CONFIG_FPE_NWFPE=y
-- 
1.7.9.5

