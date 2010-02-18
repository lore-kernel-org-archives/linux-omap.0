From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 11/12] DSPBRIDGE: Remove debug header files
Date: Thu, 18 Feb 2010 15:38:02 -0600
Message-ID: <1266529083-2358-12-git-send-email-omar.ramirez@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-3-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-4-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-5-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-6-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-7-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-8-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-9-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-10-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-11-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43577 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753950Ab0BRVZ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 16:25:26 -0500
In-Reply-To: <1266529083-2358-11-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch removes header files used in bridge debug
implementation.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbc.h |    2 -
 arch/arm/plat-omap/include/dspbridge/dbg.h |   24 ------------------
 arch/arm/plat-omap/include/dspbridge/gt.h  |   37 ----------------------------
 drivers/dsp/bridge/pmgr/chnl.c             |    1 -
 drivers/dsp/bridge/pmgr/cmm.c              |    1 -
 drivers/dsp/bridge/pmgr/cod.c              |    1 -
 drivers/dsp/bridge/pmgr/dbll.c             |    1 -
 drivers/dsp/bridge/pmgr/dev.c              |    2 -
 drivers/dsp/bridge/pmgr/dmm.c              |    1 -
 drivers/dsp/bridge/pmgr/io.c               |    1 -
 drivers/dsp/bridge/pmgr/msg.c              |    1 -
 drivers/dsp/bridge/pmgr/wcd.c              |    1 -
 drivers/dsp/bridge/rmgr/dbdcd.c            |    1 -
 drivers/dsp/bridge/rmgr/disp.c             |    1 -
 drivers/dsp/bridge/rmgr/drv.c              |    1 -
 drivers/dsp/bridge/rmgr/drv_interface.c    |    1 -
 drivers/dsp/bridge/rmgr/dspdrv.c           |    1 -
 drivers/dsp/bridge/rmgr/mgr.c              |    1 -
 drivers/dsp/bridge/rmgr/nldr.c             |    4 ---
 drivers/dsp/bridge/rmgr/node.c             |    2 -
 drivers/dsp/bridge/rmgr/proc.c             |    1 -
 drivers/dsp/bridge/rmgr/rmm.c              |    1 -
 drivers/dsp/bridge/rmgr/strm.c             |    1 -
 drivers/dsp/bridge/services/cfg.c          |    1 -
 drivers/dsp/bridge/services/clk.c          |    1 -
 drivers/dsp/bridge/services/mem.c          |    1 -
 drivers/dsp/bridge/services/ntfy.c         |    1 -
 drivers/dsp/bridge/services/reg.c          |    1 -
 drivers/dsp/bridge/services/regsup.c       |    1 -
 drivers/dsp/bridge/services/services.c     |    2 -
 drivers/dsp/bridge/services/sync.c         |    1 -
 drivers/dsp/bridge/wmd/chnl_sm.c           |    1 -
 drivers/dsp/bridge/wmd/io_sm.c             |    2 -
 drivers/dsp/bridge/wmd/mmu_fault.c         |    1 -
 drivers/dsp/bridge/wmd/tiomap3430.c        |    1 -
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c    |    3 --
 drivers/dsp/bridge/wmd/tiomap_io.c         |    1 -
 drivers/dsp/bridge/wmd/tiomap_sm.c         |    2 -
 drivers/dsp/bridge/wmd/ue_deh.c            |    1 -
 39 files changed, 0 insertions(+), 109 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/dbg.h
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/gt.h

diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
index 1b3ac44..c4bf803 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
@@ -32,8 +32,6 @@
 /* Assertion Macros: */
 #if GT_TRACE
 
-#include <dspbridge/gt.h>
-
 #define DBC_Assert(exp) \
     if (!(exp)) \
 	pr_err("%s, line %d: Assertion (" #exp ") failed.\n", \
diff --git a/arch/arm/plat-omap/include/dspbridge/dbg.h b/arch/arm/plat-omap/include/dspbridge/dbg.h
deleted file mode 100644
index 828fd71..0000000
--- a/arch/arm/plat-omap/include/dspbridge/dbg.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * dbg.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Provide debugging services for Bridge Mini Drivers.
- *
- * Copyright (C) 2008 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-#ifndef DBG_
-#define DBG_
-#include <dspbridge/host_os.h>
-#include <linux/types.h>
-
-#endif				/* DBG_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/gt.h b/arch/arm/plat-omap/include/dspbridge/gt.h
deleted file mode 100644
index 116bb6f..0000000
--- a/arch/arm/plat-omap/include/dspbridge/gt.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * gt.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2008 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-/*
- * There are two definitions that affect which portions of trace
- * are acutally compiled into the client: GT_TRACE and GT_ASSERT. If
- * GT_TRACE is set to 0 then all trace statements (except for assertions)
- * will be compiled out of the client. If GT_ASSERT is set to 0 then
- * assertions will be compiled out of the client. GT_ASSERT can not be
- * set to 0 unless GT_TRACE is also set to 0 (i.e. GT_TRACE == 1 implies
- * GT_ASSERT == 1).
- */
-
-#include <linux/types.h>
-#ifndef GT_
-#define GT_
-
-#ifndef GT_TRACE
-#define GT_TRACE 0	    /* 0 = "trace compiled out"; 1 = "trace active" */
-#endif
-
-#include <dspbridge/host_os.h>
-
-#endif				/* GTCE_ */
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index cfece9c..6331b97 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -27,7 +27,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index e8fed86..0cd50b1 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -37,7 +37,6 @@
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
 #include <dspbridge/errbase.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 9552618..1b535fd 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -32,7 +32,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/ldr.h>
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 0970974..904e03d 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -23,7 +23,6 @@
 #include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
-#include <dspbridge/gt.h>
 #include <dspbridge/dbc.h>
 #include <dspbridge/gh.h>
 
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 20faf87..42c5c6a 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -26,8 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/dbg.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index 9a1c6b0..b0d5d5c 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -31,7 +31,6 @@
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
 #include <dspbridge/errbase.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index 846562a..701d047 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index b7f3fc4..0f40051 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 20a2b04..08728d1 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -27,7 +27,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 9fd05a0..0fcf9cc 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -32,7 +32,6 @@
 #include <dspbridge/errbase.h>
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 6ae3bcb..645f233 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -26,7 +26,6 @@
 #include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
-#include <dspbridge/gt.h>
 #include <dspbridge/dbc.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 177d676..f323c8f 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 1d09bb5..74478dd 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -37,7 +37,6 @@
 #include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
-#include <dspbridge/gt.h>
 #include <dspbridge/dbc.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index 0fdb150..cc965c4 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index e63aaa1..cf015a4 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -25,7 +25,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 5c1266d..9e9dfc8 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -23,10 +23,6 @@
 #include <dspbridge/errbase.h>
 
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
-#ifdef CONFIG_BRIDGE_DEBUG
-#include <dspbridge/dbg.h>
-#endif
 
 /* OS adaptation layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index cb3d324..4eb6582 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
@@ -56,7 +55,6 @@
 #include <dspbridge/gb.h>
 #ifdef CONFIG_BRIDGE_DEBUG
 #include <dspbridge/uuidutil.h>
-#include <dspbridge/dbg.h>
 #endif
 
 /*  ----------------------------------- This */
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 8489cd3..c5f4577 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index 188faba..506bc57 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -44,7 +44,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/list.h>
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 6b62e41..63319ee 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 19c296e..1b7e0ea 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -23,7 +23,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/reg.h>
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index d279036..4ef4290 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 9eb50e5..740377f 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- This */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index 4908be1..4e73c5f 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/list.h>
diff --git a/drivers/dsp/bridge/services/reg.c b/drivers/dsp/bridge/services/reg.c
index 2e87982..2187aed 100644
--- a/drivers/dsp/bridge/services/reg.c
+++ b/drivers/dsp/bridge/services/reg.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index fc625f4..8df6fec 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index f1a8fa8..dac0b39 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -24,11 +24,9 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/dbg.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/reg.h>
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index f9cac58..bd07938 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index e681303..3696fad 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -52,7 +52,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/dbg.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 967fb17..e863478 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -35,7 +35,6 @@
 
 /* Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/dbg.h>
 
 /* Services Layer */
 #include <dspbridge/cfg.h>
@@ -70,7 +69,6 @@
 /* This */
 #include <dspbridge/io_sm.h>
 #include "_msg_sm.h"
-#include <dspbridge/gt.h>
 
 /* Defines, Data Structures, Typedefs */
 #define OUTPUTNOTREADY  0xffff
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index 1a9137d..8cac1ef 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -24,7 +24,6 @@
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/host_os.h>
 #include <dspbridge/dbc.h>
-#include <dspbridge/dbg.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index c91f919..b19d479 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -33,7 +33,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/dbg.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index bdff0a7..16e786a 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -24,9 +24,6 @@
 #include <dspbridge/io_sm.h>
 #include <dspbridge/chnl_sm.h>
 
-/*  ----------------------------------- Trace & Debug */
-#include <dspbridge/dbg.h>
-
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
 
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index d11d605..d107a3c 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -22,7 +22,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/dbg.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/dev.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 3fa24cd..ed18fdd 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -21,8 +21,6 @@
 #include <dspbridge/drv.h>
 #include <dspbridge/dev.h>
 
-#include <dspbridge/dbg.h>
-
 #include "_tiomap.h"
 #include "_tiomap_pwr.h"
 
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 618d6e2..5c69f7e 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -26,7 +26,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/dbg.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-- 
1.6.2.4

