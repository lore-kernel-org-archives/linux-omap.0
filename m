From: Ben Gamari <bgamari.foss@gmail.com>
Subject: [PATCH] omap2-beagle: Depend upon CONFIG_GPIO_TWL4030
Date: Mon, 17 Jan 2011 16:25:48 -0500
Message-ID: <1295299548-22839-1-git-send-email-bgamari.foss@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63057 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab1AQVZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 16:25:55 -0500
Received: by qyj19 with SMTP id 19so2398145qyj.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 13:25:55 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ben Gamari <bgamari.foss@gmail.com>

Some very basic setup (i.e. MMC) is done in the beagleboard's setup
callback for the TWL4030's gpio driver, causing a kernel without this
support to fail to find its root filesystem. I can't imagine why one would
want to build a kernel for this board without this driver, so I think
it's worthwhile to explicitly depend on it.

Signed-Off-By: Ben Gamari <bgamari.foss@gmail.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ab784bf..74173f1 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -120,6 +120,7 @@ config MACH_OMAP_2430SDP
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
 	depends on ARCH_OMAP3
+	depends on GPIO_TWL4030
 	default y
 	select OMAP_PACKAGE_CBB
 
-- 
1.7.0.4

