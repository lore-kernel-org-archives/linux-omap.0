From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCHv2 3/5] DSPBRIDGE: OSAL: Clean up dbreg.h and move it
Date: Wed, 23 Sep 2009 19:03:21 +0300
Message-ID: <1253721804-22816-4-git-send-email-andy.shevchenko@gmail.com>
References: <1253721804-22816-1-git-send-email-andy.shevchenko@gmail.com>
 <1253721804-22816-2-git-send-email-andy.shevchenko@gmail.com>
 <1253721804-22816-3-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49796 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbZIWQD0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 12:03:26 -0400
In-Reply-To: <1253721804-22816-3-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@nokia.com, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

* Clean up dbreg.h - there are plenty of unused definitions
* Move necessary constants to the dbdefs.h
* Remove dbreg.h inclusion from other files

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |   26 ++++++
 arch/arm/plat-omap/include/dspbridge/dbreg.h  |  110 -------------------------
 drivers/dsp/bridge/pmgr/dev.c                 |    1 -
 drivers/dsp/bridge/rmgr/drv.c                 |    3 -
 drivers/dsp/bridge/rmgr/drv_interface.c       |    2 -
 drivers/dsp/bridge/rmgr/dspdrv.c              |    3 -
 drivers/dsp/bridge/rmgr/mgr.c                 |    1 -
 drivers/dsp/bridge/rmgr/node.c                |    1 -
 drivers/dsp/bridge/rmgr/proc.c                |    1 -
 drivers/dsp/bridge/rmgr/strm.c                |    1 -
 drivers/dsp/bridge/services/cfg.c             |    3 -
 drivers/dsp/bridge/services/reg.c             |    3 -
 drivers/dsp/bridge/services/regsup.c          |    1 -
 drivers/dsp/bridge/wmd/io_sm.c                |    1 -
 drivers/dsp/bridge/wmd/tiomap3430.c           |    1 -
 15 files changed, 26 insertions(+), 132 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/dbreg.h

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 1a47839..7445b73 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -589,4 +589,30 @@ bit 6 - MMU element size = 64bit (valid only for non mixed page entries)
 #define GEM_CACHE_LINE_SIZE     128
 #define GEM_L1P_PREFETCH_SIZE   128
 
+
+/*
+ * Definitions from dbreg.h
+ */
+
+#define DSPPROCTYPE_C64		6410
+#define IVAPROCTYPE_ARM7	470
+
+#define REG_MGR_OBJECT	1
+#define REG_DRV_OBJECT	2
+
+/* registry */
+#define DRVOBJECT	"DrvObject"
+#define MGROBJECT	"MgrObject"
+
+/* Max registry path length. Also the max registry value length. */
+#define MAXREGPATHLENGTH	255
+
+/* MiniDriver related definitions */
+#define DEFEXEC		"DefaultExecutable"	/* Default executable */
+#define AUTOSTART	"AutoStart"		/* Statically load flag */
+#define CURRENTCONFIG	"CurrentConfig"		/* Current resources */
+#define SHMSIZE		"SHMSize"		/* Size of SHM reservd on MPU */
+#define TCWORDSWAP	"TCWordSwap"		/* Traffic Contoller Word Swap */
+#define DSPRESOURCES	"DspTMSResources"	/* C55 DSP resurces on OMAP */
+
 #endif				/* DBDEFS_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/dbreg.h b/arch/arm/plat-omap/include/dspbridge/dbreg.h
deleted file mode 100644
index 59b6496..0000000
--- a/arch/arm/plat-omap/include/dspbridge/dbreg.h
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * dbreg.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2005-2006 Texas Instruments, Inc.
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
-
-/*
- *  ======== dbreg.h ========
- *  Purpose:
- *      Registry keys for use in Linux.  This is the clearinghouse for
- *      registry definitions, hopefully eliminating overlapping between
- *      modules.
- *
- *! Revision History:
- *! ================
- *! 10-Apr-2003 vp:  Added macro for subkey TCWORDSWAP.
- *! 21-Mar-2003 sb:  Added macro for subkey SHMSize
- *! 27-Aug-2001 jeh  Added WSXREG_LOADERFILENAME.
- *! 13-Feb-2001 kc:  DSP/BIOS Bridge name updates.
- *! 29-Nov-2000 rr:  Added WSXREG_DSPTYPE_55 as 6.
- *! 06-Sep-2000 jeh: Added WSXREG_CHNLOFFSET, WSXREG_NUMCHNLS,
- *!                  WSXREG_CHNLBUFSIZE.
- *! 26-Aug-2000 rr:  MEMBASE expanded to 9 entries.
- *! 26-Jul-2000 rr:  Added WSXREG_DCDNAME for the DCD Dll name. It will
- *!                  live under WSXREG_WINSPOXCONFIG.
- *! 17-Jul-2000 rr:  REG_MGR_OBJECT and REG_DRV_OBJECT defined. They
- *!                  are stored in the Registrty under WSXREG_WINSPOXCONFIG
- *!                  when they are created in DSP_Init. WSXREG_DEVOBJECT
- *!                  and WSXREG_MGROBJECT defined.
- *! 11-Dec-1999 ag:  Renamed Isa to IsaBus due to conflict with ceddk.h.
- *! 12-Nov-1999 rr:  New Registry Defnitions.
- *! 15-Oct-1999 rr:  New entry for DevObject created. WSXREG_DEVOBJECT
- *!                  under WSXREG_DDSPDRIVERPATH
- *! 10-Nov-1997 cr:  Added WSXREG_INFPATH, WSXREG_WINDEVICEPATH,
- *!                  WSXREG_WINCURVERSION
- *! 21-Oct-1997 cr:  Added WSXREG_BUSTYPE.
- *! 08-Sep-1997 cr:  Added WSXREG_SERVICES, WSXREG_SERVICENAME and
- *!                  WSXREG_CLASSINDEX.
- *! 30-Aug-1997 cr:  Added WSXREG_SOFTWAREPATHNT & WSXREG_WBCLASSGUID.
- *! 24-Mar-1997 gp:  Added MAXCHIPINFOSUBKEY def.
- *! 18-Feb-1997 cr:  Changed Version1.1 -> Version1.0
- *! 12-Feb-1997 cr:  Changed WinSPOX -> WinBRIDGE.
- *! 11-Dec-1996 gp:  Added Perf key name in WinSPOX Config.
- *! 22-Jul-1996 gp:  Added Trace key name.
- *! 30-May-1996 cr:  Created.
- */
-
-#ifndef DBREG_
-#define DBREG_ 1	/* Defined as "1" so InstallShield programs compile. */
-
-#define REG_MGR_OBJECT      1
-#define REG_DRV_OBJECT      2
-/* general registry definitions */
-#define MAXREGPATHLENGTH    255	/* Max registry path length. Also the
-				   max registry value length. */
-#define DSPTYPE_55          6	/* This is the DSP Chip type for 55 */
-#define DSPTYPE_64          0x99
-#define IVA_ARM7            0x97    /* This is the DSP Chip type for IVA/ARM7 */
-
-#define DSPPROCTYPE_C55		5510
-#define DSPPROCTYPE_C64		6410
-#define IVAPROCTYPE_ARM7	470
-/* registry */
-#define DEVNODESTRING    "DevNode"	/* u32 devnode */
-#define CONFIG           "Software\\TexasInstruments\\DirectDSP\\Config"
-#define DRVOBJECT        "DrvObject"
-#define MGROBJECT        "MgrObject"
-#define CLASS            "Device"	/*  device class */
-#define TRACE            "Trace"	/* GT Trace settings.  */
-#define PERFR            "Perf"	/* Enable perf bool.  */
-#define ROOT             "Root"	/*  root dir */
-
-/* MiniDriver related definitions */
-/* The following definitions are under "Drivers\\DirectDSP\\Device\\XXX "
- * Where XXX is the device or board name */
-
-#define WMDFILENAME      "MiniDriver"	/* WMD entry name */
-#define CHIPTYPE         "ChipType"	/* Chip type */
-#define CHIPNUM          "NumChips"	/* Number of chips */
-#define DEFEXEC          "DefaultExecutable"	/* Default executable */
-#define AUTOSTART        "AutoStart"	/* Statically load flag */
-#define IVAAUTOSTART     "IvaAutoStart"	/* Statically load flag */
-#define BOARDNAME        "BoardName"	/* Name of the Board */
-#define UNITNUMBER       "UnitNumber"	/* Unit # of the Board */
-#define BUSTYPE          "BusType"	/* Bus type board is on */
-#define BUSNUMBER        "BusNumber"	/* Bus number board is on */
-#define CURRENTCONFIG    "CurrentConfig"	/* Current resources */
-#define PCIVENDEVID      "VendorDeviceId"	/* The board's id */
-#define INFPATH          "InfPath"	/* wmd's inf filename */
-#define DEVOBJECT        "DevObject"
-#define ZLFILENAME       "ZLFileName"	/* Name of ZL file */
-#define WORDSIZE         "WordSize"	/* NumBytes in DSP Word */
-#define SHMSIZE          "SHMSize"	/* Size of SHM reservd on MPU */
-#define IVAEXTMEMSIZE    "IVAEXTMEMSize"	/* IVA External Memeory size  */
-#define TCWORDSWAP       "TCWordSwap"	/* Traffic Contoller Word Swap */
-#define DSPRESOURCES     "DspTMSResources"	/* C55 DSP resurces on OMAP */
-#define IVA1RESOURCES    "ARM7IvaResources"	/* ARM7 IVA resurces on OMAP */
-
-#endif				/* DBREG_ */
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index a206f7f..0615c8b 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -142,7 +142,6 @@
 #include <dspbridge/node.h>
 
 /*  ----------------------------------- Others */
-#include <dspbridge/dbreg.h>
 #include <dspbridge/wcd.h>		/* WCD version info. */
 
 #include <dspbridge/chnl.h>
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 2b0564a..4a639ce 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -108,9 +108,6 @@
 #include <dspbridge/mem.h>
 #include <dspbridge/reg.h>
 
-/*  ----------------------------------- Others */
-#include <dspbridge/dbreg.h>
-
 /*  ----------------------------------- This */
 #include <dspbridge/drv.h>
 #include <dspbridge/dev.h>
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 152b6fc..f68978a 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -81,7 +81,6 @@
 #include <dspbridge/wcdioctl.h>
 #include <dspbridge/_dcd.h>
 #include <dspbridge/dspdrv.h>
-#include <dspbridge/dbreg.h>
 
 /*  ----------------------------------- Resource Manager */
 #include <dspbridge/pwr.h>
@@ -98,7 +97,6 @@
 #include <dspbridge/dev.h>
 #include <dspbridge/drvdefs.h>
 #include <dspbridge/drv.h>
-#include <dspbridge/dbreg.h>
 #endif
 
 #include <mach/omap-pm.h>
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index 3758e86..895279c 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -116,9 +116,6 @@
 /*  ----------------------------------- Resource Manager */
 #include <dspbridge/mgr.h>
 
-/*  ----------------------------------- Others */
-#include <dspbridge/dbreg.h>
-
 /*  ----------------------------------- This */
 #include <dspbridge/dspdrv.h>
 
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index 943cf93..b254296 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -56,7 +56,6 @@
 
 /*  ----------------------------------- Others */
 #include <dspbridge/dbdcd.h>
-#include <dspbridge/dbreg.h>
 #include <dspbridge/drv.h>
 #include <dspbridge/dev.h>
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 676d2be..54af411 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -146,7 +146,6 @@
 #ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/drv.h>
 #include <dspbridge/drvdefs.h>
-#include <dspbridge/dbreg.h>
 #include <dspbridge/resourcecleanup.h>
 #endif
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 01d39b4..c3add40 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -136,7 +136,6 @@
 
 /*  ----------------------------------- Others */
 #include <dspbridge/dbdcd.h>
-#include <dspbridge/dbreg.h>
 #include <dspbridge/msg.h>
 #include <dspbridge/wmdioctl.h>
 #include <dspbridge/drv.h>
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 4335c64..7413dc6 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -91,7 +91,6 @@
 
 #ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/cfg.h>
-#include <dspbridge/dbreg.h>
 #include <dspbridge/resourcecleanup.h>
 #endif
 
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index e3cdda3..409f753 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -84,9 +84,6 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/reg.h>
 
-/*  ----------------------------------- Others */
-#include <dspbridge/dbreg.h>
-
 /*  ----------------------------------- This */
 #include <dspbridge/cfg.h>
 #include <dspbridge/list.h>
diff --git a/drivers/dsp/bridge/services/reg.c b/drivers/dsp/bridge/services/reg.c
index 9fa1979..2030afa 100644
--- a/drivers/dsp/bridge/services/reg.c
+++ b/drivers/dsp/bridge/services/reg.c
@@ -48,9 +48,6 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
 
-/*  ----------------------------------- Others */
-#include <dspbridge/dbreg.h>
-
 /*  ----------------------------------- This */
 #include <dspbridge/reg.h>
 #include <regsup.h>
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 0527f41..e40d989 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -35,7 +35,6 @@
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/errbase.h>
-#include <dspbridge/dbreg.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index e15f632..1d478ad 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -83,7 +83,6 @@
 #include <dspbridge/cod.h>
 #include <dspbridge/dev.h>
 #include <dspbridge/chnl_sm.h>
-#include <dspbridge/dbreg.h>
 
 /*  ----------------------------------- Others */
 #include <dspbridge/rms_sh.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 032bdb4..ef15bee 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -48,7 +48,6 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
 #include <dspbridge/reg.h>
-#include <dspbridge/dbreg.h>
 #include <dspbridge/cfg.h>
 #include <dspbridge/drv.h>
 #include <dspbridge/sync.h>
-- 
1.5.6.5

