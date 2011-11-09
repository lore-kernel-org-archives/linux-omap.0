From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] input: ams_delta_serio: include linux/module.h
Date: Wed,  9 Nov 2011 20:06:45 +0200
Message-ID: <1320862005-6049-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Fix the following compilation failure with v3.2-rc1 by including module.h:

  CC      drivers/input/serio/ams_delta_serio.o
drivers/input/serio/ams_delta_serio.c:33:15: error: expected declaration specifiers or '...' before string constant
drivers/input/serio/ams_delta_serio.c:34:20: error: expected declaration specifiers or '...' before string constant
drivers/input/serio/ams_delta_serio.c:35:16: error: expected declaration specifiers or '...' before string constant
drivers/input/serio/ams_delta_serio.c: In function 'ams_delta_serio_init':
drivers/input/serio/ams_delta_serio.c:155:2: error: 'THIS_MODULE' undeclared (first use in this function)
drivers/input/serio/ams_delta_serio.c:155:2: note: each undeclared identifier is reported only once for each function it appears in

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/input/serio/ams_delta_serio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 4b2a42f..d4d08bd 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -24,6 +24,7 @@
 #include <linux/irq.h>
 #include <linux/serio.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include <asm/mach-types.h>
 #include <plat/board-ams-delta.h>
-- 
1.7.2.5
