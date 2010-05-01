From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 08/11] DSPBRIDGE: Rename files that refer to Windows OS
Date: Fri, 30 Apr 2010 19:45:48 -0500
Message-ID: <1272674751-21557-9-git-send-email-ivan.gomez@ti.com>
References: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49442 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757843Ab0EAAwz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 20:52:55 -0400
In-Reply-To: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

Since "wmd" (windows mini driver) and "wcd" (windows class driver)
refers to Windows OS, the following files are renamed:

wmd.h ==> dspdefs.h
wmdchnl.h ==> dspchnl.h
wmddeh.h ==> dspdeh.h
wmdio.h ==> dspio.h
wmdioctl.h ==> dspioctl.h
wmdmsg.h ==> dspmsg.h
wcd.h ==> dspapi.h
wcdioctl.h ==> dspapi-ioctl.h
wcd.c ==> dspapi.c

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h    |    4 ++--
 arch/arm/plat-omap/include/dspbridge/_dcd.h        |    2 +-
 arch/arm/plat-omap/include/dspbridge/dev.h         |    2 +-
 arch/arm/plat-omap/include/dspbridge/devdefs.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/drvdefs.h     |    2 +-
 .../dspbridge/{wcdioctl.h => dspapi-ioctl.h}       |    2 +-
 .../include/dspbridge/{wcd.h => dspapi.h}          |    2 +-
 .../include/dspbridge/{wmdchnl.h => dspchnl.h}     |    4 ++--
 .../include/dspbridge/{wmd.h => dspdefs.h}         |    2 +-
 .../include/dspbridge/{wmddeh.h => dspdeh.h}       |    4 ++--
 .../include/dspbridge/{wmdio.h => dspio.h}         |    4 ++--
 .../include/dspbridge/{wmdioctl.h => dspioctl.h}   |    2 +-
 .../include/dspbridge/{wmdmsg.h => dspmsg.h}       |    4 ++--
 drivers/dsp/bridge/Makefile                        |    2 +-
 drivers/dsp/bridge/core/_deh.h                     |    2 +-
 drivers/dsp/bridge/core/_tiomap.h                  |    2 +-
 drivers/dsp/bridge/core/chnl_sm.c                  |    4 ++--
 drivers/dsp/bridge/core/io_sm.c                    |    6 +++---
 drivers/dsp/bridge/core/mmu_fault.c                |    2 +-
 drivers/dsp/bridge/core/msg_sm.c                   |    2 +-
 drivers/dsp/bridge/core/tiomap3430.c               |   12 ++++++------
 drivers/dsp/bridge/core/tiomap3430_pwr.c           |    2 +-
 drivers/dsp/bridge/core/ue_deh.c                   |    4 ++--
 drivers/dsp/bridge/core/wdt.c                      |    2 +-
 drivers/dsp/bridge/pmgr/chnlobj.h                  |    2 +-
 drivers/dsp/bridge/pmgr/dev.c                      |    2 +-
 drivers/dsp/bridge/pmgr/{wcd.c => dspapi.c}        |    4 ++--
 drivers/dsp/bridge/pmgr/ioobj.h                    |    2 +-
 drivers/dsp/bridge/pmgr/msg.c                      |    2 +-
 drivers/dsp/bridge/pmgr/msgobj.h                   |    2 +-
 drivers/dsp/bridge/rmgr/disp.c                     |    2 +-
 drivers/dsp/bridge/rmgr/drv.c                      |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c            |    2 +-
 drivers/dsp/bridge/rmgr/node.c                     |    4 ++--
 drivers/dsp/bridge/rmgr/proc.c                     |    6 +++---
 drivers/dsp/bridge/rmgr/pwr.c                      |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                     |    2 +-
 37 files changed, 55 insertions(+), 55 deletions(-)
 rename arch/arm/plat-omap/include/dspbridge/{wcdioctl.h => dspapi-ioctl.h} (99%)
 rename arch/arm/plat-omap/include/dspbridge/{wcd.h => dspapi.h} (99%)
 rename arch/arm/plat-omap/include/dspbridge/{wmdchnl.h => dspchnl.h} (97%)
 rename arch/arm/plat-omap/include/dspbridge/{wmd.h => dspdefs.h} (99%)
 rename arch/arm/plat-omap/include/dspbridge/{wmddeh.h => dspdeh.h} (98%)
 rename arch/arm/plat-omap/include/dspbridge/{wmdio.h => dspio.h} (95%)
 rename arch/arm/plat-omap/include/dspbridge/{wmdioctl.h => dspioctl.h} (99%)
 rename arch/arm/plat-omap/include/dspbridge/{wmdmsg.h => dspmsg.h} (96%)
 rename drivers/dsp/bridge/pmgr/{wcd.c => dspapi.c} (99%)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 8bba33f..cc998de 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -23,8 +23,8 @@
 #ifndef _CHNL_SM_
 #define _CHNL_SM_
 
-#include <dspbridge/wcd.h>
-#include <dspbridge/wmd.h>
+#include <dspbridge/dspapi.h>
+#include <dspbridge/dspdefs.h>
 
 #include <dspbridge/list.h>
 #include <dspbridge/ntfy.h>
diff --git a/arch/arm/plat-omap/include/dspbridge/_dcd.h b/arch/arm/plat-omap/include/dspbridge/_dcd.h
index 589cd42..4c3f701 100644
--- a/arch/arm/plat-omap/include/dspbridge/_dcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/_dcd.h
@@ -20,7 +20,7 @@
 #ifndef _WCD_
 #define _WCD_
 
-#include <dspbridge/wcdioctl.h>
+#include <dspbridge/dspapi-ioctl.h>
 
 /*
  *  ======== api_call_dev_ioctl ========
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 3ada31d..ac011cd 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -26,7 +26,7 @@
 #include <dspbridge/dehdefs.h>
 #include <dspbridge/nodedefs.h>
 #include <dspbridge/dispdefs.h>
-#include <dspbridge/wmd.h>
+#include <dspbridge/dspdefs.h>
 #include <dspbridge/dmm.h>
 #include <dspbridge/host_os.h>
 
diff --git a/arch/arm/plat-omap/include/dspbridge/devdefs.h b/arch/arm/plat-omap/include/dspbridge/devdefs.h
index 8c0adc1..600be0e 100644
--- a/arch/arm/plat-omap/include/dspbridge/devdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/devdefs.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Definition of common include typedef between wmd.h and dev.h. Required
+ * Definition of common include typedef between dspdefs.h and dev.h. Required
  * to break circular dependency between WMD and DEV include files.
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
diff --git a/arch/arm/plat-omap/include/dspbridge/drvdefs.h b/arch/arm/plat-omap/include/dspbridge/drvdefs.h
index f084207..c0dea57 100644
--- a/arch/arm/plat-omap/include/dspbridge/drvdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/drvdefs.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Definition of common struct between wmd.h and drv.h.
+ * Definition of common struct between dspdefs.h and drv.h.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
similarity index 99%
rename from arch/arm/plat-omap/include/dspbridge/wcdioctl.h
rename to arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
index 49bec37..c214ea6 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
@@ -1,5 +1,5 @@
 /*
- * wcdioctl.h
+ * dspapi-ioctl.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/wcd.h b/arch/arm/plat-omap/include/dspbridge/dspapi.h
similarity index 99%
rename from arch/arm/plat-omap/include/dspbridge/wcd.h
rename to arch/arm/plat-omap/include/dspbridge/dspapi.h
index 1a68baa..232aab0 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspapi.h
@@ -1,5 +1,5 @@
 /*
- * wcd.h
+ * dspapi.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/wmdchnl.h b/arch/arm/plat-omap/include/dspbridge/dspchnl.h
similarity index 97%
rename from arch/arm/plat-omap/include/dspbridge/wmdchnl.h
rename to arch/arm/plat-omap/include/dspbridge/dspchnl.h
index 0d874ab..3c6f29d 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmdchnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspchnl.h
@@ -1,5 +1,5 @@
 /*
- * wmdchnl.h
+ * dspchnl.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
@@ -8,7 +8,7 @@
  * by every class of WMD channel library.
  *
  * Notes:
- *   The function comment headers reside in wmd.h.
+ *   The function comment headers reside in dspdefs.h.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
similarity index 99%
rename from arch/arm/plat-omap/include/dspbridge/wmd.h
rename to arch/arm/plat-omap/include/dspbridge/dspdefs.h
index d861cdf..8a1d38c 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -1,5 +1,5 @@
 /*
- * wmd.h
+ * dspdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/wmddeh.h b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
similarity index 98%
rename from arch/arm/plat-omap/include/dspbridge/wmddeh.h
rename to arch/arm/plat-omap/include/dspbridge/dspdeh.h
index 0152c43..f6a747f 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmddeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
@@ -1,5 +1,5 @@
 /*
- * wmddeh.h
+ * dspdeh.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
@@ -7,7 +7,7 @@
  * interface tables.
  *
  * Notes:
- *   Function comment headers reside with the function typedefs in wmd.h.
+ *   Function comment headers reside with the function typedefs in dspdefs.h.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/wmdio.h b/arch/arm/plat-omap/include/dspbridge/dspio.h
similarity index 95%
rename from arch/arm/plat-omap/include/dspbridge/wmdio.h
rename to arch/arm/plat-omap/include/dspbridge/dspio.h
index c566350..b010d2a 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmdio.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspio.h
@@ -1,5 +1,5 @@
 /*
- * wmdio.h
+ * dspio.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
@@ -7,7 +7,7 @@
  * driver interface tables.
  *
  * Notes:
- *   Function comment headers reside in wmd.h.
+ *   Function comment headers reside in dspdefs.h.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/wmdioctl.h b/arch/arm/plat-omap/include/dspbridge/dspioctl.h
similarity index 99%
rename from arch/arm/plat-omap/include/dspbridge/wmdioctl.h
rename to arch/arm/plat-omap/include/dspbridge/dspioctl.h
index 9fe5543..3f7a787 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspioctl.h
@@ -1,5 +1,5 @@
 /*
- * wmdioctl.h
+ * dspioctl.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/wmdmsg.h b/arch/arm/plat-omap/include/dspbridge/dspmsg.h
similarity index 96%
rename from arch/arm/plat-omap/include/dspbridge/wmdmsg.h
rename to arch/arm/plat-omap/include/dspbridge/dspmsg.h
index f8005ea..86db728 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmdmsg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspmsg.h
@@ -1,5 +1,5 @@
 /*
- * wmdmsg.h
+ * dspmsg.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
@@ -8,7 +8,7 @@
  * implemented by every class of WMD channel library.
  *
  * Notes:
- *   Function comment headers reside in wmd.h.
+ *   Function comment headers reside in dspdefs.h.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index 97e7ec1..db2027f 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -8,7 +8,7 @@ libservices = services/sync.o \
 libcore = core/chnl_sm.o core/msg_sm.o core/io_sm.o core/tiomap3430.o \
 		core/tiomap3430_pwr.o core/tiomap_io.o \
 		core/mmu_fault.o core/ue_deh.o core/wdt.o
-libpmgr = pmgr/chnl.o pmgr/io.o pmgr/msg.o pmgr/cod.o pmgr/dev.o pmgr/wcd.o \
+libpmgr = pmgr/chnl.o pmgr/io.o pmgr/msg.o pmgr/cod.o pmgr/dev.o pmgr/dspapi.o \
 		pmgr/dmm.o pmgr/cmm.o pmgr/dbll.o
 librmgr = rmgr/dbdcd.o rmgr/disp.o rmgr/drv.o rmgr/mgr.o rmgr/node.o \
 		rmgr/proc.o rmgr/pwr.o rmgr/rmm.o rmgr/strm.o rmgr/dspdrv.o \
diff --git a/drivers/dsp/bridge/core/_deh.h b/drivers/dsp/bridge/core/_deh.h
index a7e74b0..631746e 100644
--- a/drivers/dsp/bridge/core/_deh.h
+++ b/drivers/dsp/bridge/core/_deh.h
@@ -20,7 +20,7 @@
 #define _DEH_
 
 #include <dspbridge/ntfy.h>
-#include <dspbridge/wmd.h>
+#include <dspbridge/dspdefs.h>
 
 /* DEH Manager: only one created per board: */
 struct deh_mgr {
diff --git a/drivers/dsp/bridge/core/_tiomap.h b/drivers/dsp/bridge/core/_tiomap.h
index b539641..c420295 100644
--- a/drivers/dsp/bridge/core/_tiomap.h
+++ b/drivers/dsp/bridge/core/_tiomap.h
@@ -25,7 +25,7 @@
 #include <mach-omap2/cm-regbits-34xx.h>
 #include <dspbridge/devdefs.h>
 #include <hw_defs.h>
-#include <dspbridge/wmdioctl.h>	/* for bridge_ioctl_extproc defn */
+#include <dspbridge/dspioctl.h>	/* for bridge_ioctl_extproc defn */
 #include <dspbridge/sync.h>
 #include <dspbridge/clk.h>
 
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index 51017f1..9befa77 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -58,8 +58,8 @@
 #include <dspbridge/sync.h>
 
 /*  ----------------------------------- Mini-Driver */
-#include <dspbridge/wmd.h>
-#include <dspbridge/wmdchnl.h>
+#include <dspbridge/dspdefs.h>
+#include <dspbridge/dspchnl.h>
 #include "_tiomap.h"
 
 /*  ----------------------------------- Platform Manager */
diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
index e917c51..35da0b9 100644
--- a/drivers/dsp/bridge/core/io_sm.c
+++ b/drivers/dsp/bridge/core/io_sm.c
@@ -47,9 +47,9 @@
 #include <hw_mmu.h>
 
 /* Mini Driver */
-#include <dspbridge/wmddeh.h>
-#include <dspbridge/wmdio.h>
-#include <dspbridge/wmdioctl.h>
+#include <dspbridge/dspdeh.h>
+#include <dspbridge/dspio.h>
+#include <dspbridge/dspioctl.h>
 #include <dspbridge/wdt.h>
 #include <_tiomap.h>
 #include <tiomap_io.h>
diff --git a/drivers/dsp/bridge/core/mmu_fault.c b/drivers/dsp/bridge/core/mmu_fault.c
index 0e6387a..cdd2908 100644
--- a/drivers/dsp/bridge/core/mmu_fault.c
+++ b/drivers/dsp/bridge/core/mmu_fault.c
@@ -29,7 +29,7 @@
 #include <dspbridge/drv.h>
 
 /*  ----------------------------------- Link Driver */
-#include <dspbridge/wmddeh.h>
+#include <dspbridge/dspdeh.h>
 
 /* ------------------------------------ Hardware Abstraction Layer */
 #include <hw_defs.h>
diff --git a/drivers/dsp/bridge/core/msg_sm.c b/drivers/dsp/bridge/core/msg_sm.c
index e52e56a..e12884b 100644
--- a/drivers/dsp/bridge/core/msg_sm.c
+++ b/drivers/dsp/bridge/core/msg_sm.c
@@ -36,7 +36,7 @@
 
 /*  ----------------------------------- This */
 #include <_msg_sm.h>
-#include <dspbridge/wmdmsg.h>
+#include <dspbridge/dspmsg.h>
 
 /*  ----------------------------------- Function Prototypes */
 static dsp_status add_new_msg(struct lst_list *msgList);
diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index d2c4691..1ccec2d 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -41,17 +41,17 @@
 #include <hw_mmu.h>
 
 /*  ----------------------------------- Link Driver */
-#include <dspbridge/wmd.h>
-#include <dspbridge/wmdchnl.h>
-#include <dspbridge/wmddeh.h>
-#include <dspbridge/wmdio.h>
-#include <dspbridge/wmdmsg.h>
+#include <dspbridge/dspdefs.h>
+#include <dspbridge/dspchnl.h>
+#include <dspbridge/dspdeh.h>
+#include <dspbridge/dspio.h>
+#include <dspbridge/dspmsg.h>
 #include <dspbridge/pwr.h>
 #include <dspbridge/io_sm.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/dev.h>
-#include <dspbridge/wcd.h>
+#include <dspbridge/dspapi.h>
 #include <dspbridge/dmm.h>
 #include <dspbridge/wdt.h>
 
diff --git a/drivers/dsp/bridge/core/tiomap3430_pwr.c b/drivers/dsp/bridge/core/tiomap3430_pwr.c
index 8563dad..73355c6 100644
--- a/drivers/dsp/bridge/core/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/core/tiomap3430_pwr.c
@@ -35,7 +35,7 @@
 #include <dspbridge/pwr_sh.h>
 
 /*  ----------------------------------- Mini Driver */
-#include <dspbridge/wmddeh.h>
+#include <dspbridge/dspdeh.h>
 #include <dspbridge/wdt.h>
 
 /*  ----------------------------------- specific to this file */
diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 2473d3d..8a13c14 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -33,11 +33,11 @@
 #include <dspbridge/drv.h>
 
 /*  ----------------------------------- Link Driver */
-#include <dspbridge/wmddeh.h>
+#include <dspbridge/dspdeh.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/dev.h>
-#include <dspbridge/wcd.h>
+#include <dspbridge/dspapi.h>
 #include <dspbridge/wdt.h>
 
 /* ------------------------------------ Hardware Abstraction Layer */
diff --git a/drivers/dsp/bridge/core/wdt.c b/drivers/dsp/bridge/core/wdt.c
index 7a007f2..4637afb 100644
--- a/drivers/dsp/bridge/core/wdt.c
+++ b/drivers/dsp/bridge/core/wdt.c
@@ -19,7 +19,7 @@
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/errbase.h>
-#include <dspbridge/wmddeh.h>
+#include <dspbridge/dspdeh.h>
 #include <dspbridge/dev.h>
 #include <dspbridge/_chnl_sm.h>
 #include <dspbridge/wdt.h>
diff --git a/drivers/dsp/bridge/pmgr/chnlobj.h b/drivers/dsp/bridge/pmgr/chnlobj.h
index 2cc7c22..39ce007 100644
--- a/drivers/dsp/bridge/pmgr/chnlobj.h
+++ b/drivers/dsp/bridge/pmgr/chnlobj.h
@@ -21,7 +21,7 @@
 #define CHNLOBJ_
 
 #include <dspbridge/chnldefs.h>
-#include <dspbridge/wmd.h>
+#include <dspbridge/dspdefs.h>
 
 /*
  *  This struct is the first field in a chnl_mgr struct, as implemented in
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index f94eebc..109e343 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -43,7 +43,7 @@
 #include <dspbridge/node.h>
 
 /*  ----------------------------------- Others */
-#include <dspbridge/wcd.h>	/* WCD version info. */
+#include <dspbridge/dspapi.h>	/* WCD version info. */
 
 #include <dspbridge/chnl.h>
 #include <dspbridge/io.h>
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/dspapi.c
similarity index 99%
rename from drivers/dsp/bridge/pmgr/wcd.c
rename to drivers/dsp/bridge/pmgr/dspapi.c
index a63ae8f..1ac7e78 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/dspapi.c
@@ -1,5 +1,5 @@
 /*
- * wcd.c
+ * dspapi.c
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
@@ -80,7 +80,7 @@ static u32 api_c_refs;
 /*
  *  Function tables.
  *  The order of these functions MUST be the same as the order of the command
- *  numbers defined in wcdioctl.h  This is how an IOCTL number in user mode
+ *  numbers defined in dspapi-ioctl.h  This is how an IOCTL number in user mode
  *  turns into a function call in kernel mode.
  */
 
diff --git a/drivers/dsp/bridge/pmgr/ioobj.h b/drivers/dsp/bridge/pmgr/ioobj.h
index 8717f8a..8f9d871 100644
--- a/drivers/dsp/bridge/pmgr/ioobj.h
+++ b/drivers/dsp/bridge/pmgr/ioobj.h
@@ -21,7 +21,7 @@
 #define IOOBJ_
 
 #include <dspbridge/devdefs.h>
-#include <dspbridge/wmd.h>
+#include <dspbridge/dspdefs.h>
 
 /*
  *  This struct is the first field in a io_mgr struct, as implemented in
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 63cadf6..f1e178a 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -28,7 +28,7 @@
 #include <dspbridge/dbc.h>
 
 /*  ----------------------------------- Mini Driver */
-#include <dspbridge/wmd.h>
+#include <dspbridge/dspdefs.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/dev.h>
diff --git a/drivers/dsp/bridge/pmgr/msgobj.h b/drivers/dsp/bridge/pmgr/msgobj.h
index 3eb1098..d19e26b 100644
--- a/drivers/dsp/bridge/pmgr/msgobj.h
+++ b/drivers/dsp/bridge/pmgr/msgobj.h
@@ -20,7 +20,7 @@
 #ifndef MSGOBJ_
 #define MSGOBJ_
 
-#include <dspbridge/wmd.h>
+#include <dspbridge/dspdefs.h>
 
 #include <dspbridge/msgdefs.h>
 
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 9418f50..bffedef 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -32,7 +32,7 @@
 #include <dspbridge/sync.h>
 
 /*  ----------------------------------- Link Driver */
-#include <dspbridge/wmd.h>
+#include <dspbridge/dspdefs.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/dev.h>
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 3df27d9..c3df5f5 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -40,7 +40,7 @@
 #include <dspbridge/proc.h>
 #include <dspbridge/strm.h>
 #include <dspbridge/nodepriv.h>
-#include <dspbridge/wmdchnl.h>
+#include <dspbridge/dspchnl.h>
 #include <dspbridge/resourcecleanup.h>
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index dd2fe8b..70e1a3a 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -45,7 +45,7 @@
 #include <dspbridge/reg.h>
 
 /*  ----------------------------------- Platform Manager */
-#include <dspbridge/wcdioctl.h>
+#include <dspbridge/dspapi-ioctl.h>
 #include <dspbridge/_dcd.h>
 #include <dspbridge/dspdrv.h>
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index be641bc..0b187dc 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -48,8 +48,8 @@
 #include <dspbridge/rms_sh.h>
 
 /*  ----------------------------------- Link Driver */
-#include <dspbridge/wmd.h>
-#include <dspbridge/wmdioctl.h>
+#include <dspbridge/dspdefs.h>
+#include <dspbridge/dspioctl.h>
 
 /*  ----------------------------------- Others */
 #include <dspbridge/gb.h>
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 0a95355..4cdc7e3 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -33,8 +33,8 @@
 #include <dspbridge/ntfy.h>
 #include <dspbridge/sync.h>
 /*  ----------------------------------- Mini Driver */
-#include <dspbridge/wmd.h>
-#include <dspbridge/wmddeh.h>
+#include <dspbridge/dspdefs.h>
+#include <dspbridge/dspdeh.h>
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/cod.h>
 #include <dspbridge/dev.h>
@@ -50,7 +50,7 @@
 /*  ----------------------------------- Others */
 #include <dspbridge/dbdcd.h>
 #include <dspbridge/msg.h>
-#include <dspbridge/wmdioctl.h>
+#include <dspbridge/dspioctl.h>
 #include <dspbridge/drv.h>
 #include <dspbridge/reg.h>
 
diff --git a/drivers/dsp/bridge/rmgr/pwr.c b/drivers/dsp/bridge/rmgr/pwr.c
index ff8c0c3..c479a68 100644
--- a/drivers/dsp/bridge/rmgr/pwr.c
+++ b/drivers/dsp/bridge/rmgr/pwr.c
@@ -30,7 +30,7 @@
 #include <dspbridge/dev.h>
 
 /*  ----------------------------------- Link Driver */
-#include <dspbridge/wmdioctl.h>
+#include <dspbridge/dspioctl.h>
 
 /*
  *  ======== pwr_sleep_dsp ========
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 76107c9..da26df9 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -31,7 +31,7 @@
 #include <dspbridge/sync.h>
 
 /*  ----------------------------------- Mini Driver */
-#include <dspbridge/wmd.h>
+#include <dspbridge/dspdefs.h>
 
 /*  ----------------------------------- Resource Manager */
 #include <dspbridge/nodepriv.h>
-- 
1.7.0.3

