From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH 1/2] ARM: OMAP2+: remove unused omap4-keypad file and code
Date: Sat, 17 May 2014 23:24:10 +0200
Message-ID: <1400361851-32274-2-git-send-email-manabian@gmail.com>
References: <1400361851-32274-1-git-send-email-manabian@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1400361851-32274-1-git-send-email-manabian@gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: illia.smyrnov@ti.com, dmitry.torokhov@gmail.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

This has been unused since omap4 board files went away.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/mach-omap2/devices.c      | 33 ---------------------------------
 arch/arm/mach-omap2/omap4-keypad.h |  8 --------
 2 files changed, 41 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap4-keypad.h

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index e58609b312c7..592ba0a0ecf3 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/pinctrl/machine.h>
-#include <linux/platform_data/omap4-keypad.h>
 #include <linux/platform_data/mailbox-omap.h>
 
 #include <asm/mach-types.h>
@@ -29,7 +28,6 @@
 #include "iomap.h"
 #include "omap_hwmod.h"
 #include "omap_device.h"
-#include "omap4-keypad.h"
 
 #include "soc.h"
 #include "common.h"
@@ -255,37 +253,6 @@ static inline void omap_init_camera(void)
 #endif
 }
 
-int __init omap4_keyboard_init(struct omap4_keypad_platform_data
-			*sdp4430_keypad_data, struct omap_board_data *bdata)
-{
-	struct platform_device *pdev;
-	struct omap_hwmod *oh;
-	struct omap4_keypad_platform_data *keypad_data;
-	unsigned int id = -1;
-	char *oh_name = "kbd";
-	char *name = "omap4-keypad";
-
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh) {
-		pr_err("Could not look up %s\n", oh_name);
-		return -ENODEV;
-	}
-
-	keypad_data = sdp4430_keypad_data;
-
-	pdev = omap_device_build(name, id, oh, keypad_data,
-				 sizeof(struct omap4_keypad_platform_data));
-
-	if (IS_ERR(pdev)) {
-		WARN(1, "Can't build omap_device for %s:%s.\n",
-						name, oh->name);
-		return PTR_ERR(pdev);
-	}
-	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
-
-	return 0;
-}
-
 #if defined(CONFIG_OMAP2PLUS_MBOX) || defined(CONFIG_OMAP2PLUS_MBOX_MODULE)
 static inline void __init omap_init_mbox(void)
 {
diff --git a/arch/arm/mach-omap2/omap4-keypad.h b/arch/arm/mach-omap2/omap4-keypad.h
deleted file mode 100644
index 20de0d5a7e77..000000000000
--- a/arch/arm/mach-omap2/omap4-keypad.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef ARCH_ARM_PLAT_OMAP4_KEYPAD_H
-#define ARCH_ARM_PLAT_OMAP4_KEYPAD_H
-
-struct omap_board_data;
-
-extern int omap4_keyboard_init(struct omap4_keypad_platform_data *,
-				struct omap_board_data *);
-#endif
-- 
1.8.0

