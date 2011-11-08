From: tom.leiming@gmail.com
Subject: [PATCH] arm: omap2: select ARM_AMBA if OMAP3_EMU is defined
Date: Tue,  8 Nov 2011 12:36:14 +0800
Message-ID: <1320726974-11912-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:37270 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab1KHEhl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 23:37:41 -0500
Received: by pzk2 with SMTP id 2so361394pzk.1
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 20:37:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ming Lei <tom.leiming@gmail.com>

From: Ming Lei <tom.leiming@gmail.com>

This patch selects ARM_AMBA if OMAP3_EMU is defined because
OC_ETM depends on ARM_AMBA, so fix the link failure[1].

[1],
arch/arm/kernel/built-in.o: In function `etm_remove':
/home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:609: undefined
reference to `amba_release_regions'
arch/arm/kernel/built-in.o: In function `etb_remove':
/home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:409: undefined
reference to `amba_release_regions'
arch/arm/kernel/built-in.o: In function `etm_init':
/home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:640: undefined
reference to `amba_driver_register'
/home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:646: undefined
reference to `amba_driver_register'
/home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:648: undefined
reference to `amba_driver_unregister'
arch/arm/kernel/built-in.o: In function `etm_probe':
/home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:545: undefined
reference to `amba_request_regions'
/home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:595: undefined
reference to `amba_release_regions'
arch/arm/kernel/built-in.o: In function `etb_probe':
/home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:347: undefined
reference to `amba_request_regions'
/home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:392: undefined
reference to `amba_release_regions'
arch/arm/mach-omap2/built-in.o: In function `emu_init':
/home/tom/git/omap/linux-2.6-omap/arch/arm/mach-omap2/emu.c:62:
undefined reference to `amba_device_register'
/home/tom/git/omap/linux-2.6-omap/arch/arm/mach-omap2/emu.c:63:
undefined reference to `amba_device_register'
make: *** [.tmp_vmlinux1] Error 1
making modules

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 5034147..e1293aa 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -334,6 +334,7 @@ config MACH_OMAP4_PANDA
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
+	select ARM_AMBA
 	select OC_ETM
 	help
 	  Say Y here to enable debugging hardware of omap3
-- 
1.7.5.4

