From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 03/06][omapzoom] BRIDGE Moving header files to a proper
 location
Date: Fri, 19 Sep 2008 21:07:23 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5344B3DCD5@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50599 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbYITCHb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 22:07:31 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8K27Po5013442
	for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 21:07:30 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8K27PhM016251
	for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 21:07:25 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Omar Ramirez Luna <x0084701@ti.com>
Date: Fri, 19 Sep 2008 17:26:55 -0500
Subject: [PATCH] BRIDGE Moving header files to a proper location

Moving header files and fixing path references.

        mach/bridge => dspbridge


Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---
 .../include/{mach/bridge => dspbridge}/_chnl_sm.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/_dcd.h      |    2 +-
 .../include/{mach/bridge => dspbridge}/brddefs.h   |    2 +-
 .../include/{mach/bridge => dspbridge}/cfg.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/cfgdefs.h   |    2 +-
 .../include/{mach/bridge => dspbridge}/chnl.h      |    2 +-
 .../include/{mach/bridge => dspbridge}/chnl_sm.h   |    0
 .../include/{mach/bridge => dspbridge}/chnldefs.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/chnlpriv.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/clk.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/cmm.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/cmmdefs.h   |    2 +-
 .../include/{mach/bridge => dspbridge}/cod.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/csl.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/dbc.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/dbdcd.h     |    2 +-
 .../include/{mach/bridge => dspbridge}/dbdcddef.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/dbdefs.h    |    2 +-
 .../include/{mach/bridge => dspbridge}/dbg.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/dbldefs.h   |    2 +-
 .../include/{mach/bridge => dspbridge}/dbll.h      |    2 +-
 .../include/{mach/bridge => dspbridge}/dblldefs.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/dbof.h      |    2 +-
 .../include/{mach/bridge => dspbridge}/dbreg.h     |    2 +-
 .../include/{mach/bridge => dspbridge}/dbtype.h    |    2 +-
 .../include/{mach/bridge => dspbridge}/dehdefs.h   |    2 +-
 .../include/{mach/bridge => dspbridge}/dev.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/devdefs.h   |    2 +-
 .../include/{mach/bridge => dspbridge}/disp.h      |    2 +-
 .../include/{mach/bridge => dspbridge}/dispdefs.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/dmm.h       |    0
 .../include/{mach/bridge => dspbridge}/dpc.h       |    0
 .../include/{mach/bridge => dspbridge}/drv.h       |    0
 .../include/{mach/bridge => dspbridge}/drvdefs.h   |    0
 .../include/{mach/bridge => dspbridge}/dspdrv.h    |    0
 .../{mach/bridge => dspbridge}/dynamic_loader.h    |    0
 .../include/{mach/bridge => dspbridge}/errbase.h   |    0
 .../include/{mach/bridge => dspbridge}/gb.h        |    0
 .../{mach/bridge => dspbridge}/getsection.h        |    0
 .../include/{mach/bridge => dspbridge}/gh.h        |    0
 .../include/{mach/bridge => dspbridge}/gs.h        |    0
 .../include/{mach/bridge => dspbridge}/gt.h        |    0
 .../include/{mach/bridge => dspbridge}/host_os.h   |    0
 .../include/{mach/bridge => dspbridge}/io.h        |    0
 .../include/{mach/bridge => dspbridge}/io_sm.h     |    0
 .../include/{mach/bridge => dspbridge}/iodefs.h    |    0
 .../include/{mach/bridge => dspbridge}/kfile.h     |    0
 .../include/{mach/bridge => dspbridge}/ldr.h       |    0
 .../include/{mach/bridge => dspbridge}/list.h      |    0
 .../include/{mach/bridge => dspbridge}/mbx_sh.h    |    0
 .../include/{mach/bridge => dspbridge}/mem.h       |    0
 .../include/{mach/bridge => dspbridge}/memdefs.h   |    0
 .../include/{mach/bridge => dspbridge}/mgr.h       |    0
 .../include/{mach/bridge => dspbridge}/mgrpriv.h   |    0
 .../include/{mach/bridge => dspbridge}/msg.h       |    0
 .../include/{mach/bridge => dspbridge}/msgdefs.h   |    0
 .../include/{mach/bridge => dspbridge}/nldr.h      |    0
 .../include/{mach/bridge => dspbridge}/nldrdefs.h  |    0
 .../include/{mach/bridge => dspbridge}/node.h      |    0
 .../include/{mach/bridge => dspbridge}/nodedefs.h  |    0
 .../include/{mach/bridge => dspbridge}/nodepriv.h  |    0
 .../include/{mach/bridge => dspbridge}/ntfy.h      |    0
 .../include/{mach/bridge => dspbridge}/prcs.h      |    0
 .../include/{mach/bridge => dspbridge}/proc.h      |    0
 .../include/{mach/bridge => dspbridge}/procpriv.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/pwr.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/pwr_sh.h    |    2 +-
 .../include/{mach/bridge => dspbridge}/reg.h       |    2 +-
 .../{mach/bridge => dspbridge}/resourcecleanup.h   |    2 +-
 .../include/{mach/bridge => dspbridge}/rmm.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/rms_sh.h    |    2 +-
 .../include/{mach/bridge => dspbridge}/rmstypes.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/services.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/std.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/strm.h      |    2 +-
 .../include/{mach/bridge => dspbridge}/strmdefs.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/sync.h      |    2 +-
 .../include/{mach/bridge => dspbridge}/util.h      |    2 +-
 .../include/{mach/bridge => dspbridge}/utildefs.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/uuidutil.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/wcd.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/wcdioctl.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/wmd.h       |    2 +-
 .../include/{mach/bridge => dspbridge}/wmdchnl.h   |    2 +-
 .../include/{mach/bridge => dspbridge}/wmddeh.h    |    2 +-
 .../include/{mach/bridge => dspbridge}/wmdio.h     |    2 +-
 .../include/{mach/bridge => dspbridge}/wmdioctl.h  |    2 +-
 .../include/{mach/bridge => dspbridge}/wmdmsg.h    |    2 +-
 drivers/dsp/bridge/Kbuild                          |    2 +-
 89 files changed, 54 insertions(+), 54 deletions(-)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/_chnl_sm.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/_dcd.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/brddefs.h (97%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/cfg.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/cfgdefs.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/chnl.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/chnl_sm.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/chnldefs.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/chnlpriv.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/clk.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/cmm.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/cmmdefs.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/cod.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/csl.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dbc.h (97%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dbdcd.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dbdcddef.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dbdefs.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dbg.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dbldefs.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dbll.h (97%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dblldefs.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dbof.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dbreg.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dbtype.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dehdefs.h (95%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dev.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/devdefs.h (94%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/disp.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dispdefs.h (95%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dmm.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dpc.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/drv.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/drvdefs.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dspdrv.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/dynamic_loader.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/errbase.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/gb.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/getsection.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/gh.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/gs.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/gt.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/host_os.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/io.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/io_sm.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/iodefs.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/kfile.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/ldr.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/list.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/mbx_sh.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/mem.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/memdefs.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/mgr.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/mgrpriv.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/msg.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/msgdefs.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/nldr.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/nldrdefs.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/node.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/nodedefs.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/nodepriv.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/ntfy.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/prcs.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/proc.h (100%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/procpriv.h (94%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/pwr.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/pwr_sh.h (95%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/reg.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/resourcecleanup.h (97%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/rmm.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/rms_sh.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/rmstypes.h (95%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/services.h (96%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/std.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/strm.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/strmdefs.h (96%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/sync.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/util.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/utildefs.h (96%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/uuidutil.h (97%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/wcd.h (97%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/wcdioctl.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/wmd.h (99%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/wmdchnl.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/wmddeh.h (97%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/wmdio.h (96%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/wmdioctl.h (98%)
 rename arch/arm/plat-omap/include/{mach/bridge => dspbridge}/wmdmsg.h (97%)

diff --git a/arch/arm/plat-omap/include/mach/bridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/_chnl_sm.h
rename to arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 0b76572..5dfc892 100644
--- a/arch/arm/plat-omap/include/mach/bridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/_chnl_sm.h
+ * arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/_dcd.h b/arch/arm/plat-omap/include/dspbridge/_dcd.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/_dcd.h
rename to arch/arm/plat-omap/include/dspbridge/_dcd.h
index 42b62ac..823a4f7 100644
--- a/arch/arm/plat-omap/include/mach/bridge/_dcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/_dcd.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/_dcd.h
+ * arch/arm/plat-omap/include/dspbridge/_dcd.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/brddefs.h b/arch/arm/plat-omap/include/dspbridge/brddefs.h
similarity index 97%
rename from arch/arm/plat-omap/include/mach/bridge/brddefs.h
rename to arch/arm/plat-omap/include/dspbridge/brddefs.h
index 99f373b..c9a4b25 100644
--- a/arch/arm/plat-omap/include/mach/bridge/brddefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/brddefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/brddefs.h
+ * arch/arm/plat-omap/include/dspbridge/brddefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/cfg.h b/arch/arm/plat-omap/include/dspbridge/cfg.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/cfg.h
rename to arch/arm/plat-omap/include/dspbridge/cfg.h
index 84aed9c..7335702 100644
--- a/arch/arm/plat-omap/include/mach/bridge/cfg.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfg.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/cfg.h
+ * arch/arm/plat-omap/include/dspbridge/cfg.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/cfgdefs.h
rename to arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index 7cdd68a..48217d3 100644
--- a/arch/arm/plat-omap/include/mach/bridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/cfgdefs.h
+ * arch/arm/plat-omap/include/dspbridge/cfgdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/chnl.h
rename to arch/arm/plat-omap/include/dspbridge/chnl.h
index 3c0ad76..954e617 100644
--- a/arch/arm/plat-omap/include/mach/bridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/chnl.h
+ * arch/arm/plat-omap/include/dspbridge/chnl.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/chnl_sm.h
rename to arch/arm/plat-omap/include/dspbridge/chnl_sm.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/chnldefs.h b/arch/arm/plat-omap/include/dspbridge/chnldefs.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/chnldefs.h
rename to arch/arm/plat-omap/include/dspbridge/chnldefs.h
index 370d4d3..9c246ae 100644
--- a/arch/arm/plat-omap/include/mach/bridge/chnldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnldefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/chnldefs.h
+ * arch/arm/plat-omap/include/dspbridge/chnldefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/chnlpriv.h b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/chnlpriv.h
rename to arch/arm/plat-omap/include/dspbridge/chnlpriv.h
index 319401e..e528960 100644
--- a/arch/arm/plat-omap/include/mach/bridge/chnlpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/chnlpriv.h
+ * arch/arm/plat-omap/include/dspbridge/chnlpriv.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/clk.h
rename to arch/arm/plat-omap/include/dspbridge/clk.h
index a3f490f..95e899b 100644
--- a/arch/arm/plat-omap/include/mach/bridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/clk.h
+ * arch/arm/plat-omap/include/dspbridge/clk.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/cmm.h b/arch/arm/plat-omap/include/dspbridge/cmm.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/cmm.h
rename to arch/arm/plat-omap/include/dspbridge/cmm.h
index 5bc1ca5..bb87979 100644
--- a/arch/arm/plat-omap/include/mach/bridge/cmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/cmm.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/cmm.h
+ * arch/arm/plat-omap/include/dspbridge/cmm.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/cmmdefs.h b/arch/arm/plat-omap/include/dspbridge/cmmdefs.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/cmmdefs.h
rename to arch/arm/plat-omap/include/dspbridge/cmmdefs.h
index ee5ca87..978e248 100644
--- a/arch/arm/plat-omap/include/mach/bridge/cmmdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cmmdefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/cmmdefs.h
+ * arch/arm/plat-omap/include/dspbridge/cmmdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/cod.h b/arch/arm/plat-omap/include/dspbridge/cod.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/cod.h
rename to arch/arm/plat-omap/include/dspbridge/cod.h
index a56789a..0cdb3e2 100644
--- a/arch/arm/plat-omap/include/mach/bridge/cod.h
+++ b/arch/arm/plat-omap/include/dspbridge/cod.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/cod.h
+ * arch/arm/plat-omap/include/dspbridge/cod.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/csl.h b/arch/arm/plat-omap/include/dspbridge/csl.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/csl.h
rename to arch/arm/plat-omap/include/dspbridge/csl.h
index a2f31a2..3152e0d 100644
--- a/arch/arm/plat-omap/include/mach/bridge/csl.h
+++ b/arch/arm/plat-omap/include/dspbridge/csl.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/csl.h
+ * arch/arm/plat-omap/include/dspbridge/csl.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
similarity index 97%
rename from arch/arm/plat-omap/include/mach/bridge/dbc.h
rename to arch/arm/plat-omap/include/dspbridge/dbc.h
index 78e9dbe..c92a05f 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dbc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dbc.h
+ * arch/arm/plat-omap/include/dspbridge/dbc.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dbdcd.h b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/dbdcd.h
rename to arch/arm/plat-omap/include/dspbridge/dbdcd.h
index cd5326c..4f3854d 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dbdcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dbdcd.h
+ * arch/arm/plat-omap/include/dspbridge/dbdcd.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dbdcddef.h b/arch/arm/plat-omap/include/dspbridge/dbdcddef.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/dbdcddef.h
rename to arch/arm/plat-omap/include/dspbridge/dbdcddef.h
index 13b7e04..562b6a0 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dbdcddef.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdcddef.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dbdcddef.h
+ * arch/arm/plat-omap/include/dspbridge/dbdcddef.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/dbdefs.h
rename to arch/arm/plat-omap/include/dspbridge/dbdefs.h
index b8350ec..66f3da4 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dbdefs.h
+ * arch/arm/plat-omap/include/dspbridge/dbdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dbg.h b/arch/arm/plat-omap/include/dspbridge/dbg.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/dbg.h
rename to arch/arm/plat-omap/include/dspbridge/dbg.h
index 0cf6bce..079c41b 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dbg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbg.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dbg.h
+ * arch/arm/plat-omap/include/dspbridge/dbg.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dbldefs.h b/arch/arm/plat-omap/include/dspbridge/dbldefs.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/dbldefs.h
rename to arch/arm/plat-omap/include/dspbridge/dbldefs.h
index b25fd1c..a53914d 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dbldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbldefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dbldefs.h
+ * arch/arm/plat-omap/include/dspbridge/dbldefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dbll.h b/arch/arm/plat-omap/include/dspbridge/dbll.h
similarity index 97%
rename from arch/arm/plat-omap/include/mach/bridge/dbll.h
rename to arch/arm/plat-omap/include/dspbridge/dbll.h
index 461397c..3062055 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dbll.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbll.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dbll.h
+ * arch/arm/plat-omap/include/dspbridge/dbll.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dblldefs.h b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/dblldefs.h
rename to arch/arm/plat-omap/include/dspbridge/dblldefs.h
index 8d392f8..b03a1dc 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dblldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dblldefs.h
+ * arch/arm/plat-omap/include/dspbridge/dblldefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dbof.h b/arch/arm/plat-omap/include/dspbridge/dbof.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/dbof.h
rename to arch/arm/plat-omap/include/dspbridge/dbof.h
index 6c05b3f..ceca3e0 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dbof.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbof.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dbof.h
+ * arch/arm/plat-omap/include/dspbridge/dbof.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dbreg.h b/arch/arm/plat-omap/include/dspbridge/dbreg.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/dbreg.h
rename to arch/arm/plat-omap/include/dspbridge/dbreg.h
index c3784cc..1149682 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dbreg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbreg.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dbreg.h
+ * arch/arm/plat-omap/include/dspbridge/dbreg.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dbtype.h b/arch/arm/plat-omap/include/dspbridge/dbtype.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/dbtype.h
rename to arch/arm/plat-omap/include/dspbridge/dbtype.h
index eaadfba..57e9a62 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dbtype.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbtype.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dbtype.h
+ * arch/arm/plat-omap/include/dspbridge/dbtype.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dehdefs.h b/arch/arm/plat-omap/include/dspbridge/dehdefs.h
similarity index 95%
rename from arch/arm/plat-omap/include/mach/bridge/dehdefs.h
rename to arch/arm/plat-omap/include/dspbridge/dehdefs.h
index 47139ae..4887f54 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dehdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dehdefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dehdefs.h
+ * arch/arm/plat-omap/include/dspbridge/dehdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/dev.h
rename to arch/arm/plat-omap/include/dspbridge/dev.h
index 8a97bca..acc688b 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dev.h
+ * arch/arm/plat-omap/include/dspbridge/dev.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/devdefs.h b/arch/arm/plat-omap/include/dspbridge/devdefs.h
similarity index 94%
rename from arch/arm/plat-omap/include/mach/bridge/devdefs.h
rename to arch/arm/plat-omap/include/dspbridge/devdefs.h
index 3900379..08f0227 100644
--- a/arch/arm/plat-omap/include/mach/bridge/devdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/devdefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/devdefs.h
+ * arch/arm/plat-omap/include/dspbridge/devdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/disp.h b/arch/arm/plat-omap/include/dspbridge/disp.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/disp.h
rename to arch/arm/plat-omap/include/dspbridge/disp.h
index d78b355..7b1d4e0 100644
--- a/arch/arm/plat-omap/include/mach/bridge/disp.h
+++ b/arch/arm/plat-omap/include/dspbridge/disp.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/disp.h
+ * arch/arm/plat-omap/include/dspbridge/disp.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dispdefs.h b/arch/arm/plat-omap/include/dspbridge/dispdefs.h
similarity index 95%
rename from arch/arm/plat-omap/include/mach/bridge/dispdefs.h
rename to arch/arm/plat-omap/include/dspbridge/dispdefs.h
index c69f58e..125fef3 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dispdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dispdefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/dispdefs.h
+ * arch/arm/plat-omap/include/dspbridge/dispdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/dmm.h b/arch/arm/plat-omap/include/dspbridge/dmm.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/dmm.h
rename to arch/arm/plat-omap/include/dspbridge/dmm.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/dpc.h b/arch/arm/plat-omap/include/dspbridge/dpc.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/dpc.h
rename to arch/arm/plat-omap/include/dspbridge/dpc.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/drv.h
rename to arch/arm/plat-omap/include/dspbridge/drv.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/drvdefs.h b/arch/arm/plat-omap/include/dspbridge/drvdefs.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/drvdefs.h
rename to arch/arm/plat-omap/include/dspbridge/drvdefs.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/dspdrv.h b/arch/arm/plat-omap/include/dspbridge/dspdrv.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/dspdrv.h
rename to arch/arm/plat-omap/include/dspbridge/dspdrv.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/dynamic_loader.h b/arch/arm/plat-omap/include/dspbridge/dynamic_loader.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/dynamic_loader.h
rename to arch/arm/plat-omap/include/dspbridge/dynamic_loader.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/errbase.h
rename to arch/arm/plat-omap/include/dspbridge/errbase.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/gb.h b/arch/arm/plat-omap/include/dspbridge/gb.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/gb.h
rename to arch/arm/plat-omap/include/dspbridge/gb.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/getsection.h b/arch/arm/plat-omap/include/dspbridge/getsection.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/getsection.h
rename to arch/arm/plat-omap/include/dspbridge/getsection.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/gh.h b/arch/arm/plat-omap/include/dspbridge/gh.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/gh.h
rename to arch/arm/plat-omap/include/dspbridge/gh.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/gs.h b/arch/arm/plat-omap/include/dspbridge/gs.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/gs.h
rename to arch/arm/plat-omap/include/dspbridge/gs.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/gt.h b/arch/arm/plat-omap/include/dspbridge/gt.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/gt.h
rename to arch/arm/plat-omap/include/dspbridge/gt.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/host_os.h
rename to arch/arm/plat-omap/include/dspbridge/host_os.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/io.h b/arch/arm/plat-omap/include/dspbridge/io.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/io.h
rename to arch/arm/plat-omap/include/dspbridge/io.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/io_sm.h
rename to arch/arm/plat-omap/include/dspbridge/io_sm.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/iodefs.h b/arch/arm/plat-omap/include/dspbridge/iodefs.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/iodefs.h
rename to arch/arm/plat-omap/include/dspbridge/iodefs.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/kfile.h b/arch/arm/plat-omap/include/dspbridge/kfile.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/kfile.h
rename to arch/arm/plat-omap/include/dspbridge/kfile.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/ldr.h b/arch/arm/plat-omap/include/dspbridge/ldr.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/ldr.h
rename to arch/arm/plat-omap/include/dspbridge/ldr.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/list.h b/arch/arm/plat-omap/include/dspbridge/list.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/list.h
rename to arch/arm/plat-omap/include/dspbridge/list.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/mbx_sh.h b/arch/arm/plat-omap/include/dspbridge/mbx_sh.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/mbx_sh.h
rename to arch/arm/plat-omap/include/dspbridge/mbx_sh.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/mem.h
rename to arch/arm/plat-omap/include/dspbridge/mem.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/memdefs.h b/arch/arm/plat-omap/include/dspbridge/memdefs.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/memdefs.h
rename to arch/arm/plat-omap/include/dspbridge/memdefs.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/mgr.h b/arch/arm/plat-omap/include/dspbridge/mgr.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/mgr.h
rename to arch/arm/plat-omap/include/dspbridge/mgr.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/mgrpriv.h b/arch/arm/plat-omap/include/dspbridge/mgrpriv.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/mgrpriv.h
rename to arch/arm/plat-omap/include/dspbridge/mgrpriv.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/msg.h b/arch/arm/plat-omap/include/dspbridge/msg.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/msg.h
rename to arch/arm/plat-omap/include/dspbridge/msg.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/msgdefs.h b/arch/arm/plat-omap/include/dspbridge/msgdefs.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/msgdefs.h
rename to arch/arm/plat-omap/include/dspbridge/msgdefs.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/nldr.h b/arch/arm/plat-omap/include/dspbridge/nldr.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/nldr.h
rename to arch/arm/plat-omap/include/dspbridge/nldr.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/nldrdefs.h b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/nldrdefs.h
rename to arch/arm/plat-omap/include/dspbridge/nldrdefs.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/node.h
rename to arch/arm/plat-omap/include/dspbridge/node.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/nodedefs.h b/arch/arm/plat-omap/include/dspbridge/nodedefs.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/nodedefs.h
rename to arch/arm/plat-omap/include/dspbridge/nodedefs.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/nodepriv.h b/arch/arm/plat-omap/include/dspbridge/nodepriv.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/nodepriv.h
rename to arch/arm/plat-omap/include/dspbridge/nodepriv.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/ntfy.h b/arch/arm/plat-omap/include/dspbridge/ntfy.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/ntfy.h
rename to arch/arm/plat-omap/include/dspbridge/ntfy.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/prcs.h b/arch/arm/plat-omap/include/dspbridge/prcs.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/prcs.h
rename to arch/arm/plat-omap/include/dspbridge/prcs.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/bridge/proc.h
rename to arch/arm/plat-omap/include/dspbridge/proc.h
diff --git a/arch/arm/plat-omap/include/mach/bridge/procpriv.h b/arch/arm/plat-omap/include/dspbridge/procpriv.h
similarity index 94%
rename from arch/arm/plat-omap/include/mach/bridge/procpriv.h
rename to arch/arm/plat-omap/include/dspbridge/procpriv.h
index 44b51fa..c9fb729 100644
--- a/arch/arm/plat-omap/include/mach/bridge/procpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/procpriv.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/procpriv.h
+ * arch/arm/plat-omap/include/dspbridge/procpriv.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/pwr.h b/arch/arm/plat-omap/include/dspbridge/pwr.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/pwr.h
rename to arch/arm/plat-omap/include/dspbridge/pwr.h
index c936a70..b6f22e0 100644
--- a/arch/arm/plat-omap/include/mach/bridge/pwr.h
+++ b/arch/arm/plat-omap/include/dspbridge/pwr.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/pwr.h
+ * arch/arm/plat-omap/include/dspbridge/pwr.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/pwr_sh.h b/arch/arm/plat-omap/include/dspbridge/pwr_sh.h
similarity index 95%
rename from arch/arm/plat-omap/include/mach/bridge/pwr_sh.h
rename to arch/arm/plat-omap/include/dspbridge/pwr_sh.h
index 244a8de..e7993c8 100644
--- a/arch/arm/plat-omap/include/mach/bridge/pwr_sh.h
+++ b/arch/arm/plat-omap/include/dspbridge/pwr_sh.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/pwr_sh.h
+ * arch/arm/plat-omap/include/dspbridge/pwr_sh.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/reg.h b/arch/arm/plat-omap/include/dspbridge/reg.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/reg.h
rename to arch/arm/plat-omap/include/dspbridge/reg.h
index 0657c8f..6e721f4 100644
--- a/arch/arm/plat-omap/include/mach/bridge/reg.h
+++ b/arch/arm/plat-omap/include/dspbridge/reg.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/reg.h
+ * arch/arm/plat-omap/include/dspbridge/reg.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
similarity index 97%
rename from arch/arm/plat-omap/include/mach/bridge/resourcecleanup.h
rename to arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index a8378a9..aa7fef0 100644
--- a/arch/arm/plat-omap/include/mach/bridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/resourcecleanup.h
+ * arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/rmm.h b/arch/arm/plat-omap/include/dspbridge/rmm.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/rmm.h
rename to arch/arm/plat-omap/include/dspbridge/rmm.h
index f637e1c..84e7313 100644
--- a/arch/arm/plat-omap/include/mach/bridge/rmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/rmm.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/rmm.h
+ * arch/arm/plat-omap/include/dspbridge/rmm.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/rms_sh.h b/arch/arm/plat-omap/include/dspbridge/rms_sh.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/rms_sh.h
rename to arch/arm/plat-omap/include/dspbridge/rms_sh.h
index 2671fac..d567a25 100644
--- a/arch/arm/plat-omap/include/mach/bridge/rms_sh.h
+++ b/arch/arm/plat-omap/include/dspbridge/rms_sh.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/rms_sh.h
+ * arch/arm/plat-omap/include/dspbridge/rms_sh.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/rmstypes.h b/arch/arm/plat-omap/include/dspbridge/rmstypes.h
similarity index 95%
rename from arch/arm/plat-omap/include/mach/bridge/rmstypes.h
rename to arch/arm/plat-omap/include/dspbridge/rmstypes.h
index 6f5888c..85769d4 100644
--- a/arch/arm/plat-omap/include/mach/bridge/rmstypes.h
+++ b/arch/arm/plat-omap/include/dspbridge/rmstypes.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/rmstypes.h
+ * arch/arm/plat-omap/include/dspbridge/rmstypes.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/services.h b/arch/arm/plat-omap/include/dspbridge/services.h
similarity index 96%
rename from arch/arm/plat-omap/include/mach/bridge/services.h
rename to arch/arm/plat-omap/include/dspbridge/services.h
index e192230..171f3cc 100644
--- a/arch/arm/plat-omap/include/mach/bridge/services.h
+++ b/arch/arm/plat-omap/include/dspbridge/services.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/services.h
+ * arch/arm/plat-omap/include/dspbridge/services.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/std.h b/arch/arm/plat-omap/include/dspbridge/std.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/std.h
rename to arch/arm/plat-omap/include/dspbridge/std.h
index f557bf9..260c944 100644
--- a/arch/arm/plat-omap/include/mach/bridge/std.h
+++ b/arch/arm/plat-omap/include/dspbridge/std.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/std.h
+ * arch/arm/plat-omap/include/dspbridge/std.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/strm.h
rename to arch/arm/plat-omap/include/dspbridge/strm.h
index 7cac09d..a27b659 100644
--- a/arch/arm/plat-omap/include/mach/bridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/strm.h
+ * arch/arm/plat-omap/include/dspbridge/strm.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/strmdefs.h b/arch/arm/plat-omap/include/dspbridge/strmdefs.h
similarity index 96%
rename from arch/arm/plat-omap/include/mach/bridge/strmdefs.h
rename to arch/arm/plat-omap/include/dspbridge/strmdefs.h
index 9142e5d..cd31cc2 100644
--- a/arch/arm/plat-omap/include/mach/bridge/strmdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/strmdefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/strmdefs.h
+ * arch/arm/plat-omap/include/dspbridge/strmdefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/sync.h b/arch/arm/plat-omap/include/dspbridge/sync.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/sync.h
rename to arch/arm/plat-omap/include/dspbridge/sync.h
index dedd42a..ea8ea3f 100644
--- a/arch/arm/plat-omap/include/mach/bridge/sync.h
+++ b/arch/arm/plat-omap/include/dspbridge/sync.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/sync.h
+ * arch/arm/plat-omap/include/dspbridge/sync.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/util.h b/arch/arm/plat-omap/include/dspbridge/util.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/util.h
rename to arch/arm/plat-omap/include/dspbridge/util.h
index 3152507..f4d6c69 100644
--- a/arch/arm/plat-omap/include/mach/bridge/util.h
+++ b/arch/arm/plat-omap/include/dspbridge/util.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/util.h
+ * arch/arm/plat-omap/include/dspbridge/util.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/utildefs.h b/arch/arm/plat-omap/include/dspbridge/utildefs.h
similarity index 96%
rename from arch/arm/plat-omap/include/mach/bridge/utildefs.h
rename to arch/arm/plat-omap/include/dspbridge/utildefs.h
index 7b7b6bf..f44cc19 100644
--- a/arch/arm/plat-omap/include/mach/bridge/utildefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/utildefs.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/utildefs.h
+ * arch/arm/plat-omap/include/dspbridge/utildefs.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/uuidutil.h b/arch/arm/plat-omap/include/dspbridge/uuidutil.h
similarity index 97%
rename from arch/arm/plat-omap/include/mach/bridge/uuidutil.h
rename to arch/arm/plat-omap/include/dspbridge/uuidutil.h
index 1e8155e..6563a9c 100644
--- a/arch/arm/plat-omap/include/mach/bridge/uuidutil.h
+++ b/arch/arm/plat-omap/include/dspbridge/uuidutil.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/uuidutil.h
+ * arch/arm/plat-omap/include/dspbridge/uuidutil.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/wcd.h b/arch/arm/plat-omap/include/dspbridge/wcd.h
similarity index 97%
rename from arch/arm/plat-omap/include/mach/bridge/wcd.h
rename to arch/arm/plat-omap/include/dspbridge/wcd.h
index 3b2ecd5..a1cda92 100644
--- a/arch/arm/plat-omap/include/mach/bridge/wcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcd.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/wcd.h
+ * arch/arm/plat-omap/include/dspbridge/wcd.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/wcdioctl.h
rename to arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index 4f4b875..5ffdcbc 100644
--- a/arch/arm/plat-omap/include/mach/bridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/wcdioctl.h
+ * arch/arm/plat-omap/include/dspbridge/wcdioctl.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/bridge/wmd.h
rename to arch/arm/plat-omap/include/dspbridge/wmd.h
index 2b91d3a..affab8c 100644
--- a/arch/arm/plat-omap/include/mach/bridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/wmd.h
+ * arch/arm/plat-omap/include/dspbridge/wmd.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/wmdchnl.h b/arch/arm/plat-omap/include/dspbridge/wmdchnl.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/wmdchnl.h
rename to arch/arm/plat-omap/include/dspbridge/wmdchnl.h
index 52725ce..8c85dc3 100644
--- a/arch/arm/plat-omap/include/mach/bridge/wmdchnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmdchnl.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/wmdchnl.h
+ * arch/arm/plat-omap/include/dspbridge/wmdchnl.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/wmddeh.h b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
similarity index 97%
rename from arch/arm/plat-omap/include/mach/bridge/wmddeh.h
rename to arch/arm/plat-omap/include/dspbridge/wmddeh.h
index 5a1680a..5c0fcb8 100644
--- a/arch/arm/plat-omap/include/mach/bridge/wmddeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/wmddeh.h
+ * arch/arm/plat-omap/include/dspbridge/wmddeh.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/wmdio.h b/arch/arm/plat-omap/include/dspbridge/wmdio.h
similarity index 96%
rename from arch/arm/plat-omap/include/mach/bridge/wmdio.h
rename to arch/arm/plat-omap/include/dspbridge/wmdio.h
index 0a22f00..bd71c3b 100644
--- a/arch/arm/plat-omap/include/mach/bridge/wmdio.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmdio.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/wmdio.h
+ * arch/arm/plat-omap/include/dspbridge/wmdio.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/wmdioctl.h b/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/bridge/wmdioctl.h
rename to arch/arm/plat-omap/include/dspbridge/wmdioctl.h
index 8834658..eac4737 100644
--- a/arch/arm/plat-omap/include/mach/bridge/wmdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/wmdioctl.h
+ * arch/arm/plat-omap/include/dspbridge/wmdioctl.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/arch/arm/plat-omap/include/mach/bridge/wmdmsg.h b/arch/arm/plat-omap/include/dspbridge/wmdmsg.h
similarity index 97%
rename from arch/arm/plat-omap/include/mach/bridge/wmdmsg.h
rename to arch/arm/plat-omap/include/dspbridge/wmdmsg.h
index 8ca23fd..14b40d6 100644
--- a/arch/arm/plat-omap/include/mach/bridge/wmdmsg.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmdmsg.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/bridge/wmdmsg.h
+ * arch/arm/plat-omap/include/dspbridge/wmdmsg.h
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
diff --git a/drivers/dsp/bridge/Kbuild b/drivers/dsp/bridge/Kbuild
index ab85d21..cc1ae72 100644
--- a/drivers/dsp/bridge/Kbuild
+++ b/drivers/dsp/bridge/Kbuild
@@ -37,5 +37,5 @@ ccflags-y += -Idrivers/dsp/bridge/services
 ccflags-y += -Idrivers/dsp/bridge/wmd
 ccflags-y += -Idrivers/dsp/bridge/pmgr
 ccflags-y += -Idrivers/dsp/bridge/rmgr
-ccflags-y += -Iarch/arm/plat-omap/include/mach/bridge
+ccflags-y += -Iarch/arm/plat-omap/include/dspbridge
 ccflags-y += -Idrivers/dsp/bridge/hw
--
1.6.0

