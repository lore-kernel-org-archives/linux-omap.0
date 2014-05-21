From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH] ARM: OMAP4: Ctrl module register define diet
Date: Wed, 21 May 2014 17:48:48 +0200
Message-ID: <1400687328-16913-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34799 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbaEUPtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 11:49:00 -0400
Received: by mail-lb0-f172.google.com with SMTP id l4so1745486lbv.31
        for <linux-omap@vger.kernel.org>; Wed, 21 May 2014 08:48:59 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---

Hi,

The mach-omap2 directory contains full register defines for OMAP4
control module but only around 27 of those are used. There are is
a total of 1795 register defines in four files with only 27 in use.
That is pretty low usefulness ratio...

I guess alot more was used when we had omap4 board files and
mach-omap2 contained more drivers but this has now changed.

So I propose we move just what we need to control.h, were other
OMAP parts have their minimal set of defines already. Patch has
been compile tested and I have also grepped the tree for users
outside the mach dir.

Note that patch was created with format-patch -D to keep the
size down so it may not apply directly.

regards
Joachim Eastwood

 arch/arm/mach-omap2/control.h                   |   38 +-
 arch/arm/mach-omap2/ctrl_module_core_44xx.h     |  392 -------
 arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h | 1409 -----------------------
 arch/arm/mach-omap2/ctrl_module_pad_wkup_44xx.h |  236 ----
 arch/arm/mach-omap2/ctrl_module_wkup_44xx.h     |   92 --
 5 files changed, 33 insertions(+), 2134 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/ctrl_module_core_44xx.h
 delete mode 100644 arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h
 delete mode 100644 arch/arm/mach-omap2/ctrl_module_pad_wkup_44xx.h
 delete mode 100644 arch/arm/mach-omap2/ctrl_module_wkup_44xx.h

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index da054801b114..5dc2310c281d 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -16,11 +16,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CONTROL_H
 #define __ARCH_ARM_MACH_OMAP2_CONTROL_H
 
-#include "ctrl_module_core_44xx.h"
-#include "ctrl_module_wkup_44xx.h"
-#include "ctrl_module_pad_core_44xx.h"
-#include "ctrl_module_pad_wkup_44xx.h"
-
 #include "am33xx.h"
 
 #ifndef __ASSEMBLY__
@@ -254,6 +249,39 @@
 /* TI81XX CONTROL_DEVCONF register offsets */
 #define TI81XX_CONTROL_DEVICE_ID	(TI81XX_CONTROL_DEVCONF + 0x000)
 
+/* OMAP4 CONTROL MODULE */
+#define OMAP4_CTRL_MODULE_PAD_WKUP			0x4a31e000
+#define OMAP4_CTRL_MODULE_PAD_WKUP_CONTROL_I2C_2	0x0604
+#define OMAP4_CTRL_MODULE_CORE_STATUS			0x02c4
+#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_PROD_ID_1	0x0218
+#define OMAP4_CTRL_MODULE_CORE_DSP_BOOTADDR		0x0304
+#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY	0x0618
+#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_CAMERA_RX	0x0608
+
+/* OMAP4 CONTROL_DSIPHY */
+#define OMAP4_DSI2_LANEENABLE_SHIFT			29
+#define OMAP4_DSI2_LANEENABLE_MASK			(0x7 << 29)
+#define OMAP4_DSI1_LANEENABLE_SHIFT			24
+#define OMAP4_DSI1_LANEENABLE_MASK			(0x1f << 24)
+#define OMAP4_DSI1_PIPD_SHIFT				19
+#define OMAP4_DSI1_PIPD_MASK				(0x1f << 19)
+#define OMAP4_DSI2_PIPD_SHIFT				14
+#define OMAP4_DSI2_PIPD_MASK				(0x1f << 14)
+
+/* OMAP4 CONTROL_CAMERA_RX */
+#define OMAP4_CAMERARX_CSI21_LANEENABLE_SHIFT		24
+#define OMAP4_CAMERARX_CSI21_LANEENABLE_MASK		(0x1f << 24)
+#define OMAP4_CAMERARX_CSI22_LANEENABLE_SHIFT		29
+#define OMAP4_CAMERARX_CSI22_LANEENABLE_MASK		(0x3 << 29)
+#define OMAP4_CAMERARX_CSI22_CTRLCLKEN_SHIFT		21
+#define OMAP4_CAMERARX_CSI22_CTRLCLKEN_MASK		(1 << 21)
+#define OMAP4_CAMERARX_CSI22_CAMMODE_SHIFT		19
+#define OMAP4_CAMERARX_CSI22_CAMMODE_MASK		(0x3 << 19)
+#define OMAP4_CAMERARX_CSI21_CTRLCLKEN_SHIFT		18
+#define OMAP4_CAMERARX_CSI21_CTRLCLKEN_MASK		(1 << 18)
+#define OMAP4_CAMERARX_CSI21_CAMMODE_SHIFT		16
+#define OMAP4_CAMERARX_CSI21_CAMMODE_MASK		(0x3 << 16)
+
 /* OMAP54XX CONTROL STATUS register */
 #define OMAP5XXX_CONTROL_STATUS                0x134
 #define OMAP5_DEVICETYPE_MASK          (0x7 << 6)
diff --git a/arch/arm/mach-omap2/ctrl_module_core_44xx.h b/arch/arm/mach-omap2/ctrl_module_core_44xx.h
deleted file mode 100644
index 01970824e0e5..000000000000
diff --git a/arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h b/arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h
deleted file mode 100644
index c88420de1151..000000000000
diff --git a/arch/arm/mach-omap2/ctrl_module_pad_wkup_44xx.h b/arch/arm/mach-omap2/ctrl_module_pad_wkup_44xx.h
deleted file mode 100644
index 17c9b37042c0..000000000000
diff --git a/arch/arm/mach-omap2/ctrl_module_wkup_44xx.h b/arch/arm/mach-omap2/ctrl_module_wkup_44xx.h
deleted file mode 100644
index a0af9baec3f7..000000000000
-- 
1.8.0

