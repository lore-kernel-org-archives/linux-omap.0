From: Kalle Valo <kalle.valo@iki.fi>
Subject: [PATCH] omap2: compile usb-tusb6010.c
Date: Fri, 07 Aug 2009 15:48:01 +0300
Message-ID: <20090807124801.3164.35116.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:53591 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388AbZHGMsD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 08:48:03 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id B4E36EBEF0
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2009 15:48:02 +0300 (EEST)
Received: from [127.0.1.1] (a91-155-131-184.elisa-laajakaista.fi [91.155.131.184])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id A4FD341BE2
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2009 15:48:01 +0300 (EEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

For some reason usb-tusb6010.c was't compiled, add it to Makefile and
Kconfig. This is prepraration for upcoming n8x0 support.

Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
---

 arch/arm/mach-omap2/Kconfig  |    5 +++++
 arch/arm/mach-omap2/Makefile |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a755eb5..bf54686 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -31,6 +31,11 @@ config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
 
+config MACH_OMAP2_TUSB6010
+	bool
+	depends on ARCH_OMAP2 && ARCH_OMAP2420
+	default y if MACH_NOKIA_N8X0
+
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 735bae5..757c84b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
 # Platform specific device init code
 obj-y					+= usb-musb.o
+obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 
 onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:= gpmc-onenand.o
 obj-y					+= $(onenand-m) $(onenand-y)

