From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 36/40] DSPBRIDGE: remove custom errbase definitions
Date: Thu,  3 Jun 2010 00:47:49 -0500
Message-ID: <1275544073-20418-37-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37612 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932581Ab0FCF4Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:24 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

This are not used anymore, removing header file with
custom error codes.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |  177 ------------------------
 arch/arm/plat-omap/include/dspbridge/ntfy.h    |    1 -
 arch/arm/plat-omap/include/dspbridge/pwr.h     |    1 -
 arch/arm/plat-omap/include/dspbridge/sync.h    |    1 -
 drivers/dsp/bridge/core/chnl_sm.c              |    1 -
 drivers/dsp/bridge/core/dsp-clock.c            |    1 -
 drivers/dsp/bridge/core/io_sm.c                |    1 -
 drivers/dsp/bridge/core/mmu_fault.c            |    1 -
 drivers/dsp/bridge/core/msg_sm.c               |    1 -
 drivers/dsp/bridge/core/tiomap3430.c           |    1 -
 drivers/dsp/bridge/core/tiomap3430_pwr.c       |    1 -
 drivers/dsp/bridge/core/tiomap_io.c            |    1 -
 drivers/dsp/bridge/core/ue_deh.c               |    1 -
 drivers/dsp/bridge/core/wdt.c                  |    1 -
 drivers/dsp/bridge/pmgr/chnl.c                 |    1 -
 drivers/dsp/bridge/pmgr/cmm.c                  |    1 -
 drivers/dsp/bridge/pmgr/cod.c                  |    1 -
 drivers/dsp/bridge/pmgr/dbll.c                 |    1 -
 drivers/dsp/bridge/pmgr/dev.c                  |    1 -
 drivers/dsp/bridge/pmgr/dmm.c                  |    1 -
 drivers/dsp/bridge/pmgr/dspapi.c               |    1 -
 drivers/dsp/bridge/pmgr/io.c                   |    1 -
 drivers/dsp/bridge/pmgr/msg.c                  |    1 -
 drivers/dsp/bridge/rmgr/dbdcd.c                |    1 -
 drivers/dsp/bridge/rmgr/disp.c                 |    1 -
 drivers/dsp/bridge/rmgr/drv.c                  |    1 -
 drivers/dsp/bridge/rmgr/drv_interface.c        |    1 -
 drivers/dsp/bridge/rmgr/dspdrv.c               |    1 -
 drivers/dsp/bridge/rmgr/mgr.c                  |    1 -
 drivers/dsp/bridge/rmgr/nldr.c                 |    1 -
 drivers/dsp/bridge/rmgr/node.c                 |    1 -
 drivers/dsp/bridge/rmgr/proc.c                 |    1 -
 drivers/dsp/bridge/rmgr/rmm.c                  |    1 -
 drivers/dsp/bridge/rmgr/strm.c                 |    1 -
 drivers/dsp/bridge/services/cfg.c              |    1 -
 35 files changed, 0 insertions(+), 211 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/errbase.h

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
deleted file mode 100644
index eeff930..0000000
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ /dev/null
@@ -1,177 +0,0 @@
-/*
- * errbase.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Central repository for DSP/BIOS Bridge error and status code.
- *
- * Error codes are of the form:
- *     [<MODULE>]_E<ERRORCODE>
- *
- * Success codes are of the form:
- *     [<MODULE>]_S<SUCCESSCODE>
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
-#ifndef ERRBASE_
-#define ERRBASE_
-
-/* Base of generic errors and component errors */
-#define DSP_SBASE               (dsp_status)0x00008000
-#define DSP_EBASE               (dsp_status)0x80008000
-
-#define DSP_COMP_EBASE          (dsp_status)0x80040200
-#define DSP_COMP_ELAST          (dsp_status)0x80047fff
-
-/* SUCCESS Codes */
-
-/* Generic success code */
-#define 0                     (DSP_SBASE + 0)
-
-/* GPP is already attached to this DSP processor */
-#define 0        (DSP_SBASE + 1)
-
-/* This is the last object available for enumeration. */
-#define DSP_SENUMCOMPLETE           (DSP_SBASE + 2)
-
-/* The DSP is already asleep. */
-#define 0          (DSP_SBASE + 3)
-
-/* A library contains no dependent library references */
-#define 0        (DSP_SBASE + 7)
-
-/* A persistent library is already loaded by the dynamic loader */
-#define 0          (DSP_SBASE + 8)
-
-/* FAILURE Codes */
-
-/* During enumeration a change in the number or properties of the objects
- * has occurred. */
-#define DSP_ECHANGEDURINGENUM       (DSP_EBASE + 3)
-
-/* I/O is currently pending. */
-#define DSP_EPENDING                (DSP_EBASE + 0x11)
-
-/* The state of the specified object is incorrect for the requested
- * operation. */
-#define DSP_EWRONGSTATE             (DSP_EBASE + 0x1b)
-
-/* Symbol not found in the COFF file.  DSPNode_Create will return this if
- * the iAlg function table for an xDAIS socket is not found in the COFF file.
- * In this case, force the symbol to be linked into the COFF file.
- * DSPNode_Create, DSPNode_Execute, and DSPNode_Delete will return this if
- * the create, execute, or delete phase function, respectively, could not be
- * found in the COFF file. */
-#define DSP_ESYMBOL                 (DSP_EBASE + 0x1c)
-
-/* Unable to read content of DCD data section ; this is typically caused by
- * improperly configured nodes. */
-#define DSP_EDCDREADSECT            (DSP_EBASE + 0x1e)
-
-/* Unable to decode DCD data section content ; this is typically caused by
- * changes to DSP/BIOS Bridge data structures. */
-#define DSP_EDCDPARSESECT           (DSP_EBASE + 0x1f)
-
-/* Unable to get pointer to DCD data section ; this is typically caused by
- * improperly configured UUIDs. */
-#define DSP_EDCDGETSECT             (DSP_EBASE + 0x20)
-
-/* Unable to load file containing DCD data section ; this is typically
- * caused by a missing COFF file. */
-#define DSP_EDCDLOADBASE            (DSP_EBASE + 0x21)
-
-/* The specified COFF file does not contain a valid node registration
- * section. */
-#define DSP_EDCDNOAUTOREGISTER      (DSP_EBASE + 0x22)
-
-/* A specified entity was not found. */
-#define DSP_ENOTFOUND               (DSP_EBASE + 0x2d)
-
-/* A shared memory buffer contained in a message or stream could not be
- * mapped to the GPP client process's virtual space. */
-#define DSP_ETRANSLATE              (DSP_EBASE + 0x2f)
-
-/* Unable to find a named section in DSP executable */
-#define DSP_ENOSECT                 (DSP_EBASE + 0x32)
-
-/* A non-existent memory segment identifier was specified */
-#define DSP_EOVERLAYMEMORY          (DSP_EBASE + 0x37)
-
-/* Invalid segment ID */
-#define DSP_EBADSEGID               (DSP_EBASE + 0x38)
-
-/* Error occurred in a dynamic loader library function */
-#define DSP_EDYNLOAD                (DSP_EBASE + 0x3d)
-
-/* Device in 'sleep/suspend' mode due to DPM */
-#define DSP_EDPMSUSPEND             (DSP_EBASE + 0x3e)
-
-/* FAILURE Codes : COD */
-#define COD_EBASE                   (DSP_COMP_EBASE + 0x400)
-
-/* No symbol table is loaded for this board. */
-#define COD_E_NOSYMBOLSLOADED       (COD_EBASE + 0x00)
-
-/* Symbol not found in for this board. */
-#define COD_E_SYMBOLNOTFOUND        (COD_EBASE + 0x01)
-
-/* Unable to initialize the ZL COFF parsing module. */
-#define COD_E_ZLCREATEFAILED        (COD_EBASE + 0x03)
-
-/* FAILURE Codes : CHNL */
-#define CHNL_EBASE                  (DSP_COMP_EBASE + 0x500)
-
-/* Attempt to created channel manager with too many channels. */
-#define CHNL_E_MAXCHANNELS          (CHNL_EBASE + 0x00)
-
-/* No free channels are available. */
-#define CHNL_E_OUTOFSTREAMS         (CHNL_EBASE + 0x02)
-
-/* Channel ID is out of range. */
-#define CHNL_E_BADCHANID            (CHNL_EBASE + 0x03)
-
-/* dwTimeOut parameter was CHNL_IOCNOWAIT, yet no I/O completions were
- * queued. */
-#define CHNL_E_NOIOC                (CHNL_EBASE + 0x06)
-
-/* End of stream was already requested on this output channel. */
-#define CHNL_E_EOS                  (CHNL_EBASE + 0x09)
-
-/* DSP word size of zero configured for this device. */
-#define CHNL_E_INVALIDWORDSIZE      (CHNL_EBASE + 0x0D)
-
-/* A zero length memory base was specified for a shared memory class driver. */
-#define CHNL_E_INVALIDMEMBASE       (CHNL_EBASE + 0x0E)
-
-/* Memory map is not configured, or unable to map physical to linear
- * address. */
-#define CHNL_E_NOMEMMAP             (CHNL_EBASE + 0x0F)
-
-/* Attempted to create a channel manager  when one already exists. */
-#define CHNL_E_MGREXISTS            (CHNL_EBASE + 0x10)
-
-/* Unable to plug channel ISR for configured IRQ. */
-#define CHNL_E_ISR                  (CHNL_EBASE + 0x11)
-
-/* No free I/O request packets are available. */
-#define CHNL_E_NOIORPS              (CHNL_EBASE + 0x12)
-
-/* Buffer size is larger than the size of physical channel. */
-#define CHNL_E_BUFSIZE              (CHNL_EBASE + 0x13)
-
-/* User cannot mark end of stream on an input channel. */
-#define CHNL_E_NOEOS                (CHNL_EBASE + 0x14)
-
-/* Wait for flush operation on an output channel timed out. */
-#define CHNL_E_WAITTIMEOUT          (CHNL_EBASE + 0x15)
-
-#endif /* ERRBASE_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/ntfy.h b/arch/arm/plat-omap/include/dspbridge/ntfy.h
index 3c3aba7..f8d108e 100644
--- a/arch/arm/plat-omap/include/dspbridge/ntfy.h
+++ b/arch/arm/plat-omap/include/dspbridge/ntfy.h
@@ -21,7 +21,6 @@
 
 #include <dspbridge/host_os.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 #include <dspbridge/sync.h>
 
 /**
diff --git a/arch/arm/plat-omap/include/dspbridge/pwr.h b/arch/arm/plat-omap/include/dspbridge/pwr.h
index 598a11c..a7f958a 100644
--- a/arch/arm/plat-omap/include/dspbridge/pwr.h
+++ b/arch/arm/plat-omap/include/dspbridge/pwr.h
@@ -18,7 +18,6 @@
 #define PWR_
 
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 #include <dspbridge/pwr_sh.h>
 
 /*
diff --git a/arch/arm/plat-omap/include/dspbridge/sync.h b/arch/arm/plat-omap/include/dspbridge/sync.h
index 5e2c94e..5789c84 100644
--- a/arch/arm/plat-omap/include/dspbridge/sync.h
+++ b/arch/arm/plat-omap/include/dspbridge/sync.h
@@ -19,7 +19,6 @@
 #ifndef _SYNC_H
 #define _SYNC_H
 
-#include <dspbridge/errbase.h>
 #include <dspbridge/dbdefs.h>
 
 
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index 67132c2..6a8bbf9 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -48,7 +48,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/core/dsp-clock.c b/drivers/dsp/bridge/core/dsp-clock.c
index 7cc9874..9f6d7b0 100644
--- a/drivers/dsp/bridge/core/dsp-clock.c
+++ b/drivers/dsp/bridge/core/dsp-clock.c
@@ -24,7 +24,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 #include <dspbridge/cfg.h>
 #include <dspbridge/drv.h>
 #include <dspbridge/dev.h>
diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
index 72245d8..65295e7 100644
--- a/drivers/dsp/bridge/core/io_sm.c
+++ b/drivers/dsp/bridge/core/io_sm.c
@@ -31,7 +31,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /* Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/core/mmu_fault.c b/drivers/dsp/bridge/core/mmu_fault.c
index 883f45d..7185372 100644
--- a/drivers/dsp/bridge/core/mmu_fault.c
+++ b/drivers/dsp/bridge/core/mmu_fault.c
@@ -19,7 +19,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/host_os.h>
diff --git a/drivers/dsp/bridge/core/msg_sm.c b/drivers/dsp/bridge/core/msg_sm.c
index 7ac56b1..4277f2e 100644
--- a/drivers/dsp/bridge/core/msg_sm.c
+++ b/drivers/dsp/bridge/core/msg_sm.c
@@ -19,7 +19,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index 146b7c1..b1e870a 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -25,7 +25,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/core/tiomap3430_pwr.c b/drivers/dsp/bridge/core/tiomap3430_pwr.c
index ba07c51..bc576c9 100644
--- a/drivers/dsp/bridge/core/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/core/tiomap3430_pwr.c
@@ -18,7 +18,6 @@
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 #include <dspbridge/cfg.h>
 #include <dspbridge/drv.h>
 #include <dspbridge/io_sm.h>
diff --git a/drivers/dsp/bridge/core/tiomap_io.c b/drivers/dsp/bridge/core/tiomap_io.c
index 5d8e46a..f48c35a 100644
--- a/drivers/dsp/bridge/core/tiomap_io.c
+++ b/drivers/dsp/bridge/core/tiomap_io.c
@@ -18,7 +18,6 @@
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 24188bf..e33548b 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -23,7 +23,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/core/wdt.c b/drivers/dsp/bridge/core/wdt.c
index 4637afb..847b880 100644
--- a/drivers/dsp/bridge/core/wdt.c
+++ b/drivers/dsp/bridge/core/wdt.c
@@ -18,7 +18,6 @@
 
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 #include <dspbridge/dspdeh.h>
 #include <dspbridge/dev.h>
 #include <dspbridge/_chnl_sm.h>
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 22087f2..c8de886 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -23,7 +23,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 9acd675..2fda933 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -36,7 +36,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 342c1b3..ef3e3b4 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -28,7 +28,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 8e76bf6..dff0f05 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -20,7 +20,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index fd1677c..503ff4d 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -22,7 +22,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index bf2c0e1..6fa7a6a 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -30,7 +30,6 @@
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/sync.h>
diff --git a/drivers/dsp/bridge/pmgr/dspapi.c b/drivers/dsp/bridge/pmgr/dspapi.c
index 9bf2bae..01f456a 100644
--- a/drivers/dsp/bridge/pmgr/dspapi.c
+++ b/drivers/dsp/bridge/pmgr/dspapi.c
@@ -23,7 +23,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index de46cde..0f4c1df 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -22,7 +22,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 7e74e22..0d83df1 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -22,7 +22,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index d5b0bce..e0fbdb0 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -29,7 +29,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
 
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index b099125..035830b 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -23,7 +23,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index a92b0d7..cced18a 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -22,7 +22,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 08ad56d..bbcb6a8 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -34,7 +34,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index 0e22ca1..8b64067 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -22,7 +22,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index 7738245..1ec08dc 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -21,7 +21,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index f5b7239..9b855fa 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -20,7 +20,6 @@
 
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 #include <dspbridge/dbc.h>
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 4d27445..ad9b62c 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -22,7 +22,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 78f06ad..f3d5a94 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -22,7 +22,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index efefb65..f95fe1d 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -40,7 +40,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 58ec979..6c90687 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -22,7 +22,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index cef7110..69c8dc2 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -19,7 +19,6 @@
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
-- 
1.7.1

