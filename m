From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP1: Include gpio-omap.h for board-h2 and board-h3
Date: Mon, 17 Sep 2012 16:54:44 -0700
Message-ID: <20120917234821.GL11762@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:25063 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757460Ab2IQXyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 19:54:47 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Bryan Wu <bryan.wu@canonical.com>

=46rom de6ca33a96a6bf61fcb91d3d399703e19ead9d1e Mon Sep 17 00:00:00 200=
1
=46rom: Tony Lindgren <tony@atomide.com>
Date: Mon, 17 Sep 2012 16:24:20 -0700
Subject: [PATCH] ARM: OMAP1: Include gpio-omap.h for board-h2 and board=
-h3
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Merge of the LED related changes with omap sparse IRQ and
hardware.h related changes causes a build issue otherwise:

arch/arm/mach-omap1/board-h2.c:319: error: implicit declaration of func=
tion =E2=80=98OMAP_MPUIO=E2=80=99
arch/arm/mach-omap1/board-h2.c:319: error: initializer element is not c=
onstant
arch/arm/mach-omap1/board-h2.c:319: error: (near initialization for =E2=
=80=98h2_gpio_led_pins[1].gpio=E2=80=99)

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Noticed this with current linux next and omap1_defconfig.
The arm-soc drivers branch builds fine, but merged
with omap-cleanup-sparseirq-for-v3.7 compile breaks.

I'll queue this into cleanup-fixes branch on top of the
omap-cleanup-sparseirq-for-v3.7 branch.

--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -31,6 +31,7 @@
 #include <linux/i2c/tps65010.h>
 #include <linux/smc91x.h>
 #include <linux/omapfb.h>
+#include <linux/platform_data/gpio-omap.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -31,6 +31,7 @@
 #include <linux/i2c/tps65010.h>
 #include <linux/smc91x.h>
 #include <linux/omapfb.h>
+#include <linux/platform_data/gpio-omap.h>
=20
 #include <asm/setup.h>
 #include <asm/page.h>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
