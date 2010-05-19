From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 4/4] DSPBRIDGE: Remove comments refering to "class driver"
Date: Wed, 19 May 2010 17:21:42 -0500
Message-ID: <1274307702-22637-5-git-send-email-ivan.gomez@ti.com>
References: <1274307702-22637-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58168 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215Ab0ESWaP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 18:30:15 -0400
In-Reply-To: <1274307702-22637-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

class-driver refers to the Windows Driver Model, and as this code is
specific to Linux then these comments are removed.

This is a complement of the patch series to remove code refering
to other OS.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h     |    2 +-
 .../arm/plat-omap/include/dspbridge/dspapi-ioctl.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/dspdefs.h     |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dspdrv.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/ldr.h         |    2 +-
 arch/arm/plat-omap/include/dspbridge/mgr.h         |    2 +-
 arch/arm/plat-omap/include/dspbridge/proc.h        |    2 +-
 drivers/dsp/bridge/pmgr/chnlobj.h                  |    2 +-
 drivers/dsp/bridge/pmgr/ioobj.h                    |    2 +-
 drivers/dsp/bridge/pmgr/msgobj.h                   |    2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index 6e6f609..38122db 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Global CFG constants and types, shared between class and Bridge driver.
+ * Global CFG constants and types, shared between DSP API and Bridge driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h b/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
index 1780855..89003d8 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
@@ -4,7 +4,7 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * Contains structures and commands that are used for interaction
- * between the DDSP API and class driver.
+ * between the DDSP API and Bridge driver.
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 0412050..68c80c7 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -6,7 +6,7 @@
  * Bridge driver entry point and interface function declarations.
  *
  * Notes:
- *   The Bridge class driver obtains it's function interface to
+ *   The DSP API obtains it's function interface to
  *   the Bridge driver via a call to bridge_drv_entry().
  *
  *   Bridge services exported to Bridge drivers are initialized by the
@@ -1036,8 +1036,8 @@ typedef void (*fxn_msg_setqueueid) (struct msg_queue *msg_queue_obj,
  *  Bridge Driver interface function table.
  *
  *  The information in this table is filled in by the specific Bridge driver,
- *  and copied into the 'Bridge class driver's own space.  If any interface
- *  function field is set to a value of NULL, then the class driver will
+ *  and copied into the DSP API's own space.  If any interface
+ *  function field is set to a value of NULL, then the DSP API will
  *  consider that function not implemented, and return the error code
  *  -ENOSYS when a Bridge driver client attempts to call that function.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdrv.h b/arch/arm/plat-omap/include/dspbridge/dspdrv.h
index 7ee1d98..2dd4f8b 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdrv.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdrv.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * This is the Stream Interface for the DDSP Class driver.
+ * This is the Stream Interface for the DSp API.
  * All Device operations are performed via DeviceIOControl.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
diff --git a/arch/arm/plat-omap/include/dspbridge/ldr.h b/arch/arm/plat-omap/include/dspbridge/ldr.h
index 38c616b..6a0269c 100644
--- a/arch/arm/plat-omap/include/dspbridge/ldr.h
+++ b/arch/arm/plat-omap/include/dspbridge/ldr.h
@@ -7,7 +7,7 @@
  *
  * Notes:
  *   This service is meant to be used by modules of the DSP/BIOS Bridge
- *   class driver.
+ *   driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/mgr.h b/arch/arm/plat-omap/include/dspbridge/mgr.h
index 1b42e84..40fa2aa 100644
--- a/arch/arm/plat-omap/include/dspbridge/mgr.h
+++ b/arch/arm/plat-omap/include/dspbridge/mgr.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * This is the Class driver RM module interface.
+ * This is the DSP API RM module interface.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 3546c80..bbb844a 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * This is the Class driver RM module interface.
+ * This is the DSP API RM module interface.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/drivers/dsp/bridge/pmgr/chnlobj.h b/drivers/dsp/bridge/pmgr/chnlobj.h
index 51c04f0..6795e0a 100644
--- a/drivers/dsp/bridge/pmgr/chnlobj.h
+++ b/drivers/dsp/bridge/pmgr/chnlobj.h
@@ -4,7 +4,7 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * Structure subcomponents of channel class library channel objects which
- * are exposed to class driver from Bridge driver.
+ * are exposed to DSP API from Bridge driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/drivers/dsp/bridge/pmgr/ioobj.h b/drivers/dsp/bridge/pmgr/ioobj.h
index 9fc706c..f46355f 100644
--- a/drivers/dsp/bridge/pmgr/ioobj.h
+++ b/drivers/dsp/bridge/pmgr/ioobj.h
@@ -4,7 +4,7 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * Structure subcomponents of channel class library IO objects which
- * are exposed to class driver from Bridge driver.
+ * are exposed to DSP API from Bridge driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/drivers/dsp/bridge/pmgr/msgobj.h b/drivers/dsp/bridge/pmgr/msgobj.h
index 7949800..14ca633 100644
--- a/drivers/dsp/bridge/pmgr/msgobj.h
+++ b/drivers/dsp/bridge/pmgr/msgobj.h
@@ -4,7 +4,7 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * Structure subcomponents of channel class library msg_ctrl objects which
- * are exposed to class driver from Bridge driver.
+ * are exposed to DSP API from Bridge driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
-- 
1.7.0.3

