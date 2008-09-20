From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 05/06][omapzoom] BRIDGE: Fix header path name to
 "arch/arm/plat-omap/include/dspbridge"
Date: Fri, 19 Sep 2008 21:07:53 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5344B3DCD7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50615 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYITCIA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 22:08:00 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8K27sPm013714
	for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 21:07:59 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8K27sLv016329
	for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 21:07:54 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Fri, 19 Sep 2008 19:18:15 -0500
Subject: [PATCH] BRIDGE: Fix header path name to "arch/arm/plat-omap/include/dspbridge"

sed -i -e \
's@arch/arm/plat-omap/include/bridge@arch/arm/plat-omap/include/dspbridge@g' \
drivers/dsp/bridge/Kbuild \
drivers/dsp/bridge/*/*.[ch] \
arch/arm/plat-omap/include/dspbridge/*.h

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl_sm.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/dmm.h         |    2 +-
 arch/arm/plat-omap/include/dspbridge/dpc.h         |    2 +-
 arch/arm/plat-omap/include/dspbridge/drv.h         |    2 +-
 arch/arm/plat-omap/include/dspbridge/drvdefs.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/dspdrv.h      |    2 +-
 .../plat-omap/include/dspbridge/dynamic_loader.h   |    2 +-
 arch/arm/plat-omap/include/dspbridge/errbase.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/gb.h          |    2 +-
 arch/arm/plat-omap/include/dspbridge/getsection.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/gh.h          |    2 +-
 arch/arm/plat-omap/include/dspbridge/gs.h          |    2 +-
 arch/arm/plat-omap/include/dspbridge/gt.h          |    2 +-
 arch/arm/plat-omap/include/dspbridge/host_os.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/io.h          |    2 +-
 arch/arm/plat-omap/include/dspbridge/io_sm.h       |    2 +-
 arch/arm/plat-omap/include/dspbridge/iodefs.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/kfile.h       |    2 +-
 arch/arm/plat-omap/include/dspbridge/ldr.h         |    2 +-
 arch/arm/plat-omap/include/dspbridge/list.h        |    2 +-
 arch/arm/plat-omap/include/dspbridge/mbx_sh.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/mem.h         |    2 +-
 arch/arm/plat-omap/include/dspbridge/memdefs.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/mgr.h         |    2 +-
 arch/arm/plat-omap/include/dspbridge/mgrpriv.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/msg.h         |    2 +-
 arch/arm/plat-omap/include/dspbridge/msgdefs.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/nldr.h        |    2 +-
 arch/arm/plat-omap/include/dspbridge/nldrdefs.h    |    2 +-
 arch/arm/plat-omap/include/dspbridge/node.h        |    2 +-
 arch/arm/plat-omap/include/dspbridge/nodedefs.h    |    2 +-
 arch/arm/plat-omap/include/dspbridge/nodepriv.h    |    2 +-
 arch/arm/plat-omap/include/dspbridge/ntfy.h        |    2 +-
 arch/arm/plat-omap/include/dspbridge/prcs.h        |    2 +-
 arch/arm/plat-omap/include/dspbridge/proc.h        |    2 +-
 35 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
index da25fa7..6a97a7a 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
@@ -1,5 +1,5 @@
 /*
- * dspbridge/inc/chnl_sm.h
+ * dsplinux/arch/arm/plat-omap/include/dspbridge//chnl_sm.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/dmm.h b/arch/arm/plat-omap/include/dspbridge/dmm.h
index ea939ba..454e7e6 100644
--- a/arch/arm/plat-omap/include/dspbridge/dmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/dmm.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/dmm.h
+ * linux/arch/arm/plat-omap/include/dspbridge//dmm.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/dpc.h b/arch/arm/plat-omap/include/dspbridge/dpc.h
index 08167b4..9f367bd 100644
--- a/arch/arm/plat-omap/include/dspbridge/dpc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dpc.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/dpc.h
+ * linux/arch/arm/plat-omap/include/dspbridge//dpc.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 274afc4..5aa5756 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/drv.h
+ * linux/arch/arm/plat-omap/include/dspbridge//drv.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/drvdefs.h b/arch/arm/plat-omap/include/dspbridge/drvdefs.h
index 72297ee..d21ea40 100644
--- a/arch/arm/plat-omap/include/dspbridge/drvdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/drvdefs.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/drvdefs.h
+ * linux/arch/arm/plat-omap/include/dspbridge//drvdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdrv.h b/arch/arm/plat-omap/include/dspbridge/dspdrv.h
index 6581a07..42cebb8 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdrv.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdrv.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/dspdrv.h
+ * linux/arch/arm/plat-omap/include/dspbridge//dspdrv.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/dynamic_loader.h b/arch/arm/plat-omap/include/dspbridge/dynamic_loader.h
index 2301331..0723684 100644
--- a/arch/arm/plat-omap/include/dspbridge/dynamic_loader.h
+++ b/arch/arm/plat-omap/include/dspbridge/dynamic_loader.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/dynamic_loader.h
+ * linux/arch/arm/plat-omap/include/dspbridge//dynamic_loader.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 4cdc26c..b90a3bd 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/errbase.h
+ * linux/arch/arm/plat-omap/include/dspbridge//errbase.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/gb.h b/arch/arm/plat-omap/include/dspbridge/gb.h
index 4c7b5ed..ec41363 100644
--- a/arch/arm/plat-omap/include/dspbridge/gb.h
+++ b/arch/arm/plat-omap/include/dspbridge/gb.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/gb.h
+ * linux/arch/arm/plat-omap/include/dspbridge//gb.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/getsection.h b/arch/arm/plat-omap/include/dspbridge/getsection.h
index d2eeb52..cd3c91d 100644
--- a/arch/arm/plat-omap/include/dspbridge/getsection.h
+++ b/arch/arm/plat-omap/include/dspbridge/getsection.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/getsection.h
+ * linux/arch/arm/plat-omap/include/dspbridge//getsection.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/gh.h b/arch/arm/plat-omap/include/dspbridge/gh.h
index 91fedfe..f51e3a2 100644
--- a/arch/arm/plat-omap/include/dspbridge/gh.h
+++ b/arch/arm/plat-omap/include/dspbridge/gh.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/gh.h
+ * linux/arch/arm/plat-omap/include/dspbridge//gh.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/gs.h b/arch/arm/plat-omap/include/dspbridge/gs.h
index a4d6fff..6aa47c0 100644
--- a/arch/arm/plat-omap/include/dspbridge/gs.h
+++ b/arch/arm/plat-omap/include/dspbridge/gs.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/gs.h
+ * linux/arch/arm/plat-omap/include/dspbridge//gs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/gt.h b/arch/arm/plat-omap/include/dspbridge/gt.h
index 47e6b5f..054cf4c 100644
--- a/arch/arm/plat-omap/include/dspbridge/gt.h
+++ b/arch/arm/plat-omap/include/dspbridge/gt.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/gt.h
+ * linux/arch/arm/plat-omap/include/dspbridge//gt.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index edbfe7e..7d90cdc 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/host_os.h
+ * linux/arch/arm/plat-omap/include/dspbridge//host_os.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/io.h b/arch/arm/plat-omap/include/dspbridge/io.h
index 1fb959b..63a71a7 100644
--- a/arch/arm/plat-omap/include/dspbridge/io.h
+++ b/arch/arm/plat-omap/include/dspbridge/io.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/io.h
+ * linux/arch/arm/plat-omap/include/dspbridge//io.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index cabce3b..c353c30 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/io_sm.h
+ * linux/arch/arm/plat-omap/include/dspbridge//io_sm.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/iodefs.h b/arch/arm/plat-omap/include/dspbridge/iodefs.h
index 1cadeaf..e27038a 100644
--- a/arch/arm/plat-omap/include/dspbridge/iodefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/iodefs.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/iodefs.h
+ * linux/arch/arm/plat-omap/include/dspbridge//iodefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/kfile.h b/arch/arm/plat-omap/include/dspbridge/kfile.h
index 9a741be..cc5956e 100644
--- a/arch/arm/plat-omap/include/dspbridge/kfile.h
+++ b/arch/arm/plat-omap/include/dspbridge/kfile.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/kfile.h
+ * linux/arch/arm/plat-omap/include/dspbridge//kfile.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/ldr.h b/arch/arm/plat-omap/include/dspbridge/ldr.h
index 7050be4..e20ddf3 100644
--- a/arch/arm/plat-omap/include/dspbridge/ldr.h
+++ b/arch/arm/plat-omap/include/dspbridge/ldr.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/ldr.h
+ * linux/arch/arm/plat-omap/include/dspbridge//ldr.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/list.h b/arch/arm/plat-omap/include/dspbridge/list.h
index b37d7a6..caeb8d9 100644
--- a/arch/arm/plat-omap/include/dspbridge/list.h
+++ b/arch/arm/plat-omap/include/dspbridge/list.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/list.h
+ * linux/arch/arm/plat-omap/include/dspbridge//list.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/mbx_sh.h b/arch/arm/plat-omap/include/dspbridge/mbx_sh.h
index f0cbb85..e8ac73c 100644
--- a/arch/arm/plat-omap/include/dspbridge/mbx_sh.h
+++ b/arch/arm/plat-omap/include/dspbridge/mbx_sh.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/mbx_sh.h
+ * linux/arch/arm/plat-omap/include/dspbridge//mbx_sh.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index ffb3ec3..1c77cd0 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/mem.h
+ * linux/arch/arm/plat-omap/include/dspbridge//mem.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/memdefs.h b/arch/arm/plat-omap/include/dspbridge/memdefs.h
index 066c8cd..c35379a 100644
--- a/arch/arm/plat-omap/include/dspbridge/memdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/memdefs.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/memdefs.h
+ * linux/arch/arm/plat-omap/include/dspbridge//memdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/mgr.h b/arch/arm/plat-omap/include/dspbridge/mgr.h
index 1fd6fef..1a532c2 100644
--- a/arch/arm/plat-omap/include/dspbridge/mgr.h
+++ b/arch/arm/plat-omap/include/dspbridge/mgr.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/mgr.h
+ * linux/arch/arm/plat-omap/include/dspbridge//mgr.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/mgrpriv.h b/arch/arm/plat-omap/include/dspbridge/mgrpriv.h
index 55e0d48..e93bd0a 100644
--- a/arch/arm/plat-omap/include/dspbridge/mgrpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/mgrpriv.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/mgrpriv.h
+ * linux/arch/arm/plat-omap/include/dspbridge//mgrpriv.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/msg.h b/arch/arm/plat-omap/include/dspbridge/msg.h
index 44375d6..7a109a5 100644
--- a/arch/arm/plat-omap/include/dspbridge/msg.h
+++ b/arch/arm/plat-omap/include/dspbridge/msg.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/msg.h
+ * linux/arch/arm/plat-omap/include/dspbridge//msg.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/msgdefs.h b/arch/arm/plat-omap/include/dspbridge/msgdefs.h
index 22b38e8..25168d7 100644
--- a/arch/arm/plat-omap/include/dspbridge/msgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/msgdefs.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/msgdefs.h
+ * linux/arch/arm/plat-omap/include/dspbridge//msgdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/nldr.h b/arch/arm/plat-omap/include/dspbridge/nldr.h
index b091337..19896c5 100644
--- a/arch/arm/plat-omap/include/dspbridge/nldr.h
+++ b/arch/arm/plat-omap/include/dspbridge/nldr.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/nldr.h
+ * linux/arch/arm/plat-omap/include/dspbridge//nldr.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
index d7436e8..2b1dadd 100644
--- a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/nldrdefs.h
+ * linux/arch/arm/plat-omap/include/dspbridge//nldrdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index c683e47..5b9a8bd 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/node.h
+ * linux/arch/arm/plat-omap/include/dspbridge//node.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/nodedefs.h b/arch/arm/plat-omap/include/dspbridge/nodedefs.h
index a943bd1..04b2ef1 100644
--- a/arch/arm/plat-omap/include/dspbridge/nodedefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/nodedefs.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/nodedefs.h
+ * linux/arch/arm/plat-omap/include/dspbridge//nodedefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/nodepriv.h b/arch/arm/plat-omap/include/dspbridge/nodepriv.h
index cb93389..c1440a0 100644
--- a/arch/arm/plat-omap/include/dspbridge/nodepriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/nodepriv.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/nodepriv.h
+ * linux/arch/arm/plat-omap/include/dspbridge//nodepriv.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/ntfy.h b/arch/arm/plat-omap/include/dspbridge/ntfy.h
index 3e99a85..8d6c2c8 100644
--- a/arch/arm/plat-omap/include/dspbridge/ntfy.h
+++ b/arch/arm/plat-omap/include/dspbridge/ntfy.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/ntfy.h
+ * linux/arch/arm/plat-omap/include/dspbridge//ntfy.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/prcs.h b/arch/arm/plat-omap/include/dspbridge/prcs.h
index 5240449..c211e1c 100644
--- a/arch/arm/plat-omap/include/dspbridge/prcs.h
+++ b/arch/arm/plat-omap/include/dspbridge/prcs.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/prcs.h
+ * linux/arch/arm/plat-omap/include/dspbridge//prcs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index ba256eb..0515bfc 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -1,5 +1,5 @@
 /*
- * bridge/inc/proc.h
+ * linux/arch/arm/plat-omap/include/dspbridge//proc.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
--
1.6.0

