From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP1: USB: fix ocpi_enable compile problem on non-1610
 builds
Date: Thu, 10 May 2012 16:27:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205101625360.32719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54689 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761862Ab2EJW1X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 18:27:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, tony@atomide.com


Janusz Krzysztofik reported the following build break on OMAP1 builds that
don't include CONFIG_ARCH_OMAP16XX:

  LD      .tmp_vmlinux1
arch/arm/mach-omap1/built-in.o: In function `omap1_usb_init':
lcd_dma.c:(.init.text+0x1420): undefined reference to `ocpi_enable'
make: *** [.tmp_vmlinux1] Error 1

This was caused by commit d3645d39ad0ed9f09535065676ea0ba114f93cdf
("ARM: OMAP1: OHCI: use platform_data fn ptr to enable OCPI bus").
Fix by declaring an empty ocpi_enable() on non-16XX builds, which
should work until the OCPI code is moved out to drivers/.

Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
Passes a compile test with a 15xx-only config.

 arch/arm/mach-omap1/common.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index a90b9d7..4193383 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -63,6 +63,10 @@ extern bool omap_32k_timer_init(void);
 
 extern u32 omap_irq_flags;
 
+#ifdef CONFIG_ARCH_OMAP16XX
 extern int ocpi_enable(void);
+#else
+static inline int ocpi_enable(void) { return 0; }
+#endif
 
 #endif /* __ARCH_ARM_MACH_OMAP1_COMMON_H */
-- 
1.7.10

