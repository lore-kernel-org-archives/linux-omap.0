From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 09/13] DSPBRIDGE: Remove mem.c and mem.h files
Date: Thu, 8 Apr 2010 19:09:03 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB09548E64D154@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34207 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759220Ab0DIAJX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 20:09:23 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 06b40c3cfcf6d8349026ea5f42883ab0d133a9cc Mon Sep 17 00:00:00 2001
From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Date: Thu, 25 Mar 2010 15:38:31 -0600
Subject: [PATCH 09/13] DSPBRIDGE: Remove mem.c and mem.h files

These files are not used anymore.

Also, a cleanup of memdefs.h file is done, because the Memory Pool
Attributes are not used after removing mem.c and mem.h files.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/mem.h      |  142 -----------------------
 arch/arm/plat-omap/include/dspbridge/memdefs.h  |    7 -
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |   29 -----
 drivers/dsp/bridge/Makefile                     |    2 +-
 drivers/dsp/bridge/gen/gs.c                     |    4 +-
 drivers/dsp/bridge/pmgr/chnl.c                  |    1 -
 drivers/dsp/bridge/pmgr/cmm.c                   |    1 -
 drivers/dsp/bridge/pmgr/cod.c                   |    1 -
 drivers/dsp/bridge/pmgr/dbll.c                  |    1 -
 drivers/dsp/bridge/pmgr/dev.c                   |    1 -
 drivers/dsp/bridge/pmgr/dmm.c                   |    1 -
 drivers/dsp/bridge/pmgr/io.c                    |    1 -
 drivers/dsp/bridge/pmgr/msg.c                   |    3 -
 drivers/dsp/bridge/pmgr/wcd.c                   |    1 -
 drivers/dsp/bridge/rmgr/dbdcd.c                 |    1 -
 drivers/dsp/bridge/rmgr/disp.c                  |    1 -
 drivers/dsp/bridge/rmgr/drv.c                   |    1 -
 drivers/dsp/bridge/rmgr/dspdrv.c                |    1 -
 drivers/dsp/bridge/rmgr/mgr.c                   |    1 -
 drivers/dsp/bridge/rmgr/nldr.c                  |    3 -
 drivers/dsp/bridge/rmgr/node.c                  |    2 +-
 drivers/dsp/bridge/rmgr/proc.c                  |    1 -
 drivers/dsp/bridge/rmgr/rmm.c                   |    1 -
 drivers/dsp/bridge/rmgr/strm.c                  |    1 -
 drivers/dsp/bridge/services/clk.c               |    3 -
 drivers/dsp/bridge/services/mem.c               |   98 ----------------
 drivers/dsp/bridge/services/reg.c               |    3 -
 drivers/dsp/bridge/services/regsup.c            |    1 -
 drivers/dsp/bridge/services/services.c          |    1 -
 drivers/dsp/bridge/wmd/chnl_sm.c                |    1 -
 drivers/dsp/bridge/wmd/io_sm.c                  |    1 -
 drivers/dsp/bridge/wmd/mmu_fault.c              |    1 -
 drivers/dsp/bridge/wmd/msg_sm.c                 |    1 -
 drivers/dsp/bridge/wmd/tiomap3430.c             |    1 -
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c         |    3 -
 drivers/dsp/bridge/wmd/tiomap_io.c              |    1 -
 drivers/dsp/bridge/wmd/ue_deh.c                 |    1 -
 37 files changed, 4 insertions(+), 320 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/mem.h
 delete mode 100644 drivers/dsp/bridge/services/mem.c

diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
deleted file mode 100644
index f321f3f..0000000
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- * mem.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Memory management and address mapping services for the DSP/BIOS Bridge
- * class driver and mini-driver.
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
-#ifndef MEM_
-#define MEM_
-
-#include <dspbridge/host_os.h>
-#include <dspbridge/memdefs.h>
-
-/*
- *  ======== mem_alloc ========
- *  Purpose:
- *      Allocate memory from the paged or non-paged pools.
- *  Parameters:
- *      byte_size: Number of bytes to allocate.
- *      type:   Type of memory to allocate; one of:
- *              MEM_PAGED: Allocate from pageable memory.
- *              MEM_NONPAGED: Allocate from page locked memory.
- *  Returns:
- *      Pointer to a block of memory;
- *      NULL if memory couldn't be allocated, if byte_size == 0, or if type is
- *      not one of MEM_PAGED or MEM_NONPAGED.
- *  Requires:
- *      MEM initialized.
- *  Ensures:
- *      The returned pointer, if not NULL, points to a valid memory block of
- *      the size requested.
- */
-extern void *mem_alloc(IN u32 byte_size, IN enum mem_poolattrs type);
-
-/*
- *  ======== MEM_ALLOC_OBJECT ========
- *  Purpose:
- *      Allocate an object, and set it's signature.
- *  Parameters:
- *      pObj:       Pointer to the new object.
- *      Obj:        Type of the object to allocate.
- *      Signature:  Magic field value.  Must be non-zero.
- *  Returns:
- *  Requires:
- *      Same requirements as mem_calloc(); and
- *      The object structure has a dw_signature field.  The compiler ensures
- *      this requirement.
- *  Ensures:
- *      A subsequent call to MEM_IS_VALID_HANDLE() will succeed for this object.
- */
-#define MEM_ALLOC_OBJECT(pObj, Obj, Signature)           \
-{                                                       \
-    pObj = kzalloc(sizeof(Obj), GFP_KERNEL);       \
-    if (pObj) {                                         \
-       pObj->dw_signature = Signature;                  \
-    }                                                   \
-}
-
-/*
- *  ======== mem_calloc ========
- *  Purpose:
- *      Allocate zero-initialized memory from the paged or non-paged pools.
- *  Parameters:
- *      byte_size: Number of bytes to allocate.
- *      type:   Type of memory to allocate; one of:
- *              MEM_PAGED:   Allocate from pageable memory.
- *              MEM_NONPAGED: Allocate from page locked memory.
- *  Returns:
- *      Pointer to a block of zeroed memory;
- *      NULL if memory couldn't be allocated, if byte_size == 0, or if type is
- *      not one of MEM_PAGED or MEM_NONPAGED.
- *  Requires:
- *      MEM initialized.
- *  Ensures:
- *      The returned pointer, if not NULL, points to a valid memory block
- *      of the size requested.
- */
-extern void *mem_calloc(IN u32 byte_size, IN enum mem_poolattrs type);
-
-/*
- *  ======== MEM_FREE_OBJECT ========
- *  Purpose:
- *      Utility macro to invalidate an object's signature, and deallocate it.
- *  Parameters:
- *      pObj:   Pointer to the object to free.
- *  Returns:
- *  Requires:
- *      Same requirements as kfree().
- *  Ensures:
- *      A subsequent call to MEM_IS_VALID_HANDLE() will fail for this object.
- */
-#define MEM_FREE_OBJECT(pObj)    \
-{                               \
-    pObj->dw_signature = 0x00;   \
-    kfree(pObj);                \
-}
-
-/*
- *  ======== mem_get_num_pages ========
- *  Purpose:
- *      Calculate the number of pages corresponding to the supplied buffer.
- *  Parameters:
- *      paddr:  Linear (virtual) address of the buffer.
- *      byte_size: Number of bytes in the buffer.
- *  Returns:
- *      Number of pages.
- *  Requires:
- *      MEM initialized.
- *  Ensures:
- *      If byte_size > 0, number of pages returned > 0.
- */
-extern s32 mem_get_num_pages(IN void *paddr, IN u32 byte_size);
-
-/*
- *  ======== MEM_IS_VALID_HANDLE ========
- *  Purpose:
- *      Validate the object handle.
- *  Parameters:
- *      hObj:   Handle to object created with MEM_ALLOC_OBJECT().
- *      Sig:    Expected signature u32.
- *  Returns:
- *      TRUE if handle is valid; FALSE otherwise.
- *  Requires:
- *      The object structure has a dw_signature field. Ensured by compiler.
- *  Ensures:
- */
-#define MEM_IS_VALID_HANDLE(hObj, Sig)                \
-     ((hObj != NULL) && (hObj->dw_signature == Sig))
-
-#endif /* MEM_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/memdefs.h b/arch/arm/plat-omap/include/dspbridge/memdefs.h
index 23885fd..cce6957 100644
--- a/arch/arm/plat-omap/include/dspbridge/memdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/memdefs.h
@@ -19,13 +19,6 @@
 #ifndef MEMDEFS_
 #define MEMDEFS_

-/* Memory Pool Attributes: */
-enum mem_poolattrs {
-       MEM_PAGED = 0,
-       MEM_NONPAGED = 1,
-       MEM_LARGEVIRTMEM = 2
-};
-
 /*
  *  MEM_VIRTUALSEGID is used by Node & Strm to access virtual address space in
  *  the correct client process context.
diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index b6a4dda..49bec37 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -20,7 +20,6 @@
 #ifndef WCDIOCTL_
 #define WCDIOCTL_

-#include <dspbridge/mem.h>
 #include <dspbridge/cmm.h>
 #include <dspbridge/strmdefs.h>
 #include <dspbridge/dbdcd.h>
@@ -352,34 +351,6 @@ union Trapped_Args {
                struct cmm_info __user *cmm_info_obj;
        } args_cmm_getinfo;

-       /* MEM Module */
-       struct {
-               u32 byte_size;
-               enum mem_poolattrs type;
-               void *mem;
-       } args_mem_alloc;
-
-       struct {
-               u32 byte_size;
-               enum mem_poolattrs type;
-               void *mem;
-       } args_mem_calloc;
-
-       struct {
-               void *mem;
-       } args_mem_free;
-
-       struct {
-               void *pbuffer;
-               u32 size;
-               void *locked_buffer;
-       } args_mem_pagelock;
-
-       struct {
-               void *pbuffer;
-               u32 size;
-       } args_mem_pageunlock;
-
        /* UTIL module */
        struct {
                s32 util_argc;
diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index 5a28374..c6f2551 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -1,7 +1,7 @@
 obj-$(CONFIG_MPU_BRIDGE)       += bridgedriver.o

 libgen = gen/gb.o gen/gs.o gen/gh.o gen/uuidutil.o
-libservices = services/mem.o services/sync.o \
+libservices = services/sync.o \
                services/clk.o services/cfg.o services/reg.o \
                services/regsup.o services/ntfy.o \
                services/services.o
diff --git a/drivers/dsp/bridge/gen/gs.c b/drivers/dsp/bridge/gen/gs.c
index 1a43fd5..3d091b9 100644
--- a/drivers/dsp/bridge/gen/gs.c
+++ b/drivers/dsp/bridge/gen/gs.c
@@ -20,12 +20,12 @@
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
 #include <linux/types.h>
-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>

 /*  ----------------------------------- This */
 #include <dspbridge/gs.h>

+#include <linux/slab.h>
+
 /*  ----------------------------------- Globals */
 static u32 cumsize;

diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 66f59ce..6adc3c3 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -30,7 +30,6 @@

 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/mem.h>
 #include <dspbridge/sync.h>

 /*  ----------------------------------- Platform Manager */
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index e391f97..e1fcc38 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -41,7 +41,6 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
 #include <dspbridge/list.h>
-#include <dspbridge/mem.h>
 #include <dspbridge/sync.h>
 #include <dspbridge/utildefs.h>

diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 5810563..1a84c53 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -35,7 +35,6 @@

 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/ldr.h>
-#include <dspbridge/mem.h>

 /*  ----------------------------------- Platform Manager */
 /* Include appropriate loader header file */
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index ff58578..18bc662 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -27,7 +27,6 @@
 #include <dspbridge/gh.h>

 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>

 /* Dynamic loader library interface */
 #include <dspbridge/dynamic_loader.h>
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index ba4f5cc..aafdbaa 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -31,7 +31,6 @@
 #include <dspbridge/cfg.h>
 #include <dspbridge/ldr.h>
 #include <dspbridge/list.h>
-#include <dspbridge/mem.h>

 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/cod.h>
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index 595ac02..e2e47f2 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -33,7 +33,6 @@
 #include <dspbridge/errbase.h>

 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
 #include <dspbridge/sync.h>

 /*  ----------------------------------- Platform Manager */
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index 154ed67..e16d47b 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -29,7 +29,6 @@

 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/mem.h>

 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/dev.h>
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 217cf73..63cadf6 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -27,9 +27,6 @@
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>

-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
-
 /*  ----------------------------------- Mini Driver */
 #include <dspbridge/wmd.h>

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 5b2c1f5..9f734ab 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -30,7 +30,6 @@

 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/services.h>

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 70806af..8895b93 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -34,7 +34,6 @@
 #include <dspbridge/dbc.h>

 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
 #include <dspbridge/reg.h>

 /*  ----------------------------------- Platform Manager */
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 2cc3f3d..b7ddc4e 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -29,7 +29,6 @@
 #include <dspbridge/dbc.h>

 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
 #include <dspbridge/sync.h>

 /*  ----------------------------------- Link Driver */
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index de9499a..2c01c4a 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -30,7 +30,6 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
 #include <dspbridge/list.h>
-#include <dspbridge/mem.h>
 #include <dspbridge/reg.h>

 /*  ----------------------------------- This */
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index f8ceeba..94f7605 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -29,7 +29,6 @@

 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/mem.h>
 #include <dspbridge/reg.h>

 /*  ----------------------------------- Platform Manager */
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index bcd8c8b..e8a9a33 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -28,7 +28,6 @@

 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/mem.h>
 #include <dspbridge/sync.h>

 /*  ----------------------------------- Others */
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 8cd6ae2..ed6d08b 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -24,9 +24,6 @@

 #include <dspbridge/dbc.h>

-/* OS adaptation layer */
-#include <dspbridge/mem.h>
-
 /* Platform manager */
 #include <dspbridge/cod.h>
 #include <dspbridge/dev.h>
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 547d80b..d918e24 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -30,7 +30,7 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
 #include <dspbridge/list.h>
-#include <dspbridge/mem.h>
+#include <dspbridge/memdefs.h>
 #include <dspbridge/proc.h>
 #include <dspbridge/strm.h>
 #include <dspbridge/sync.h>
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 1c3a86e..b85a90f 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -30,7 +30,6 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
 #include <dspbridge/list.h>
-#include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/sync.h>
 /*  ----------------------------------- Mini Driver */
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index 8553371..ac721da 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -47,7 +47,6 @@

 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/list.h>
-#include <dspbridge/mem.h>

 /*  ----------------------------------- This */
 #include <dspbridge/rmm.h>
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 0e328a1..d6f2012 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -28,7 +28,6 @@
 #include <dspbridge/dbc.h>

 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
 #include <dspbridge/sync.h>

 /*  ----------------------------------- Mini Driver */
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index a398dc4..cd2da67 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -27,9 +27,6 @@
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>

-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
-
 /*  ----------------------------------- This */
 #include <dspbridge/clk.h>

diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
deleted file mode 100644
index cf33e89..0000000
--- a/drivers/dsp/bridge/services/mem.c
+++ /dev/null
@@ -1,98 +0,0 @@
-/*
- * mem.c
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Implementation of platform specific memory services.
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
-/*  ----------------------------------- Host OS */
-#include <dspbridge/host_os.h>
-
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dspbridge/std.h>
-#include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
-
-/*  ----------------------------------- Trace & Debug */
-#include <dspbridge/dbc.h>
-
-/*  ----------------------------------- This */
-#include <dspbridge/mem.h>
-#include <dspbridge/list.h>
-
-/*  ----------------------------------- Defines */
-#define MEM512MB   0x1fffffff
-
-/*  ----------------------------------- Globals */
-
-
-/*
- *  ======== mem_alloc ========
- *  Purpose:
- *      Allocate memory from the paged or non-paged pools.
- */
-void *mem_alloc(u32 byte_size, enum mem_poolattrs type)
-{
-       void *mem = NULL;
-
-       if (byte_size > 0) {
-               switch (type) {
-               case MEM_NONPAGED:
-                       /* Fall through */
-               case MEM_PAGED:
-                       mem = kmalloc(byte_size,
-                                     (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
-                       break;
-               case MEM_LARGEVIRTMEM:
-                       mem = vmalloc(byte_size);
-                       break;
-
-               default:
-                       break;
-               }
-       }
-
-       return mem;
-}
-
-
-/*
- *  ======== mem_calloc ========
- *  Purpose:
- *      Allocate zero-initialized memory from the paged or non-paged pools.
- */
-void *mem_calloc(u32 byte_size, enum mem_poolattrs type)
-{
-       void *mem = NULL;
-
-       if (byte_size > 0) {
-               switch (type) {
-               case MEM_NONPAGED:
-                       /*  Fall through */
-               case MEM_PAGED:
-                       mem = kzalloc(byte_size,
-                                     (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
-                       break;
-               case MEM_LARGEVIRTMEM:
-                       mem = __vmalloc(byte_size,
-                                       GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO,
-                                       PAGE_KERNEL);
-                       break;
-               default:
-                       break;
-               }
-       }
-
-       return mem;
-}
diff --git a/drivers/dsp/bridge/services/reg.c b/drivers/dsp/bridge/services/reg.c
index e7f15cf..b5745ea 100644
--- a/drivers/dsp/bridge/services/reg.c
+++ b/drivers/dsp/bridge/services/reg.c
@@ -27,9 +27,6 @@
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>

-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
-
 /*  ----------------------------------- This */
 #include <dspbridge/reg.h>
 #include <regsup.h>
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 49b6fb9..96844fc 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -28,7 +28,6 @@
 #include <dspbridge/dbc.h>

 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
 #include <dspbridge/list.h>

 /*  ----------------------------------- This */
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index 49a0a89..1d7a0b2 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -27,7 +27,6 @@

 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/reg.h>
 #include <dspbridge/sync.h>
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index cd66b5a..1a5d84d 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -54,7 +54,6 @@
 #include <dspbridge/dbc.h>

 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
 #include <dspbridge/cfg.h>
 #include <dspbridge/sync.h>

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 6246327..885e25c 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -38,7 +38,6 @@

 /* Services Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/sync.h>
 #include <dspbridge/reg.h>
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index 824cda8..2b82818 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -26,7 +26,6 @@
 #include <dspbridge/dbc.h>

 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
 #include <dspbridge/drv.h>

 /*  ----------------------------------- Link Driver */
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index e4d5189..cf9c41a 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -26,7 +26,6 @@

 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/list.h>
-#include <dspbridge/mem.h>
 #include <dspbridge/sync.h>

 /*  ----------------------------------- Platform Manager */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index a3f2bdc..407e926 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -31,7 +31,6 @@
 #include <dspbridge/dbc.h>

 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
 #include <dspbridge/reg.h>
 #include <dspbridge/cfg.h>
 #include <dspbridge/drv.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index c15f0c9..004c246 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -23,9 +23,6 @@
 #include <dspbridge/drv.h>
 #include <dspbridge/io_sm.h>

-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
-
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/brddefs.h>
 #include <dspbridge/dev.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index 0755ca7..03e1028 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -28,7 +28,6 @@
 #include <dspbridge/drv.h>

 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
 #include <dspbridge/cfg.h>
 #include <dspbridge/wdt.h>

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index ca81c68..f10d185 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -29,7 +29,6 @@

 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/drv.h>

--
1.7.0.3
