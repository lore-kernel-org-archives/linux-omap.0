From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 07/11] DSPBRIDGE: Rename "wmd" directory by "core"
Date: Fri, 30 Apr 2010 19:45:47 -0500
Message-ID: <1272674751-21557-8-git-send-email-ivan.gomez@ti.com>
References: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56917 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757477Ab0EAAwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 20:52:55 -0400
In-Reply-To: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

Since "wmd" (windows mini driver) refers to Windows OS, then this
directory is renamed by "core"

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 drivers/dsp/bridge/Makefile                       |   10 +++++-----
 drivers/dsp/bridge/{wmd => core}/_cmm.h           |    0
 drivers/dsp/bridge/{wmd => core}/_deh.h           |    0
 drivers/dsp/bridge/{wmd => core}/_msg_sm.h        |    0
 drivers/dsp/bridge/{wmd => core}/_tiomap.h        |    0
 drivers/dsp/bridge/{wmd => core}/_tiomap_mmu.h    |    0
 drivers/dsp/bridge/{wmd => core}/_tiomap_pwr.h    |    0
 drivers/dsp/bridge/{wmd => core}/_tiomap_util.h   |    0
 drivers/dsp/bridge/{wmd => core}/chnl_sm.c        |    0
 drivers/dsp/bridge/{wmd => core}/io_sm.c          |    0
 drivers/dsp/bridge/{wmd => core}/mmu_fault.c      |    0
 drivers/dsp/bridge/{wmd => core}/mmu_fault.h      |    0
 drivers/dsp/bridge/{wmd => core}/msg_sm.c         |    0
 drivers/dsp/bridge/{wmd => core}/tiomap3430.c     |    0
 drivers/dsp/bridge/{wmd => core}/tiomap3430_pwr.c |    0
 drivers/dsp/bridge/{wmd => core}/tiomap_io.c      |    0
 drivers/dsp/bridge/{wmd => core}/tiomap_io.h      |    0
 drivers/dsp/bridge/{wmd => core}/ue_deh.c         |    0
 drivers/dsp/bridge/{wmd => core}/wdt.c            |    0
 19 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/dsp/bridge/{wmd => core}/_cmm.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/_deh.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/_msg_sm.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/_tiomap.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/_tiomap_mmu.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/_tiomap_pwr.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/_tiomap_util.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/chnl_sm.c (100%)
 rename drivers/dsp/bridge/{wmd => core}/io_sm.c (100%)
 rename drivers/dsp/bridge/{wmd => core}/mmu_fault.c (100%)
 rename drivers/dsp/bridge/{wmd => core}/mmu_fault.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/msg_sm.c (100%)
 rename drivers/dsp/bridge/{wmd => core}/tiomap3430.c (100%)
 rename drivers/dsp/bridge/{wmd => core}/tiomap3430_pwr.c (100%)
 rename drivers/dsp/bridge/{wmd => core}/tiomap_io.c (100%)
 rename drivers/dsp/bridge/{wmd => core}/tiomap_io.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/ue_deh.c (100%)
 rename drivers/dsp/bridge/{wmd => core}/wdt.c (100%)

diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index c6f2551..97e7ec1 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -5,9 +5,9 @@ libservices = services/sync.o \
 		services/clk.o services/cfg.o services/reg.o \
                services/regsup.o services/ntfy.o \
 		services/services.o
-libwmd = wmd/chnl_sm.o wmd/msg_sm.o wmd/io_sm.o wmd/tiomap3430.o \
-		wmd/tiomap3430_pwr.o wmd/tiomap_io.o \
-		wmd/mmu_fault.o wmd/ue_deh.o wmd/wdt.o
+libcore = core/chnl_sm.o core/msg_sm.o core/io_sm.o core/tiomap3430.o \
+		core/tiomap3430_pwr.o core/tiomap_io.o \
+		core/mmu_fault.o core/ue_deh.o core/wdt.o
 libpmgr = pmgr/chnl.o pmgr/io.o pmgr/msg.o pmgr/cod.o pmgr/dev.o pmgr/wcd.o \
 		pmgr/dmm.o pmgr/cmm.o pmgr/dbll.o
 librmgr = rmgr/dbdcd.o rmgr/disp.o rmgr/drv.o rmgr/mgr.o rmgr/node.o \
@@ -17,7 +17,7 @@ libdload = dynload/cload.o dynload/getsection.o dynload/reloc.o \
 		 dynload/tramp.o
 libhw = hw/hw_mmu.o
 
-bridgedriver-objs = $(libgen) $(libservices) $(libwmd) $(libpmgr) $(librmgr) \
+bridgedriver-objs = $(libgen) $(libservices) $(libcore) $(libpmgr) $(librmgr) \
 			$(libdload) $(libhw)
 
 #Machine dependent
@@ -27,7 +27,7 @@ ccflags-y += -D_TI_ -D_DB_TIOMAP -DTMS32060 \
 
 #Header files
 ccflags-y += -Idrivers/dsp/bridge/services
-ccflags-y += -Idrivers/dsp/bridge/wmd
+ccflags-y += -Idrivers/dsp/bridge/core
 ccflags-y += -Idrivers/dsp/bridge/pmgr
 ccflags-y += -Idrivers/dsp/bridge/rmgr
 ccflags-y += -Idrivers/dsp/bridge/hw
diff --git a/drivers/dsp/bridge/wmd/_cmm.h b/drivers/dsp/bridge/core/_cmm.h
similarity index 100%
rename from drivers/dsp/bridge/wmd/_cmm.h
rename to drivers/dsp/bridge/core/_cmm.h
diff --git a/drivers/dsp/bridge/wmd/_deh.h b/drivers/dsp/bridge/core/_deh.h
similarity index 100%
rename from drivers/dsp/bridge/wmd/_deh.h
rename to drivers/dsp/bridge/core/_deh.h
diff --git a/drivers/dsp/bridge/wmd/_msg_sm.h b/drivers/dsp/bridge/core/_msg_sm.h
similarity index 100%
rename from drivers/dsp/bridge/wmd/_msg_sm.h
rename to drivers/dsp/bridge/core/_msg_sm.h
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/core/_tiomap.h
similarity index 100%
rename from drivers/dsp/bridge/wmd/_tiomap.h
rename to drivers/dsp/bridge/core/_tiomap.h
diff --git a/drivers/dsp/bridge/wmd/_tiomap_mmu.h b/drivers/dsp/bridge/core/_tiomap_mmu.h
similarity index 100%
rename from drivers/dsp/bridge/wmd/_tiomap_mmu.h
rename to drivers/dsp/bridge/core/_tiomap_mmu.h
diff --git a/drivers/dsp/bridge/wmd/_tiomap_pwr.h b/drivers/dsp/bridge/core/_tiomap_pwr.h
similarity index 100%
rename from drivers/dsp/bridge/wmd/_tiomap_pwr.h
rename to drivers/dsp/bridge/core/_tiomap_pwr.h
diff --git a/drivers/dsp/bridge/wmd/_tiomap_util.h b/drivers/dsp/bridge/core/_tiomap_util.h
similarity index 100%
rename from drivers/dsp/bridge/wmd/_tiomap_util.h
rename to drivers/dsp/bridge/core/_tiomap_util.h
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
similarity index 100%
rename from drivers/dsp/bridge/wmd/chnl_sm.c
rename to drivers/dsp/bridge/core/chnl_sm.c
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
similarity index 100%
rename from drivers/dsp/bridge/wmd/io_sm.c
rename to drivers/dsp/bridge/core/io_sm.c
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/core/mmu_fault.c
similarity index 100%
rename from drivers/dsp/bridge/wmd/mmu_fault.c
rename to drivers/dsp/bridge/core/mmu_fault.c
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.h b/drivers/dsp/bridge/core/mmu_fault.h
similarity index 100%
rename from drivers/dsp/bridge/wmd/mmu_fault.h
rename to drivers/dsp/bridge/core/mmu_fault.h
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/core/msg_sm.c
similarity index 100%
rename from drivers/dsp/bridge/wmd/msg_sm.c
rename to drivers/dsp/bridge/core/msg_sm.c
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
similarity index 100%
rename from drivers/dsp/bridge/wmd/tiomap3430.c
rename to drivers/dsp/bridge/core/tiomap3430.c
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/core/tiomap3430_pwr.c
similarity index 100%
rename from drivers/dsp/bridge/wmd/tiomap3430_pwr.c
rename to drivers/dsp/bridge/core/tiomap3430_pwr.c
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/core/tiomap_io.c
similarity index 100%
rename from drivers/dsp/bridge/wmd/tiomap_io.c
rename to drivers/dsp/bridge/core/tiomap_io.c
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.h b/drivers/dsp/bridge/core/tiomap_io.h
similarity index 100%
rename from drivers/dsp/bridge/wmd/tiomap_io.h
rename to drivers/dsp/bridge/core/tiomap_io.h
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
similarity index 100%
rename from drivers/dsp/bridge/wmd/ue_deh.c
rename to drivers/dsp/bridge/core/ue_deh.c
diff --git a/drivers/dsp/bridge/wmd/wdt.c b/drivers/dsp/bridge/core/wdt.c
similarity index 100%
rename from drivers/dsp/bridge/wmd/wdt.c
rename to drivers/dsp/bridge/core/wdt.c
-- 
1.7.0.3

