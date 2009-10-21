From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] OMAP: Fix broken omap-keypad
Date: Wed, 21 Oct 2009 16:20:29 +0200
Message-ID: <200910211620.30538.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:57356 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346AbZJUOVH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Oct 2009 10:21:07 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

Hi,
Commit 4f5433324d1e29cf234d5b1b14782c0fc2948298 had made machines that use new 
matrix_keypad based drivers happy while breaking those that still use old
omap-keypad driver. The patch fixes omap-keypad device for my Amstrad Delta
(tested) and probably 11 more OMAP1 based machines. It leaves a potential
similiar problem on OMAP2 H4 machine not addressed.

I would say that those new, matrix_keypad based drivers should be corrected to
simply not include arch/arm/plat-omap/include/mach/keypad.h, which should keep
serving omap-keypad based machines until they are all upgraded to use 
matrix_keypad.

Created against linux-2.6.32-rc5

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
--- linux-2.6.32-rc5/arch/arm/plat-omap/include/mach/keypad.h.orig	2009-10-16 02:41:50.000000000 +0200
+++ linux-2.6.32-rc5/arch/arm/plat-omap/include/mach/keypad.h	2009-10-21 15:32:37.000000000 +0200
@@ -10,7 +10,9 @@
 #ifndef ASMARM_ARCH_KEYPAD_H
 #define ASMARM_ARCH_KEYPAD_H
 
+#ifndef CONFIG_ARCH_OMAP1
 #include <linux/input/matrix_keypad.h>
+#endif
 
 struct omap_kp_platform_data {
 	int rows;
@@ -38,5 +40,11 @@ struct omap_kp_platform_data {
 #define KEY_PERSISTENT		0x00800000
 #define KEYNUM_MASK		0x00EFFFFF
 
+#ifdef CONFIG_ARCH_OMAP1
+#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
+#define PERSISTENT_KEY(col, row) (((col) << 28) | ((row) << 24) | \
+						KEY_PERSISTENT)
+#endif
+
 #endif
 
