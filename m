From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] DSP: Move dspgateway to drivers/dsp/dspgateway
Date: Tue, 27 Nov 2007 21:20:08 -0800
Message-ID: <20071128052005.GJ11825@atomide.com>
References: <20071128051811.GI11825@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071128051811.GI11825@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch does the actual moving of the files.

Tony



--aVD9QWMuhilNxW9f
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline;
	filename="0002-DSP-Move-dspgateway-to-drivers-dsp-dspgateway.patch"

>From c43c710df9b75494ce931f8e4b730a7f54d56d05 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 27 Nov 2007 21:13:02 -0800
Subject: [PATCH] DSP: Move dspgateway to drivers/dsp/dspgateway

Move dspgateway to drivers/dsp/dspgateway

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-omap1/mmu.c             |    6 +
 arch/arm/mach-omap1/mmu.h             |    7 -
 arch/arm/mach-omap2/mmu.h             |    6 +-
 arch/arm/plat-omap/Kconfig            |    2 -
 arch/arm/plat-omap/Makefile           |    3 -
 arch/arm/plat-omap/dsp/Kconfig        |   24 -
 arch/arm/plat-omap/dsp/Makefile       |   15 -
 arch/arm/plat-omap/dsp/dsp.h          |  391 -----
 arch/arm/plat-omap/dsp/dsp_common.c   |  627 -------
 arch/arm/plat-omap/dsp/dsp_core.c     |  663 -------
 arch/arm/plat-omap/dsp/dsp_ctl.c      | 1069 ------------
 arch/arm/plat-omap/dsp/dsp_ctl_core.c |  132 --
 arch/arm/plat-omap/dsp/dsp_mbcmd.h    |  147 --
 arch/arm/plat-omap/dsp/dsp_mem.c      |  482 ------
 arch/arm/plat-omap/dsp/error.c        |  227 ---
 arch/arm/plat-omap/dsp/hardware_dsp.h |   34 -
 arch/arm/plat-omap/dsp/ipbuf.c        |  353 ----
 arch/arm/plat-omap/dsp/ipbuf.h        |  193 ---
 arch/arm/plat-omap/dsp/mblog.c        |  280 ---
 arch/arm/plat-omap/dsp/mmu.h          |  140 --
 arch/arm/plat-omap/dsp/omap1_dsp.h    |  114 --
 arch/arm/plat-omap/dsp/omap2_dsp.h    |   95 -
 arch/arm/plat-omap/dsp/proclist.h     |   87 -
 arch/arm/plat-omap/dsp/task.c         | 3042 ---------------------------------
 arch/arm/plat-omap/dsp/taskwatch.c    |  163 --
 arch/arm/plat-omap/dsp/uaccess_dsp.S  |   77 -
 arch/arm/plat-omap/dsp/uaccess_dsp.h  |  176 --
 drivers/Makefile                      |    1 +
 drivers/dsp/dspgateway/Kconfig        |   24 +
 drivers/dsp/dspgateway/Makefile       |   15 +
 drivers/dsp/dspgateway/dsp.h          |  391 +++++
 drivers/dsp/dspgateway/dsp_common.c   |  627 +++++++
 drivers/dsp/dspgateway/dsp_core.c     |  663 +++++++
 drivers/dsp/dspgateway/dsp_ctl.c      | 1069 ++++++++++++
 drivers/dsp/dspgateway/dsp_ctl_core.c |  132 ++
 drivers/dsp/dspgateway/dsp_mbcmd.h    |  147 ++
 drivers/dsp/dspgateway/dsp_mem.c      |  484 ++++++
 drivers/dsp/dspgateway/error.c        |  227 +++
 drivers/dsp/dspgateway/hardware_dsp.h |   34 +
 drivers/dsp/dspgateway/ipbuf.c        |  353 ++++
 drivers/dsp/dspgateway/ipbuf.h        |  193 +++
 drivers/dsp/dspgateway/mblog.c        |  280 +++
 drivers/dsp/dspgateway/mmu.h          |  140 ++
 drivers/dsp/dspgateway/omap1_dsp.h    |  114 ++
 drivers/dsp/dspgateway/omap2_dsp.h    |   95 +
 drivers/dsp/dspgateway/proclist.h     |   87 +
 drivers/dsp/dspgateway/task.c         | 3042 +++++++++++++++++++++++++++++++++
 drivers/dsp/dspgateway/taskwatch.c    |  163 ++
 drivers/dsp/dspgateway/uaccess_dsp.S  |   77 +
 drivers/dsp/dspgateway/uaccess_dsp.h  |  176 ++
 include/asm-arm/arch-omap/mmu.h       |   10 +
 52 files changed, 8552 insertions(+), 8548 deletions(-)
 delete mode 100644 arch/arm/plat-omap/dsp/Kconfig
 delete mode 100644 arch/arm/plat-omap/dsp/Makefile
 delete mode 100644 arch/arm/plat-omap/dsp/dsp.h
 delete mode 100644 arch/arm/plat-omap/dsp/dsp_common.c
 delete mode 100644 arch/arm/plat-omap/dsp/dsp_core.c
 delete mode 100644 arch/arm/plat-omap/dsp/dsp_ctl.c
 delete mode 100644 arch/arm/plat-omap/dsp/dsp_ctl_core.c
 delete mode 100644 arch/arm/plat-omap/dsp/dsp_mbcmd.h
 delete mode 100644 arch/arm/plat-omap/dsp/dsp_mem.c
 delete mode 100644 arch/arm/plat-omap/dsp/error.c
 delete mode 100644 arch/arm/plat-omap/dsp/hardware_dsp.h
 delete mode 100644 arch/arm/plat-omap/dsp/ipbuf.c
 delete mode 100644 arch/arm/plat-omap/dsp/ipbuf.h
 delete mode 100644 arch/arm/plat-omap/dsp/mblog.c
 delete mode 100644 arch/arm/plat-omap/dsp/mmu.h
 delete mode 100644 arch/arm/plat-omap/dsp/omap1_dsp.h
 delete mode 100644 arch/arm/plat-omap/dsp/omap2_dsp.h
 delete mode 100644 arch/arm/plat-omap/dsp/proclist.h
 delete mode 100644 arch/arm/plat-omap/dsp/task.c
 delete mode 100644 arch/arm/plat-omap/dsp/taskwatch.c
 delete mode 100644 arch/arm/plat-omap/dsp/uaccess_dsp.S
 delete mode 100644 arch/arm/plat-omap/dsp/uaccess_dsp.h
 create mode 100644 drivers/dsp/dspgateway/Kconfig
 create mode 100644 drivers/dsp/dspgateway/Makefile
 create mode 100644 drivers/dsp/dspgateway/dsp.h
 create mode 100644 drivers/dsp/dspgateway/dsp_common.c
 create mode 100644 drivers/dsp/dspgateway/dsp_core.c
 create mode 100644 drivers/dsp/dspgateway/dsp_ctl.c
 create mode 100644 drivers/dsp/dspgateway/dsp_ctl_core.c
 create mode 100644 drivers/dsp/dspgateway/dsp_mbcmd.h
 create mode 100644 drivers/dsp/dspgateway/dsp_mem.c
 create mode 100644 drivers/dsp/dspgateway/error.c
 create mode 100644 drivers/dsp/dspgateway/hardware_dsp.h
 create mode 100644 drivers/dsp/dspgateway/ipbuf.c
 create mode 100644 drivers/dsp/dspgateway/ipbuf.h
 create mode 100644 drivers/dsp/dspgateway/mblog.c
 create mode 100644 drivers/dsp/dspgateway/mmu.h
 create mode 100644 drivers/dsp/dspgateway/omap1_dsp.h
 create mode 100644 drivers/dsp/dspgateway/omap2_dsp.h
 create mode 100644 drivers/dsp/dspgateway/proclist.h
 create mode 100644 drivers/dsp/dspgateway/task.c
 create mode 100644 drivers/dsp/dspgateway/taskwatch.c
 create mode 100644 drivers/dsp/dspgateway/uaccess_dsp.S
 create mode 100644 drivers/dsp/dspgateway/uaccess_dsp.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d589397..f468fee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1081,6 +1081,7 @@ source "drivers/dma/Kconfig"
 
 if ARCH_OMAP
 source "drivers/cbus/Kconfig"
+source "drivers/dsp/dspgateway/Kconfig"
 endif
 
 endmenu
diff --git a/arch/arm/mach-omap1/mmu.c b/arch/arm/mach-omap1/mmu.c
index a254410..c7cb4ff 100644
--- a/arch/arm/mach-omap1/mmu.c
+++ b/arch/arm/mach-omap1/mmu.c
@@ -81,6 +81,12 @@ void dsp_mem_usecount_clear(void)
 }
 EXPORT_SYMBOL_GPL(dsp_mem_usecount_clear);
 
+void omap_mmu_itack(struct omap_mmu *mmu)
+{
+	omap_mmu_write_reg(mmu, OMAP_MMU_IT_ACK_IT_ACK, OMAP_MMU_IT_ACK);
+}
+EXPORT_SYMBOL(omap_mmu_itack);
+
 static int omap1_mmu_mem_enable(struct omap_mmu *mmu, void *addr)
 {
 	int ret = 0;
diff --git a/arch/arm/mach-omap1/mmu.h b/arch/arm/mach-omap1/mmu.h
index 9ab2d99..521c3bf 100644
--- a/arch/arm/mach-omap1/mmu.h
+++ b/arch/arm/mach-omap1/mmu.h
@@ -95,8 +95,6 @@ do {							\
 	(ent)->ap	= OMAP_MMU_RAM_L_AP_FA;		\
 } while (0)
 
-extern struct omap_mmu_ops omap1_mmu_ops;
-
 struct omap_mmu_tlb_entry {
 	unsigned long va;
 	unsigned long pa;
@@ -118,9 +116,4 @@ static inline void omap_mmu_write_reg(struct omap_mmu *mmu,
 	__raw_writew(val, mmu->base + reg);
 }
 
-static inline void omap_mmu_itack(struct omap_mmu *mmu)
-{
-	omap_mmu_write_reg(mmu, OMAP_MMU_IT_ACK_IT_ACK, OMAP_MMU_IT_ACK);
-}
-
 #endif /* __MACH_OMAP1_MMU_H */
diff --git a/arch/arm/mach-omap2/mmu.h b/arch/arm/mach-omap2/mmu.h
index 736932e..818ea8c 100644
--- a/arch/arm/mach-omap2/mmu.h
+++ b/arch/arm/mach-omap2/mmu.h
@@ -93,8 +93,6 @@ do {								\
 	(ent)->mixed	= 0;					\
 } while (0)
 
-extern struct omap_mmu_ops omap2_mmu_ops;
-
 struct omap_mmu_tlb_entry {
 	unsigned long va;
 	unsigned long pa;
@@ -115,7 +113,5 @@ static inline void omap_mmu_write_reg(struct omap_mmu *mmu,
 {
 	__raw_writel(val, mmu->base + reg);
 }
-static inline void omap_mmu_itack(struct omap_mmu *mmu)
-{
-}
+
 #endif /* __MACH_OMAP2_MMU_H */
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index d1558df..3cb9545 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -211,8 +211,6 @@ config OMAP_SERIAL_WAKE
 	  to data on the serial RX line. This allows you to wake the
 	  system from serial console.
 
-source "arch/arm/plat-omap/dsp/Kconfig"
-
 endmenu
 
 endif
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 4eaef7e..c1ada8f 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -32,6 +32,3 @@ obj-$(CONFIG_OMAP_MMU_FWK) += mmu.o
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
 
-# DSP subsystem
-obj-y += dsp/
-obj-$(CONFIG_OMAP_DSP) += mailbox.o
diff --git a/arch/arm/plat-omap/dsp/Kconfig b/arch/arm/plat-omap/dsp/Kconfig
deleted file mode 100644
index 122164a..0000000
--- a/arch/arm/plat-omap/dsp/Kconfig
+++ /dev/null
@@ -1,24 +0,0 @@
-
-config OMAP_DSP
-	tristate "OMAP DSP driver (DSP Gateway)"
-	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP24XX
-	select OMAP_MMU_FWK
-	select OMAP_MBOX_FWK
-	help
-	  This enables OMAP DSP driver, DSP Gateway.
-
-config OMAP_DSP_MBCMD_VERBOSE
-	bool "Mailbox Command Verbose LOG"
-	depends on OMAP_DSP
-	help
-          This enables kernel log output in the Mailbox command exchanges
-	  in the DSP Gateway driver.
-
-config OMAP_DSP_FBEXPORT
-	bool "Framebuffer export to DSP"
-	depends on OMAP_DSP && FB
-	help
-          This enables to map the frame buffer to DSP.
-	  By doing this, DSP can access the frame buffer directly without
-	  bothering ARM.
-
diff --git a/arch/arm/plat-omap/dsp/Makefile b/arch/arm/plat-omap/dsp/Makefile
deleted file mode 100644
index c7d86f3..0000000
--- a/arch/arm/plat-omap/dsp/Makefile
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-# Makefile for the OMAP DSP driver.
-#
-
-# The target object and module list name.
-
-obj-y := dsp_common.o
-
-obj-$(CONFIG_OMAP_DSP) += dsp.o
-
-# Declare multi-part drivers
-
-dsp-objs	:= dsp_core.o ipbuf.o mblog.o task.o \
-		   dsp_ctl_core.o dsp_ctl.o taskwatch.o error.o dsp_mem.o \
-		   uaccess_dsp.o
diff --git a/arch/arm/plat-omap/dsp/dsp.h b/arch/arm/plat-omap/dsp/dsp.h
deleted file mode 100644
index a7eee1d..0000000
--- a/arch/arm/plat-omap/dsp/dsp.h
+++ /dev/null
@@ -1,391 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __PLAT_OMAP_DSP_DSP_H
-#define __PLAT_OMAP_DSP_DSP_H
-
-#include "hardware_dsp.h"
-#include <asm/arch/dsp_common.h>
-#include <asm/arch/mmu.h>
-
-
-#ifdef CONFIG_ARCH_OMAP2
-#include "../../mach-omap2/prm.h"
-#include "../../mach-omap2/prm_regbits_24xx.h"
-#include "../../mach-omap2/cm.h"
-#include "../../mach-omap2/cm_regbits_24xx.h"
-#endif
-
-/*
- * MAJOR device number: !! allocated arbitrary !!
- */
-#define OMAP_DSP_CTL_MAJOR		96
-#define OMAP_DSP_TASK_MAJOR		97
-
-#define OLD_BINARY_SUPPORT	y
-
-#ifdef OLD_BINARY_SUPPORT
-#define MBREV_3_0	0x0017
-#define MBREV_3_2	0x0018
-#endif
-
-#define DSP_INIT_PAGE	0xfff000
-
-#ifdef CONFIG_ARCH_OMAP1
-/* idle program will be placed at IDLEPG_BASE. */
-#define IDLEPG_BASE	0xfffe00
-#define IDLEPG_SIZE	0x100
-#endif /* CONFIG_ARCH_OMAP1 */
-
-/* timeout value for DSP response */
-#define DSP_TIMEOUT	(10 * HZ)
-
-enum dsp_mem_type_e {
-	MEM_TYPE_CROSSING = -1,
-	MEM_TYPE_NONE = 0,
-	MEM_TYPE_DARAM,
-	MEM_TYPE_SARAM,
-	MEM_TYPE_EXTERN,
-};
-
-
-typedef int __bitwise arm_dsp_dir_t;
-#define DIR_A2D	((__force arm_dsp_dir_t) 1)
-#define DIR_D2A	((__force arm_dsp_dir_t) 2)
-
-enum cfgstat_e {
-	CFGSTAT_CLEAN = 0,
-	CFGSTAT_READY,
-	CFGSTAT_SUSPEND,
-	CFGSTAT_RESUME,	/* request only */
-	CFGSTAT_MAX
-};
-
-enum errcode_e {
-	ERRCODE_WDT = 0,
-	ERRCODE_MMU,
-	ERRCODE_MAX
-};
-
-/* keep 2 entries for TID_FREE and TID_ANON */
-#define TASKDEV_MAX	254
-
-#define MK32(uw,lw)	(((u32)(uw)) << 16 | (lw))
-#define MKLONG(uw,lw)	(((unsigned long)(uw)) << 16 | (lw))
-#define MKVIRT(uw,lw)	dspword_to_virt(MKLONG((uw), (lw)));
-
-struct sync_seq {
-	u16 da_dsp;
-	u16 da_arm;
-	u16 ad_dsp;
-	u16 ad_arm;
-};
-
-struct mem_sync_struct {
-	struct sync_seq *DARAM;
-	struct sync_seq *SARAM;
-	struct sync_seq *SDRAM;
-};
-
-/* struct mbcmd and union mbcmd_hw must be compatible */
-struct mbcmd {
-	u32 data:16;
-	u32 cmd_l:8;
-	u32 cmd_h:7;
-	u32 seq:1;
-};
-
-#define MBCMD_INIT(h, l, d) { \
-		.cmd_h = (h), \
-		.cmd_l = (l), \
-		.data  = (d), \
-	}
-
-struct mb_exarg {
-	u8 tid;
-	int argc;
-	u16 *argv;
-};
-
-typedef u32 dsp_long_t;	/* must have ability to carry TADD_ABORTADR */
-
-extern void dsp_mbox_start(void);
-extern void dsp_mbox_stop(void);
-extern int dsp_mbox_config(void *p);
-extern int sync_with_dsp(u16 *syncwd, u16 tid, int try_cnt);
-extern int __dsp_mbcmd_send_exarg(struct mbcmd *mb, struct mb_exarg *arg,
-				  int recovery_flag);
-#define dsp_mbcmd_send(mb)		__dsp_mbcmd_send_exarg((mb), NULL, 0)
-#define dsp_mbcmd_send_exarg(mb, arg)	__dsp_mbcmd_send_exarg((mb), (arg), 0)
-extern int dsp_mbcmd_send_and_wait_exarg(struct mbcmd *mb, struct mb_exarg *arg,
-					 wait_queue_head_t *q);
-#define dsp_mbcmd_send_and_wait(mb, q) \
-	dsp_mbcmd_send_and_wait_exarg((mb), NULL, (q))
-
-static inline int __mbcompose_send_exarg(u8 cmd_h, u8 cmd_l, u16 data,
-					     struct mb_exarg *arg,
-					     int recovery_flag)
-{
-	struct mbcmd mb = MBCMD_INIT(cmd_h, cmd_l, data);
-	return __dsp_mbcmd_send_exarg(&mb, arg, recovery_flag);
-}
-#define mbcompose_send(cmd_h, cmd_l, data) \
-	__mbcompose_send_exarg(MBOX_CMD_DSP_##cmd_h, (cmd_l), (data), NULL, 0)
-#define mbcompose_send_exarg(cmd_h, cmd_l, data, arg) \
-	__mbcompose_send_exarg(MBOX_CMD_DSP_##cmd_h, (cmd_l), (data), arg, 0)
-#define mbcompose_send_recovery(cmd_h, cmd_l, data) \
-	__mbcompose_send_exarg(MBOX_CMD_DSP_##cmd_h, (cmd_l), (data), NULL, 1)
-
-static inline int __mbcompose_send_and_wait_exarg(u8 cmd_h, u8 cmd_l,
-						      u16 data,
-						      struct mb_exarg *arg,
-						      wait_queue_head_t *q)
-{
-	struct mbcmd mb = MBCMD_INIT(cmd_h, cmd_l, data);
-	return dsp_mbcmd_send_and_wait_exarg(&mb, arg, q);
-}
-#define mbcompose_send_and_wait(cmd_h, cmd_l, data, q) \
-	__mbcompose_send_and_wait_exarg(MBOX_CMD_DSP_##cmd_h, (cmd_l), (data), \
-					NULL, (q))
-#define mbcompose_send_and_wait_exarg(cmd_h, cmd_l, data, arg, q) \
-	__mbcompose_send_and_wait_exarg(MBOX_CMD_DSP_##cmd_h, (cmd_l), (data), \
-					(arg), (q))
-
-extern struct ipbuf_head *bid_to_ipbuf(u16 bid);
-extern void ipbuf_start(void);
-extern void ipbuf_stop(void);
-extern int ipbuf_config(u16 ln, u16 lsz, void *base);
-extern int ipbuf_sys_config(void *p, arm_dsp_dir_t dir);
-extern int ipbuf_p_validate(void *p, arm_dsp_dir_t dir);
-extern struct ipbuf_head *get_free_ipbuf(u8 tid);
-extern void release_ipbuf(struct ipbuf_head *ipb_h);
-extern void balance_ipbuf(void);
-extern void unuse_ipbuf(struct ipbuf_head *ipb_h);
-extern void unuse_ipbuf_nowait(struct ipbuf_head *ipb_h);
-
-#define release_ipbuf_pvt(ipbuf_pvt) \
-	do { \
-		(ipbuf_pvt)->s = TID_FREE; \
-	} while(0)
-
-extern int mbox_revision;
-
-extern int dsp_cfgstat_request(enum cfgstat_e st);
-extern enum cfgstat_e dsp_cfgstat_get_stat(void);
-extern int dsp_set_runlevel(u8 level);
-
-extern int dsp_task_config_all(u8 n);
-extern void dsp_task_unconfig_all(void);
-extern u8 dsp_task_count(void);
-extern int dsp_taskmod_busy(void);
-extern int dsp_mkdev(char *name);
-extern int dsp_rmdev(char *name);
-extern int dsp_tadd_minor(unsigned char minor, dsp_long_t adr);
-extern int dsp_tdel_minor(unsigned char minor);
-extern int dsp_tkill_minor(unsigned char minor);
-extern long taskdev_state_stale(unsigned char minor);
-extern int dsp_dbg_config(u16 *buf, u16 sz, u16 lsz);
-extern void dsp_dbg_stop(void);
-
-extern int ipbuf_is_held(u8 tid, u16 bid);
-
-extern int dsp_mem_sync_inc(void);
-extern int dsp_mem_sync_config(struct mem_sync_struct *sync);
-extern enum dsp_mem_type_e dsp_mem_type(void *vadr, size_t len);
-extern int dsp_address_validate(void *p, size_t len, char *fmt, ...);
-#ifdef CONFIG_ARCH_OMAP1
-extern void dsp_mem_usecount_clear(void);
-#endif
-extern void exmap_use(void *vadr, size_t len);
-extern void exmap_unuse(void *vadr, size_t len);
-extern unsigned long dsp_virt_to_phys(void *vadr, size_t *len);
-extern void dsp_mem_start(void);
-extern void dsp_mem_stop(void);
-
-extern void dsp_twch_start(void);
-extern void dsp_twch_stop(void);
-extern void dsp_twch_touch(void);
-
-extern void dsp_err_start(void);
-extern void dsp_err_stop(void);
-extern void dsp_err_set(enum errcode_e code, unsigned long arg);
-extern void dsp_err_clear(enum errcode_e code);
-extern int dsp_err_isset(enum errcode_e code);
-
-enum cmd_l_type_e {
-	CMD_L_TYPE_NULL,
-	CMD_L_TYPE_TID,
-	CMD_L_TYPE_SUBCMD,
-};
-
-struct cmdinfo {
-	char *name;
-	enum cmd_l_type_e cmd_l_type;
-	void (*handler)(struct mbcmd *mb);
-};
-
-extern const struct cmdinfo *cmdinfo[];
-
-#define cmd_name(mb)	(cmdinfo[(mb).cmd_h]->name)
-extern char *subcmd_name(struct mbcmd *mb);
-
-extern void mblog_add(struct mbcmd *mb, arm_dsp_dir_t dir);
-
-extern struct omap_mmu dsp_mmu;
-
-#define dsp_mem_enable(addr)	omap_mmu_mem_enable(&dsp_mmu, (addr))
-#define dsp_mem_disable(addr)	omap_mmu_mem_disable(&dsp_mmu, (addr))
-
-#define DSPSPACE_SIZE	0x1000000
-
-#define omap_set_bit_regw(b,r) \
-	do { omap_writew(omap_readw(r) | (b), (r)); } while(0)
-#define omap_clr_bit_regw(b,r) \
-	do { omap_writew(omap_readw(r) & ~(b), (r)); } while(0)
-#define omap_set_bit_regl(b,r) \
-	do { omap_writel(omap_readl(r) | (b), (r)); } while(0)
-#define omap_clr_bit_regl(b,r) \
-	do { omap_writel(omap_readl(r) & ~(b), (r)); } while(0)
-#define omap_set_bits_regl(val,mask,r) \
-	do { omap_writel((omap_readl(r) & ~(mask)) | (val), (r)); } while(0)
-
-#define dspword_to_virt(dw)	((void *)(dspmem_base + ((dw) << 1)))
-#define dspbyte_to_virt(db)	((void *)(dspmem_base + (db)))
-#define virt_to_dspword(va) \
-	((dsp_long_t)(((unsigned long)(va) - dspmem_base) >> 1))
-#define virt_to_dspbyte(va) \
-	((dsp_long_t)((unsigned long)(va) - dspmem_base))
-#define is_dsp_internal_mem(va) \
-	(((unsigned long)(va) >= dspmem_base) &&  \
-	 ((unsigned long)(va) < dspmem_base + dspmem_size))
-#define is_dspbyte_internal_mem(db)	((db) < dspmem_size)
-#define is_dspword_internal_mem(dw)	(((dw) << 1) < dspmem_size)
-
-#ifdef CONFIG_ARCH_OMAP1
-/*
- * MPUI byteswap/wordswap on/off
- *   default setting: wordswap = all, byteswap = APIMEM only
- */
-#define mpui_wordswap_on() \
-	omap_set_bits_regl(MPUI_CTRL_WORDSWAP_ALL, MPUI_CTRL_WORDSWAP_MASK, \
-			   MPUI_CTRL)
-
-#define mpui_wordswap_off() \
-	omap_set_bits_regl(MPUI_CTRL_WORDSWAP_NONE, MPUI_CTRL_WORDSWAP_MASK, \
-			   MPUI_CTRL)
-
-#define mpui_byteswap_on() \
-	omap_set_bits_regl(MPUI_CTRL_BYTESWAP_API, MPUI_CTRL_BYTESWAP_MASK, \
-			   MPUI_CTRL)
-
-#define mpui_byteswap_off() \
-	omap_set_bits_regl(MPUI_CTRL_BYTESWAP_NONE, MPUI_CTRL_BYTESWAP_MASK, \
-			   MPUI_CTRL)
-
-/*
- * TC wordswap on / off
- */
-#define tc_wordswap() \
-	do { \
-		omap_writel(TC_ENDIANISM_SWAP_WORD | TC_ENDIANISM_EN, \
-			    TC_ENDIANISM); \
-	} while(0)
-
-#define tc_noswap()	omap_clr_bit_regl(TC_ENDIANISM_EN, TC_ENDIANISM)
-
-/*
- * enable priority registers, EMIF, MPUI control logic
- */
-#define __dsp_enable()	omap_set_bit_regw(ARM_RSTCT1_DSP_RST, ARM_RSTCT1)
-#define __dsp_disable()	omap_clr_bit_regw(ARM_RSTCT1_DSP_RST, ARM_RSTCT1)
-#define __dsp_run()	omap_set_bit_regw(ARM_RSTCT1_DSP_EN, ARM_RSTCT1)
-#define __dsp_reset()	omap_clr_bit_regw(ARM_RSTCT1_DSP_EN, ARM_RSTCT1)
-#endif /* CONFIG_ARCH_OMAP1 */
-
-#ifdef CONFIG_ARCH_OMAP2
-/*
- * PRCM / IPI control logic
- *
- * REVISIT: these macros should probably be static inline functions
- */
-#define __dsp_core_enable() \
-	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
-	     & ~OMAP24XX_RST1_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
-#define __dsp_core_disable() \
-	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
-	     | OMAP24XX_RST1_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
-#define __dsp_per_enable() \
-	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
-	     & ~OMAP24XX_RST2_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
-#define __dsp_per_disable() \
-	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
-	     | OMAP24XX_RST2_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
-#endif /* CONFIG_ARCH_OMAP2 */
-
-#if defined(CONFIG_ARCH_OMAP1)
-extern struct clk *dsp_ck_handle;
-extern struct clk *api_ck_handle;
-#elif defined(CONFIG_ARCH_OMAP2)
-extern struct clk *dsp_fck_handle;
-extern struct clk *dsp_ick_handle;
-#endif
-extern dsp_long_t dspmem_base, dspmem_size,
-		  daram_base, daram_size,
-		  saram_base, saram_size;
-
-enum cpustat_e {
-	CPUSTAT_RESET = 0,
-#ifdef CONFIG_ARCH_OMAP1
-	CPUSTAT_GBL_IDLE,
-	CPUSTAT_CPU_IDLE,
-#endif
-	CPUSTAT_RUN,
-	CPUSTAT_MAX
-};
-
-int dsp_set_rstvect(dsp_long_t adr);
-dsp_long_t dsp_get_rstvect(void);
-void dsp_set_idle_boot_base(dsp_long_t adr, size_t size);
-void dsp_reset_idle_boot_base(void);
-void dsp_cpustat_request(enum cpustat_e req);
-enum cpustat_e dsp_cpustat_get_stat(void);
-u16 dsp_cpustat_get_icrmask(void);
-void dsp_cpustat_set_icrmask(u16 mask);
-void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void));
-void dsp_unregister_mem_cb(void);
-
-#if defined(CONFIG_ARCH_OMAP1)
-#define command_dvfs_stop(m) (0)
-#define command_dvfs_start(m) (0)
-#elif defined(CONFIG_ARCH_OMAP2)
-#define command_dvfs_stop(m) \
-	(((m)->cmd_l == KFUNC_POWER) && ((m)->data == DVFS_STOP))
-#define command_dvfs_start(m) \
-	(((m)->cmd_l == KFUNC_POWER) && ((m)->data == DVFS_START))
-#endif
-
-extern struct omap_dsp *omap_dsp;
-
-extern int dsp_late_init(void);
-
-#endif /* __PLAT_OMAP_DSP_DSP_H */
diff --git a/arch/arm/plat-omap/dsp/dsp_common.c b/arch/arm/plat-omap/dsp/dsp_common.c
deleted file mode 100644
index 99be995..0000000
--- a/arch/arm/plat-omap/dsp/dsp_common.c
+++ /dev/null
@@ -1,627 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/delay.h>
-#include <linux/mm.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/mutex.h>
-#include <linux/interrupt.h>
-#include <asm/io.h>
-#include <asm/tlbflush.h>
-#include <asm/irq.h>
-#include <asm/arch/dsp_common.h>
-#include "dsp.h"
-
-#ifdef CONFIG_ARCH_OMAP1
-#include <asm/arch/tc.h>
-#endif
-
-#if defined(CONFIG_ARCH_OMAP1)
-#define dsp_boot_config(mode)	omap_writew((mode), MPUI_DSP_BOOT_CONFIG)
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-#define dsp_boot_config(mode)	writel((mode), DSP_IPI_DSPBOOTCONFIG)
-#endif
-
-struct omap_dsp *omap_dsp;
-
-#if defined(CONFIG_ARCH_OMAP1)
-struct clk *dsp_ck_handle;
-struct clk *api_ck_handle;
-#elif defined(CONFIG_ARCH_OMAP2)
-struct clk *dsp_fck_handle;
-struct clk *dsp_ick_handle;
-#endif
-dsp_long_t dspmem_base, dspmem_size,
-	   daram_base, daram_size,
-	   saram_base, saram_size;
-
-static struct cpustat {
-	struct mutex lock;
-	enum cpustat_e stat;
-	enum cpustat_e req;
-	u16 icrmask;
-#ifdef CONFIG_ARCH_OMAP1
-	struct {
-		int mpui;
-		int mem;
-		int mem_delayed;
-	} usecount;
-	int (*mem_req_cb)(void);
-	void (*mem_rel_cb)(void);
-#endif
-} cpustat = {
-	.stat = CPUSTAT_RESET,
-	.icrmask = 0xffff,
-};
-
-int dsp_set_rstvect(dsp_long_t adr)
-{
-	unsigned long *dst_adr;
-
-	if (adr >= DSPSPACE_SIZE)
-		return -EINVAL;
-
-	dst_adr = dspbyte_to_virt(DSP_BOOT_ADR_DIRECT);
-	/* word swap */
-	*dst_adr = ((adr & 0xffff) << 16) | (adr >> 16);
-	/* fill 8 bytes! */
-	*(dst_adr + 1) = 0;
-	/* direct boot */
-	dsp_boot_config(DSP_BOOT_CONFIG_DIRECT);
-
-	return 0;
-}
-
-dsp_long_t dsp_get_rstvect(void)
-{
-	unsigned long *dst_adr;
-
-	dst_adr = dspbyte_to_virt(DSP_BOOT_ADR_DIRECT);
-	return ((*dst_adr & 0xffff) << 16) | (*dst_adr >> 16);
-}
-
-#ifdef CONFIG_ARCH_OMAP1
-static void simple_load_code(unsigned char *src_c, u16 *dst, int len)
-{
-	int i;
-	u16 *src = (u16 *)src_c;
-	int len_w;
-
-	/* len must be multiple of 2. */
-	if (len & 1)
-		BUG();
-
-	len_w = len / 2;
-	for (i = 0; i < len_w; i++) {
-		/* byte swap copy */
-		*dst = ((*src & 0x00ff) << 8) |
-		       ((*src & 0xff00) >> 8);
-		src++;
-		dst++;
-	}
-}
-
-/* program size must be multiple of 2 */
-#define GBL_IDLE_TEXT_SIZE	52
-#define GBL_IDLE_TEXT_INIT { \
-	/* SAM */ \
-	0x3c, 0x4a,			/* 0x3c4a:     MOV 0x4, AR2 */ \
-	0xf4, 0x41, 0xfc, 0xff,		/* 0xf441fcff: AND 0xfcff, *AR2 */ \
-	/* disable WDT */ \
-	0x76, 0x34, 0x04, 0xb8,		/* 0x763404b8: MOV 0x3404, AR3 */ \
-	0xfb, 0x61, 0x00, 0xf5,		/* 0xfb6100f5: MOV 0x00f5, *AR3 */ \
-	0x9a,				/* 0x9a:       PORT */ \
-	0xfb, 0x61, 0x00, 0xa0,		/* 0xfb6100a0: MOV 0x00a0, *AR3 */ \
-	0x9a,				/* 0x9a:       PORT */ \
-	/* *IER0 = 0, *IER1 = 0 */ \
-	0x3c, 0x0b,			/* 0x3c0b:     MOV 0x0, AR3 */ \
-	0xe6, 0x61, 0x00,		/* 0xe66100:   MOV 0, *AR3 */ \
-	0x76, 0x00, 0x45, 0xb8,		/* 0x76004508: MOV 0x45, AR3 */ \
-	0xe6, 0x61, 0x00,		/* 0xe66100:   MOV 0, *AR3 */ \
-	/* *ICR = 0xffff */ \
-	0x3c, 0x1b,			/* 0x3c1b:     MOV 0x1, AR3 */ \
-	0xfb, 0x61, 0xff, 0xff,		/* 0xfb61ffff: MOV 0xffff, *AR3 */ \
-	0x9a,				/* 0x9a:       PORT */ \
-	/* HOM */ \
-	0xf5, 0x41, 0x03, 0x00,		/* 0xf5410300: OR 0x0300, *AR2 */ \
-	/* idle and loop forever */ \
-	0x7a, 0x00, 0x00, 0x0c,		/* 0x7a00000c: IDLE */ \
-	0x4a, 0x7a,			/* 0x4a7a:     B -6 (infinite loop) */ \
-	0x20, 0x20, 0x20,		/* 0x20:       NOP */ \
-}
-
-/* program size must be multiple of 2 */
-#define CPU_IDLE_TEXT_SIZE	48
-#define CPU_IDLE_TEXT_INIT(icrh, icrl) { \
-	/* SAM */ \
-	0x3c, 0x4b,			/* 0x3c4b:     MOV 0x4, AR3 */ \
-	0xf4, 0x61, 0xfc, 0xff,		/* 0xf461fcff: AND 0xfcff, *AR3 */ \
-	/* disable WDT */ \
-	0x76, 0x34, 0x04, 0xb8,		/* 0x763404b8: MOV 0x3404, AR3 */ \
-	0xfb, 0x61, 0x00, 0xf5,		/* 0xfb6100f5: MOV 0x00f5, *AR3 */ \
-	0x9a,				/* 0x9a:       PORT */ \
-	0xfb, 0x61, 0x00, 0xa0,		/* 0xfb6100a0: MOV 0x00a0, *AR3 */ \
-	0x9a,				/* 0x9a:       PORT */ \
-	/* *IER0 = 0, *IER1 = 0 */ \
-	0x3c, 0x0b,			/* 0x3c0b:     MOV 0x0, AR3 */ \
-	0xe6, 0x61, 0x00,		/* 0xe66100:   MOV 0, *AR3 */ \
-	0x76, 0x00, 0x45, 0xb8,		/* 0x76004508: MOV 0x45, AR3 */ \
-	0xe6, 0x61, 0x00,		/* 0xe66100:   MOV 0, *AR3 */ \
-	/* set ICR = icr */ \
-	0x3c, 0x1b,			/* 0x3c1b:     MOV AR3 0x1 */ \
-	0xfb, 0x61, (icrh), (icrl),	/* 0xfb61****: MOV *AR3, icr */ \
-	0x9a,				/* 0x9a:       PORT */ \
-	/* idle and loop forever */ \
-	0x7a, 0x00, 0x00, 0x0c,		/* 0x7a00000c: IDLE */ \
-	0x4a, 0x7a,			/* 0x4a7a:     B -6 (infinite loop) */ \
-	0x20, 0x20, 0x20		/* 0x20: nop */ \
-}
-
-/*
- * idle_boot base:
- * Initialized with DSP_BOOT_ADR_MPUI (=0x010000).
- * This value is used before DSP Gateway driver is initialized.
- * DSP Gateway driver will overwrite this value with other value,
- * to avoid confliction with the user program.
- */
-static dsp_long_t idle_boot_base = DSP_BOOT_ADR_MPUI;
-
-static void dsp_gbl_idle(void)
-{
-	unsigned char idle_text[GBL_IDLE_TEXT_SIZE] = GBL_IDLE_TEXT_INIT;
-
-	__dsp_reset();
-	clk_enable(api_ck_handle);
-
-#if 0
-	dsp_boot_config(DSP_BOOT_CONFIG_IDLE);
-#endif
-	simple_load_code(idle_text, dspbyte_to_virt(idle_boot_base),
-			 GBL_IDLE_TEXT_SIZE);
-	if (idle_boot_base == DSP_BOOT_ADR_MPUI)
-		dsp_boot_config(DSP_BOOT_CONFIG_MPUI);
-	else
-		dsp_set_rstvect(idle_boot_base);
-
-	__dsp_run();
-	udelay(100);	/* to make things stable */
-	clk_disable(api_ck_handle);
-}
-
-static void dsp_cpu_idle(void)
-{
-	u16 icr_tmp;
-	unsigned char icrh, icrl;
-
-	__dsp_reset();
-	clk_enable(api_ck_handle);
-
-	/*
-	 * icr settings:
-	 * DMA should not sleep for DARAM/SARAM access
-	 * DPLL should not sleep while any other domain is active
-	 */
-	icr_tmp = cpustat.icrmask & ~(DSPREG_ICR_DMA | DSPREG_ICR_DPLL);
-	icrh = icr_tmp >> 8;
-	icrl = icr_tmp & 0xff;
-	{
-		unsigned char idle_text[CPU_IDLE_TEXT_SIZE] = CPU_IDLE_TEXT_INIT(icrh, icrl);
-		simple_load_code(idle_text, dspbyte_to_virt(idle_boot_base),
-				 CPU_IDLE_TEXT_SIZE);
-	}
-	if (idle_boot_base == DSP_BOOT_ADR_MPUI)
-		dsp_boot_config(DSP_BOOT_CONFIG_MPUI);
-	else
-		dsp_set_rstvect(idle_boot_base);
-	__dsp_run();
-	udelay(100);	/* to make things stable */
-	clk_disable(api_ck_handle);
-}
-
-void dsp_set_idle_boot_base(dsp_long_t adr, size_t size)
-{
-	if (adr == idle_boot_base)
-		return;
-	idle_boot_base = adr;
-	if ((size < GBL_IDLE_TEXT_SIZE) ||
-	    (size < CPU_IDLE_TEXT_SIZE)) {
-		printk(KERN_ERR
-		       "omapdsp: size for idle program is not enough!\n");
-		BUG();
-	}
-
-	/* restart idle program with new base address */
-	if (cpustat.stat == CPUSTAT_GBL_IDLE)
-		dsp_gbl_idle();
-	if (cpustat.stat == CPUSTAT_CPU_IDLE)
-		dsp_cpu_idle();
-}
-
-void dsp_reset_idle_boot_base(void)
-{
-	idle_boot_base = DSP_BOOT_ADR_MPUI;
-}
-#else
-void dsp_reset_idle_boot_base(void) { }
-#endif /* CONFIG_ARCH_OMAP1 */
-
-static int init_done;
-
-static int omap_dsp_init(void)
-{
-	mutex_init(&cpustat.lock);
-
-	dspmem_size = 0;
-#ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap15xx()) {
-		dspmem_base = OMAP1510_DSP_BASE;
-		dspmem_size = OMAP1510_DSP_SIZE;
-		daram_base = OMAP1510_DARAM_BASE;
-		daram_size = OMAP1510_DARAM_SIZE;
-		saram_base = OMAP1510_SARAM_BASE;
-		saram_size = OMAP1510_SARAM_SIZE;
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-	if (cpu_is_omap16xx()) {
-		dspmem_base = OMAP16XX_DSP_BASE;
-		dspmem_size = OMAP16XX_DSP_SIZE;
-		daram_base = OMAP16XX_DARAM_BASE;
-		daram_size = OMAP16XX_DARAM_SIZE;
-		saram_base = OMAP16XX_SARAM_BASE;
-		saram_size = OMAP16XX_SARAM_SIZE;
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP24XX
-	if (cpu_is_omap24xx()) {
-		dspmem_base = DSP_MEM_24XX_VIRT;
-		dspmem_size = DSP_MEM_24XX_SIZE;
-		daram_base = OMAP24XX_DARAM_BASE;
-		daram_size = OMAP24XX_DARAM_SIZE;
-		saram_base = OMAP24XX_SARAM_BASE;
-		saram_size = OMAP24XX_SARAM_SIZE;
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP34XX
-	/* To be Revisited for 3430 */
-	if (cpu_is_omap34xx()) {
-		return -ENODEV;
-	}
-#endif
-	if (dspmem_size == 0) {
-		printk(KERN_ERR "omapdsp: unsupported omap architecture.\n");
-		return -ENODEV;
-	}
-
-#if defined(CONFIG_ARCH_OMAP1)
-	dsp_ck_handle = clk_get(NULL, "dsp_ck");
-	if (IS_ERR(dsp_ck_handle)) {
-		printk(KERN_ERR "omapdsp: could not acquire dsp_ck handle.\n");
-		return PTR_ERR(dsp_ck_handle);
-	}
-
-	api_ck_handle = clk_get(NULL, "api_ck");
-	if (IS_ERR(api_ck_handle)) {
-		printk(KERN_ERR "omapdsp: could not acquire api_ck handle.\n");
-		if (dsp_ck_handle != NULL)
-			clk_put(dsp_ck_handle);
-		return PTR_ERR(api_ck_handle);
-	}
-
-	/* This is needed for McBSP init, released in late_initcall */
-	clk_enable(api_ck_handle);
-
-	__dsp_enable();
-	mpui_byteswap_off();
-	mpui_wordswap_on();
-	tc_wordswap();
-#elif defined(CONFIG_ARCH_OMAP2)
-	dsp_fck_handle = clk_get(NULL, "dsp_fck");
-	if (IS_ERR(dsp_fck_handle)) {
-		printk(KERN_ERR "omapdsp: could not acquire dsp_fck handle.\n");
-		return PTR_ERR(dsp_fck_handle);
-	}
-
-	dsp_ick_handle = clk_get(NULL, "dsp_ick");
-	if (IS_ERR(dsp_ick_handle)) {
-		printk(KERN_ERR "omapdsp: could not acquire dsp_ick handle.\n");
-		if (dsp_fck_handle != NULL)
-			clk_put(dsp_fck_handle);
-		return PTR_ERR(dsp_ick_handle);
-	}
-#endif
-
-	init_done = 1;
-	pr_info("omap_dsp_init() done\n");
-	return 0;
-}
-
-#if defined(CONFIG_ARCH_OMAP1)
-static int __dsp_late_init(void)
-{
-	clk_disable(api_ck_handle);
-	return 0;
-}
-late_initcall(__dsp_late_init);
-#endif
-
-static void dsp_cpustat_update(void)
-{
-	if (!init_done)
-		omap_dsp_init();
-
-	if (cpustat.req == CPUSTAT_RUN) {
-		if (cpustat.stat < CPUSTAT_RUN) {
-#if defined(CONFIG_ARCH_OMAP1)
-			__dsp_reset();
-			clk_enable(api_ck_handle);
-			udelay(10);
-			__dsp_run();
-#elif defined(CONFIG_ARCH_OMAP2)
-			__dsp_core_disable();
-			udelay(10);
-			__dsp_core_enable();
-#endif
-			cpustat.stat = CPUSTAT_RUN;
-		}
-		return;
-	}
-
-	/* cpustat.req < CPUSTAT_RUN */
-
-	if (cpustat.stat == CPUSTAT_RUN) {
-#ifdef CONFIG_ARCH_OMAP1
-		clk_disable(api_ck_handle);
-#endif
-	}
-
-#ifdef CONFIG_ARCH_OMAP1
-	/*
-	 * (1) when ARM wants DARAM access, MPUI should be SAM and
-	 *     DSP needs to be on.
-	 * (2) if any bits of icr is masked, we can not enter global idle.
-	 */
-	if ((cpustat.req == CPUSTAT_CPU_IDLE) ||
-	    (cpustat.usecount.mem > 0) ||
-	    (cpustat.usecount.mem_delayed > 0) ||
-	    ((cpustat.usecount.mpui > 0) && (cpustat.icrmask != 0xffff))) {
-		if (cpustat.stat != CPUSTAT_CPU_IDLE) {
-			dsp_cpu_idle();
-			cpustat.stat = CPUSTAT_CPU_IDLE;
-		}
-		return;
-	}
-
-	/*
-	 * when ARM only needs MPUI access, MPUI can be HOM and
-	 * DSP can be idling.
-	 */
-	if ((cpustat.req == CPUSTAT_GBL_IDLE) ||
-	    (cpustat.usecount.mpui > 0)) {
-		if (cpustat.stat != CPUSTAT_GBL_IDLE) {
-			dsp_gbl_idle();
-			cpustat.stat = CPUSTAT_GBL_IDLE;
-		}
-		return;
-	}
-#endif /* CONFIG_ARCH_OMAP1 */
-
-	/*
-	 * no user, no request
-	 */
-	if (cpustat.stat != CPUSTAT_RESET) {
-#if defined(CONFIG_ARCH_OMAP1)
-		__dsp_reset();
-#elif defined(CONFIG_ARCH_OMAP2)
-		__dsp_core_disable();
-#endif
-		cpustat.stat = CPUSTAT_RESET;
-	}
-}
-
-void dsp_cpustat_request(enum cpustat_e req)
-{
-	mutex_lock(&cpustat.lock);
-	cpustat.req = req;
-	dsp_cpustat_update();
-	mutex_unlock(&cpustat.lock);
-}
-
-enum cpustat_e dsp_cpustat_get_stat(void)
-{
-	return cpustat.stat;
-}
-
-u16 dsp_cpustat_get_icrmask(void)
-{
-	return cpustat.icrmask;
-}
-
-void dsp_cpustat_set_icrmask(u16 mask)
-{
-	mutex_lock(&cpustat.lock);
-	cpustat.icrmask = mask;
-	dsp_cpustat_update();
-	mutex_unlock(&cpustat.lock);
-}
-
-#ifdef CONFIG_ARCH_OMAP1
-void omap_dsp_request_mpui(void)
-{
-	mutex_lock(&cpustat.lock);
-	if (cpustat.usecount.mpui++ == 0)
-		dsp_cpustat_update();
-	mutex_unlock(&cpustat.lock);
-}
-
-void omap_dsp_release_mpui(void)
-{
-	mutex_lock(&cpustat.lock);
-	if (cpustat.usecount.mpui-- == 0) {
-		printk(KERN_ERR
-		       "omapdsp: unbalanced mpui request/release detected.\n"
-		       "         cpustat.usecount.mpui is going to be "
-		       "less than zero! ... fixed to be zero.\n");
-		cpustat.usecount.mpui = 0;
-	}
-	if (cpustat.usecount.mpui == 0)
-		dsp_cpustat_update();
-	mutex_unlock(&cpustat.lock);
-}
-
-int omap_dsp_request_mem(void)
-{
-	int ret = 0;
-
-	mutex_lock(&cpustat.lock);
-	if ((cpustat.usecount.mem++ == 0) &&
-	    (cpustat.usecount.mem_delayed == 0)) {
-		if (cpustat.mem_req_cb) {
-			if ((ret = cpustat.mem_req_cb()) < 0) {
-				cpustat.usecount.mem--;
-				goto out;
-			}
-		}
-		dsp_cpustat_update();
-	}
-out:
-	mutex_unlock(&cpustat.lock);
-
-	return ret;
-}
-
-/*
- * release_mem will be delayed.
- */
-static void do_release_mem(struct work_struct *dummy)
-{
-	mutex_lock(&cpustat.lock);
-	cpustat.usecount.mem_delayed = 0;
-	if (cpustat.usecount.mem == 0) {
-		dsp_cpustat_update();
-		if (cpustat.mem_rel_cb)
-			cpustat.mem_rel_cb();
-	}
-	mutex_unlock(&cpustat.lock);
-}
-
-static DECLARE_DELAYED_WORK(mem_rel_work, do_release_mem);
-
-int omap_dsp_release_mem(void)
-{
-	mutex_lock(&cpustat.lock);
-
-	/* cancel previous release work */
-	cancel_delayed_work(&mem_rel_work);
-	cpustat.usecount.mem_delayed = 0;
-
-	if (cpustat.usecount.mem-- == 0) {
-		printk(KERN_ERR
-		       "omapdsp: unbalanced memory request/release detected.\n"
-		       "         cpustat.usecount.mem is going to be "
-		       "less than zero! ... fixed to be zero.\n");
-		cpustat.usecount.mem = 0;
-	}
-	if (cpustat.usecount.mem == 0) {
-		cpustat.usecount.mem_delayed = 1;
-		schedule_delayed_work(&mem_rel_work, HZ);
-	}
-
-	mutex_unlock(&cpustat.lock);
-
-	return 0;
-}
-
-void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void))
-{
-	mutex_lock(&cpustat.lock);
-
-	cpustat.mem_req_cb = req_cb;
-	cpustat.mem_rel_cb = rel_cb;
-
-	/*
-	 * This function must be called while mem is enabled!
-	 */
-	BUG_ON(cpustat.usecount.mem == 0);
-
-	mutex_unlock(&cpustat.lock);
-}
-
-void dsp_unregister_mem_cb(void)
-{
-	mutex_lock(&cpustat.lock);
-	cpustat.mem_req_cb = NULL;
-	cpustat.mem_rel_cb = NULL;
-	mutex_unlock(&cpustat.lock);
-}
-#else
-void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void)) { }
-void dsp_unregister_mem_cb(void) { }
-#endif /* CONFIG_ARCH_OMAP1 */
-
-arch_initcall(omap_dsp_init);
-
-#ifdef CONFIG_ARCH_OMAP1
-EXPORT_SYMBOL(omap_dsp_request_mpui);
-EXPORT_SYMBOL(omap_dsp_release_mpui);
-EXPORT_SYMBOL(omap_dsp_request_mem);
-EXPORT_SYMBOL(omap_dsp_release_mem);
-#endif /* CONFIG_ARCH_OMAP1 */
-
-#ifdef CONFIG_OMAP_DSP_MODULE
-#if defined(CONFIG_ARCH_OMAP1)
-EXPORT_SYMBOL(dsp_ck_handle);
-EXPORT_SYMBOL(api_ck_handle);
-#elif defined(CONFIG_ARCH_OMAP2)
-EXPORT_SYMBOL(dsp_fck_handle);
-EXPORT_SYMBOL(dsp_ick_handle);
-#endif
-EXPORT_SYMBOL(omap_dsp);
-EXPORT_SYMBOL(dspmem_base);
-EXPORT_SYMBOL(dspmem_size);
-EXPORT_SYMBOL(daram_base);
-EXPORT_SYMBOL(daram_size);
-EXPORT_SYMBOL(saram_base);
-EXPORT_SYMBOL(saram_size);
-EXPORT_SYMBOL(dsp_set_rstvect);
-EXPORT_SYMBOL(dsp_get_rstvect);
-#ifdef CONFIG_ARCH_OMAP1
-EXPORT_SYMBOL(dsp_set_idle_boot_base);
-EXPORT_SYMBOL(dsp_reset_idle_boot_base);
-#endif /* CONFIG_ARCH_OMAP1 */
-EXPORT_SYMBOL(dsp_cpustat_request);
-EXPORT_SYMBOL(dsp_cpustat_get_stat);
-EXPORT_SYMBOL(dsp_cpustat_get_icrmask);
-EXPORT_SYMBOL(dsp_cpustat_set_icrmask);
-EXPORT_SYMBOL(dsp_register_mem_cb);
-EXPORT_SYMBOL(dsp_unregister_mem_cb);
-
-EXPORT_SYMBOL(__cpu_flush_kern_tlb_range);
-EXPORT_SYMBOL(cpu_architecture);
-EXPORT_SYMBOL(pmd_clear_bad);
-#endif
diff --git a/arch/arm/plat-omap/dsp/dsp_core.c b/arch/arm/plat-omap/dsp/dsp_core.c
deleted file mode 100644
index 05274be..0000000
--- a/arch/arm/plat-omap/dsp/dsp_core.c
+++ /dev/null
@@ -1,663 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/sched.h>
-#include <linux/mutex.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <asm/delay.h>
-#include <asm/arch/mailbox.h>
-#include <asm/arch/dsp.h>
-#include <asm/arch/dsp_common.h>
-#include "dsp_mbcmd.h"
-#include "dsp.h"
-#include "ipbuf.h"
-
-MODULE_AUTHOR("Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>");
-MODULE_DESCRIPTION("OMAP DSP driver module");
-MODULE_LICENSE("GPL");
-
-static struct sync_seq *mbseq;
-static u16 mbseq_expect_tmp;
-static u16 *mbseq_expect = &mbseq_expect_tmp;
-
-extern int dsp_mem_late_init(void);
-
-/*
- * mailbox commands
- */
-extern void mbox_wdsnd(struct mbcmd *mb);
-extern void mbox_wdreq(struct mbcmd *mb);
-extern void mbox_bksnd(struct mbcmd *mb);
-extern void mbox_bkreq(struct mbcmd *mb);
-extern void mbox_bkyld(struct mbcmd *mb);
-extern void mbox_bksndp(struct mbcmd *mb);
-extern void mbox_bkreqp(struct mbcmd *mb);
-extern void mbox_tctl(struct mbcmd *mb);
-extern void mbox_poll(struct mbcmd *mb);
-#ifdef OLD_BINARY_SUPPORT
-/* v3.3 obsolete */
-extern void mbox_wdt(struct mbcmd *mb);
-#endif
-extern void mbox_suspend(struct mbcmd *mb);
-static void mbox_kfunc(struct mbcmd *mb);
-extern void mbox_tcfg(struct mbcmd *mb);
-extern void mbox_tadd(struct mbcmd *mb);
-extern void mbox_tdel(struct mbcmd *mb);
-extern void mbox_dspcfg(struct mbcmd *mb);
-extern void mbox_regrw(struct mbcmd *mb);
-extern void mbox_getvar(struct mbcmd *mb);
-extern void mbox_err(struct mbcmd *mb);
-extern void mbox_dbg(struct mbcmd *mb);
-
-static const struct cmdinfo
-	cif_wdsnd    = { "WDSND",    CMD_L_TYPE_TID,    mbox_wdsnd   },
-	cif_wdreq    = { "WDREQ",    CMD_L_TYPE_TID,    mbox_wdreq   },
-	cif_bksnd    = { "BKSND",    CMD_L_TYPE_TID,    mbox_bksnd   },
-	cif_bkreq    = { "BKREQ",    CMD_L_TYPE_TID,    mbox_bkreq   },
-	cif_bkyld    = { "BKYLD",    CMD_L_TYPE_NULL,   mbox_bkyld   },
-	cif_bksndp   = { "BKSNDP",   CMD_L_TYPE_TID,    mbox_bksndp  },
-	cif_bkreqp   = { "BKREQP",   CMD_L_TYPE_TID,    mbox_bkreqp  },
-	cif_tctl     = { "TCTL",     CMD_L_TYPE_TID,    mbox_tctl    },
-	cif_poll     = { "POLL",     CMD_L_TYPE_NULL,   mbox_poll    },
-#ifdef OLD_BINARY_SUPPORT
-	/* v3.3 obsolete */
-	cif_wdt      = { "WDT",      CMD_L_TYPE_NULL,   mbox_wdt     },
-#endif
-	cif_runlevel = { "RUNLEVEL", CMD_L_TYPE_SUBCMD, NULL        },
-	cif_pm       = { "PM",       CMD_L_TYPE_SUBCMD, NULL        },
-	cif_suspend  = { "SUSPEND",  CMD_L_TYPE_NULL,   mbox_suspend },
-	cif_kfunc    = { "KFUNC",    CMD_L_TYPE_SUBCMD, mbox_kfunc   },
-	cif_tcfg     = { "TCFG",     CMD_L_TYPE_TID,    mbox_tcfg    },
-	cif_tadd     = { "TADD",     CMD_L_TYPE_TID,    mbox_tadd    },
-	cif_tdel     = { "TDEL",     CMD_L_TYPE_TID,    mbox_tdel    },
-	cif_tstop    = { "TSTOP",    CMD_L_TYPE_TID,    NULL        },
-	cif_dspcfg   = { "DSPCFG",   CMD_L_TYPE_SUBCMD, mbox_dspcfg  },
-	cif_regrw    = { "REGRW",    CMD_L_TYPE_SUBCMD, mbox_regrw   },
-	cif_getvar   = { "GETVAR",   CMD_L_TYPE_SUBCMD, mbox_getvar  },
-	cif_setvar   = { "SETVAR",   CMD_L_TYPE_SUBCMD, NULL        },
-	cif_err      = { "ERR",      CMD_L_TYPE_SUBCMD, mbox_err     },
-	cif_dbg      = { "DBG",      CMD_L_TYPE_NULL,   mbox_dbg     };
-
-#define MBOX_CMD_MAX	0x80
-const struct cmdinfo *cmdinfo[MBOX_CMD_MAX] = {
-	[MBOX_CMD_DSP_WDSND]    = &cif_wdsnd,
-	[MBOX_CMD_DSP_WDREQ]    = &cif_wdreq,
-	[MBOX_CMD_DSP_BKSND]    = &cif_bksnd,
-	[MBOX_CMD_DSP_BKREQ]    = &cif_bkreq,
-	[MBOX_CMD_DSP_BKYLD]    = &cif_bkyld,
-	[MBOX_CMD_DSP_BKSNDP]   = &cif_bksndp,
-	[MBOX_CMD_DSP_BKREQP]   = &cif_bkreqp,
-	[MBOX_CMD_DSP_TCTL]     = &cif_tctl,
-	[MBOX_CMD_DSP_POLL]     = &cif_poll,
-#ifdef OLD_BINARY_SUPPORT
-	[MBOX_CMD_DSP_WDT]      = &cif_wdt, /* v3.3 obsolete */
-#endif
-	[MBOX_CMD_DSP_RUNLEVEL] = &cif_runlevel,
-	[MBOX_CMD_DSP_PM]       = &cif_pm,
-	[MBOX_CMD_DSP_SUSPEND]  = &cif_suspend,
-	[MBOX_CMD_DSP_KFUNC]    = &cif_kfunc,
-	[MBOX_CMD_DSP_TCFG]     = &cif_tcfg,
-	[MBOX_CMD_DSP_TADD]     = &cif_tadd,
-	[MBOX_CMD_DSP_TDEL]     = &cif_tdel,
-	[MBOX_CMD_DSP_TSTOP]    = &cif_tstop,
-	[MBOX_CMD_DSP_DSPCFG]   = &cif_dspcfg,
-	[MBOX_CMD_DSP_REGRW]    = &cif_regrw,
-	[MBOX_CMD_DSP_GETVAR]   = &cif_getvar,
-	[MBOX_CMD_DSP_SETVAR]   = &cif_setvar,
-	[MBOX_CMD_DSP_ERR]      = &cif_err,
-	[MBOX_CMD_DSP_DBG]      = &cif_dbg,
-};
-
-#define list_for_each_entry_safe_natural(p,n,h,m) \
-			list_for_each_entry_safe(p,n,h,m)
-#define __BUILD_KFUNC(fn, dir)							\
-static int __dsp_kfunc_##fn##_devices(struct omap_dsp *dsp, int type, int stage)\
-{										\
-	struct dsp_kfunc_device *p, *tmp;					\
-	int ret, fail = 0;							\
-										\
-	list_for_each_entry_safe_##dir(p, tmp, dsp->kdev_list, entry) {		\
-		if (type && (p->type != type))					\
-			continue;						\
-		if (p->fn == NULL)						\
-			continue;						\
-		ret = p->fn(p, stage);						\
-		if (ret) {							\
-			printk(KERN_ERR "%s %s failed\n", #fn, p->name);	\
-			fail++;							\
-		}								\
-	}									\
-	return fail;								\
-}
-#define BUILD_KFUNC(fn, dir)						\
-__BUILD_KFUNC(fn, dir)							\
-static inline int dsp_kfunc_##fn##_devices(struct omap_dsp *dsp)	\
-{									\
-	return __dsp_kfunc_##fn##_devices(dsp, 0, 0);			\
-}
-#define BUILD_KFUNC_CTL(fn, dir)							\
-__BUILD_KFUNC(fn, dir)									\
-static inline int dsp_kfunc_##fn##_devices(struct omap_dsp *dsp, int type, int stage)	\
-{											\
-	return __dsp_kfunc_##fn##_devices(dsp, type, stage);				\
-}
-
-BUILD_KFUNC(probe, natural)
-BUILD_KFUNC(remove, reverse)
-BUILD_KFUNC_CTL(enable, natural)
-BUILD_KFUNC_CTL(disable, reverse)
-
-int sync_with_dsp(u16 *adr, u16 val, int try_cnt)
-{
-	int try;
-
-	if (*(volatile u16 *)adr == val)
-		return 0;
-
-	for (try = 0; try < try_cnt; try++) {
-		udelay(1);
-		if (*(volatile u16 *)adr == val) {
-			/* success! */
-			pr_info("omapdsp: sync_with_dsp(): try = %d\n", try);
-			return 0;
-		}
-	}
-
-	/* fail! */
-	return -1;
-}
-
-static int mbcmd_sender_prepare(void *data)
-{
-	struct mb_exarg *arg = data;
-	int i, ret = 0;
-	/*
-	 * even if ipbuf_sys_ad is in DSP internal memory,
-	 * dsp_mem_enable() never cause to call PM mailbox command
-	 * because in that case DSP memory should be always enabled.
-	 * (see ipbuf_sys_hold_mem_active in ipbuf.c)
-	 *
-	 * Therefore, we can call this function here safely.
-	 */
-	dsp_mem_enable(ipbuf_sys_ad);
-	if (sync_with_dsp(&ipbuf_sys_ad->s, TID_FREE, 10) < 0) {
-		printk(KERN_ERR "omapdsp: ipbuf_sys_ad is busy.\n");
-		ret = -EBUSY;
-		goto out;
-	}
-
-	for (i = 0; i < arg->argc; i++) {
-		ipbuf_sys_ad->d[i] = arg->argv[i];
-	}
-	ipbuf_sys_ad->s = arg->tid;
- out:
-	dsp_mem_disable(ipbuf_sys_ad);
-	return ret;
-}
-
-/*
- * __dsp_mbcmd_send_exarg(): mailbox dispatcher
- */
-int __dsp_mbcmd_send_exarg(struct mbcmd *mb, struct mb_exarg *arg,
-			   int recovery_flag)
-{
-	int ret = 0;
-
-	if (unlikely(omap_dsp->enabled == 0)) {
-		ret = dsp_kfunc_enable_devices(omap_dsp,
-					       DSP_KFUNC_DEV_TYPE_COMMON, 0);
-		if (ret == 0)
-			omap_dsp->enabled = 1;
-	}
-
-	/*
-	 * while MMU fault is set,
-	 * only recovery command can be executed
-	 */
-	if (dsp_err_isset(ERRCODE_MMU) && !recovery_flag) {
-		printk(KERN_ERR
-		       "mbox: mmu interrupt is set. %s is aborting.\n",
-		       cmd_name(*mb));
-		goto out;
-	}
-
-	ret = omap_mbox_msg_send(omap_dsp->mbox,
-				 *(mbox_msg_t *)mb, (void*)arg);
-	if (ret)
-		goto out;
-
-	if (mbseq)
-		mbseq->ad_arm++;
-
-	mblog_add(mb, DIR_A2D);
- out:
-	return ret;
-}
-
-int dsp_mbcmd_send_and_wait_exarg(struct mbcmd *mb, struct mb_exarg *arg,
-				  wait_queue_head_t *q)
-{
-	int ret;
-
-	DEFINE_WAIT(wait);
-	prepare_to_wait(q, &wait, TASK_INTERRUPTIBLE);
-	ret = dsp_mbcmd_send_exarg(mb, arg);
-	if (ret < 0)
-		goto out;
-	schedule_timeout(DSP_TIMEOUT);
- out:
-	finish_wait(q, &wait);
-	return ret;
-}
-
-/*
- * mbcmd receiver
- */
-static int mbcmd_receiver(void* msg)
-{
-	struct mbcmd *mb = (struct mbcmd *)&msg;
-
-	if (cmdinfo[mb->cmd_h] == NULL) {
-		printk(KERN_ERR
-		       "invalid message (%08x) for mbcmd_receiver().\n",
-		       (mbox_msg_t)msg);
-		return -1;
-	}
-
-	(*mbseq_expect)++;
-
-	mblog_add(mb, DIR_D2A);
-
-	/* call handler for the command */
-	if (cmdinfo[mb->cmd_h]->handler)
-		cmdinfo[mb->cmd_h]->handler(mb);
-	else
-		printk(KERN_ERR "mbox: %s is not allowed from DSP.\n",
-		       cmd_name(*mb));
-	return 0;
-}
-
-static int mbsync_hold_mem_active;
-
-void dsp_mbox_start(void)
-{
-	omap_mbox_init_seq(omap_dsp->mbox);
-	mbseq_expect_tmp = 0;
-}
-
-void dsp_mbox_stop(void)
-{
-	mbseq = NULL;
-	mbseq_expect = &mbseq_expect_tmp;
-}
-
-int dsp_mbox_config(void *p)
-{
-	unsigned long flags;
-
-	if (dsp_address_validate(p, sizeof(struct sync_seq), "mbseq") < 0)
-		return -1;
-	if (dsp_mem_type(p, sizeof(struct sync_seq)) != MEM_TYPE_EXTERN) {
-		printk(KERN_WARNING
-		       "omapdsp: mbseq is placed in DSP internal memory.\n"
-		       "         It will prevent DSP from idling.\n");
-		mbsync_hold_mem_active = 1;
-		/*
-		 * dsp_mem_enable() never fails because
-		 * it has been already enabled in dspcfg process and
-		 * this will just increment the usecount.
-		 */
-		dsp_mem_enable((void *)daram_base);
-	}
-
-	local_irq_save(flags);
-	mbseq = p;
-	mbseq->da_arm = mbseq_expect_tmp;
-	mbseq_expect = &mbseq->da_arm;
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-static int __init dsp_mbox_init(void)
-{
-	omap_dsp->mbox = omap_mbox_get("dsp");
-	if (IS_ERR(omap_dsp->mbox)) {
-		printk(KERN_ERR "failed to get mailbox handler for DSP.\n");
-		return -ENODEV;
-	}
-
-	omap_dsp->mbox->rxq->callback = mbcmd_receiver;
-	omap_dsp->mbox->txq->callback = mbcmd_sender_prepare;
-
-	return 0;
-}
-
-static void dsp_mbox_exit(void)
-{
-	omap_dsp->mbox->txq->callback = NULL;
-	omap_dsp->mbox->rxq->callback = NULL;
-
-	omap_mbox_put(omap_dsp->mbox);
-
-	if (mbsync_hold_mem_active) {
-		dsp_mem_disable((void *)daram_base);
-		mbsync_hold_mem_active = 0;
-	}
-}
-
-/*
- * kernel function dispatcher
- */
-extern void mbox_fbctl_upd(void);
-extern void mbox_fbctl_disable(struct mbcmd *mb);
-
-static void mbox_kfunc_fbctl(struct mbcmd *mb)
-{
-	switch (mb->data) {
-	case FBCTL_UPD:
-		mbox_fbctl_upd();
-		break;
-	case FBCTL_DISABLE:
-		mbox_fbctl_disable(mb);
-		break;
-	default:
-		printk(KERN_ERR
-		       "mbox: Unknown FBCTL from DSP: 0x%04x\n", mb->data);
-	}
-}
-
-/*
- * dspgw: KFUNC message handler
- */
-static void mbox_kfunc_power(unsigned short data)
-{
-	int ret = -1;
-
-	switch (data) {
-	case DVFS_START: /* ACK from DSP */
-		/* TBD */
-		break;
-	case AUDIO_PWR_UP:
-		ret = dsp_kfunc_enable_devices(omap_dsp,
-					       DSP_KFUNC_DEV_TYPE_AUDIO, 0);
-		if (ret == 0)
-			ret++;
-		break;
-	case AUDIO_PWR_DOWN: /* == AUDIO_PWR_DOWN1 */
-		ret = dsp_kfunc_disable_devices(omap_dsp,
-						DSP_KFUNC_DEV_TYPE_AUDIO, 1);
-		break;
-	case AUDIO_PWR_DOWN2:
-		ret = dsp_kfunc_disable_devices(omap_dsp,
-						DSP_KFUNC_DEV_TYPE_AUDIO, 2);
-		break;
-	case DSP_PWR_DOWN:
-		ret = dsp_kfunc_disable_devices(omap_dsp,
-						DSP_KFUNC_DEV_TYPE_COMMON, 0);
-		if (ret == 0)
-			omap_dsp->enabled = 0;
-		break;
-	default:
-		printk(KERN_ERR
-		       "mailbox: Unknown PWR from DSP: 0x%04x\n", data);
-		break;
-	}
-
-	if (unlikely(ret < 0)) {
-		printk(KERN_ERR "mailbox: PWR(0x%04x) failed\n", data);
-		return;
-	}
-
-	if (likely(ret == 0))
-		return;
-
-	mbcompose_send(KFUNC, KFUNC_POWER, data);
-}
-
-static void mbox_kfunc(struct mbcmd *mb)
-{
-	switch (mb->cmd_l) {
-	case KFUNC_FBCTL:
-		mbox_kfunc_fbctl(mb);
-		break;
-	case KFUNC_POWER:
-		mbox_kfunc_power(mb->data);
-		break;
-	default:
-		printk(KERN_ERR
-		       "mbox: Unknown KFUNC from DSP: 0x%02x\n", mb->cmd_l);
-	}
-}
-
-#if defined(CONFIG_ARCH_OMAP1)
-static inline void dsp_clk_enable(void) {}
-static inline void dsp_clk_disable(void) {}
-#elif defined(CONFIG_ARCH_OMAP2)
-static inline void dsp_clk_enable(void)
-{
-	u32 r;
-
-	/*XXX should be handled in mach-omap[1,2] XXX*/
-	prm_write_mod_reg(OMAP24XX_FORCESTATE | (1 << OMAP_POWERSTATE_SHIFT),
-			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
-
-	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
-	r |= OMAP2420_AUTO_DSP_IPI;
-	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_AUTOIDLE);
-
-	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
-	r |= OMAP24XX_AUTOSTATE_DSP;
-	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
-
-	clk_enable(dsp_fck_handle);
-	clk_enable(dsp_ick_handle);
-	__dsp_per_enable();
-}
-static inline void dsp_clk_disable(void)
-{
-	__dsp_per_disable();
-	clk_disable(dsp_ick_handle);
-	clk_disable(dsp_fck_handle);
-
-	prm_write_mod_reg(OMAP24XX_FORCESTATE | (3 << OMAP_POWERSTATE_SHIFT),
-			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
-}
-#endif
-
-int dsp_late_init(void)
-{
-	int ret;
-
-	dsp_clk_enable();
-	ret = dsp_mem_late_init();
-	if (ret)
-		return ret;
-	ret = dsp_mbox_init();
-	if (ret)
-		goto fail_mbox;
-#ifdef CONFIG_ARCH_OMAP1
-	dsp_set_idle_boot_base(IDLEPG_BASE, IDLEPG_SIZE);
-#endif
-	ret = dsp_kfunc_enable_devices(omap_dsp,
-				       DSP_KFUNC_DEV_TYPE_COMMON, 0);
-	if (ret)
-		goto fail_kfunc;
-	omap_dsp->enabled = 1;
-
-	return 0;
-
- fail_kfunc:
-	dsp_mbox_exit();
- fail_mbox:
-	dsp_clk_disable();
-
-	return ret;
-}
-
-extern int  dsp_ctl_core_init(void);
-extern void dsp_ctl_core_exit(void);
-extern int dsp_ctl_init(void);
-extern void dsp_ctl_exit(void);
-extern int  dsp_mem_init(void);
-extern void dsp_mem_exit(void);
-extern void mblog_init(void);
-extern void mblog_exit(void);
-extern int  dsp_taskmod_init(void);
-extern void dsp_taskmod_exit(void);
-
-/*
- * driver functions
- */
-static int __init dsp_drv_probe(struct platform_device *pdev)
-{
-	int ret;
-	struct omap_dsp *info;
-	struct dsp_platform_data *pdata = pdev->dev.platform_data;
-
-	dev_info(&pdev->dev, "OMAP DSP driver initialization\n");
-
-	info = kzalloc(sizeof(struct omap_dsp), GFP_KERNEL);
-	if (unlikely(info == NULL)) {
-		dev_dbg(&pdev->dev, "no memory for info\n");
-		return -ENOMEM;
-	}
-	platform_set_drvdata(pdev, info);
-	omap_dsp = info;
-
-	mutex_init(&info->lock);
-	info->dev = &pdev->dev;
-	info->kdev_list = &pdata->kdev_list;
-
-	ret = dsp_kfunc_probe_devices(info);
-	if (ret) {
-		ret = -ENXIO;
-		goto fail_kfunc;
-	}
-
-	ret = dsp_ctl_core_init();
-	if (ret)
-		goto fail_ctl_core;
-	ret = dsp_mem_init();
-	if (ret)
-		goto fail_mem;
-	ret = dsp_ctl_init();
-	if (unlikely(ret))
-		goto fail_ctl_init;
-	mblog_init();
-	ret = dsp_taskmod_init();
-	if (ret)
-		goto fail_taskmod;
-
-	return 0;
-
- fail_taskmod:
-	mblog_exit();
-	dsp_ctl_exit();
- fail_ctl_init:
-	dsp_mem_exit();
- fail_mem:
-	dsp_ctl_core_exit();
- fail_ctl_core:
-	dsp_kfunc_remove_devices(info);
- fail_kfunc:
-	kfree(info);
-
-	return ret;
-}
-
-static int dsp_drv_remove(struct platform_device *pdev)
-{
-	struct omap_dsp *info = platform_get_drvdata(pdev);
-
-	dsp_cpustat_request(CPUSTAT_RESET);
-
-	dsp_cfgstat_request(CFGSTAT_CLEAN);
-	dsp_mbox_exit();
-	dsp_taskmod_exit();
-	mblog_exit();
-	dsp_ctl_exit();
-	dsp_mem_exit();
-
-	dsp_ctl_core_exit();
-
-#ifdef CONFIG_ARCH_OMAP2
-	__dsp_per_disable();
-	clk_disable(dsp_ick_handle);
-	clk_disable(dsp_fck_handle);
-#endif
-	dsp_kfunc_remove_devices(info);
-	kfree(info);
-
-	return 0;
-}
-
-#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP1)
-static int dsp_drv_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	dsp_cfgstat_request(CFGSTAT_SUSPEND);
-
-	return 0;
-}
-
-static int dsp_drv_resume(struct platform_device *pdev)
-{
-	dsp_cfgstat_request(CFGSTAT_RESUME);
-
-	return 0;
-}
-#else
-#define dsp_drv_suspend		NULL
-#define dsp_drv_resume		NULL
-#endif /* CONFIG_PM */
-
-static struct platform_driver dsp_driver = {
-	.probe		= dsp_drv_probe,
-	.remove		= dsp_drv_remove,
-	.suspend	= dsp_drv_suspend,
-	.resume		= dsp_drv_resume,
-	.driver		= {
-		.name	= "dsp",
-	},
-};
-
-static int __init omap_dsp_mod_init(void)
-{
-	return platform_driver_register(&dsp_driver);
-}
-
-static void __exit omap_dsp_mod_exit(void)
-{
-	platform_driver_unregister(&dsp_driver);
-}
-
-/* module dependency: need mailbox module that have mbox_dsp_info */
-extern struct omap_mbox mbox_dsp_info;
-struct omap_mbox *mbox_dep = &mbox_dsp_info;
-
-module_init(omap_dsp_mod_init);
-module_exit(omap_dsp_mod_exit);
diff --git a/arch/arm/plat-omap/dsp/dsp_ctl.c b/arch/arm/plat-omap/dsp/dsp_ctl.c
deleted file mode 100644
index 79c1fdf..0000000
--- a/arch/arm/plat-omap/dsp/dsp_ctl.c
+++ /dev/null
@@ -1,1069 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/mutex.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/ioctls.h>
-#include <asm/arch/mailbox.h>
-#include <asm/arch/dsp.h>
-#include "hardware_dsp.h"
-#include "dsp_mbcmd.h"
-#include "dsp.h"
-#include "ipbuf.h"
-
-enum dsp_space_e {
-	SPACE_MEM,
-	SPACE_IO,
-};
-
-#ifdef CONFIG_OMAP_DSP_FBEXPORT
-static enum fbstat_e {
-	FBSTAT_DISABLED = 0,
-	FBSTAT_ENABLED,
-	FBSTAT_MAX,
-} fbstat = FBSTAT_ENABLED;
-#endif
-
-static enum cfgstat_e cfgstat;
-int mbox_revision;
-static u8 n_stask;
-
-static ssize_t ifver_show(struct device *dev, struct device_attribute *attr,
-			  char *buf);
-static ssize_t cpustat_show(struct device *dev, struct device_attribute *attr,
-			    char *buf);
-static ssize_t icrmask_show(struct device *dev, struct device_attribute *attr,
-			    char *buf);
-static ssize_t icrmask_store(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count);
-static ssize_t loadinfo_show(struct device *dev, struct device_attribute *attr,
-			     char *buf);
-
-#define __ATTR_RW(_name, _mode) { \
-	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
-	.show	= _name##_show,					\
-	.store	= _name##_store,					\
-}
-
-static struct device_attribute dev_attr_ifver     = __ATTR_RO(ifver);
-static struct device_attribute dev_attr_cpustat   = __ATTR_RO(cpustat);
-static struct device_attribute dev_attr_icrmask   = __ATTR_RW(icrmask, 0644);
-static struct device_attribute dev_attr_loadinfo  = __ATTR_RO(loadinfo);
-
-/*
- * misc interactive mailbox command operations
- */
-static struct misc_mb_wait_struct {
-	struct mutex lock;
-	wait_queue_head_t wait_q;
-	u8 cmd_h;
-	u8 cmd_l;
-	u16 *retvp;
-} misc_mb_wait = {
-	.lock = __MUTEX_INITIALIZER(misc_mb_wait.lock),
-	.wait_q = __WAIT_QUEUE_HEAD_INITIALIZER(misc_mb_wait.wait_q),
-};
-
-static int __misc_mbcompose_send_and_wait(u8 cmd_h, u8 cmd_l, u16 data,
-					  u16 *retvp)
-{
-	struct mbcmd mb = MBCMD_INIT(cmd_h, cmd_l, data);
-	int ret = 0;
-
-	if (mutex_lock_interruptible(&misc_mb_wait.lock))
-		return -EINTR;
-
-	misc_mb_wait.cmd_h = mb.cmd_h;
-	misc_mb_wait.cmd_l = mb.cmd_l;
-	misc_mb_wait.retvp = retvp;
-	dsp_mbcmd_send_and_wait(&mb, &misc_mb_wait.wait_q);
-
-	if (misc_mb_wait.cmd_h != 0)
-		ret = -EINVAL;
-
-	mutex_unlock(&misc_mb_wait.lock);
-	return ret;
-}
-
-#define misc_mbcompose_send_and_wait(cmd_h, cmd_l, data, retvp) \
-		__misc_mbcompose_send_and_wait(MBOX_CMD_DSP_##cmd_h, (cmd_l), \
-					       (data), (retvp));
-
-static int misc_mbcmd_response(struct mbcmd *mb, int argc, int match_cmd_l_flag)
-{
-	volatile u16 *buf;
-	int i;
-
-	/* if match_cmd_l_v flag is set, cmd_l needs to be matched as well. */
-	if (!waitqueue_active(&misc_mb_wait.wait_q) ||
-	    (misc_mb_wait.cmd_h != mb->cmd_h) ||
-	    (match_cmd_l_flag && (misc_mb_wait.cmd_l != mb->cmd_l))) {
-		const struct cmdinfo *ci = cmdinfo[mb->cmd_h];
-		char cmdstr[32];
-
-		if (ci->cmd_l_type == CMD_L_TYPE_SUBCMD)
-			sprintf(cmdstr, "%s:%s", ci->name, subcmd_name(mb));
-		else
-			strcpy(cmdstr, ci->name);
-		printk(KERN_WARNING
-		       "mbox: unexpected command %s received!\n", cmdstr);
-		return -1;
-	}
-
-	/*
-	 * if argc == 1, receive data through mbox:data register.
-	 * if argc > 1, receive through ipbuf_sys.
-	 */
-	if (argc == 1)
-		misc_mb_wait.retvp[0] = mb->data;
-	else if (argc > 1) {
-		if (dsp_mem_enable(ipbuf_sys_da) < 0) {
-			printk(KERN_ERR "mbox: %s - ipbuf_sys_da read failed!\n",
-			       cmdinfo[mb->cmd_h]->name);
-			return -1;
-		}
-		if (sync_with_dsp(&ipbuf_sys_da->s, TID_ANON, 10) < 0) {
-			printk(KERN_ERR "mbox: %s - IPBUF sync failed!\n",
-			       cmdinfo[mb->cmd_h]->name);
-			dsp_mem_disable(ipbuf_sys_da);
-			return -1;
-		}
-		/* need word access. do not use memcpy. */
-		buf = ipbuf_sys_da->d;
-		for (i = 0; i < argc; i++)
-			misc_mb_wait.retvp[i] = buf[i];
-		release_ipbuf_pvt(ipbuf_sys_da);
-		dsp_mem_disable(ipbuf_sys_da);
-	}
-
-	misc_mb_wait.cmd_h = 0;
-	wake_up_interruptible(&misc_mb_wait.wait_q);
-	return 0;
-}
-
-static int dsp_regread(enum dsp_space_e space, u16 adr, u16 *val)
-{
-	u8 cmd_l = (space == SPACE_MEM) ? REGRW_MEMR : REGRW_IOR;
-	int ret;
-
-	ret = misc_mbcompose_send_and_wait(REGRW, cmd_l, adr, val);
-	if ((ret < 0) && (ret != -EINTR))
-		printk(KERN_ERR "omapdsp: register read error!\n");
-
-	return ret;
-}
-
-static int dsp_regwrite(enum dsp_space_e space, u16 adr, u16 val)
-{
-	u8 cmd_l = (space == SPACE_MEM) ? REGRW_MEMW : REGRW_IOW;
-	struct mb_exarg arg = {
-		.tid  = TID_ANON,
-		.argc = 1,
-		.argv = &val,
-	};
-
-	mbcompose_send_exarg(REGRW, cmd_l, adr, &arg);
-	return 0;
-}
-
-static int dsp_getvar(u8 varid, u16 *val)
-{
-	int ret;
-
-	ret = misc_mbcompose_send_and_wait(GETVAR, varid, 0, val);
-	if ((ret < 0) && (ret != -EINTR))
-		printk(KERN_ERR "omapdsp: variable read error!\n");
-
-	return ret;
-}
-
-static int dsp_setvar(u8 varid, u16 val)
-{
-	mbcompose_send(SETVAR, varid, val);
-	return 0;
-}
-
-/*
- * dsp_cfg() return value
- *  = 0: OK
- *  = 1: failed, but state is clear. (DSPCFG command failed)
- *  < 0: failed. need cleanup.
- */
-static int dsp_cfg(void)
-{
-	int ret = 0;
-
-#ifdef CONFIG_ARCH_OMAP1
-	/* for safety */
-	dsp_mem_usecount_clear();
-#endif
-
-	/*
-	 * DSPCFG command and dsp_mem_start() must be called
-	 * while internal mem is on.
-	 */
-	dsp_mem_enable((void *)dspmem_base);
-
-	dsp_mbox_start();
-	dsp_twch_start();
-	dsp_mem_start();
-	dsp_err_start();
-
-	mbox_revision = -1;
-
-	ret = misc_mbcompose_send_and_wait(DSPCFG, DSPCFG_REQ, 0, NULL);
-	if (ret < 0) {
-		if (ret != -EINTR)
-			printk(KERN_ERR "omapdsp: configuration error!\n");
-		ret = 1;
-		goto out;
-	}
-
-#if defined(CONFIG_ARCH_OMAP1) && defined(OLD_BINARY_SUPPORT)
-	/*
-	 * MBREV 3.2 or earlier doesn't assume DMA domain is on
-	 * when DSPCFG command is sent
-	 */
-	if ((mbox_revision == MBREV_3_0) ||
-	    (mbox_revision == MBREV_3_2)) {
-		if ((ret = mbcompose_send(PM, PM_ENABLE, DSPREG_ICR_DMA)) < 0)
-			goto out;
-	}
-#endif
-
-	if ((ret = dsp_task_config_all(n_stask)) < 0)
-		goto out;
-
-	/* initialization */
-#ifdef CONFIG_OMAP_DSP_FBEXPORT
-	fbstat = FBSTAT_ENABLED;
-#endif
-
-	/* send parameter */
-	ret = dsp_setvar(VARID_ICRMASK, dsp_cpustat_get_icrmask());
-	if (ret < 0)
-		goto out;
-
-	/* create runtime sysfs entries */
-	ret = device_create_file(omap_dsp->dev, &dev_attr_loadinfo);
-	if (ret)
-		printk(KERN_ERR "device_create_file failed: %d\n", ret);
- out:
-	dsp_mem_disable((void *)dspmem_base);
-	return ret;
-}
-
-static int dsp_uncfg(void)
-{
-	if (dsp_taskmod_busy()) {
-		printk(KERN_WARNING "omapdsp: tasks are busy.\n");
-		return -EBUSY;
-	}
-
-	/* FIXME: lock task module */
-
-	/* remove runtime sysfs entries */
-	device_remove_file(omap_dsp->dev, &dev_attr_loadinfo);
-
-	dsp_mbox_stop();
-	dsp_twch_stop();
-	dsp_mem_stop();
-	dsp_err_stop();
-	dsp_dbg_stop();
-	dsp_task_unconfig_all();
-	ipbuf_stop();
-
-	return 0;
-}
-
-static int dsp_suspend(void)
-{
-	int ret;
-
-	ret = misc_mbcompose_send_and_wait(SUSPEND, 0, 0, NULL);
-	if (ret < 0) {
-		if (ret != -EINVAL)
-			printk(KERN_ERR "omapdsp: DSP suspend error!\n");
-		return ret;
-	}
-
-	udelay(100);	/* wait for DSP-side execution */
-	return 0;
-}
-
-int dsp_cfgstat_request(enum cfgstat_e st_req)
-{
-	static DEFINE_MUTEX(cfgstat_lock);
-	int ret = 0, ret_override = 0;
-
-	if (mutex_lock_interruptible(&cfgstat_lock))
-		return -EINTR;
-
-again:
-	switch (st_req) {
-
-	/* cfgstat takes CLEAN, READY or SUSPEND,
-	   while st_req can take SUSPEND in addition. */
-
-	case CFGSTAT_CLEAN:
-		if (cfgstat == CFGSTAT_CLEAN)
-			goto up_out;
-		if ((ret = dsp_uncfg()) < 0)
-			goto up_out;
-		break;
-
-	case CFGSTAT_READY:
-		if (cfgstat != CFGSTAT_CLEAN) {
-			printk(KERN_ERR "omapdsp: DSP is ready already!\n");
-			ret = -EINVAL;
-			goto up_out;
-		}
-
-		ret = dsp_cfg();
-		if (ret > 0) {	/* failed, but state is clear. */
-			ret = -EINVAL;
-			goto up_out;
-		} else if (ret < 0) {	/* failed, need cleanup. */
-			st_req = CFGSTAT_CLEAN;
-			ret_override = ret;
-			goto again;
-		}
-		break;
-
-	/*
-	 * suspend / resume
-	 * DSP is not reset within this code, but done in omap_pm_suspend.
-	 * so if these functions are called from sysfs,
-	 * DSP should be reset / unreset out of these functions.
-	 */
-	case CFGSTAT_SUSPEND:
-		switch (cfgstat) {
-
-		case CFGSTAT_CLEAN:
-			if (dsp_cpustat_get_stat() == CPUSTAT_RUN) {
-				printk(KERN_WARNING
-				       "omapdsp: illegal operation -- trying "
-				       "suspend DSP while it is running but "
-				       "not configured.\n"
-				       "  Resetting DSP.\n");
-				dsp_cpustat_request(CPUSTAT_RESET);
-				ret = -EINVAL;
-			}
-			goto up_out;
-
-		case CFGSTAT_READY:
-			if ((ret = dsp_suspend()) < 0)
-				goto up_out;
-			break;
-
-		case CFGSTAT_SUSPEND:
-			goto up_out;
-
-		default:
-			BUG();
-
-		}
-
-		break;
-
-	case CFGSTAT_RESUME:
-		if (cfgstat != CFGSTAT_SUSPEND) {
-			printk(KERN_WARNING
-			       "omapdsp: DSP resume request, but DSP is not in "
-			       "suspend state.\n");
-			ret = -EINVAL;
-			goto up_out;
-		}
-		st_req = CFGSTAT_READY;
-		break;
-
-	default:
-		BUG();
-
-	}
-
-	cfgstat = st_req;
-up_out:
-	mutex_unlock(&cfgstat_lock);
-	return ret_override ? ret_override : ret;
-}
-
-enum cfgstat_e dsp_cfgstat_get_stat(void)
-{
-	return cfgstat;
-}
-
-/*
- * polls all tasks
- */
-static int dsp_poll(void)
-{
-	int ret;
-
-	ret = misc_mbcompose_send_and_wait(POLL, 0, 0, NULL);
-	if ((ret < 0) && (ret != -EINTR))
-		printk(KERN_ERR "omapdsp: poll error!\n");
-
-	return ret;
-}
-
-int dsp_set_runlevel(u8 level)
-{
-	if (level == RUNLEVEL_RECOVERY) {
-		if (mbcompose_send_recovery(RUNLEVEL, level, 0) < 0)
-			return -EINVAL;
-	} else {
-		if ((level < RUNLEVEL_USER) ||
-		    (level > RUNLEVEL_SUPER))
-			return -EINVAL;
-		if (mbcompose_send(RUNLEVEL, level, 0) < 0)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_OMAP_DSP_FBEXPORT
-static void dsp_fbctl_enable(void)
-{
-	mbcompose_send(KFUNC, KFUNC_FBCTL, FBCTL_ENABLE);
-}
-
-static int dsp_fbctl_disable(void)
-{
-	int ret;
-
-	ret = misc_mbcompose_send_and_wait(KFUNC, KFUNC_FBCTL, FBCTL_DISABLE,
-					   NULL);
-	if ((ret < 0) && (ret != -EINTR))
-		printk(KERN_ERR "omapdsp: fb disable error!\n");
-
-	return 0;
-}
-
-static int dsp_fbstat_request(enum fbstat_e st)
-{
-	static DEFINE_MUTEX(fbstat_lock);
-	int ret = 0;
-
-	if (mutex_lock_interruptible(&fbstat_lock))
-		return -EINTR;
-
-	if (st == fbstat)
-		goto up_out;
-
-	switch (st) {
-	case FBSTAT_ENABLED:
-		dsp_fbctl_enable();
-		break;
-	case FBSTAT_DISABLED:
-		if ((ret = dsp_fbctl_disable()) < 0)
-			goto up_out;
-		break;
-	default:
-		BUG();
-	}
-
-	fbstat = st;
-up_out:
-	mutex_unlock(&fbstat_lock);
-	return 0;
-}
-#endif /* CONFIG_OMAP_DSP_FBEXPORT */
-
-/*
- * DSP control device file operations
- */
-static int dsp_ctl_ioctl(struct inode *inode, struct file *file,
-			 unsigned int cmd, unsigned long arg)
-{
-	int ret = 0;
-
-	switch (cmd) {
-	/*
-	 * command level 1: commands which don't need lock
-	 */
-	case DSPCTL_IOCTL_RUN:
-		dsp_cpustat_request(CPUSTAT_RUN);
-		break;
-
-	case DSPCTL_IOCTL_RESET:
-		dsp_cpustat_request(CPUSTAT_RESET);
-		break;
-
-	case DSPCTL_IOCTL_SETRSTVECT:
-		ret = dsp_set_rstvect((dsp_long_t)arg);
-		break;
-
-#ifdef CONFIG_ARCH_OMAP1
-	case DSPCTL_IOCTL_CPU_IDLE:
-		dsp_cpustat_request(CPUSTAT_CPU_IDLE);
-		break;
-
-	case DSPCTL_IOCTL_GBL_IDLE:
-		dsp_cpustat_request(CPUSTAT_GBL_IDLE);
-		break;
-
-	case DSPCTL_IOCTL_MPUI_WORDSWAP_ON:
-		mpui_wordswap_on();
-		break;
-
-	case DSPCTL_IOCTL_MPUI_WORDSWAP_OFF:
-		mpui_wordswap_off();
-		break;
-
-	case DSPCTL_IOCTL_MPUI_BYTESWAP_ON:
-		mpui_byteswap_on();
-		break;
-
-	case DSPCTL_IOCTL_MPUI_BYTESWAP_OFF:
-		mpui_byteswap_off();
-		break;
-#endif /* CONFIG_ARCH_OMAP1 */
-
-	case DSPCTL_IOCTL_TASKCNT:
-		ret = dsp_task_count();
-		break;
-
-	case DSPCTL_IOCTL_MBSEND:
-		{
-			struct omap_dsp_mailbox_cmd u_cmd;
-			mbox_msg_t msg;
-			if (copy_from_user(&u_cmd, (void *)arg, sizeof(u_cmd)))
-				return -EFAULT;
-			msg = (u_cmd.cmd << 16) | u_cmd.data;
-			ret = dsp_mbcmd_send((struct mbcmd *)&msg);
-			break;
-		}
-
-	case DSPCTL_IOCTL_SETVAR:
-		{
-			struct omap_dsp_varinfo var;
-			if (copy_from_user(&var, (void *)arg, sizeof(var)))
-				return -EFAULT;
-			ret = dsp_setvar(var.varid, var.val[0]);
-			break;
-		}
-
-	case DSPCTL_IOCTL_RUNLEVEL:
-		ret = dsp_set_runlevel(arg);
-		break;
-
-#ifdef CONFIG_OMAP_DSP_FBEXPORT
-	case DSPCTL_IOCTL_FBEN:
-		ret = dsp_fbstat_request(FBSTAT_ENABLED);
-		break;
-#endif
-
-	/*
-	 * command level 2: commands which need lock
-	 */
-	case DSPCTL_IOCTL_DSPCFG:
-		ret = dsp_cfgstat_request(CFGSTAT_READY);
-		break;
-
-	case DSPCTL_IOCTL_DSPUNCFG:
-		ret = dsp_cfgstat_request(CFGSTAT_CLEAN);
-		break;
-
-	case DSPCTL_IOCTL_POLL:
-		ret = dsp_poll();
-		break;
-
-#ifdef CONFIG_OMAP_DSP_FBEXPORT
-	case DSPCTL_IOCTL_FBDIS:
-		ret = dsp_fbstat_request(FBSTAT_DISABLED);
-		break;
-#endif
-
-	case DSPCTL_IOCTL_SUSPEND:
-		if ((ret = dsp_cfgstat_request(CFGSTAT_SUSPEND)) < 0)
-			break;
-		dsp_cpustat_request(CPUSTAT_RESET);
-		break;
-
-	case DSPCTL_IOCTL_RESUME:
-		if ((ret = dsp_cfgstat_request(CFGSTAT_RESUME)) < 0)
-			break;
-		dsp_cpustat_request(CPUSTAT_RUN);
-		break;
-
-	case DSPCTL_IOCTL_REGMEMR:
-		{
-			struct omap_dsp_reginfo *u_reg = (void *)arg;
-			u16 adr, val;
-
-			if (copy_from_user(&adr, &u_reg->adr, sizeof(u16)))
-				return -EFAULT;
-			if ((ret = dsp_regread(SPACE_MEM, adr, &val)) < 0)
-				return ret;
-			if (copy_to_user(&u_reg->val, &val, sizeof(u16)))
-				return -EFAULT;
-			break;
-		}
-
-	case DSPCTL_IOCTL_REGMEMW:
-		{
-			struct omap_dsp_reginfo reg;
-
-			if (copy_from_user(&reg, (void *)arg, sizeof(reg)))
-				return -EFAULT;
-			ret = dsp_regwrite(SPACE_MEM, reg.adr, reg.val);
-			break;
-		}
-
-	case DSPCTL_IOCTL_REGIOR:
-		{
-			struct omap_dsp_reginfo *u_reg = (void *)arg;
-			u16 adr, val;
-
-			if (copy_from_user(&adr, &u_reg->adr, sizeof(u16)))
-				return -EFAULT;
-			if ((ret = dsp_regread(SPACE_IO, adr, &val)) < 0)
-				return ret;
-			if (copy_to_user(&u_reg->val, &val, sizeof(u16)))
-				return -EFAULT;
-			break;
-		}
-
-	case DSPCTL_IOCTL_REGIOW:
-		{
-			struct omap_dsp_reginfo reg;
-
-			if (copy_from_user(&reg, (void *)arg, sizeof(reg)))
-				return -EFAULT;
-			ret = dsp_regwrite(SPACE_IO, reg.adr, reg.val);
-			break;
-		}
-
-	case DSPCTL_IOCTL_GETVAR:
-		{
-			struct omap_dsp_varinfo *u_var = (void *)arg;
-			u8 varid;
-			u16 val[5]; /* maximum */
-			int argc;
-
-			if (copy_from_user(&varid, &u_var->varid, sizeof(u8)))
-				return -EFAULT;
-			switch (varid) {
-			case VARID_ICRMASK:
-				argc = 1;
-				break;
-			case VARID_LOADINFO:
-				argc = 5;
-				break;
-			default:
-				return -EINVAL;
-			}
-			if ((ret = dsp_getvar(varid, val)) < 0)
-				return ret;
-			if (copy_to_user(&u_var->val, val, sizeof(u16) * argc))
-				return -EFAULT;
-			break;
-		}
-
-	default:
-		return -ENOIOCTLCMD;
-	}
-
-	return ret;
-}
-
-/*
- * functions called from mailbox interrupt routine
- */
-void mbox_suspend(struct mbcmd *mb)
-{
-	misc_mbcmd_response(mb, 0, 0);
-}
-
-void mbox_dspcfg(struct mbcmd *mb)
-{
-	u8 last   = mb->cmd_l & 0x80;
-	u8 cfgcmd = mb->cmd_l & 0x7f;
-	static dsp_long_t tmp_ipb_adr;
-
-	if (!waitqueue_active(&misc_mb_wait.wait_q) ||
-	    (misc_mb_wait.cmd_h != MBOX_CMD_DSP_DSPCFG)) {
-		printk(KERN_WARNING
-		       "mbox: DSPCFG command received, "
-		       "but nobody is waiting for it...\n");
-		return;
-	}
-
-	/* mailbox protocol check */
-	if (cfgcmd == DSPCFG_PROTREV) {
-		mbox_revision = mb->data;
-		if (mbox_revision == MBPROT_REVISION)
-			return;
-#ifdef OLD_BINARY_SUPPORT
-		else if ((mbox_revision == MBREV_3_0) ||
-			 (mbox_revision == MBREV_3_2)) {
-			printk(KERN_WARNING
-			       "mbox: ***** old DSP binary *****\n"
-			       "  Please update your DSP application.\n");
-			return;
-		}
-#endif
-		else {
-			printk(KERN_ERR
-			       "mbox: protocol revision check error!\n"
-			       "  expected=0x%04x, received=0x%04x\n",
-			       MBPROT_REVISION, mb->data);
-			mbox_revision = -1;
-			goto abort1;
-		}
-	}
-
-	/*
-	 * following commands are accepted only after
-	 * revision check has been passed.
-	 */
-	if (!mbox_revision < 0) {
-		pr_info("mbox: DSPCFG command received, "
-			"but revision check has not been passed.\n");
-		return;
-	}
-
-	switch (cfgcmd) {
-	case DSPCFG_SYSADRH:
-		tmp_ipb_adr = (u32)mb->data << 16;
-		break;
-
-	case DSPCFG_SYSADRL:
-		tmp_ipb_adr |= mb->data;
-		break;
-
-	case DSPCFG_ABORT:
-		goto abort1;
-
-	default:
-		printk(KERN_ERR
-		       "mbox: Unknown CFG command: cmd_l=0x%02x, data=0x%04x\n",
-		       mb->cmd_l, mb->data);
-		return;
-	}
-
-	if (last) {
-		void *badr;
-		u16 bln;
-		u16 bsz;
-		volatile u16 *buf;
-		void *ipb_sys_da, *ipb_sys_ad;
-		void *mbseq;	 /* FIXME: 3.4 obsolete */
-		short *dbg_buf;
-		u16 dbg_buf_sz, dbg_line_sz;
-		struct mem_sync_struct mem_sync, *mem_syncp;
-
-		ipb_sys_da = dspword_to_virt(tmp_ipb_adr);
-		if (ipbuf_sys_config(ipb_sys_da, DIR_D2A) < 0)
-			goto abort1;
-
-		if (dsp_mem_enable(ipbuf_sys_da) < 0) {
-			printk(KERN_ERR "mbox: DSPCFG - ipbuf_sys_da read failed!\n");
-			goto abort1;
-		}
-		if (sync_with_dsp(&ipbuf_sys_da->s, TID_ANON, 10) < 0) {
-			printk(KERN_ERR "mbox: DSPCFG - IPBUF sync failed!\n");
-			dsp_mem_disable(ipbuf_sys_da);
-			goto abort1;
-		}
-		/*
-		 * read configuration data on system IPBUF
-		 * we must read with 16bit-access
-		 */
-#ifdef OLD_BINARY_SUPPORT
-		if (mbox_revision == MBPROT_REVISION) {
-#endif
-			buf = ipbuf_sys_da->d;
-			n_stask        = buf[0];
-			bln            = buf[1];
-			bsz            = buf[2];
-			badr           = MKVIRT(buf[3], buf[4]);
-			/* ipb_sys_da     = MKVIRT(buf[5], buf[6]); */
-			ipb_sys_ad     = MKVIRT(buf[7], buf[8]);
-			mbseq          = MKVIRT(buf[9], buf[10]);
-			dbg_buf        = MKVIRT(buf[11], buf[12]);
-			dbg_buf_sz     = buf[13];
-			dbg_line_sz    = buf[14];
-			mem_sync.DARAM = MKVIRT(buf[15], buf[16]);
-			mem_sync.SARAM = MKVIRT(buf[17], buf[18]);
-			mem_sync.SDRAM = MKVIRT(buf[19], buf[20]);
-			mem_syncp = &mem_sync;
-#ifdef OLD_BINARY_SUPPORT
-		} else if (mbox_revision == MBREV_3_2) {
-			buf = ipbuf_sys_da->d;
-			n_stask     = buf[0];
-			bln         = buf[1];
-			bsz         = buf[2];
-			badr        = MKVIRT(buf[3], buf[4]);
-			/* ipb_sys_da  = MKVIRT(buf[5], buf[6]); */
-			ipb_sys_ad  = MKVIRT(buf[7], buf[8]);
-			mbseq       = MKVIRT(buf[9], buf[10]);
-			dbg_buf     = NULL;
-			dbg_buf_sz  = 0;
-			dbg_line_sz = 0;
-			mem_syncp   = NULL;
-		} else if (mbox_revision == MBREV_3_0) {
-			buf = ipbuf_sys_da->d;
-			n_stask     = buf[0];
-			bln         = buf[1];
-			bsz         = buf[2];
-			badr        = MKVIRT(buf[3], buf[4]);
-			/* bkeep       = buf[5]; */
-			/* ipb_sys_da  = MKVIRT(buf[6], buf[7]); */
-			ipb_sys_ad  = MKVIRT(buf[8], buf[9]);
-			mbseq       = MKVIRT(buf[10], buf[11]);
-			dbg_buf     = NULL;
-			dbg_buf_sz  = 0;
-			dbg_line_sz = 0;
-			mem_syncp   = NULL;
-		} else { /* should not occur */
-			dsp_mem_disable(ipbuf_sys_da);
-			goto abort1;
-		}
-#endif /* OLD_BINARY_SUPPORT */
-
-		release_ipbuf_pvt(ipbuf_sys_da);
-		dsp_mem_disable(ipbuf_sys_da);
-
-		/*
-		 * following configurations need to be done before
-		 * waking up the dspcfg initiator process.
-		 */
-		if (ipbuf_sys_config(ipb_sys_ad, DIR_A2D) < 0)
-			goto abort1;
-		if (ipbuf_config(bln, bsz, badr) < 0)
-			goto abort1;
-		if (dsp_mbox_config(mbseq) < 0)
-			goto abort2;
-		if (dsp_dbg_config(dbg_buf, dbg_buf_sz, dbg_line_sz) < 0)
-			goto abort2;
-		if (dsp_mem_sync_config(mem_syncp) < 0)
-			goto abort2;
-
-		misc_mb_wait.cmd_h = 0;
-		wake_up_interruptible(&misc_mb_wait.wait_q);
-	}
-	return;
-
-abort2:
-	ipbuf_stop();
-abort1:
-	wake_up_interruptible(&misc_mb_wait.wait_q);
-	return;
-}
-
-void mbox_poll(struct mbcmd *mb)
-{
-	misc_mbcmd_response(mb, 0, 0);
-}
-
-void mbox_regrw(struct mbcmd *mb)
-{
-	switch (mb->cmd_l) {
-	case REGRW_DATA:
-		misc_mbcmd_response(mb, 1, 0);
-		break;
-	default:
-		printk(KERN_ERR
-		       "mbox: Illegal REGRW command: "
-		       "cmd_l=0x%02x, data=0x%04x\n", mb->cmd_l, mb->data);
-		return;
-	}
-}
-
-void mbox_getvar(struct mbcmd *mb)
-{
-	switch (mb->cmd_l) {
-	case VARID_ICRMASK:
-		misc_mbcmd_response(mb, 1, 1);
-		break;
-	case VARID_LOADINFO:
-		misc_mbcmd_response(mb, 5, 1);
-		break;
-	default:
-		printk(KERN_ERR
-		       "mbox: Illegal GETVAR command: "
-		       "cmd_l=0x%02x, data=0x%04x\n", mb->cmd_l, mb->data);
-		return;
-	}
-}
-
-void mbox_fbctl_disable(struct mbcmd *mb)
-{
-	misc_mbcmd_response(mb, 0, 0);
-}
-
-struct file_operations dsp_ctl_fops = {
-	.owner   = THIS_MODULE,
-	.ioctl   = dsp_ctl_ioctl,
-};
-
-/*
- * sysfs files
- */
-
-/* ifver */
-static ssize_t ifver_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
-{
-	int len = 0;
-
-	/*
-	 * I/F VERSION descriptions:
-	 *
-	 * 3.2: sysfs / udev support
-	 *      KMEM_RESERVE / KMEM_RELEASE ioctls for mem device
-	 * 3.3: added following ioctls
-	 *      DSPCTL_IOCTL_GBL_IDLE
-	 *      DSPCTL_IOCTL_CPU_IDLE (instead of DSPCTL_IOCTL_IDLE)
-	 *      DSPCTL_IOCTL_POLL
-	 */
-
-	/*
-	 * print all supporting I/F VERSIONs, like followings.
-	 *
-	 * len += sprintf(buf, "3.2\n");
-	 * len += sprintf(buf, "3.3\n");
-	 */
-	len += sprintf(buf + len, "3.2\n");
-	len += sprintf(buf + len, "3.3\n");
-
-	return len;
-}
-
-/* cpustat */
-static char *cpustat_name[CPUSTAT_MAX] = {
-	[CPUSTAT_RESET]    = "reset",
-#ifdef CONFIG_ARCH_OMAP1
-	[CPUSTAT_GBL_IDLE] = "gbl_idle",
-	[CPUSTAT_CPU_IDLE] = "cpu_idle",
-#endif
-	[CPUSTAT_RUN]      = "run",
-};
-
-static ssize_t cpustat_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	return sprintf(buf, "%s\n", cpustat_name[dsp_cpustat_get_stat()]);
-}
-
-/* icrmask */
-static ssize_t icrmask_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	return sprintf(buf, "0x%04x\n", dsp_cpustat_get_icrmask());
-}
-
-static ssize_t icrmask_store(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
-{
-	u16 mask;
-	int ret;
-
-	mask = simple_strtol(buf, NULL, 16);
-	dsp_cpustat_set_icrmask(mask);
-
-	if (dsp_cfgstat_get_stat() == CFGSTAT_READY) {
-		ret = dsp_setvar(VARID_ICRMASK, mask);
-		if (ret < 0)
-			return ret;
-	}
-
-	return count;
-}
-
-/* loadinfo */
-static ssize_t loadinfo_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
-{
-	int len;
-	int ret;
-	u16 val[5];
-
-	if ((ret = dsp_getvar(VARID_LOADINFO, val)) < 0)
-		return ret;
-
-	/*
-	 * load info value range is 0(free) - 10000(busy):
-	 * if CPU load is not measured on DSP, it sets 0xffff at val[0].
-	 */
-
-	if (val[0] == 0xffff) {
-		len = sprintf(buf,
-			      "currently DSP load info is not available.\n");
-		goto out;
-	}
-
-	len = sprintf(buf,
-		      "DSP load info:\n"
-		      "  10ms average = %3d.%02d%%\n"
-		      "  1sec average = %3d.%02d%%  busiest 10ms = %3d.%02d%%\n"
-		      "  1min average = %3d.%02d%%  busiest 1s   = %3d.%02d%%\n",
-		      val[0]/100, val[0]%100,
-		      val[1]/100, val[1]%100, val[2]/100, val[2]%100,
-		      val[3]/100, val[3]%100, val[4]/100, val[4]%100);
-out:
-	return len;
-}
-
-int __init dsp_ctl_init(void)
-{
-	int ret;
-
-	ret = device_create_file(omap_dsp->dev, &dev_attr_ifver);
-	if (unlikely(ret))
-		return ret;
-	ret = device_create_file(omap_dsp->dev, &dev_attr_cpustat);
-	if (unlikely(ret))
-		goto fail_create_cpustat;
-	ret = device_create_file(omap_dsp->dev, &dev_attr_icrmask);
-	if (unlikely(ret))
-		goto fail_create_icrmask;
-
-	return 0;
-
-fail_create_icrmask:
-	device_remove_file(omap_dsp->dev, &dev_attr_cpustat);
-fail_create_cpustat:
-	device_remove_file(omap_dsp->dev, &dev_attr_ifver);
-
-	return ret;
-}
-
-void dsp_ctl_exit(void)
-{
-	device_remove_file(omap_dsp->dev, &dev_attr_ifver);
-	device_remove_file(omap_dsp->dev, &dev_attr_cpustat);
-	device_remove_file(omap_dsp->dev, &dev_attr_icrmask);
-}
diff --git a/arch/arm/plat-omap/dsp/dsp_ctl_core.c b/arch/arm/plat-omap/dsp/dsp_ctl_core.c
deleted file mode 100644
index 956ef26..0000000
--- a/arch/arm/plat-omap/dsp/dsp_ctl_core.c
+++ /dev/null
@@ -1,132 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2004-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/major.h>
-#include <linux/fs.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include "dsp.h"
-
-#define CTL_MINOR	0
-#define MEM_MINOR	1
-#define TWCH_MINOR	2
-#define ERR_MINOR	3
-
-static struct class *dsp_ctl_class;
-extern struct file_operations dsp_ctl_fops,
-			      dsp_mem_fops,
-			      dsp_twch_fops,
-			      dsp_err_fops;
-
-static int dsp_ctl_core_open(struct inode *inode, struct file *file)
-{
-	static DEFINE_MUTEX(open_lock);
-	int ret = 0;
-
-	if (mutex_lock_interruptible(&open_lock))
-		return -EINTR;
-	if (omap_dsp->initialized == 0) {
-		ret = dsp_late_init();
-		if (ret != 0) {
-			mutex_unlock(&open_lock);
-			return ret;
-		}
-		omap_dsp->initialized = 1;
-	}
-	mutex_unlock(&open_lock);
-
-	switch (iminor(inode)) {
-	case CTL_MINOR:
-		file->f_op = &dsp_ctl_fops;
-		break;
-	case MEM_MINOR:
-		file->f_op = &dsp_mem_fops;
-		break;
-	case TWCH_MINOR:
-		file->f_op = &dsp_twch_fops;
-		break;
-	case ERR_MINOR:
-		file->f_op = &dsp_err_fops;
-		break;
-	default:
-		return -ENXIO;
-	}
-	if (file->f_op && file->f_op->open)
-		return file->f_op->open(inode, file);
-	return 0;
-}
-
-static struct file_operations dsp_ctl_core_fops = {
-	.owner = THIS_MODULE,
-	.open  = dsp_ctl_core_open,
-};
-
-static const struct dev_list {
-	unsigned int	minor;
-	char		*devname;
-	umode_t		mode;
-} dev_list[] = {
-	{CTL_MINOR,  "dspctl",  S_IRUSR | S_IWUSR},
-	{MEM_MINOR,  "dspmem",  S_IRUSR | S_IWUSR | S_IRGRP},
-	{TWCH_MINOR, "dsptwch", S_IRUSR | S_IWUSR | S_IRGRP},
-	{ERR_MINOR,  "dsperr",  S_IRUSR | S_IRGRP},
-};
-
-int __init dsp_ctl_core_init(void)
-{
-	int retval;
-	int i;
-
-	retval = register_chrdev(OMAP_DSP_CTL_MAJOR, "dspctl",
-				 &dsp_ctl_core_fops);
-	if (retval < 0) {
-		printk(KERN_ERR
-		       "omapdsp: failed to register dspctl device: %d\n",
-		       retval);
-		return retval;
-	}
-
-	dsp_ctl_class = class_create(THIS_MODULE, "dspctl");
-	for (i = 0; i < ARRAY_SIZE(dev_list); i++) {
-		device_create(dsp_ctl_class, NULL,
-				    MKDEV(OMAP_DSP_CTL_MAJOR,
-					  dev_list[i].minor),
-				    dev_list[i].devname);
-	}
-
-	return 0;
-}
-
-void dsp_ctl_core_exit(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(dev_list); i++) {
-		device_destroy(dsp_ctl_class,
-				MKDEV(OMAP_DSP_CTL_MAJOR,
-					dev_list[i].minor));
-	}
-	class_destroy(dsp_ctl_class);
-
-	unregister_chrdev(OMAP_DSP_CTL_MAJOR, "dspctl");
-}
diff --git a/arch/arm/plat-omap/dsp/dsp_mbcmd.h b/arch/arm/plat-omap/dsp/dsp_mbcmd.h
deleted file mode 100644
index fb35749..0000000
--- a/arch/arm/plat-omap/dsp/dsp_mbcmd.h
+++ /dev/null
@@ -1,147 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __PLAT_OMAP_DSP_MBCMD_H
-#define __PLAT_OMAP_DSP_MBCMD_H
-/*
- * mailbox command: 0x00 - 0x7f
- * when a driver wants to use mailbox, it must reserve mailbox commands here.
- */
-#define MBOX_CMD_DSP_WDSND	0x10
-#define MBOX_CMD_DSP_WDREQ	0x11
-#define MBOX_CMD_DSP_BKSND	0x20
-#define MBOX_CMD_DSP_BKREQ	0x21
-#define MBOX_CMD_DSP_BKYLD	0x23
-#define MBOX_CMD_DSP_BKSNDP	0x24
-#define MBOX_CMD_DSP_BKREQP	0x25
-#define MBOX_CMD_DSP_TCTL	0x30
-#define MBOX_CMD_DSP_TCTLDATA	0x31
-#define MBOX_CMD_DSP_POLL	0x32
-#define MBOX_CMD_DSP_WDT	0x50
-#define MBOX_CMD_DSP_RUNLEVEL	0x51
-#define MBOX_CMD_DSP_PM		0x52
-#define MBOX_CMD_DSP_SUSPEND	0x53
-#define MBOX_CMD_DSP_KFUNC	0x54
-#define MBOX_CMD_DSP_TCFG	0x60
-#define MBOX_CMD_DSP_TADD	0x62
-#define MBOX_CMD_DSP_TDEL	0x63
-#define MBOX_CMD_DSP_TSTOP	0x65
-#define MBOX_CMD_DSP_DSPCFG	0x70
-#define MBOX_CMD_DSP_REGRW	0x72
-#define MBOX_CMD_DSP_GETVAR	0x74
-#define MBOX_CMD_DSP_SETVAR	0x75
-#define MBOX_CMD_DSP_ERR	0x78
-#define MBOX_CMD_DSP_DBG	0x79
-
-/*
- * DSP mailbox protocol definitions
- */
-#define MBPROT_REVISION	0x0019
-
-#define TCTL_TINIT		0x0000
-#define TCTL_TEN		0x0001
-#define TCTL_TDIS		0x0002
-#define TCTL_TCLR		0x0003
-#define TCTL_TCLR_FORCE		0x0004
-
-#define RUNLEVEL_USER		0x01
-#define RUNLEVEL_SUPER		0x0e
-#define RUNLEVEL_RECOVERY	0x10
-
-#define PM_DISABLE		0x00
-#define PM_ENABLE		0x01
-
-#define KFUNC_FBCTL		0x00
-#define KFUNC_POWER		0x01
-
-#define FBCTL_UPD		0x0000
-#define FBCTL_ENABLE		0x0002
-#define FBCTL_DISABLE		0x0003
-
-/* KFUNC_POWER */
-#define AUDIO_PWR_UP		0x0000	/* ARM(exe/ack)	<->  DSP(req)	*/
-#define AUDIO_PWR_DOWN		0x0001	/* ARM(exe)	<-  DSP(req)	*/
-#define AUDIO_PWR_DOWN1		AUDIO_PWR_DOWN
-#define AUDIO_PWR_DOWN2		0x0002
-#define DSP_PWR_UP		0x0003	/* ARM(exe/snd)	->  DSP(exe)	*/
-#define DSP_PWR_DOWN		0x0004	/* ARM(exe)	<-  DSP(req)	*/
-#define DVFS_START		0x0006	/* ARM(req)	<-> DSP(exe/ack)*/
-#define DVFS_STOP		0x0007	/* ARM(req)	 -> DSP(exe)	*/
-
-#define TDEL_SAFE		0x0000
-#define TDEL_KILL		0x0001
-
-#define DSPCFG_REQ		0x00
-#define DSPCFG_SYSADRH		0x28
-#define DSPCFG_SYSADRL		0x29
-#define DSPCFG_PROTREV		0x70
-#define DSPCFG_ABORT		0x78
-#define DSPCFG_LAST		0x80
-
-#define REGRW_MEMR		0x00
-#define REGRW_MEMW		0x01
-#define REGRW_IOR		0x02
-#define REGRW_IOW		0x03
-#define REGRW_DATA		0x04
-
-#define VARID_ICRMASK		0x00
-#define VARID_LOADINFO		0x01
-
-#define TTYP_ARCV		0x0001
-#define TTYP_ASND		0x0002
-#define TTYP_BKMD		0x0004
-#define TTYP_BKDM		0x0008
-#define TTYP_PVMD		0x0010
-#define TTYP_PVDM		0x0020
-
-#define EID_BADTID		0x10
-#define EID_BADTCN		0x11
-#define EID_BADBID		0x20
-#define EID_BADCNT		0x21
-#define EID_NOTLOCKED		0x22
-#define EID_STVBUF		0x23
-#define EID_BADADR		0x24
-#define EID_BADTCTL		0x30
-#define EID_BADPARAM		0x50
-#define EID_FATAL		0x58
-#define EID_NOMEM		0xc0
-#define EID_NORES		0xc1
-#define EID_IPBFULL		0xc2
-#define EID_WDT			0xd0
-#define EID_TASKNOTRDY		0xe0
-#define EID_TASKBSY		0xe1
-#define EID_TASKERR		0xef
-#define EID_BADCFGTYP		0xf0
-#define EID_DEBUG		0xf8
-#define EID_BADSEQ		0xfe
-#define EID_BADCMD		0xff
-
-#define TNM_LEN			16
-
-#define TID_FREE		0xff
-#define TID_ANON		0xfe
-
-#define BID_NULL		0xffff
-#define BID_PVT			0xfffe
-
-#endif /* __PLAT_OMAP_DSP_MBCMD_H */
diff --git a/arch/arm/plat-omap/dsp/dsp_mem.c b/arch/arm/plat-omap/dsp/dsp_mem.c
deleted file mode 100644
index ca87a3a..0000000
--- a/arch/arm/plat-omap/dsp/dsp_mem.c
+++ /dev/null
@@ -1,482 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * Conversion to mempool API and ARM MMU section mapping
- * by Paul Mundt <paul.mundt@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/fb.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/mempool.h>
-#include <linux/clk.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/pgalloc.h>
-#include <asm/pgtable.h>
-#include <asm/arch/tc.h>
-#include <asm/arch/omapfb.h>
-#include <asm/arch/dsp.h>
-#include <asm/arch/mailbox.h>
-#include <asm/arch/mmu.h>
-#include "dsp_mbcmd.h"
-#include "dsp.h"
-#include "ipbuf.h"
-
-#if defined(CONFIG_ARCH_OMAP1)
-#include "../../mach-omap1/mmu.h"
-#elif defined(CONFIG_ARCH_OMAP2)
-#include "../../mach-omap2/mmu.h"
-#endif
-
-#include "mmu.h"
-
-static struct mem_sync_struct mem_sync;
-
-int dsp_mem_sync_inc(void)
-{
-	if (dsp_mem_enable((void *)dspmem_base) < 0)
-		return -1;
-	if (mem_sync.DARAM)
-		mem_sync.DARAM->ad_arm++;
-	if (mem_sync.SARAM)
-		mem_sync.SARAM->ad_arm++;
-	if (mem_sync.SDRAM)
-		mem_sync.SDRAM->ad_arm++;
-	dsp_mem_disable((void *)dspmem_base);
-
-	return 0;
-}
-
-/*
- * dsp_mem_sync_config() is called from mbox1 workqueue
- */
-int dsp_mem_sync_config(struct mem_sync_struct *sync)
-{
-	size_t sync_seq_sz = sizeof(struct sync_seq);
-
-#ifdef OLD_BINARY_SUPPORT
-	if (sync == NULL) {
-		memset(&mem_sync, 0, sizeof(struct mem_sync_struct));
-		return 0;
-	}
-#endif
-	if ((dsp_mem_type(sync->DARAM, sync_seq_sz) != MEM_TYPE_DARAM) ||
-	    (dsp_mem_type(sync->SARAM, sync_seq_sz) != MEM_TYPE_SARAM) ||
-	    (dsp_mem_type(sync->SDRAM, sync_seq_sz) != MEM_TYPE_EXTERN)) {
-		printk(KERN_ERR
-		       "omapdsp: mem_sync address validation failure!\n"
-		       "  mem_sync.DARAM = 0x%p,\n"
-		       "  mem_sync.SARAM = 0x%p,\n"
-		       "  mem_sync.SDRAM = 0x%p,\n",
-		       sync->DARAM, sync->SARAM, sync->SDRAM);
-		return -1;
-	}
-
-	memcpy(&mem_sync, sync, sizeof(struct mem_sync_struct));
-
-	return 0;
-}
-
-
-enum dsp_mem_type_e dsp_mem_type(void *vadr, size_t len)
-{
-	void *ds = (void *)daram_base;
-	void *de = (void *)daram_base + daram_size;
-	void *ss = (void *)saram_base;
-	void *se = (void *)saram_base + saram_size;
-	int ret;
-
-	if ((vadr >= ds) && (vadr < de)) {
-		if (vadr + len > de)
-			return MEM_TYPE_CROSSING;
-		else
-			return MEM_TYPE_DARAM;
-	} else if ((vadr >= ss) && (vadr < se)) {
-		if (vadr + len > se)
-			return MEM_TYPE_CROSSING;
-		else
-			return MEM_TYPE_SARAM;
-	} else {
-		down_read(&dsp_mmu.exmap_sem);
-		if (exmap_valid(&dsp_mmu, vadr, len))
-			ret = MEM_TYPE_EXTERN;
-		else
-			ret = MEM_TYPE_NONE;
-		up_read(&dsp_mmu.exmap_sem);
-		return ret;
-	}
-}
-
-int dsp_address_validate(void *p, size_t len, char *fmt, ...)
-{
-	char s[64];
-	va_list args;
-
-	if (dsp_mem_type(p, len) > 0)
-		return 0;
-
-	if (fmt == NULL)
-		goto out;
-
-	va_start(args, fmt);
-	vsprintf(s, fmt, args);
-	va_end(args);
-	printk(KERN_ERR
-	       "omapdsp: %s address(0x%p) and size(0x%x) is not valid!\n"
-	       "(crossing different type of memories, or external memory\n"
-	       "space where no actual memory is mapped)\n", s, p, len);
- out:
-	return -1;
-}
-
-#ifdef CONFIG_OMAP_DSP_FBEXPORT
-
-static inline unsigned long lineup_offset(unsigned long adr,
-					  unsigned long ref,
-					  unsigned long mask)
-{
-	unsigned long newadr;
-
-	newadr = (adr & ~mask) | (ref & mask);
-	if (newadr < adr)
-		newadr += mask + 1;
-	return newadr;
-}
-
-/*
- * fb update functions:
- * fbupd_response() is executed by the workqueue.
- * fbupd_cb() is called when fb update is done, in interrupt context.
- * mbox_fbupd() is called when KFUNC:FBCTL:UPD is received from DSP.
- */
-static void fbupd_response(struct work_struct *unused)
-{
-	int status;
-
-	status = mbcompose_send(KFUNC, KFUNC_FBCTL, FBCTL_UPD);
-	if (status == 0)
-		return;
-
-	/* FIXME: DSP is busy !! */
-	printk(KERN_ERR
-	       "omapdsp:"
-	       "DSP is busy when trying to send FBCTL:UPD response!\n");
-}
-
-static DECLARE_WORK(fbupd_response_work, fbupd_response);
-
-static void fbupd_cb(void *arg)
-{
-	schedule_work(&fbupd_response_work);
-}
-
-void mbox_fbctl_upd(void)
-{
-	struct omapfb_update_window win;
-	volatile unsigned short *buf = ipbuf_sys_da->d;
-
-	if (sync_with_dsp(&ipbuf_sys_da->s, TID_ANON, 5000) < 0) {
-		printk(KERN_ERR "mbox: FBCTL:UPD - IPBUF sync failed!\n");
-		return;
-	}
-	win.x = buf[0];
-	win.y = buf[1];
-	win.width = buf[2];
-	win.height = buf[3];
-	win.format = buf[4];
-	release_ipbuf_pvt(ipbuf_sys_da);
-
-#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
-	if (!omapfb_ready) {
-		printk(KERN_WARNING
-		       "omapdsp: fbupd() called while HWA742 is not ready!\n");
-		return;
-	}
-#endif
-	omapfb_update_window_async(registered_fb[0], &win, fbupd_cb, NULL);
-}
-
-#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
-static int omapfb_notifier_cb(struct notifier_block *omapfb_nb,
-			      unsigned long event, void *fbi)
-{
-	pr_info("omapfb_notifier_cb(): event = %s\n",
-		(event == OMAPFB_EVENT_READY)    ? "READY" :
-		(event == OMAPFB_EVENT_DISABLED) ? "DISABLED" : "Unknown");
-	if (event == OMAPFB_EVENT_READY)
-		omapfb_ready = 1;
-	else if (event == OMAPFB_EVENT_DISABLED)
-		omapfb_ready = 0;
-	return 0;
-}
-#endif
-
-static int dsp_fbexport(dsp_long_t *dspadr)
-{
-	dsp_long_t dspadr_actual;
-	unsigned long padr_sys, padr, fbsz_sys, fbsz;
-	int cnt;
-#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
-	int status;
-#endif
-
-	pr_debug( "omapdsp: frame buffer export\n");
-
-#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
-	if (omapfb_nb) {
-		printk(KERN_WARNING
-		       "omapdsp: frame buffer has been exported already!\n");
-		return -EBUSY;
-	}
-#endif
-
-	if (num_registered_fb == 0) {
-		pr_info("omapdsp: frame buffer not registered.\n");
-		return -EINVAL;
-	}
-	if (num_registered_fb != 1) {
-		pr_info("omapdsp: %d frame buffers found. we use first one.\n",
-			num_registered_fb);
-	}
-	padr_sys = registered_fb[0]->fix.smem_start;
-	fbsz_sys = registered_fb[0]->fix.smem_len;
-	if (fbsz_sys == 0) {
-		printk(KERN_ERR
-		       "omapdsp: framebuffer doesn't seem to be configured "
-		       "correctly! (size=0)\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * align padr and fbsz to 4kB boundary
-	 * (should be noted to the user afterwards!)
-	 */
-	padr = padr_sys & ~(SZ_4K-1);
-	fbsz = (fbsz_sys + padr_sys - padr + SZ_4K-1) & ~(SZ_4K-1);
-
-	/* line up dspadr offset with padr */
-	dspadr_actual =
-		(fbsz > SZ_1M) ?  lineup_offset(*dspadr, padr, SZ_1M-1) :
-		(fbsz > SZ_64K) ? lineup_offset(*dspadr, padr, SZ_64K-1) :
-		/* (fbsz > SZ_4KB) ? */ *dspadr;
-	if (dspadr_actual != *dspadr)
-		pr_debug(
-			"omapdsp: actual dspadr for FBEXPORT = %08x\n",
-			dspadr_actual);
-	*dspadr = dspadr_actual;
-
-	cnt = omap_mmu_exmap(&dsp_mmu, dspadr_actual, padr, fbsz,
-			     EXMAP_TYPE_FB);
-	if (cnt < 0) {
-		printk(KERN_ERR "omapdsp: exmap failure.\n");
-		return cnt;
-	}
-
-	if ((padr != padr_sys) || (fbsz != fbsz_sys)) {
-		printk(KERN_WARNING
-"  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
-"  !!  screen base address or size is not aligned in 4kB:           !!\n"
-"  !!    actual screen  adr = %08lx, size = %08lx                   !!\n"
-"  !!    exporting      adr = %08lx, size = %08lx                   !!\n"
-"  !!  Make sure that the framebuffer is allocated with 4kB-order!  !!\n"
-"  !!  Otherwise DSP can corrupt the kernel memory.                 !!\n"
-"  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n",
-		       padr_sys, fbsz_sys, padr, fbsz);
-	}
-
-	/* increase the DMA priority */
-	set_emiff_dma_prio(15);
-
-#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
-	omapfb_nb = kzalloc(sizeof(struct omapfb_notifier_block), GFP_KERNEL);
-	if (omapfb_nb == NULL) {
-		printk(KERN_ERR
-		       "omapdsp: failed to allocate memory for omapfb_nb!\n");
-		omap_mmu_exunmap(&dsp_mmu, (unsigned long)dspadr);
-		return -ENOMEM;
-	}
-
-	status = omapfb_register_client(omapfb_nb, omapfb_notifier_cb, NULL);
-	if (status)
-		pr_info("omapfb_register_client(): failure(%d)\n", status);
-#endif
-
-	return cnt;
-}
-#else
-void mbox_fbctl_upd(void) { }
-#endif
-
-/* dsp/mem fops: backward compatibility */
-static ssize_t dsp_mem_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
-{
-	struct bin_attribute attr;
-
-	return __omap_mmu_mem_read(&dsp_mmu, &attr,
-				   (char __user *)buf, *ppos, count);
-}
-
-static ssize_t dsp_mem_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
-{
-	struct bin_attribute attr;
-
-	return __omap_mmu_mem_write(&dsp_mmu, &attr,
-				    (char __user *)buf, *ppos, count);
-}
-
-static int dsp_mem_ioctl(struct inode *inode, struct file *file,
-			 unsigned int cmd, unsigned long arg)
-{
-	struct omap_dsp_mapinfo mapinfo;
-	__u32 size;
-
-	switch (cmd) {
-	case MEM_IOCTL_MMUINIT:
-		if (dsp_mmu.exmap_tbl)
-			omap_mmu_unregister(&dsp_mmu);
-		dsp_mem_ipi_init();
-		return omap_mmu_register(&dsp_mmu);
-
-	case MEM_IOCTL_EXMAP:
-		if (copy_from_user(&mapinfo, (void __user *)arg,
-				   sizeof(mapinfo)))
-			return -EFAULT;
-		return omap_mmu_exmap(&dsp_mmu, mapinfo.dspadr,
-				      0, mapinfo.size, EXMAP_TYPE_MEM);
-
-	case MEM_IOCTL_EXUNMAP:
-		return omap_mmu_exunmap(&dsp_mmu, (unsigned long)arg);
-
-	case MEM_IOCTL_EXMAP_FLUSH:
-		omap_mmu_exmap_flush(&dsp_mmu);
-		return 0;
-#ifdef CONFIG_OMAP_DSP_FBEXPORT
-	case MEM_IOCTL_FBEXPORT:
-	{
-		dsp_long_t dspadr;
-		int ret;
-		if (copy_from_user(&dspadr, (void __user *)arg,
-				   sizeof(dsp_long_t)))
-			return -EFAULT;
-		ret = dsp_fbexport(&dspadr);
-		if (copy_to_user((void __user *)arg, &dspadr,
-				 sizeof(dsp_long_t)))
-			return -EFAULT;
-		return ret;
-	}
-#endif
-	case MEM_IOCTL_MMUITACK:
-		return dsp_mmu_itack();
-
-	case MEM_IOCTL_KMEM_RESERVE:
-
-		if (copy_from_user(&size, (void __user *)arg,
-				   sizeof(__u32)))
-			return -EFAULT;
-		return omap_mmu_kmem_reserve(&dsp_mmu, size);
-
-
-	case MEM_IOCTL_KMEM_RELEASE:
-		omap_mmu_kmem_release();
-		return 0;
-
-	default:
-		return -ENOIOCTLCMD;
-	}
-}
-
-struct file_operations dsp_mem_fops = {
-	.owner   = THIS_MODULE,
-	.read	 = dsp_mem_read,
-	.write	 = dsp_mem_write,
-	.ioctl   = dsp_mem_ioctl,
-};
-
-void dsp_mem_start(void)
-{
-	dsp_register_mem_cb(intmem_enable, intmem_disable);
-}
-
-void dsp_mem_stop(void)
-{
-	memset(&mem_sync, 0, sizeof(struct mem_sync_struct));
-	dsp_unregister_mem_cb();
-}
-
-static void dsp_mmu_irq_work(struct work_struct *work)
-{
-	struct omap_mmu *mmu = container_of(work, struct omap_mmu, irq_work);
-
-	if (dsp_cfgstat_get_stat() == CFGSTAT_READY) {
-		dsp_err_set(ERRCODE_MMU, mmu->fault_address);
-		return;
-	}
-	omap_mmu_itack(mmu);
-	pr_info("Resetting DSP...\n");
-	dsp_cpustat_request(CPUSTAT_RESET);
-	omap_mmu_enable(mmu, 0);
-}
-
-/*
- * later half of dsp memory initialization
- */
-int dsp_mem_late_init(void)
-{
-	int ret;
-
-	dsp_mem_ipi_init();
-
-	INIT_WORK(&dsp_mmu.irq_work, dsp_mmu_irq_work);
-	ret = omap_mmu_register(&dsp_mmu);
-	if (ret) {
-		dsp_reset_idle_boot_base();
-		goto out;
-	}
-	omap_dsp->mmu = &dsp_mmu;
- out:
-	return ret;
-}
-
-int __init dsp_mem_init(void)
-{
-#ifdef CONFIG_ARCH_OMAP2
-	dsp_mmu.clk    = dsp_fck_handle;
-	dsp_mmu.memclk = dsp_ick_handle;
-#elif defined(CONFIG_ARCH_OMAP1)
-	dsp_mmu.clk    = dsp_ck_handle;
-	dsp_mmu.memclk = api_ck_handle;
-#endif
-	return 0;
-}
-
-void dsp_mem_exit(void)
-{
-	dsp_reset_idle_boot_base();
-	omap_mmu_unregister(&dsp_mmu);
-}
diff --git a/arch/arm/plat-omap/dsp/error.c b/arch/arm/plat-omap/dsp/error.c
deleted file mode 100644
index d2276f9..0000000
--- a/arch/arm/plat-omap/dsp/error.c
+++ /dev/null
@@ -1,227 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/poll.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <asm/arch/mailbox.h>
-#include <asm/uaccess.h>
-#include "dsp_mbcmd.h"
-#include "dsp.h"
-
-/*
- * value seen through read()
- */
-#define DSP_ERR_WDT	0x00000001
-#define DSP_ERR_MMU	0x00000002
-static unsigned long errval;
-
-static DECLARE_WAIT_QUEUE_HEAD(err_wait_q);
-static int errcnt;
-static u16 wdtval;	/* FIXME: read through ioctl */
-static u32 mmu_fadr;	/* FIXME: read through ioctl */
-
-/*
- * DSP error detection device file operations
- */
-static ssize_t dsp_err_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
-{
-	unsigned long flags;
-	int status;
-	DEFINE_WAIT(wait);
-
-	if (count < 4)
-		return 0;
-
-	prepare_to_wait(&err_wait_q, &wait, TASK_INTERRUPTIBLE);
-	if (errcnt == 0)
-		schedule();
-	finish_wait(&err_wait_q, &wait);
-	if (signal_pending(current))
-		return -EINTR;
-
-	local_irq_save(flags);
-	status = copy_to_user(buf, &errval, 4);
-	if (status) {
-		local_irq_restore(flags);
-		return -EFAULT;
-	}
-	errcnt = 0;
-	local_irq_restore(flags);
-
-	return 4;
-}
-
-static unsigned int dsp_err_poll(struct file *file, poll_table *wait)
-{
-	unsigned int mask = 0;
-
-	poll_wait(file, &err_wait_q, wait);
-	if (errcnt != 0)
-		mask |= POLLIN | POLLRDNORM;
-
-	return mask;
-}
-
-struct file_operations dsp_err_fops = {
-	.owner = THIS_MODULE,
-	.poll  = dsp_err_poll,
-	.read  = dsp_err_read,
-};
-
-/*
- * set / clear functions
- */
-
-/* DSP MMU */
-static void dsp_err_mmu_set(unsigned long arg)
-{
-	disable_irq(omap_dsp->mmu->irq);
-	mmu_fadr = (u32)arg;
-}
-
-static void dsp_err_mmu_clr(void)
-{
-	enable_irq(omap_dsp->mmu->irq);
-}
-
-/* WDT */
-static void dsp_err_wdt_set(unsigned long arg)
-{
-	wdtval = (u16)arg;
-}
-
-/*
- * error code handler
- */
-static struct {
-	unsigned long val;
-	void (*set)(unsigned long arg);
-	void (*clr)(void);
-} dsp_err_desc[ERRCODE_MAX] = {
-	[ERRCODE_MMU] = { DSP_ERR_MMU, dsp_err_mmu_set, dsp_err_mmu_clr },
-	[ERRCODE_WDT] = { DSP_ERR_WDT, dsp_err_wdt_set, NULL },
-};
-
-void dsp_err_set(enum errcode_e code, unsigned long arg)
-{
-	if (dsp_err_desc[code].set != NULL)
-		dsp_err_desc[code].set(arg);
-
-	errval |= dsp_err_desc[code].val;
-	errcnt++;
-	wake_up_interruptible(&err_wait_q);
-}
-
-void dsp_err_clear(enum errcode_e code)
-{
-	errval &= ~dsp_err_desc[code].val;
-
-	if (dsp_err_desc[code].clr != NULL)
-		dsp_err_desc[code].clr();
-}
-
-int dsp_err_isset(enum errcode_e code)
-{
-	return (errval & dsp_err_desc[code].val) ? 1 : 0;
-}
-
-void dsp_err_notify(void)
-{
-	/* new error code should be assigned */
-	dsp_err_set(DSP_ERR_WDT, 0);
-}
-
-/*
- * functions called from mailbox interrupt routine
- */
-static void mbox_err_wdt(u16 data)
-{
-	dsp_err_set(DSP_ERR_WDT, (unsigned long)data);
-}
-
-#ifdef OLD_BINARY_SUPPORT
-/* v3.3 obsolete */
-void mbox_wdt(struct mbcmd *mb)
-{
-	mbox_err_wdt(mb->data);
-}
-#endif
-
-extern void mbox_err_ipbfull(void);
-extern void mbox_err_fatal(u8 tid);
-
-void mbox_err(struct mbcmd *mb)
-{
-	u8 eid = mb->cmd_l;
-	char *eidnm = subcmd_name(mb);
-	u8 tid;
-
-	if (eidnm) {
-		printk(KERN_WARNING
-		       "mbox: ERR from DSP (%s): 0x%04x\n", eidnm, mb->data);
-	} else {
-		printk(KERN_WARNING
-		       "mbox: ERR from DSP (unknown EID=%02x): %04x\n",
-		       eid, mb->data);
-	}
-
-	switch (eid) {
-	case EID_IPBFULL:
-		mbox_err_ipbfull();
-		break;
-
-	case EID_FATAL:
-		tid = mb->data & 0x00ff;
-		mbox_err_fatal(tid);
-		break;
-
-	case EID_WDT:
-		mbox_err_wdt(mb->data);
-		break;
-	}
-}
-
-/*
- *
- */
-void dsp_err_start(void)
-{
-	enum errcode_e i;
-
-	for (i = 0; i < ERRCODE_MAX; i++) {
-		if (dsp_err_isset(i))
-			dsp_err_clear(i);
-	}
-	omap_dsp->mbox->err_notify = dsp_err_notify;
-	errcnt = 0;
-}
-
-void dsp_err_stop(void)
-{
-	wake_up_interruptible(&err_wait_q);
-	omap_dsp->mbox->err_notify = NULL;
-}
diff --git a/arch/arm/plat-omap/dsp/hardware_dsp.h b/arch/arm/plat-omap/dsp/hardware_dsp.h
deleted file mode 100644
index 5af46f8..0000000
--- a/arch/arm/plat-omap/dsp/hardware_dsp.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __OMAP_DSP_HARDWARE_DSP_H
-#define __OMAP_DSP_HARDWARE_DSP_H
-
-#ifdef CONFIG_ARCH_OMAP1
-#include "omap1_dsp.h"
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3430)
-#include "omap2_dsp.h"
-#endif
-
-#endif /* __OMAP_DSP_HARDWARE_DSP_H */
diff --git a/arch/arm/plat-omap/dsp/ipbuf.c b/arch/arm/plat-omap/dsp/ipbuf.c
deleted file mode 100644
index aba8e74..0000000
--- a/arch/arm/plat-omap/dsp/ipbuf.c
+++ /dev/null
@@ -1,353 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/sched.h>
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <asm/arch/mailbox.h>
-#include "dsp_mbcmd.h"
-#include "dsp.h"
-#include "ipbuf.h"
-
-static struct ipbuf_head *g_ipbuf;
-struct ipbcfg ipbcfg;
-struct ipbuf_sys *ipbuf_sys_da, *ipbuf_sys_ad;
-static struct ipblink ipb_free = IPBLINK_INIT;
-static int ipbuf_sys_hold_mem_active;
-
-static ssize_t ipbuf_show(struct device *dev, struct device_attribute *attr,
-			  char *buf);
-static struct device_attribute dev_attr_ipbuf = __ATTR_RO(ipbuf);
-
-void ipbuf_stop(void)
-{
-	int i;
-
-	device_remove_file(omap_dsp->dev, &dev_attr_ipbuf);
-
-	spin_lock(&ipb_free.lock);
-	RESET_IPBLINK(&ipb_free);
-	spin_unlock(&ipb_free.lock);
-
-	ipbcfg.ln = 0;
-	if (g_ipbuf) {
-		kfree(g_ipbuf);
-		g_ipbuf = NULL;
-	}
-	for (i = 0; i < ipbuf_sys_hold_mem_active; i++) {
-		dsp_mem_disable((void *)daram_base);
-	}
-	ipbuf_sys_hold_mem_active = 0;
-}
-
-int ipbuf_config(u16 ln, u16 lsz, void *base)
-{
-	size_t lsz_byte = ((size_t)lsz) << 1;
-	size_t size;
-	int ret = 0;
-	int i;
-
-	/*
-	 * global IPBUF
-	 */
-	if (((unsigned long)base) & 0x3) {
-		printk(KERN_ERR
-		       "omapdsp: global ipbuf address(0x%p) is not "
-		       "32-bit aligned!\n", base);
-		return -EINVAL;
-	}
-	size = lsz_byte * ln;
-	if (dsp_address_validate(base, size, "global ipbuf") < 0)
-		return -EINVAL;
-
-	g_ipbuf = kmalloc(sizeof(struct ipbuf_head) * ln, GFP_KERNEL);
-	if (g_ipbuf == NULL) {
-		printk(KERN_ERR
-		       "omapdsp: memory allocation for ipbuf failed.\n");
-		return -ENOMEM;
-	}
-	for (i = 0; i < ln; i++) {
-		void *top, *btm;
-
-		top = base + (sizeof(struct ipbuf) + lsz_byte) * i;
-		btm = base + (sizeof(struct ipbuf) + lsz_byte) * (i+1) - 1;
-		g_ipbuf[i].p = (struct ipbuf *)top;
-		g_ipbuf[i].bid = i;
-		if (((unsigned long)top & 0xfffe0000) !=
-		    ((unsigned long)btm & 0xfffe0000)) {
-			/*
-			 * an ipbuf line should not cross
-			 * 64k-word boundary.
-			 */
-			printk(KERN_ERR
-			       "omapdsp: ipbuf[%d] crosses 64k-word boundary!\n"
-			       "  @0x%p, size=0x%08x\n", i, top, lsz_byte);
-			ret = -EINVAL;
-			goto free_out;
-		}
-	}
-	ipbcfg.ln       = ln;
-	ipbcfg.lsz      = lsz;
-	ipbcfg.base     = base;
-	ipbcfg.bsycnt   = ln;	/* DSP holds all ipbufs initially. */
-	ipbcfg.cnt_full = 0;
-
-	pr_info("omapdsp: IPBUF configuration\n"
-		"           %d words * %d lines at 0x%p.\n",
-		ipbcfg.lsz, ipbcfg.ln, ipbcfg.base);
-
-	ret = device_create_file(omap_dsp->dev, &dev_attr_ipbuf);
-	if (ret)
-		printk(KERN_ERR "device_create_file failed: %d\n", ret);
-
-	return ret;
-
- free_out:
-	kfree(g_ipbuf);
-	g_ipbuf = NULL;
-	return ret;
-}
-
-int ipbuf_sys_config(void *p, arm_dsp_dir_t dir)
-{
-	char *dir_str = (dir == DIR_D2A) ? "D2A" : "A2D";
-
-	if (((unsigned long)p) & 0x3) {
-		printk(KERN_ERR
-		       "omapdsp: system ipbuf(%s) address(0x%p) is "
-		       "not 32-bit aligned!\n", dir_str, p);
-		return -1;
-	}
-	if (dsp_address_validate(p, sizeof(struct ipbuf_sys),
-				 "system ipbuf(%s)", dir_str) < 0)
-		return -1;
-	if (dsp_mem_type(p, sizeof(struct ipbuf_sys)) != MEM_TYPE_EXTERN) {
-		printk(KERN_WARNING
-		       "omapdsp: system ipbuf(%s) is placed in"
-		       " DSP internal memory.\n"
-		       "         It will prevent DSP from idling.\n", dir_str);
-		ipbuf_sys_hold_mem_active++;
-		/*
-		 * dsp_mem_enable() never fails because
-		 * it has been already enabled in dspcfg process and
-		 * this will just increment the usecount.
-		 */
-		dsp_mem_enable((void *)daram_base);
-	}
-
-	if (dir == DIR_D2A)
-		ipbuf_sys_da = p;
-	else
-		ipbuf_sys_ad = p;
-
-	return 0;
-}
-
-int ipbuf_p_validate(void *p, arm_dsp_dir_t dir)
-{
-	char *dir_str = (dir == DIR_D2A) ? "D2A" : "A2D";
-
-	if (((unsigned long)p) & 0x3) {
-		printk(KERN_ERR
-		       "omapdsp: private ipbuf(%s) address(0x%p) is "
-		       "not 32-bit aligned!\n", dir_str, p);
-		return -1;
-	}
-	return dsp_address_validate(p, sizeof(struct ipbuf_p),
-				    "private ipbuf(%s)", dir_str);
-}
-
-/*
- * Global IPBUF operations
- */
-struct ipbuf_head *bid_to_ipbuf(u16 bid)
-{
-	return &g_ipbuf[bid];
-}
-
-struct ipbuf_head *get_free_ipbuf(u8 tid)
-{
-	struct ipbuf_head *ipb_h;
-
-	if (dsp_mem_enable_ipbuf() < 0)
-		return NULL;
-
-	spin_lock(&ipb_free.lock);
-
-	if (ipblink_empty(&ipb_free)) {
-		/* FIXME: wait on queue when not available.  */
-		ipb_h = NULL;
-		goto out;
-	}
-	ipb_h = &g_ipbuf[ipb_free.top];
-	ipb_h->p->la = tid;	/* lock */
-	__ipblink_del_top(&ipb_free);
-out:
-	spin_unlock(&ipb_free.lock);
-	dsp_mem_disable_ipbuf();
-
-	return ipb_h;
-}
-
-void release_ipbuf(struct ipbuf_head *ipb_h)
-{
-	if (ipb_h->p->la == TID_FREE) {
-		printk(KERN_WARNING
-		       "omapdsp: attempt to release unlocked IPBUF[%d].\n",
-		       ipb_h->bid);
-		/*
-		 * FIXME: re-calc bsycnt
-		 */
-		return;
-	}
-	ipb_h->p->la = TID_FREE;
-	ipb_h->p->sa = TID_FREE;
-	ipblink_add_tail(&ipb_free, ipb_h->bid);
-}
-
-static int try_yld(struct ipbuf_head *ipb_h)
-{
-	int status;
-
-	ipb_h->p->sa = TID_ANON;
-	status = mbcompose_send(BKYLD, 0, ipb_h->bid);
-	if (status < 0) {
-		/* DSP is busy and ARM keeps this line. */
-		release_ipbuf(ipb_h);
-		return status;
-	}
-
-	ipb_bsycnt_inc(&ipbcfg);
-	return 0;
-}
-
-/*
- * balancing ipbuf lines with DSP
- */
-static void do_balance_ipbuf(struct work_struct *unused)
-{
-	while (ipbcfg.bsycnt <= ipbcfg.ln / 4) {
-		struct ipbuf_head *ipb_h;
-
-		if ((ipb_h = get_free_ipbuf(TID_ANON)) == NULL)
-			return;
-		if (try_yld(ipb_h) < 0)
-			return;
-	}
-}
-
-static DECLARE_WORK(balance_ipbuf_work, do_balance_ipbuf);
-
-void balance_ipbuf(void)
-{
-	schedule_work(&balance_ipbuf_work);
-}
-
-/* for process context */
-void unuse_ipbuf(struct ipbuf_head *ipb_h)
-{
-	if (ipbcfg.bsycnt > ipbcfg.ln / 4) {
-		/* we don't have enough IPBUF lines. let's keep it. */
-		release_ipbuf(ipb_h);
-	} else {
-		/* we have enough IPBUF lines. let's return this line to DSP. */
-		ipb_h->p->la = TID_ANON;
-		try_yld(ipb_h);
-		balance_ipbuf();
-	}
-}
-
-/* for interrupt context */
-void unuse_ipbuf_nowait(struct ipbuf_head *ipb_h)
-{
-	release_ipbuf(ipb_h);
-	balance_ipbuf();
-}
-
-/*
- * functions called from mailbox interrupt routine
- */
-
-void mbox_err_ipbfull(void)
-{
-	ipbcfg.cnt_full++;
-}
-
-/*
- * sysfs files
- */
-static ssize_t ipbuf_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
-{
-	int len = 0;
-	u16 bid;
-
-	for (bid = 0; bid < ipbcfg.ln; bid++) {
-		struct ipbuf_head *ipb_h = &g_ipbuf[bid];
-		u16 la = ipb_h->p->la;
-		u16 ld = ipb_h->p->ld;
-		u16 c  = ipb_h->p->c;
-
-		if (len > PAGE_SIZE - 100) {
-			len += sprintf(buf + len, "out of buffer.\n");
-			goto finish;
-		}
-
-		len += sprintf(buf + len, "ipbuf[%d]: adr = 0x%p\n",
-			       bid, ipb_h->p);
-		if (la == TID_FREE) {
-			len += sprintf(buf + len,
-				       "  DSPtask[%d]->Linux "
-				       "(already read and now free for Linux)\n",
-				       ld);
-		} else if (ld == TID_FREE) {
-			len += sprintf(buf + len,
-				       "  Linux->DSPtask[%d] "
-				       "(already read and now free for DSP)\n",
-				       la);
-		} else if (ipbuf_is_held(ld, bid)) {
-			len += sprintf(buf + len,
-				       "  DSPtask[%d]->Linux "
-				       "(waiting to be read)\n"
-				       "  count = %d\n", ld, c);
-		} else {
-			len += sprintf(buf + len,
-				       "  Linux->DSPtask[%d] "
-				       "(waiting to be read)\n"
-				       "  count = %d\n", la, c);
-		}
-	}
-
-	len += sprintf(buf + len, "\nFree IPBUF link: ");
-	spin_lock(&ipb_free.lock);
-	ipblink_for_each(bid, &ipb_free) {
-		len += sprintf(buf + len, "%d ", bid);
-	}
-	spin_unlock(&ipb_free.lock);
-	len += sprintf(buf + len, "\n");
-	len += sprintf(buf + len, "IPBFULL error count: %ld\n",
-		       ipbcfg.cnt_full);
-
-finish:
-	return len;
-}
diff --git a/arch/arm/plat-omap/dsp/ipbuf.h b/arch/arm/plat-omap/dsp/ipbuf.h
deleted file mode 100644
index 926d353..0000000
--- a/arch/arm/plat-omap/dsp/ipbuf.h
+++ /dev/null
@@ -1,193 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __PLAT_OMAP_DSP_IPBUF_H
-#define __PLAT_OMAP_DSP_IPBUF_H
-
-struct ipbuf {
-	u16 c;			/* count */
-	u16 next;		/* link */
-	u16 la;			/* lock owner (ARM side) */
-	u16 sa;			/* sync word (ARM->DSP) */
-	u16 ld;			/* lock owner (DSP side) */
-	u16 sd;			/* sync word (DSP->ARM) */
-	unsigned char d[0];	/* data */
-};
-
-struct ipbuf_p {
-	u16 c;		/* count */
-	u16 s;		/* sync word */
-	u16 al;		/* data address lower */
-	u16 ah;		/* data address upper */
-};
-
-#define IPBUF_SYS_DLEN	31
-
-struct ipbuf_sys {
-	u16 s;			/* sync word */
-	u16 d[IPBUF_SYS_DLEN];	/* data */
-};
-
-struct ipbcfg {
-	u16 ln;
-	u16 lsz;
-	void *base;
-	u16 bsycnt;
-	unsigned long cnt_full;	/* count of IPBFULL error */
-};
-
-struct ipbuf_head {
-	u16 bid;
-	struct ipbuf *p;
-};
-
-extern struct ipbcfg ipbcfg;
-extern struct ipbuf_sys *ipbuf_sys_da, *ipbuf_sys_ad;
-
-#define ipb_bsycnt_inc(ipbcfg)	atomic_inc((atomic_t *)&((ipbcfg)->bsycnt))
-#define ipb_bsycnt_dec(ipbcfg)	atomic_dec((atomic_t *)&((ipbcfg)->bsycnt))
-
-#define dsp_mem_enable_ipbuf()	dsp_mem_enable(ipbcfg.base)
-#define dsp_mem_disable_ipbuf()	dsp_mem_disable(ipbcfg.base)
-
-struct ipblink {
-	spinlock_t lock;
-	u16 top;
-	u16 tail;
-};
-
-#define IPBLINK_INIT {				\
-		.lock = SPIN_LOCK_UNLOCKED,	\
-		.top  = BID_NULL,		\
-		.tail = BID_NULL,		\
-	}
-
-#define INIT_IPBLINK(link)			\
-	do {					\
-		spin_lock_init(&(link)->lock);	\
-		(link)->top  = BID_NULL;	\
-		(link)->tail = BID_NULL;	\
-	} while(0)
-
-#define RESET_IPBLINK(link)			\
-	do {					\
-		(link)->top  = BID_NULL;	\
-		(link)->tail = BID_NULL;	\
-	} while(0)
-
-#define ipblink_empty(link)	((link)->top == BID_NULL)
-
-static inline void __ipblink_del_top(struct ipblink *link)
-{
-	struct ipbuf_head *ipb_h = bid_to_ipbuf(link->top);
-
-	if ((link->top = ipb_h->p->next) == BID_NULL)
-		link->tail = BID_NULL;
-	else
-		ipb_h->p->next = BID_NULL;
-}
-
-static inline void ipblink_del_top(struct ipblink *link)
-{
-	spin_lock(&link->lock);
-	__ipblink_del_top(link);
-	spin_unlock(&link->lock);
-}
-
-static inline void __ipblink_add_tail(struct ipblink *link, u16 bid)
-{
-	if (ipblink_empty(link))
-		link->top = bid;
-	else
-		bid_to_ipbuf(link->tail)->p->next = bid;
-	link->tail = bid;
-}
-
-static inline void ipblink_add_tail(struct ipblink *link, u16 bid)
-{
-	spin_lock(&link->lock);
-	__ipblink_add_tail(link, bid);
-	spin_unlock(&link->lock);
-}
-
-static inline void __ipblink_flush(struct ipblink *link)
-{
-	u16 bid;
-
-	while (!ipblink_empty(link)) {
-		bid = link->top;
-		__ipblink_del_top(link);
-		unuse_ipbuf(bid_to_ipbuf(bid));
-	}
-}
-
-static inline void ipblink_flush(struct ipblink *link)
-{
-	spin_lock(&link->lock);
-	__ipblink_flush(link);
-	spin_unlock(&link->lock);
-}
-
-static inline void __ipblink_add_pvt(struct ipblink *link)
-{
-	link->top  = BID_PVT;
-	link->tail = BID_PVT;
-}
-
-static inline void ipblink_add_pvt(struct ipblink *link)
-{
-	spin_lock(&link->lock);
-	__ipblink_add_pvt(link);
-	spin_unlock(&link->lock);
-}
-
-static inline void __ipblink_del_pvt(struct ipblink *link)
-{
-	link->top  = BID_NULL;
-	link->tail = BID_NULL;
-}
-
-static inline void ipblink_del_pvt(struct ipblink *link)
-{
-	spin_lock(&link->lock);
-	__ipblink_del_pvt(link);
-	spin_unlock(&link->lock);
-}
-
-static inline void __ipblink_flush_pvt(struct ipblink *link)
-{
-	if (!ipblink_empty(link))
-		ipblink_del_pvt(link);
-}
-
-static inline void ipblink_flush_pvt(struct ipblink *link)
-{
-	spin_lock(&link->lock);
-	__ipblink_flush_pvt(link);
-	spin_unlock(&link->lock);
-}
-
-#define ipblink_for_each(bid, link) \
-	for (bid = (link)->top; bid != BID_NULL; bid = bid_to_ipbuf(bid)->p->next)
-
-#endif /* __PLAT_OMAP_DSP_IPBUF_H */
diff --git a/arch/arm/plat-omap/dsp/mblog.c b/arch/arm/plat-omap/dsp/mblog.c
deleted file mode 100644
index 2b1e113..0000000
--- a/arch/arm/plat-omap/dsp/mblog.c
+++ /dev/null
@@ -1,280 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2003-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/jiffies.h>
-#include <asm/arch/mailbox.h>
-#include "dsp_mbcmd.h"
-#include "dsp.h"
-
-char *subcmd_name(struct mbcmd *mb)
-{
-	u8 cmd_h = mb->cmd_h;
-	u8 cmd_l = mb->cmd_l;
-	char *s;
-
-	switch (cmd_h) {
-	case MBOX_CMD_DSP_RUNLEVEL:
-		s = (cmd_l == RUNLEVEL_USER)     ? "USER":
-		    (cmd_l == RUNLEVEL_SUPER)    ? "SUPER":
-		    (cmd_l == RUNLEVEL_RECOVERY) ? "RECOVERY":
-		    NULL;
-		break;
-	case MBOX_CMD_DSP_PM:
-		s = (cmd_l == PM_DISABLE) ? "DISABLE":
-		    (cmd_l == PM_ENABLE)  ? "ENABLE":
-		    NULL;
-		break;
-	case MBOX_CMD_DSP_KFUNC:
-		s = (cmd_l == KFUNC_FBCTL) ? "FBCTL":
-			(cmd_l == KFUNC_POWER) ?
-			((mb->data == AUDIO_PWR_UP)	? "PWR AUD /UP":
-			 (mb->data == AUDIO_PWR_DOWN)	? "PWR AUD /DOWN":
-			 (mb->data == AUDIO_PWR_DOWN2)	? "PWR AUD /DOWN(2)":
-			 (mb->data == DSP_PWR_UP)	? "PWR DSP /UP":
-			 (mb->data == DSP_PWR_DOWN)	? "PWR DSP /DOWN":
-			 (mb->data == DVFS_START)	? "PWR DVFS/START":
-			 (mb->data == DVFS_STOP)	? "PWR DVFS/STOP":
-			 NULL):
-
-		    NULL;
-		break;
-	case MBOX_CMD_DSP_DSPCFG:
-		{
-			u8 cfgc = cmd_l & 0x7f;
-			s = (cfgc == DSPCFG_REQ)     ? "REQ":
-			    (cfgc == DSPCFG_SYSADRH) ? "SYSADRH":
-			    (cfgc == DSPCFG_SYSADRL) ? "SYSADRL":
-			    (cfgc == DSPCFG_ABORT)   ? "ABORT":
-			    (cfgc == DSPCFG_PROTREV) ? "PROTREV":
-			    NULL;
-			break;
-		}
-	case MBOX_CMD_DSP_REGRW:
-		s = (cmd_l == REGRW_MEMR) ? "MEMR":
-		    (cmd_l == REGRW_MEMW) ? "MEMW":
-		    (cmd_l == REGRW_IOR)  ? "IOR":
-		    (cmd_l == REGRW_IOW)  ? "IOW":
-		    (cmd_l == REGRW_DATA) ? "DATA":
-		    NULL;
-		break;
-	case MBOX_CMD_DSP_GETVAR:
-	case MBOX_CMD_DSP_SETVAR:
-		s = (cmd_l == VARID_ICRMASK)  ? "ICRMASK":
-		    (cmd_l == VARID_LOADINFO) ? "LOADINFO":
-		    NULL;
-		break;
-	case MBOX_CMD_DSP_ERR:
-		s = (cmd_l == EID_BADTID)     ? "BADTID":
-		    (cmd_l == EID_BADTCN)     ? "BADTCN":
-		    (cmd_l == EID_BADBID)     ? "BADBID":
-		    (cmd_l == EID_BADCNT)     ? "BADCNT":
-		    (cmd_l == EID_NOTLOCKED)  ? "NOTLOCKED":
-		    (cmd_l == EID_STVBUF)     ? "STVBUF":
-		    (cmd_l == EID_BADADR)     ? "BADADR":
-		    (cmd_l == EID_BADTCTL)    ? "BADTCTL":
-		    (cmd_l == EID_BADPARAM)   ? "BADPARAM":
-		    (cmd_l == EID_FATAL)      ? "FATAL":
-		    (cmd_l == EID_WDT)        ? "WDT":
-		    (cmd_l == EID_NOMEM)      ? "NOMEM":
-		    (cmd_l == EID_NORES)      ? "NORES":
-		    (cmd_l == EID_IPBFULL)    ? "IPBFULL":
-		    (cmd_l == EID_TASKNOTRDY) ? "TASKNOTRDY":
-		    (cmd_l == EID_TASKBSY)    ? "TASKBSY":
-		    (cmd_l == EID_TASKERR)    ? "TASKERR":
-		    (cmd_l == EID_BADCFGTYP)  ? "BADCFGTYP":
-		    (cmd_l == EID_DEBUG)      ? "DEBUG":
-		    (cmd_l == EID_BADSEQ)     ? "BADSEQ":
-		    (cmd_l == EID_BADCMD)     ? "BADCMD":
-		    NULL;
-		break;
-	default:
-		s = NULL;
-	}
-
-	return s;
-}
-
-/* output of show() method should fit to PAGE_SIZE */
-#define MBLOG_DEPTH	64
-
-struct mblogent {
-	unsigned long jiffies;
-	mbox_msg_t msg;
-	arm_dsp_dir_t dir;
-};
-
-static struct {
-	spinlock_t lock;
-	int wp;
-	unsigned long cnt, cnt_ad, cnt_da;
-	struct mblogent ent[MBLOG_DEPTH];
-} mblog = {
-	.lock = SPIN_LOCK_UNLOCKED,
-};
-
-#ifdef CONFIG_OMAP_DSP_MBCMD_VERBOSE
-static inline void mblog_print_cmd(struct mbcmd *mb, arm_dsp_dir_t dir)
-{
-	const struct cmdinfo *ci = cmdinfo[mb->cmd_h];
-	char *dir_str;
-	char *subname;
-
-	dir_str = (dir == DIR_A2D) ? "sending  " : "receiving";
-	switch (ci->cmd_l_type) {
-	case CMD_L_TYPE_SUBCMD:
-		subname = subcmd_name(mb);
-		if (unlikely(!subname))
-			subname = "Unknown";
-		pr_debug("mbox: %s seq=%d, cmd=%02x:%02x(%s:%s), data=%04x\n",
-			 dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
-			 ci->name, subname, mb->data);
-		break;
-	case CMD_L_TYPE_TID:
-		pr_debug("mbox: %s seq=%d, cmd=%02x:%02x(%s:task %d), data=%04x\n",
-			 dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
-			 ci->name, mb->cmd_l, mb->data);
-		break;
-	case CMD_L_TYPE_NULL:
-		pr_debug("mbox: %s seq=%d, cmd=%02x:%02x(%s), data=%04x\n",
-			 dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
-			 ci->name, mb->data);
-		break;
-	}
-}
-#else
-static inline void mblog_print_cmd(struct mbcmd *mb, arm_dsp_dir_t dir) { }
-#endif
-
-void mblog_add(struct mbcmd *mb, arm_dsp_dir_t dir)
-{
-	struct mblogent *ent;
-
-	spin_lock(&mblog.lock);
-	ent = &mblog.ent[mblog.wp];
-	ent->jiffies = jiffies;
-	ent->msg = *(mbox_msg_t *)mb;
-	ent->dir = dir;
-	if (mblog.cnt < 0xffffffff)
-		mblog.cnt++;
-	switch (dir) {
-	case DIR_A2D:
-		if (mblog.cnt_ad < 0xffffffff)
-			mblog.cnt_ad++;
-		break;
-	case DIR_D2A:
-		if (mblog.cnt_da < 0xffffffff)
-			mblog.cnt_da++;
-		break;
-	}
-	if (++mblog.wp == MBLOG_DEPTH)
-		mblog.wp = 0;
-	spin_unlock(&mblog.lock);
-
-	mblog_print_cmd(mb, dir);
-}
-
-/*
- * sysfs file
- */
-static ssize_t mblog_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
-{
-	int len = 0;
-	int wp;
-	int i;
-
-	spin_lock(&mblog.lock);
-
-	wp = mblog.wp;
-	len += sprintf(buf + len,
-		       "log count:%ld / ARM->DSP:%ld, DSP->ARM:%ld\n",
-		       mblog.cnt, mblog.cnt_ad, mblog.cnt_da);
-	if (mblog.cnt == 0)
-		goto done;
-
-	len += sprintf(buf + len, "           ARM->DSP   ARM<-DSP\n");
-	len += sprintf(buf + len, " jiffies  cmd  data  cmd  data\n");
-	i = (mblog.cnt >= MBLOG_DEPTH) ? wp : 0;
-	do {
-		struct mblogent *ent = &mblog.ent[i];
-		struct mbcmd *mb = (struct mbcmd *)&ent->msg;
-		char *subname;
-		struct cmdinfo ci_null = {
-			.name = "Unknown",
-			.cmd_l_type = CMD_L_TYPE_NULL,
-		};
-		const struct cmdinfo *ci;
-
-		len += sprintf(buf + len,
-			       (ent->dir == DIR_A2D) ?
-				"%08lx  %04x %04x            ":
-				"%08lx             %04x %04x ",
-			       ent->jiffies,
-			       (ent->msg >> 16) & 0x7fff, ent->msg & 0xffff);
-
-		if ((ci = cmdinfo[mb->cmd_h]) == NULL)
-			ci = &ci_null;
-
-		switch (ci->cmd_l_type) {
-		case CMD_L_TYPE_SUBCMD:
-			if ((subname = subcmd_name(mb)) == NULL)
-				subname = "Unknown";
-			len += sprintf(buf + len, "%s:%s\n",
-				       ci->name, subname);
-			break;
-		case CMD_L_TYPE_TID:
-			len += sprintf(buf + len, "%s:task %d\n",
-				       ci->name, mb->cmd_l);
-			break;
-		case CMD_L_TYPE_NULL:
-			len += sprintf(buf + len, "%s\n", ci->name);
-			break;
-		}
-
-		if (++i == MBLOG_DEPTH)
-			i = 0;
-	} while (i != wp);
-
-done:
-	spin_unlock(&mblog.lock);
-
-	return len;
-}
-
-static struct device_attribute dev_attr_mblog = __ATTR_RO(mblog);
-
-void __init mblog_init(void)
-{
-	int ret;
-
-	ret = device_create_file(omap_dsp->dev, &dev_attr_mblog);
-	if (ret)
-		printk(KERN_ERR "device_create_file failed: %d\n", ret);
-}
-
-void mblog_exit(void)
-{
-	device_remove_file(omap_dsp->dev, &dev_attr_mblog);
-}
diff --git a/arch/arm/plat-omap/dsp/mmu.h b/arch/arm/plat-omap/dsp/mmu.h
deleted file mode 100644
index 9d60e9e..0000000
--- a/arch/arm/plat-omap/dsp/mmu.h
+++ /dev/null
@@ -1,140 +0,0 @@
-#ifndef __PLAT_OMAP_DSP_MMU_H
-#define __PLAT_OMAP_DSP_MMU_H
-
-#ifdef CONFIG_ARCH_OMAP1
-
-#ifdef CONFIG_ARCH_OMAP15XX
-struct omap_mmu dsp_mmu = {
-	.name		= "mmu:dsp",
-	.type		= OMAP_MMU_DSP,
-	.base		= IO_ADDRESS(OMAP1510_DSP_MMU_BASE),
-	.membase	= OMAP1510_DSP_BASE,
-	.memsize	= OMAP1510_DSP_SIZE,
-	.nr_tlb_entries	= 32,
-	.addrspace	= 24,
-	.irq		= INT_1510_DSP_MMU,
-	.ops		= &omap1_mmu_ops,
-};
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-struct omap_mmu dsp_mmu = {
-	.name		= "mmu:dsp",
-	.type		= OMAP_MMU_DSP,
-	.base		= IO_ADDRESS(OMAP16XX_DSP_MMU_BASE),
-	.membase	= OMAP16XX_DSP_BASE,
-	.memsize	= OMAP16XX_DSP_SIZE,
-	.nr_tlb_entries	= 32,
-	.addrspace	= 24,
-	.irq		= INT_1610_DSP_MMU,
-	.ops		= &omap1_mmu_ops,
-};
-#endif
-#else /* OMAP2 */
-struct omap_mmu dsp_mmu = {
-	.name		= "mmu:dsp",
-	.type		= OMAP_MMU_DSP,
-	.base		= DSP_MMU_24XX_VIRT,
-	.membase	= DSP_MEM_24XX_VIRT,
-	.memsize	= DSP_MEM_24XX_SIZE,
-	.nr_tlb_entries	= 32,
-	.addrspace	= 24,
-	.irq		= INT_24XX_DSP_MMU,
-	.ops		= &omap2_mmu_ops,
-};
-
-#define IOMAP_VAL	0x3f
-#endif
-
-#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
-static struct omapfb_notifier_block *omapfb_nb;
-static int omapfb_ready;
-#endif
-
-/*
- * OMAP1 EMIFF access
- */
-#ifdef CONFIG_ARCH_OMAP1
-#define EMIF_PRIO_LB_MASK	0x0000f000
-#define EMIF_PRIO_LB_SHIFT	12
-#define EMIF_PRIO_DMA_MASK	0x00000f00
-#define EMIF_PRIO_DMA_SHIFT	8
-#define EMIF_PRIO_DSP_MASK	0x00000070
-#define EMIF_PRIO_DSP_SHIFT	4
-#define EMIF_PRIO_MPU_MASK	0x00000007
-#define EMIF_PRIO_MPU_SHIFT	0
-#define set_emiff_dma_prio(prio) \
-	do { \
-		omap_writel((omap_readl(OMAP_TC_OCPT1_PRIOR) & \
-			     ~EMIF_PRIO_DMA_MASK) | \
-			    ((prio) << EMIF_PRIO_DMA_SHIFT), \
-			    OMAP_TC_OCPT1_PRIOR); \
-	} while(0)
-#else
-#define set_emiff_dma_prio(prio)	do { } while (0)
-#endif /* CONFIG_ARCH_OMAP1 */
-
-#ifdef CONFIG_ARCH_OMAP1
-static int dsp_mmu_itack(void)
-{
-	unsigned long dspadr;
-
-	pr_info("omapdsp: sending DSP MMU interrupt ack.\n");
-	if (!dsp_err_isset(ERRCODE_MMU)) {
-		printk(KERN_ERR "omapdsp: DSP MMU error has not been set.\n");
-		return -EINVAL;
-	}
-	dspadr = dsp_mmu.fault_address & ~(SZ_4K-1);
-	/* FIXME: reserve TLB entry for this */
-	omap_mmu_exmap(&dsp_mmu, dspadr, 0, SZ_4K, EXMAP_TYPE_MEM);
-	pr_info("omapdsp: falling into recovery runlevel...\n");
-	dsp_set_runlevel(RUNLEVEL_RECOVERY);
-	omap_mmu_itack(&dsp_mmu);
-	udelay(100);
-	omap_mmu_exunmap(&dsp_mmu, dspadr);
-	dsp_err_clear(ERRCODE_MMU);
-	return 0;
-}
-
-/*
- * intmem_enable() / disable():
- * if the address is in DSP internal memories,
- * we send PM mailbox commands so that DSP DMA domain won't go in idle
- * when ARM is accessing to those memories.
- */
-static int intmem_enable(void)
-{
-	int ret = 0;
-
-	if (dsp_cfgstat_get_stat() == CFGSTAT_READY)
-		ret = mbcompose_send(PM, PM_ENABLE, DSPREG_ICR_DMA);
-
-	return ret;
-}
-
-static void intmem_disable(void) {
-	if (dsp_cfgstat_get_stat() == CFGSTAT_READY)
-		mbcompose_send(PM, PM_DISABLE, DSPREG_ICR_DMA);
-}
-#else
-static int intmem_enable(void) { return 0; }
-static void intmem_disable(void) { }
-static int dsp_mmu_itack(void) { return 0; }
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2
-static inline void dsp_mem_ipi_init(void)
-{
-	int i, dspmem_pg_count;
-	dspmem_pg_count = dspmem_size >> 12;
-	for (i = 0; i < dspmem_pg_count; i++) {
-		writel(i, DSP_IPI_INDEX);
-		writel(DSP_IPI_ENTRY_ELMSIZEVALUE_16, DSP_IPI_ENTRY);
-	}
-	writel(1, DSP_IPI_ENABLE);
-	writel(IOMAP_VAL, DSP_IPI_IOMAP);
-}
-#else
-static inline void dsp_mem_ipi_init(void) { }
-#endif
-
-#endif /* __PLAT_OMAP_DSP_MMU_H */
diff --git a/arch/arm/plat-omap/dsp/omap1_dsp.h b/arch/arm/plat-omap/dsp/omap1_dsp.h
deleted file mode 100644
index f4ec73e..0000000
--- a/arch/arm/plat-omap/dsp/omap1_dsp.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __OMAP_DSP_OMAP1_DSP_H
-#define __OMAP_DSP_OMAP1_DSP_H
-
-#ifdef CONFIG_ARCH_OMAP15XX
-#define OMAP1510_DARAM_BASE	(OMAP1510_DSP_BASE + 0x0)
-#define OMAP1510_DARAM_SIZE	0x10000
-#define OMAP1510_SARAM_BASE	(OMAP1510_DSP_BASE + 0x10000)
-#define OMAP1510_SARAM_SIZE	0x18000
-#endif
-
-#ifdef CONFIG_ARCH_OMAP16XX
-#define OMAP16XX_DARAM_BASE	(OMAP16XX_DSP_BASE + 0x0)
-#define OMAP16XX_DARAM_SIZE	0x10000
-#define OMAP16XX_SARAM_BASE	(OMAP16XX_DSP_BASE + 0x10000)
-#define OMAP16XX_SARAM_SIZE	0x18000
-#endif
-
-/*
- * Reset Control
- */
-#define ARM_RSTCT1_SW_RST		0x0008
-#define ARM_RSTCT1_DSP_RST		0x0004
-#define ARM_RSTCT1_DSP_EN		0x0002
-#define ARM_RSTCT1_ARM_RST		0x0001
-
-/*
- * MPUI
- */
-#define MPUI_CTRL_WORDSWAP_MASK		0x00600000
-#define MPUI_CTRL_WORDSWAP_ALL		0x00000000
-#define MPUI_CTRL_WORDSWAP_NONAPI	0x00200000
-#define MPUI_CTRL_WORDSWAP_API		0x00400000
-#define MPUI_CTRL_WORDSWAP_NONE		0x00600000
-#define MPUI_CTRL_AP_MASK		0x001c0000
-#define MPUI_CTRL_AP_MDH		0x00000000
-#define MPUI_CTRL_AP_MHD		0x00040000
-#define MPUI_CTRL_AP_DMH		0x00080000
-#define MPUI_CTRL_AP_HMD		0x000c0000
-#define MPUI_CTRL_AP_DHM		0x00100000
-#define MPUI_CTRL_AP_HDM		0x00140000
-#define MPUI_CTRL_BYTESWAP_MASK		0x00030000
-#define MPUI_CTRL_BYTESWAP_NONE		0x00000000
-#define MPUI_CTRL_BYTESWAP_NONAPI	0x00010000
-#define MPUI_CTRL_BYTESWAP_ALL		0x00020000
-#define MPUI_CTRL_BYTESWAP_API		0x00030000
-#define MPUI_CTRL_TIMEOUT_MASK		0x0000ff00
-#define MPUI_CTRL_APIF_HNSTB_DIV_MASK	0x000000f0
-#define MPUI_CTRL_S_NABORT_GL		0x00000008
-#define MPUI_CTRL_S_NABORT_32BIT	0x00000004
-#define MPUI_CTRL_EN_TIMEOUT		0x00000002
-#define MPUI_CTRL_HF_MCUCLK		0x00000001
-#define DSP_BOOT_CONFIG_DIRECT		0x00000000
-#define DSP_BOOT_CONFIG_PSD_DIRECT	0x00000001
-#define DSP_BOOT_CONFIG_IDLE		0x00000002
-#define DSP_BOOT_CONFIG_DL16		0x00000003
-#define DSP_BOOT_CONFIG_DL32		0x00000004
-#define DSP_BOOT_CONFIG_MPUI		0x00000005
-#define DSP_BOOT_CONFIG_INTERNAL	0x00000006
-
-/*
- * DSP boot mode
- *   direct:        0xffff00
- *   pseudo direct: 0x080000
- *   MPUI:          branch 0x010000
- *   internel:      branch 0x024000
- */
-#define DSP_BOOT_ADR_DIRECT		0xffff00
-#define DSP_BOOT_ADR_PSD_DIRECT		0x080000
-#define DSP_BOOT_ADR_MPUI		0x010000
-#define DSP_BOOT_ADR_INTERNAL		0x024000
-
-/*
- * TC
- */
-#define TC_ENDIANISM_SWAP		0x00000002
-#define TC_ENDIANISM_SWAP_WORD		0x00000002
-#define TC_ENDIANISM_SWAP_BYTE		0x00000000
-#define TC_ENDIANISM_EN			0x00000001
-
-/*
- * DSP ICR
- */
-#define DSPREG_ICR_RESERVED_BITS	0xffc0
-#define DSPREG_ICR_EMIF			0x0020
-#define DSPREG_ICR_DPLL			0x0010
-#define DSPREG_ICR_PER			0x0008
-#define DSPREG_ICR_CACHE		0x0004
-#define DSPREG_ICR_DMA			0x0002
-#define DSPREG_ICR_CPU			0x0001
-
-#endif /* __OMAP_DSP_OMAP1_DSP_H */
diff --git a/arch/arm/plat-omap/dsp/omap2_dsp.h b/arch/arm/plat-omap/dsp/omap2_dsp.h
deleted file mode 100644
index 0dc43f0..0000000
--- a/arch/arm/plat-omap/dsp/omap2_dsp.h
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __OMAP_DSP_OMAP2_DSP_H
-#define __OMAP_DSP_OMAP2_DSP_H
-
-#ifdef CONFIG_ARCH_OMAP24XX
-#define OMAP24XX_DARAM_BASE	(DSP_MEM_24XX_VIRT + 0x0)
-#define OMAP24XX_DARAM_SIZE	0x10000
-#define OMAP24XX_SARAM_BASE	(DSP_MEM_24XX_VIRT + 0x10000)
-#define OMAP24XX_SARAM_SIZE	0x18000
-#endif
-
-#include <asm/arch/hardware.h>
-
-/*
- * DSP IPI registers: mapped to 0xe1000000 -- use readX(), writeX()
- */
-#ifdef CONFIG_ARCH_OMAP24XX
-#define DSP_IPI_BASE			DSP_IPI_24XX_VIRT
-#endif
-
-#ifdef CONFIG_ARCH_OMAP34XX
-#define DSP_IPI_BASE			DSP_IPI_34XX_VIRT
-#endif
-
-#define DSP_IPI_REVISION		(DSP_IPI_BASE + 0x00)
-#define DSP_IPI_SYSCONFIG		(DSP_IPI_BASE + 0x10)
-#define DSP_IPI_INDEX			(DSP_IPI_BASE + 0x40)
-#define DSP_IPI_ENTRY			(DSP_IPI_BASE + 0x44)
-#define DSP_IPI_ENABLE			(DSP_IPI_BASE + 0x48)
-#define DSP_IPI_IOMAP			(DSP_IPI_BASE + 0x4c)
-#define DSP_IPI_DSPBOOTCONFIG		(DSP_IPI_BASE + 0x50)
-
-#define DSP_IPI_ENTRY_ELMSIZEVALUE_MASK	0x00000003
-#define DSP_IPI_ENTRY_ELMSIZEVALUE_8	0x00000000
-#define DSP_IPI_ENTRY_ELMSIZEVALUE_16	0x00000001
-#define DSP_IPI_ENTRY_ELMSIZEVALUE_32	0x00000002
-
-#define DSP_BOOT_CONFIG_DIRECT		0x00000000
-#define DSP_BOOT_CONFIG_PSD_DIRECT	0x00000001
-#define DSP_BOOT_CONFIG_IDLE		0x00000002
-#define DSP_BOOT_CONFIG_DL16		0x00000003
-#define DSP_BOOT_CONFIG_DL32		0x00000004
-#define DSP_BOOT_CONFIG_API		0x00000005
-#define DSP_BOOT_CONFIG_INTERNAL	0x00000006
-
-/*
- * DSP boot mode
- *   direct:        0xffff00
- *   pseudo direct: 0x080000
- *   API:           branch 0x010000
- *   internel:      branch 0x024000
- */
-#define DSP_BOOT_ADR_DIRECT		0xffff00
-#define DSP_BOOT_ADR_PSD_DIRECT		0x080000
-#define DSP_BOOT_ADR_API		0x010000
-#define DSP_BOOT_ADR_INTERNAL		0x024000
-
-/*
- * DSP ICR
- */
-#define DSPREG_ICR_RESERVED_BITS	0xfc00
-#define DSPREG_ICR_HWA			0x0200
-#define DSPREG_ICR_IPORT		0x0100
-#define DSPREG_ICR_MPORT		0x0080
-#define DSPREG_ICR_XPORT		0x0040
-#define DSPREG_ICR_DPORT		0x0020
-#define DSPREG_ICR_DPLL			0x0010
-#define DSPREG_ICR_PER			0x0008
-#define DSPREG_ICR_CACHE		0x0004
-#define DSPREG_ICR_DMA			0x0002
-#define DSPREG_ICR_CPU			0x0001
-
-#endif /* __OMAP_DSP_OMAP2_DSP_H */
diff --git a/arch/arm/plat-omap/dsp/proclist.h b/arch/arm/plat-omap/dsp/proclist.h
deleted file mode 100644
index 666ca4d..0000000
--- a/arch/arm/plat-omap/dsp/proclist.h
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2004-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __PLAT_OMAP_DSP_PROCLIST_H
-#define __PLAT_OMAP_DSP_PROCLIST_H
-
-struct proc_list {
-	struct list_head list_head;
-	pid_t pid;
-	struct file *file;
-};
-
-static inline int proc_list_add(spinlock_t *lock, struct list_head *list,
-				     struct task_struct *tsk, struct file *file)
-{
-	struct proc_list *new;
-
-	new = kmalloc(sizeof(struct proc_list), GFP_KERNEL);
-	if (new == NULL)
-		return -ENOMEM;
-	new->pid = tsk->pid;
-	new->file = file;
-	spin_lock(lock);
-	list_add_tail(&new->list_head, list);
-	spin_unlock(lock);
-
-	return 0;
-}
-
-static inline void proc_list_del(spinlock_t *lock, struct list_head *list,
-				     struct task_struct *tsk, struct file *file)
-{
-	struct proc_list *pl;
-
-	spin_lock(lock);
-	list_for_each_entry(pl, list, list_head) {
-		if (pl->file == file) {
-			list_del(&pl->list_head);
-			kfree(pl);
-			spin_unlock(lock);
-			return;
-		}
-	}
-
-	/* correspinding file struct isn't found in the list ???  */
-	printk(KERN_ERR "proc_list_del(): proc_list is inconsistent!\n"
-			"struct file (%p) not found\n", file);
-	printk(KERN_ERR "listing proc_list...\n");
-	list_for_each_entry(pl, list, list_head)
-		printk(KERN_ERR "  pid:%d file:%p\n", pl->pid, pl->file);
-	spin_unlock(lock);
-}
-
-static inline void proc_list_flush(spinlock_t *lock, struct list_head *list)
-{
-	struct proc_list *pl;
-
-	spin_lock(lock);
-	while (!list_empty(list)) {
-		pl = list_entry(list->next, struct proc_list, list_head);
-		list_del(&pl->list_head);
-		kfree(pl);
-	}
-	spin_unlock(lock);
-}
-
-#endif /* __PLAT_OMAP_DSP_PROCLIST_H */
diff --git a/arch/arm/plat-omap/dsp/task.c b/arch/arm/plat-omap/dsp/task.c
deleted file mode 100644
index e5ee8e0..0000000
--- a/arch/arm/plat-omap/dsp/task.c
+++ /dev/null
@@ -1,3042 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/major.h>
-#include <linux/fs.h>
-#include <linux/poll.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/mutex.h>
-#include <linux/interrupt.h>
-#include <linux/kfifo.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/arch/mailbox.h>
-#include <asm/arch/dsp.h>
-#include "uaccess_dsp.h"
-#include "dsp_mbcmd.h"
-#include "dsp.h"
-#include "ipbuf.h"
-#include "proclist.h"
-
-/*
- * devstate: task device state machine
- * NOTASK:	task is not attached.
- * ATTACHED:	task is attached.
- * GARBAGE:	task is detached. waiting for all processes to close this device.
- * ADDREQ:	requesting for tadd
- * DELREQ:	requesting for tdel. no process is opening this device.
- * FREEZED:	task is attached, but reserved to be killed.
- * ADDFAIL:	tadd failed.
- * ADDING:	tadd in process.
- * DELING:	tdel in process.
- * KILLING:	tkill in process.
- */
-#define TASKDEV_ST_NOTASK	0x00000001
-#define TASKDEV_ST_ATTACHED	0x00000002
-#define TASKDEV_ST_GARBAGE	0x00000004
-#define TASKDEV_ST_INVALID	0x00000008
-#define TASKDEV_ST_ADDREQ	0x00000100
-#define TASKDEV_ST_DELREQ	0x00000200
-#define TASKDEV_ST_FREEZED	0x00000400
-#define TASKDEV_ST_ADDFAIL	0x00001000
-#define TASKDEV_ST_ADDING	0x00010000
-#define TASKDEV_ST_DELING	0x00020000
-#define TASKDEV_ST_KILLING	0x00040000
-#define TASKDEV_ST_STATE_MASK	0x7fffffff
-#define TASKDEV_ST_STALE	0x80000000
-
-static struct {
-	long state;
-	char *name;
-} devstate_desc[] = {
-	{ TASKDEV_ST_NOTASK,   "notask" },
-	{ TASKDEV_ST_ATTACHED, "attached" },
-	{ TASKDEV_ST_GARBAGE,  "garbage" },
-	{ TASKDEV_ST_INVALID,  "invalid" },
-	{ TASKDEV_ST_ADDREQ,   "addreq" },
-	{ TASKDEV_ST_DELREQ,   "delreq" },
-	{ TASKDEV_ST_FREEZED,  "freezed" },
-	{ TASKDEV_ST_ADDFAIL,  "addfail" },
-	{ TASKDEV_ST_ADDING,   "adding" },
-	{ TASKDEV_ST_DELING,   "deling" },
-	{ TASKDEV_ST_KILLING,  "killing" },
-};
-
-static char *devstate_name(long state)
-{
-	int i;
-	int max = ARRAY_SIZE(devstate_desc);
-
-	for (i = 0; i < max; i++) {
-		if (state & devstate_desc[i].state)
-			return devstate_desc[i].name;
-	}
-	return "unknown";
-}
-
-struct rcvdt_bk_struct {
-	struct ipblink link;
-	unsigned int rp;
-};
-
-struct taskdev {
-	struct bus_type *bus;
-	struct device dev;	/* Generic device interface */
-
-	long state;
-	struct rw_semaphore state_sem;
-	wait_queue_head_t state_wait_q;
-	struct mutex usecount_lock;
-	unsigned int usecount;
-	char name[TNM_LEN];
-	struct file_operations fops;
-	spinlock_t proc_list_lock;
-	struct list_head proc_list;
-	struct dsptask *task;
-
-	/* read stuff */
-	wait_queue_head_t read_wait_q;
-	struct mutex read_mutex;
-	spinlock_t read_lock;
-	union {
-		struct kfifo *fifo;	/* for active word */
-		struct rcvdt_bk_struct bk;
-	} rcvdt;
-
-	/* write stuff */
-	wait_queue_head_t write_wait_q;
-	struct mutex write_mutex;
-	spinlock_t wsz_lock;
-	size_t wsz;
-
-	/* tctl stuff */
-	wait_queue_head_t tctl_wait_q;
-	struct mutex tctl_mutex;
-	int tctl_stat;
-	int tctl_ret;	/* return value for tctl_show() */
-
-	/* device lock */
-	struct mutex lock;
-	pid_t lock_pid;
-};
-
-#define to_taskdev(n) container_of(n, struct taskdev, dev)
-
-struct dsptask {
-	enum {
-		TASK_ST_ERR = 0,
-		TASK_ST_READY,
-		TASK_ST_CFGREQ
-	} state;
-	u8 tid;
-	char name[TNM_LEN];
-	u16 ttyp;
-	struct taskdev *dev;
-
-	/* read stuff */
-	struct ipbuf_p *ipbuf_pvt_r;
-
-	/* write stuff */
-	struct ipbuf_p *ipbuf_pvt_w;
-
-	/* mmap stuff */
-	void *map_base;
-	size_t map_length;
-};
-
-#define sndtyp_acv(ttyp)	((ttyp) & TTYP_ASND)
-#define sndtyp_psv(ttyp)	(!((ttyp) & TTYP_ASND))
-#define sndtyp_bk(ttyp)		((ttyp) & TTYP_BKDM)
-#define sndtyp_wd(ttyp)		(!((ttyp) & TTYP_BKDM))
-#define sndtyp_pvt(ttyp)	((ttyp) & TTYP_PVDM)
-#define sndtyp_gbl(ttyp)	(!((ttyp) & TTYP_PVDM))
-#define rcvtyp_acv(ttyp)	((ttyp) & TTYP_ARCV)
-#define rcvtyp_psv(ttyp)	(!((ttyp) & TTYP_ARCV))
-#define rcvtyp_bk(ttyp)		((ttyp) & TTYP_BKMD)
-#define rcvtyp_wd(ttyp)		(!((ttyp) & TTYP_BKMD))
-#define rcvtyp_pvt(ttyp)	((ttyp) & TTYP_PVMD)
-#define rcvtyp_gbl(ttyp)	(!((ttyp) & TTYP_PVMD))
-
-static inline int has_taskdev_lock(struct taskdev *dev);
-static int dsp_rmdev_minor(unsigned char minor);
-static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor);
-static void taskdev_delete(unsigned char minor);
-static int taskdev_attach_task(struct taskdev *dev, struct dsptask *task);
-static int dsp_tdel_bh(struct taskdev *dev, u16 type);
-
-static struct bus_type dsptask_bus = {
-	.name = "dsptask",
-};
-
-static struct class *dsp_task_class;
-static DEFINE_MUTEX(devmgr_lock);
-static struct taskdev *taskdev[TASKDEV_MAX];
-static struct dsptask *dsptask[TASKDEV_MAX];
-static DEFINE_MUTEX(cfg_lock);
-static u16 cfg_cmd;
-static u8 cfg_tid;
-static DECLARE_WAIT_QUEUE_HEAD(cfg_wait_q);
-static u8 n_task;	/* static task count */
-static void *heap;
-
-#define is_dynamic_task(tid)	((tid) >= n_task)
-
-#define devstate_read_lock(dev, devstate) \
-		devstate_read_lock_timeout(dev, devstate, 0)
-#define devstate_read_unlock(dev)	up_read(&(dev)->state_sem)
-#define devstate_write_lock(dev, devstate) \
-		devstate_write_lock_timeout(dev, devstate, 0)
-#define devstate_write_unlock(dev)	up_write(&(dev)->state_sem)
-
-static ssize_t devname_show(struct device *d, struct device_attribute *attr,
-			    char *buf);
-static ssize_t devstate_show(struct device *d, struct device_attribute *attr,
-			     char *buf);
-static ssize_t proc_list_show(struct device *d, struct device_attribute *attr,
-			      char *buf);
-static ssize_t taskname_show(struct device *d, struct device_attribute *attr,
-			     char *buf);
-static ssize_t ttyp_show(struct device *d, struct device_attribute *attr,
-			 char *buf);
-static ssize_t fifosz_show(struct device *d, struct device_attribute *attr,
-			   char *buf);
-static int fifosz_store(struct device *d, struct device_attribute *attr,
-			const char *buf, size_t count);
-static ssize_t fifocnt_show(struct device *d, struct device_attribute *attr,
-			    char *buf);
-static ssize_t ipblink_show(struct device *d, struct device_attribute *attr,
-			    char *buf);
-static ssize_t wsz_show(struct device *d, struct device_attribute *attr,
-			char *buf);
-static ssize_t mmap_show(struct device *d, struct device_attribute *attr,
-			 char *buf);
-
-#define __ATTR_RW(_name,_mode) { \
-	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
-	.show	= _name##_show,					\
-	.store	= _name##_store,					\
-}
-
-static struct device_attribute dev_attr_devname   = __ATTR_RO(devname);
-static struct device_attribute dev_attr_devstate  = __ATTR_RO(devstate);
-static struct device_attribute dev_attr_proc_list = __ATTR_RO(proc_list);
-static struct device_attribute dev_attr_taskname  = __ATTR_RO(taskname);
-static struct device_attribute dev_attr_ttyp      = __ATTR_RO(ttyp);
-static struct device_attribute dev_attr_fifosz    = __ATTR_RW(fifosz, 0666);
-static struct device_attribute dev_attr_fifocnt   = __ATTR_RO(fifocnt);
-static struct device_attribute dev_attr_ipblink   = __ATTR_RO(ipblink);
-static struct device_attribute dev_attr_wsz       = __ATTR_RO(wsz);
-static struct device_attribute dev_attr_mmap      = __ATTR_RO(mmap);
-
-static inline void set_taskdev_state(struct taskdev *dev, int state)
-{
-	pr_debug("omapdsp: devstate: CHANGE %s[%d]:\"%s\"->\"%s\"\n",
-		 dev->name,
-		 (dev->task ? dev->task->tid : -1),
-		 devstate_name(dev->state),
-		 devstate_name(state));
-	dev->state = state;
-}
-
-/*
- * devstate_read_lock_timeout()
- * devstate_write_lock_timeout():
- * timeout != 0: dev->state can be diffeent from what you want.
- * timeout == 0: no timeout
- */
-#define BUILD_DEVSTATE_LOCK_TIMEOUT(rw)						\
-static int devstate_##rw##_lock_timeout(struct taskdev *dev, long devstate,     \
-				      int timeout)				\
-{										\
-	DEFINE_WAIT(wait);							\
-	down_##rw(&dev->state_sem);						\
-	while (!(dev->state & devstate)) {					\
-		up_##rw(&dev->state_sem);					\
-		prepare_to_wait(&dev->state_wait_q, &wait, TASK_INTERRUPTIBLE);	\
-		if (!timeout)							\
-			timeout = MAX_SCHEDULE_TIMEOUT;				\
-		timeout = schedule_timeout(timeout);				\
-		finish_wait(&dev->state_wait_q, &wait);				\
-		if (timeout == 0)						\
-			return -ETIME;						\
-		if (signal_pending(current))					\
-			return -EINTR;						\
-		down_##rw(&dev->state_sem);					\
-	}									\
-	return 0;                                                               \
-}
-BUILD_DEVSTATE_LOCK_TIMEOUT(read)
-BUILD_DEVSTATE_LOCK_TIMEOUT(write)
-
-#define BUILD_DEVSTATE_LOCK_AND_TEST(rw)					\
-static int devstate_##rw##_lock_and_test(struct taskdev *dev, long devstate)	\
-{										\
-	down_##rw(&dev->state_sem);						\
-	if (dev->state & devstate)						\
-		return 1;	/* success */					\
-	/* failure */								\
-	up_##rw(&dev->state_sem);						\
-	return 0;								\
-}
-BUILD_DEVSTATE_LOCK_AND_TEST(read)
-BUILD_DEVSTATE_LOCK_AND_TEST(write)
-
-static int taskdev_lock_interruptible(struct taskdev *dev,
-				      struct mutex *lock)
-{
-	int ret;
-
-	if (has_taskdev_lock(dev))
-		ret = mutex_lock_interruptible(lock);
-	else {
-		if ((ret = mutex_lock_interruptible(&dev->lock)) != 0)
-			return ret;
-		ret = mutex_lock_interruptible(lock);
-		mutex_unlock(&dev->lock);
-	}
-
-	return ret;
-}
-
-static int taskdev_lock_and_statelock_attached(struct taskdev *dev,
-					       struct mutex *lock)
-{
-	int ret;
-
-	if (!devstate_read_lock_and_test(dev, TASKDEV_ST_ATTACHED))
-		return -ENODEV;
-
-	if ((ret = taskdev_lock_interruptible(dev, lock)) != 0)
-		devstate_read_unlock(dev);
-
-	return ret;
-}
-
-static inline void taskdev_unlock_and_stateunlock(struct taskdev *dev,
-						      struct mutex *lock)
-{
-	mutex_unlock(lock);
-	devstate_read_unlock(dev);
-}
-
-/*
- * taskdev_flush_buf()
- * must be called under state_lock(ATTACHED) and dev->read_mutex.
- */
-static int taskdev_flush_buf(struct taskdev *dev)
-{
-	u16 ttyp = dev->task->ttyp;
-
-	if (sndtyp_wd(ttyp)) {
-		/* word receiving */
-		kfifo_reset(dev->rcvdt.fifo);
-	} else {
-		/* block receiving */
-		struct rcvdt_bk_struct *rcvdt = &dev->rcvdt.bk;
-
-		if (sndtyp_gbl(ttyp))
-			ipblink_flush(&rcvdt->link);
-		else {
-			ipblink_flush_pvt(&rcvdt->link);
-			release_ipbuf_pvt(dev->task->ipbuf_pvt_r);
-		}
-	}
-
-	return 0;
-}
-
-/*
- * taskdev_set_fifosz()
- * must be called under dev->read_mutex.
- */
-static int taskdev_set_fifosz(struct taskdev *dev, unsigned long sz)
-{
-	u16 ttyp = dev->task->ttyp;
-
-	if (!(sndtyp_wd(ttyp) && sndtyp_acv(ttyp))) {
-		printk(KERN_ERR
-		       "omapdsp: buffer size can be changed only for "
-		       "active word sending task.\n");
-		return -EINVAL;
-	}
-	if ((sz == 0) || (sz & 1)) {
-		printk(KERN_ERR "omapdsp: illegal buffer size! (%ld)\n"
-				"it must be even and non-zero value.\n", sz);
-		return -EINVAL;
-	}
-
-	if (kfifo_len(dev->rcvdt.fifo)) {
-		printk(KERN_ERR "omapdsp: buffer is not empty!\n");
-		return -EIO;
-	}
-
-	kfifo_free(dev->rcvdt.fifo);
-	dev->rcvdt.fifo = kfifo_alloc(sz, GFP_KERNEL, &dev->read_lock);
-	if (IS_ERR(dev->rcvdt.fifo)) {
-		printk(KERN_ERR
-		       "omapdsp: unable to change receive buffer size. "
-		       "(%ld bytes for %s)\n", sz, dev->name);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static inline int has_taskdev_lock(struct taskdev *dev)
-{
-	return (dev->lock_pid == current->pid);
-}
-
-static int taskdev_lock(struct taskdev *dev)
-{
-	if (mutex_lock_interruptible(&dev->lock))
-		return -EINTR;
-	dev->lock_pid = current->pid;
-	return 0;
-}
-
-static int taskdev_unlock(struct taskdev *dev)
-{
-	if (!has_taskdev_lock(dev)) {
-		printk(KERN_ERR
-		       "omapdsp: an illegal process attempted to "
-		       "unlock the dsptask lock!\n");
-		return -EINVAL;
-	}
-	dev->lock_pid = 0;
-	mutex_unlock(&dev->lock);
-	return 0;
-}
-
-static int dsp_task_config(struct dsptask *task, u8 tid)
-{
-	u16 ttyp;
-	int ret;
-
-	task->tid = tid;
-	dsptask[tid] = task;
-
-	/* TCFG request */
-	task->state = TASK_ST_CFGREQ;
-	if (mutex_lock_interruptible(&cfg_lock)) {
-		ret = -EINTR;
-		goto fail_out;
-	}
-	cfg_cmd = MBOX_CMD_DSP_TCFG;
-	mbcompose_send_and_wait(TCFG, tid, 0, &cfg_wait_q);
-	cfg_cmd = 0;
-	mutex_unlock(&cfg_lock);
-
-	if (task->state != TASK_ST_READY) {
-		printk(KERN_ERR "omapdsp: task %d configuration error!\n", tid);
-		ret = -EINVAL;
-		goto fail_out;
-	}
-
-	if (strlen(task->name) <= 1)
-		sprintf(task->name, "%d", tid);
-	pr_info("omapdsp: task %d: name %s\n", tid, task->name);
-
-	ttyp = task->ttyp;
-
-	/*
-	 * task info sanity check
-	 */
-
-	/* task type check */
-	if (rcvtyp_psv(ttyp) && rcvtyp_pvt(ttyp)) {
-		printk(KERN_ERR "omapdsp: illegal task type(0x%04x), tid=%d\n",
-		       tid, ttyp);
-		ret = -EINVAL;
-		goto fail_out;
-	}
-
-	/* private buffer address check */
-	if (sndtyp_pvt(ttyp) &&
-	    (ipbuf_p_validate(task->ipbuf_pvt_r, DIR_D2A) < 0)) {
-		ret = -EINVAL;
-		goto fail_out;
-	}
-	if (rcvtyp_pvt(ttyp) &&
-	    (ipbuf_p_validate(task->ipbuf_pvt_w, DIR_A2D) < 0)) {
-		ret = -EINVAL;
-		goto fail_out;
-	}
-
-	/* mmap buffer configuration check */
-	if ((task->map_length > 0) &&
-	    ((!ALIGN((unsigned long)task->map_base, PAGE_SIZE)) ||
-	     (!ALIGN(task->map_length, PAGE_SIZE)) ||
-	     (dsp_mem_type(task->map_base, task->map_length) != MEM_TYPE_EXTERN))) {
-		printk(KERN_ERR
-		       "omapdsp: illegal mmap buffer address(0x%p) or "
-		       "length(0x%x).\n"
-		       "  It needs to be page-aligned and located at "
-		       "external memory.\n",
-		       task->map_base, task->map_length);
-		ret = -EINVAL;
-		goto fail_out;
-	}
-
-	return 0;
-
-fail_out:
-	dsptask[tid] = NULL;
-	return ret;
-}
-
-static void dsp_task_init(struct dsptask *task)
-{
-	mbcompose_send(TCTL, task->tid, TCTL_TINIT);
-}
-
-int dsp_task_config_all(u8 n)
-{
-	int i, ret;
-	struct taskdev *devheap;
-	struct dsptask *taskheap;
-	size_t devheapsz, taskheapsz;
-
-	pr_info("omapdsp: found %d task(s)\n", n);
-	if (n == 0)
-		return 0;
-
-	/*
-	 * reducing kmalloc!
-	 */
-	devheapsz  = sizeof(struct taskdev) * n;
-	taskheapsz = sizeof(struct dsptask) * n;
-	heap = kzalloc(devheapsz + taskheapsz, GFP_KERNEL);
-	if (heap == NULL)
-		return -ENOMEM;
-	devheap  = heap;
-	taskheap = heap + devheapsz;
-
-	n_task = n;
-	for (i = 0; i < n; i++) {
-		struct taskdev *dev  = &devheap[i];
-		struct dsptask *task = &taskheap[i];
-
-		if ((ret = dsp_task_config(task, i)) < 0)
-			return ret;
-		if ((ret = taskdev_init(dev, task->name, i)) < 0)
-			return ret;
-		if ((ret = taskdev_attach_task(dev, task)) < 0)
-			return ret;
-		dsp_task_init(task);
-		pr_info("omapdsp: taskdev %s enabled.\n", dev->name);
-	}
-
-	return 0;
-}
-
-static void dsp_task_unconfig(struct dsptask *task)
-{
-	dsptask[task->tid] = NULL;
-}
-
-void dsp_task_unconfig_all(void)
-{
-	unsigned char minor;
-	u8 tid;
-	struct dsptask *task;
-
-	for (minor = 0; minor < n_task; minor++) {
-		/*
-		 * taskdev[minor] can be NULL in case of
-		 * configuration failure
-		 */
-		if (taskdev[minor])
-			taskdev_delete(minor);
-	}
-	for (; minor < TASKDEV_MAX; minor++) {
-		if (taskdev[minor])
-			dsp_rmdev_minor(minor);
-	}
-
-	for (tid = 0; tid < n_task; tid++) {
-		/*
-		 * dsptask[tid] can be NULL in case of
-		 * configuration failure
-		 */
-		task = dsptask[tid];
-		if (task)
-			dsp_task_unconfig(task);
-	}
-	for (; tid < TASKDEV_MAX; tid++) {
-		task = dsptask[tid];
-		if (task) {
-			/*
-			 * on-demand tasks should be deleted in
-			 * rmdev_minor(), but just in case.
-			 */
-			dsp_task_unconfig(task);
-			kfree(task);
-		}
-	}
-
-	if (heap) {
-		kfree(heap);
-		heap = NULL;
-	}
-
-	n_task = 0;
-}
-
-static struct device_driver dsptask_driver = {
-	.name	= "dsptask",
-	.bus	= &dsptask_bus,
-};
-
-u8 dsp_task_count(void)
-{
-	return n_task;
-}
-
-int dsp_taskmod_busy(void)
-{
-	struct taskdev *dev;
-	unsigned char minor;
-	unsigned int usecount;
-
-	for (minor = 0; minor < TASKDEV_MAX; minor++) {
-		dev = taskdev[minor];
-		if (dev == NULL)
-			continue;
-		if ((usecount = dev->usecount) > 0) {
-			printk("dsp_taskmod_busy(): %s: usecount=%d\n",
-			       dev->name, usecount);
-			return 1;
-		}
-/*
-		if ((dev->state & (TASKDEV_ST_ADDREQ |
-				   TASKDEV_ST_DELREQ)) {
-*/
-		if (dev->state & TASKDEV_ST_ADDREQ) {
-			printk("dsp_taskmod_busy(): %s is in %s\n",
-			       dev->name, devstate_name(dev->state));
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * DSP task device file operations
- */
-static ssize_t dsp_task_read_wd_acv(struct file *file, char __user *buf,
-				    size_t count, loff_t *ppos)
-{
-	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
-	struct taskdev *dev = taskdev[minor];
-	int ret = 0;
-	DEFINE_WAIT(wait);
-
-	if (count == 0) {
-		return 0;
-	} else if (count & 0x1) {
-		printk(KERN_ERR
-		       "omapdsp: odd count is illegal for DSP task device.\n");
-		return -EINVAL;
-	}
-
-	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
-		return -ENODEV;
-
-
-	prepare_to_wait(&dev->read_wait_q, &wait, TASK_INTERRUPTIBLE);
-	if (kfifo_len(dev->rcvdt.fifo) == 0)
-		schedule();
-	finish_wait(&dev->read_wait_q, &wait);
-	if (kfifo_len(dev->rcvdt.fifo) == 0) {
-		/* failure */
-		if (signal_pending(current))
-			ret = -EINTR;
-		goto up_out;
-	}
-
-
-	ret = kfifo_get_to_user(dev->rcvdt.fifo, buf, count);
-
- up_out:
-	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
-	return ret;
-}
-
-static ssize_t dsp_task_read_bk_acv(struct file *file, char __user *buf,
-				    size_t count, loff_t *ppos)
-{
-	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
-	struct taskdev *dev = taskdev[minor];
-	struct rcvdt_bk_struct *rcvdt = &dev->rcvdt.bk;
-	ssize_t ret = 0;
-	DEFINE_WAIT(wait);
-
-	if (count == 0) {
-		return 0;
-	} else if (count & 0x1) {
-		printk(KERN_ERR
-		       "omapdsp: odd count is illegal for DSP task device.\n");
-		return -EINVAL;
-	} else if ((int)buf & 0x1) {
-		printk(KERN_ERR
-		       "omapdsp: buf should be word aligned for "
-		       "dsp_task_read().\n");
-		return -EINVAL;
-	}
-
-	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
-		return -ENODEV;
-
-	prepare_to_wait(&dev->read_wait_q, &wait, TASK_INTERRUPTIBLE);
-	if (ipblink_empty(&rcvdt->link))
-		schedule();
-	finish_wait(&dev->read_wait_q, &wait);
-	if (ipblink_empty(&rcvdt->link)) {
-		/* failure */
-		if (signal_pending(current))
-			ret = -EINTR;
-		goto up_out;
-	}
-
-	/* copy from delayed IPBUF */
-	if (sndtyp_pvt(dev->task->ttyp)) {
-		/* private */
-		if (!ipblink_empty(&rcvdt->link)) {
-			struct ipbuf_p *ipbp = dev->task->ipbuf_pvt_r;
-			unsigned char *base, *src;
-			size_t bkcnt;
-
-			if (dsp_mem_enable(ipbp) < 0) {
-				ret = -EBUSY;
-				goto up_out;
-			}
-			base = MKVIRT(ipbp->ah, ipbp->al);
-			bkcnt = ((unsigned long)ipbp->c) * 2 - rcvdt->rp;
-			if (dsp_address_validate(base, bkcnt,
-						 "task %s read buffer",
-						 dev->task->name) < 0) {
-				ret = -EINVAL;
-				goto pv_out1;
-			}
-			if (dsp_mem_enable(base) < 0) {
-				ret = -EBUSY;
-				goto pv_out1;
-			}
-			src = base + rcvdt->rp;
-			if (bkcnt > count) {
-				if (copy_to_user_dsp(buf, src, count)) {
-					ret = -EFAULT;
-					goto pv_out2;
-				}
-				ret = count;
-				rcvdt->rp += count;
-			} else {
-				if (copy_to_user_dsp(buf, src, bkcnt)) {
-					ret = -EFAULT;
-					goto pv_out2;
-				}
-				ret = bkcnt;
-				ipblink_del_pvt(&rcvdt->link);
-				release_ipbuf_pvt(ipbp);
-				rcvdt->rp = 0;
-			}
-		pv_out2:
-			dsp_mem_disable(src);
-		pv_out1:
-			dsp_mem_disable(ipbp);
-		}
-	} else {
-		/* global */
-		if (dsp_mem_enable_ipbuf() < 0) {
-			ret = -EBUSY;
-			goto up_out;
-		}
-		while (!ipblink_empty(&rcvdt->link)) {
-			unsigned char *src;
-			size_t bkcnt;
-			struct ipbuf_head *ipb_h = bid_to_ipbuf(rcvdt->link.top);
-
-			src = ipb_h->p->d + rcvdt->rp;
-			bkcnt = ((unsigned long)ipb_h->p->c) * 2 - rcvdt->rp;
-			if (bkcnt > count) {
-				if (copy_to_user_dsp(buf, src, count)) {
-					ret = -EFAULT;
-					goto gb_out;
-				}
-				ret += count;
-				rcvdt->rp += count;
-				break;
-			} else {
-				if (copy_to_user_dsp(buf, src, bkcnt)) {
-					ret = -EFAULT;
-					goto gb_out;
-				}
-				ret += bkcnt;
-				buf += bkcnt;
-				count -= bkcnt;
-				ipblink_del_top(&rcvdt->link);
-				unuse_ipbuf(ipb_h);
-				rcvdt->rp = 0;
-			}
-		}
-	gb_out:
-		dsp_mem_disable_ipbuf();
-	}
-
- up_out:
-	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
-	return ret;
-}
-
-static ssize_t dsp_task_read_wd_psv(struct file *file, char __user *buf,
-				    size_t count, loff_t *ppos)
-{
-	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
-	struct taskdev *dev = taskdev[minor];
-	int ret = 0;
-
-	if (count == 0) {
-		return 0;
-	} else if (count & 0x1) {
-		printk(KERN_ERR
-		       "omapdsp: odd count is illegal for DSP task device.\n");
-		return -EINVAL;
-	} else {
-		/* force! */
-		count = 2;
-	}
-
-	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
-		return -ENODEV;
-
-	mbcompose_send_and_wait(WDREQ, dev->task->tid, 0, &dev->read_wait_q);
-
-	if (kfifo_len(dev->rcvdt.fifo) == 0) {
-		/* failure */
-		if (signal_pending(current))
-			ret = -EINTR;
-		goto up_out;
-	}
-
-	ret = kfifo_get_to_user(dev->rcvdt.fifo, buf, count);
-
-up_out:
-	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
-	return ret;
-}
-
-static ssize_t dsp_task_read_bk_psv(struct file *file, char __user *buf,
-				    size_t count, loff_t *ppos)
-{
-	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
-	struct taskdev *dev = taskdev[minor];
-	struct rcvdt_bk_struct *rcvdt = &dev->rcvdt.bk;
-	int ret = 0;
-
-	if (count == 0) {
-		return 0;
-	} else if (count & 0x1) {
-		printk(KERN_ERR
-		       "omapdsp: odd count is illegal for DSP task device.\n");
-		return -EINVAL;
-	} else if ((int)buf & 0x1) {
-		printk(KERN_ERR
-		       "omapdsp: buf should be word aligned for "
-		       "dsp_task_read().\n");
-		return -EINVAL;
-	}
-
-	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
-		return -ENODEV;
-
-	mbcompose_send_and_wait(BKREQ, dev->task->tid, count/2,
-				&dev->read_wait_q);
-
-	if (ipblink_empty(&rcvdt->link)) {
-		/* failure */
-		if (signal_pending(current))
-			ret = -EINTR;
-		goto up_out;
-	}
-
-	/*
-	 * We will not receive more than requested count.
-	 */
-	if (sndtyp_pvt(dev->task->ttyp)) {
-		/* private */
-		struct ipbuf_p *ipbp = dev->task->ipbuf_pvt_r;
-		size_t rcvcnt;
-		void *src;
-
-		if (dsp_mem_enable(ipbp) < 0) {
-			ret = -EBUSY;
-			goto up_out;
-		}
-		src = MKVIRT(ipbp->ah, ipbp->al);
-		rcvcnt = ((unsigned long)ipbp->c) * 2;
-		if (dsp_address_validate(src, rcvcnt, "task %s read buffer",
-					 dev->task->name) < 0) {
-			ret = -EINVAL;
-			goto pv_out1;
-		}
-		if (dsp_mem_enable(src) < 0) {
-			ret = -EBUSY;
-			goto pv_out1;
-		}
-		if (count > rcvcnt)
-			count = rcvcnt;
-		if (copy_to_user_dsp(buf, src, count)) {
-			ret = -EFAULT;
-			goto pv_out2;
-		}
-		ipblink_del_pvt(&rcvdt->link);
-		release_ipbuf_pvt(ipbp);
-		ret = count;
-pv_out2:
-		dsp_mem_disable(src);
-pv_out1:
-		dsp_mem_disable(ipbp);
-	} else {
-		/* global */
-		struct ipbuf_head *ipb_h = bid_to_ipbuf(rcvdt->link.top);
-		size_t rcvcnt;
-
-		if (dsp_mem_enable_ipbuf() < 0) {
-			ret = -EBUSY;
-			goto up_out;
-		}
-		rcvcnt = ((unsigned long)ipb_h->p->c) * 2;
-		if (count > rcvcnt)
-			count = rcvcnt;
-		if (copy_to_user_dsp(buf, ipb_h->p->d, count)) {
-			ret = -EFAULT;
-			goto gb_out;
-		}
-		ipblink_del_top(&rcvdt->link);
-		unuse_ipbuf(ipb_h);
-		ret = count;
-gb_out:
-		dsp_mem_disable_ipbuf();
-	}
-
-up_out:
-	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
-	return ret;
-}
-
-static ssize_t dsp_task_write_wd(struct file *file, const char __user *buf,
-				 size_t count, loff_t *ppos)
-{
-	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
-	struct taskdev *dev = taskdev[minor];
-	u16 wd;
-	int ret = 0;
-	DEFINE_WAIT(wait);
-
-	if (count == 0) {
-		return 0;
-	} else if (count & 0x1) {
-		printk(KERN_ERR
-		       "omapdsp: odd count is illegal for DSP task device.\n");
-		return -EINVAL;
-	} else {
-		/* force! */
-		count = 2;
-	}
-
-	if (taskdev_lock_and_statelock_attached(dev, &dev->write_mutex))
-		return -ENODEV;
-
-	prepare_to_wait(&dev->write_wait_q, &wait, TASK_INTERRUPTIBLE);
-	if (dev->wsz == 0)
-		schedule();
-	finish_wait(&dev->write_wait_q, &wait);
-	if (dev->wsz == 0) {
-		/* failure */
-		if (signal_pending(current))
-			ret = -EINTR;
-		goto up_out;
-	}
-
-	if (copy_from_user(&wd, buf, count)) {
-		ret = -EFAULT;
-		goto up_out;
-	}
-
-	spin_lock(&dev->wsz_lock);
-	if (mbcompose_send(WDSND, dev->task->tid, wd) < 0) {
-		spin_unlock(&dev->wsz_lock);
-		goto up_out;
-	}
-	ret = count;
-	if (rcvtyp_acv(dev->task->ttyp))
-		dev->wsz = 0;
-	spin_unlock(&dev->wsz_lock);
-
- up_out:
-	taskdev_unlock_and_stateunlock(dev, &dev->write_mutex);
-	return ret;
-}
-
-static ssize_t dsp_task_write_bk(struct file *file, const char __user *buf,
-				 size_t count, loff_t *ppos)
-{
-	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
-	struct taskdev *dev = taskdev[minor];
-	int ret = 0;
-	DEFINE_WAIT(wait);
-
-	if (count == 0) {
-		return 0;
-	} else if (count & 0x1) {
-		printk(KERN_ERR
-		       "omapdsp: odd count is illegal for DSP task device.\n");
-		return -EINVAL;
-	} else if ((int)buf & 0x1) {
-		printk(KERN_ERR
-		       "omapdsp: buf should be word aligned for "
-		       "dsp_task_write().\n");
-		return -EINVAL;
-	}
-
-	if (taskdev_lock_and_statelock_attached(dev, &dev->write_mutex))
-		return -ENODEV;
-
-	prepare_to_wait(&dev->write_wait_q, &wait, TASK_INTERRUPTIBLE);
-	if (dev->wsz == 0)
-		schedule();
-	finish_wait(&dev->write_wait_q, &wait);
-	if (dev->wsz == 0) {
-		/* failure */
-		if (signal_pending(current))
-			ret = -EINTR;
-		goto up_out;
-	}
-
-	if (count > dev->wsz)
-		count = dev->wsz;
-
-	if (rcvtyp_pvt(dev->task->ttyp)) {
-		/* private */
-		struct ipbuf_p *ipbp = dev->task->ipbuf_pvt_w;
-		unsigned char *dst;
-
-		if (dsp_mem_enable(ipbp) < 0) {
-			ret = -EBUSY;
-			goto up_out;
-		}
-		dst = MKVIRT(ipbp->ah, ipbp->al);
-		if (dsp_address_validate(dst, count, "task %s write buffer",
-					 dev->task->name) < 0) {
-			ret = -EINVAL;
-			goto pv_out1;
-		}
-		if (dsp_mem_enable(dst) < 0) {
-			ret = -EBUSY;
-			goto pv_out1;
-		}
-		if (copy_from_user_dsp(dst, buf, count)) {
-			ret = -EFAULT;
-			goto pv_out2;
-		}
-		ipbp->c = count/2;
-		ipbp->s = dev->task->tid;
-		spin_lock(&dev->wsz_lock);
-		if (mbcompose_send(BKSNDP, dev->task->tid, 0) == 0) {
-			if (rcvtyp_acv(dev->task->ttyp))
-				dev->wsz = 0;
-			ret = count;
-		}
-		spin_unlock(&dev->wsz_lock);
-	pv_out2:
-		dsp_mem_disable(dst);
-	pv_out1:
-		dsp_mem_disable(ipbp);
-	} else {
-		/* global */
-		struct ipbuf_head *ipb_h;
-
-		if (dsp_mem_enable_ipbuf() < 0) {
-			ret = -EBUSY;
-			goto up_out;
-		}
-		if ((ipb_h = get_free_ipbuf(dev->task->tid)) == NULL)
-			goto gb_out;
-		if (copy_from_user_dsp(ipb_h->p->d, buf, count)) {
-			release_ipbuf(ipb_h);
-			ret = -EFAULT;
-			goto gb_out;
-		}
-		ipb_h->p->c  = count/2;
-		ipb_h->p->sa = dev->task->tid;
-		spin_lock(&dev->wsz_lock);
-		if (mbcompose_send(BKSND, dev->task->tid, ipb_h->bid) == 0) {
-			if (rcvtyp_acv(dev->task->ttyp))
-				dev->wsz = 0;
-			ret = count;
-			ipb_bsycnt_inc(&ipbcfg);
-		} else
-			release_ipbuf(ipb_h);
-		spin_unlock(&dev->wsz_lock);
-	gb_out:
-		dsp_mem_disable_ipbuf();
-	}
-
- up_out:
-	taskdev_unlock_and_stateunlock(dev, &dev->write_mutex);
-	return ret;
-}
-
-static unsigned int dsp_task_poll(struct file * file, poll_table * wait)
-{
-	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
-	struct taskdev *dev = taskdev[minor];
-	struct dsptask *task = dev->task;
-	unsigned int mask = 0;
-
-	if (!devstate_read_lock_and_test(dev, TASKDEV_ST_ATTACHED))
-		return 0;
-	poll_wait(file, &dev->read_wait_q, wait);
-	poll_wait(file, &dev->write_wait_q, wait);
-	if (sndtyp_psv(task->ttyp) ||
-	    (sndtyp_wd(task->ttyp) && kfifo_len(dev->rcvdt.fifo)) ||
-	    (sndtyp_bk(task->ttyp) && !ipblink_empty(&dev->rcvdt.bk.link)))
-		mask |= POLLIN | POLLRDNORM;
-	if (dev->wsz)
-		mask |= POLLOUT | POLLWRNORM;
-	devstate_read_unlock(dev);
-
-	return mask;
-}
-
-static int dsp_tctl_issue(struct taskdev *dev, u16 cmd, int argc, u16 argv[])
-{
-	int tctl_argc;
-	struct mb_exarg mbarg, *mbargp;
-	int interactive;
-	u8 tid;
-	int ret = 0;
-
-	if (cmd < 0x8000) {
-		/*
-		 * 0x0000 - 0x7fff
-		 * system reserved TCTL commands
-		 */
-		switch (cmd) {
-		case TCTL_TEN:
-		case TCTL_TDIS:
-			tctl_argc = 0;
-			interactive = 0;
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-	/*
-	 * 0x8000 - 0xffff
-	 * user-defined TCTL commands
-	 */
-	else if (cmd < 0x8100) {
-		/* 0x8000-0x80ff: no arg, non-interactive */
-		tctl_argc = 0;
-		interactive = 0;
-	} else if (cmd < 0x8200) {
-		/* 0x8100-0x81ff: 1 arg, non-interactive */
-		tctl_argc = 1;
-		interactive = 0;
-	} else if (cmd < 0x9000) {
-		/* 0x8200-0x8fff: reserved */
-		return -EINVAL;
-	} else if (cmd < 0x9100) {
-		/* 0x9000-0x90ff: no arg, interactive */
-		tctl_argc = 0;
-		interactive = 1;
-	} else if (cmd < 0x9200) {
-		/* 0x9100-0x91ff: 1 arg, interactive */
-		tctl_argc = 1;
-		interactive = 1;
-	} else {
-		/* 0x9200-0xffff: reserved */
-		return -EINVAL;
-	}
-
-	/*
-	 * if argc < 0, use tctl_argc as is.
-	 * if argc >= 0, check arg count.
-	 */
-	if ((argc >= 0) && (argc != tctl_argc))
-		return -EINVAL;
-
-	/*
-	 * issue TCTL
-	 */
-	if (taskdev_lock_interruptible(dev, &dev->tctl_mutex))
-		return -EINTR;
-
-	tid = dev->task->tid;
-	if (tctl_argc > 0) {
-		mbarg.argc = tctl_argc;
-		mbarg.tid  = tid;
-		mbarg.argv = argv;
-		mbargp = &mbarg;
-	} else
-		mbargp = NULL;
-
-	if (interactive) {
-		dev->tctl_stat = -EINVAL;
-
-		mbcompose_send_and_wait_exarg(TCTL, tid, cmd, mbargp,
-					      &dev->tctl_wait_q);
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			goto up_out;
-		}
-		if ((ret = dev->tctl_stat) < 0) {
-			printk(KERN_ERR "omapdsp: TCTL not responding.\n");
-			goto up_out;
-		}
-	} else
-		mbcompose_send_exarg(TCTL, tid, cmd, mbargp);
-
-up_out:
-	mutex_unlock(&dev->tctl_mutex);
-	return ret;
-}
-
-static int dsp_task_ioctl(struct inode *inode, struct file *file,
-			  unsigned int cmd, unsigned long arg)
-{
-	unsigned int minor = MINOR(inode->i_rdev);
-	struct taskdev *dev = taskdev[minor];
-	int ret;
-
-	if (cmd < 0x10000) {
-		/* issue TCTL */
-		u16 mbargv[1];
-
-		mbargv[0] = arg & 0xffff;
-		return dsp_tctl_issue(dev, cmd, -1, mbargv);
-	}
-
-	/* non TCTL ioctls */
-	switch (cmd) {
-
-	case TASK_IOCTL_LOCK:
-		ret = taskdev_lock(dev);
-		break;
-
-	case TASK_IOCTL_UNLOCK:
-		ret = taskdev_unlock(dev);
-		break;
-
-	case TASK_IOCTL_BFLSH:
-		if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
-			return -ENODEV;
-		ret = taskdev_flush_buf(dev);
-		taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
-		break;
-
-	case TASK_IOCTL_SETBSZ:
-		if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
-			return -ENODEV;
-		ret = taskdev_set_fifosz(dev, arg);
-		taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
-		break;
-
-	case TASK_IOCTL_GETNAME:
-		ret = 0;
-		if (copy_to_user((void __user *)arg, dev->name,
-				 strlen(dev->name) + 1))
-			ret = -EFAULT;
-		break;
-
-	default:
-		ret = -ENOIOCTLCMD;
-
-	}
-
-	return ret;
-}
-
-static void dsp_task_mmap_open(struct vm_area_struct *vma)
-{
-	struct taskdev *dev = (struct taskdev *)vma->vm_private_data;
-	struct dsptask *task;
-	size_t len = vma->vm_end - vma->vm_start;
-
-	BUG_ON(!(dev->state & TASKDEV_ST_ATTACHED));
-	task = dev->task;
-	omap_mmu_exmap_use(&dsp_mmu, task->map_base, len);
-}
-
-static void dsp_task_mmap_close(struct vm_area_struct *vma)
-{
-	struct taskdev *dev = (struct taskdev *)vma->vm_private_data;
-	struct dsptask *task;
-	size_t len = vma->vm_end - vma->vm_start;
-
-	BUG_ON(!(dev->state & TASKDEV_ST_ATTACHED));
-	task = dev->task;
-	omap_mmu_exmap_unuse(&dsp_mmu, task->map_base, len);
-}
-
-/**
- * On demand page allocation is not allowed. The mapping area is defined by
- * corresponding DSP tasks.
- */
-static struct page *dsp_task_mmap_nopage(struct vm_area_struct *vma,
-					 unsigned long address, int *type)
-{
-	return NOPAGE_SIGBUS;
-}
-
-static struct vm_operations_struct dsp_task_vm_ops = {
-	.open = dsp_task_mmap_open,
-	.close = dsp_task_mmap_close,
-	.nopage = dsp_task_mmap_nopage,
-};
-
-static int dsp_task_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	void *tmp_vadr;
-	unsigned long tmp_padr, tmp_vmadr, off;
-	size_t req_len, tmp_len;
-	unsigned int minor = MINOR(filp->f_dentry->d_inode->i_rdev);
-	struct taskdev *dev = taskdev[minor];
-	struct dsptask *task;
-	int ret = 0;
-
-	if (!devstate_read_lock_and_test(dev, TASKDEV_ST_ATTACHED))
-		return -ENODEV;
-	task = dev->task;
-
-	/*
-	 * Don't swap this area out
-	 * Don't dump this area to a core file
-	 */
-	vma->vm_flags |= VM_RESERVED | VM_IO;
-
-	/* Do not cache this area */
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-	req_len = vma->vm_end - vma->vm_start;
-	off = vma->vm_pgoff << PAGE_SHIFT;
-	tmp_vmadr = vma->vm_start;
-	tmp_vadr = task->map_base + off;
-	do {
-		tmp_padr = omap_mmu_virt_to_phys(&dsp_mmu, tmp_vadr, &tmp_len);
-		if (tmp_padr == 0) {
-			printk(KERN_ERR
-			       "omapdsp: task %s: illegal address "
-			       "for mmap: %p", task->name, tmp_vadr);
-			/* partial mapping will be cleared in upper layer */
-			ret = -EINVAL;
-			goto unlock_out;
-		}
-		if (tmp_len > req_len)
-			tmp_len = req_len;
-
-		pr_debug("omapdsp: mmap info: "
-			 "vmadr = %08lx, padr = %08lx, len = %x\n",
-			 tmp_vmadr, tmp_padr, tmp_len);
-		if (remap_pfn_range(vma, tmp_vmadr, tmp_padr >> PAGE_SHIFT,
-				    tmp_len, vma->vm_page_prot) != 0) {
-			printk(KERN_ERR
-			       "omapdsp: task %s: remap_page_range() failed.\n",
-			       task->name);
-			/* partial mapping will be cleared in upper layer */
-			ret = -EINVAL;
-			goto unlock_out;
-		}
-
-		req_len   -= tmp_len;
-		tmp_vmadr += tmp_len;
-		tmp_vadr  += tmp_len;
-	} while (req_len);
-
-	vma->vm_ops = &dsp_task_vm_ops;
-	vma->vm_private_data = dev;
-	omap_mmu_exmap_use(&dsp_mmu, task->map_base, vma->vm_end - vma->vm_start);
-
-unlock_out:
-	devstate_read_unlock(dev);
-	return ret;
-}
-
-static int dsp_task_open(struct inode *inode, struct file *file)
-{
-	unsigned int minor = MINOR(inode->i_rdev);
-	struct taskdev *dev;
-	int ret = 0;
-
-	if ((minor >= TASKDEV_MAX) || ((dev = taskdev[minor]) == NULL))
-		return -ENODEV;
-
- restart:
-	mutex_lock(&dev->usecount_lock);
-	down_write(&dev->state_sem);
-
-	/* state can be NOTASK, ATTACHED/FREEZED, KILLING, GARBAGE or INVALID here. */
-	switch (dev->state & TASKDEV_ST_STATE_MASK) {
-	case TASKDEV_ST_NOTASK:
-		break;
-	case TASKDEV_ST_ATTACHED:
-		goto attached;
-
-	case TASKDEV_ST_INVALID:
-		up_write(&dev->state_sem);
-		mutex_unlock(&dev->usecount_lock);
-		return -ENODEV;
-
-	case TASKDEV_ST_FREEZED:
-	case TASKDEV_ST_KILLING:
-	case TASKDEV_ST_GARBAGE:
-	case TASKDEV_ST_DELREQ:
-		/* on the kill process. wait until it becomes NOTASK. */
-		up_write(&dev->state_sem);
-		mutex_unlock(&dev->usecount_lock);
-		if (devstate_write_lock(dev, TASKDEV_ST_NOTASK) < 0)
-			return -EINTR;
-		devstate_write_unlock(dev);
-		goto restart;
-	}
-
-	/* NOTASK */
-	set_taskdev_state(dev, TASKDEV_ST_ADDREQ);
-	/* wake up twch daemon for tadd */
-	dsp_twch_touch();
-	up_write(&dev->state_sem);
-	if (devstate_write_lock(dev, TASKDEV_ST_ATTACHED |
-				TASKDEV_ST_ADDFAIL) < 0) {
-		/* cancelled */
-		if (!devstate_write_lock_and_test(dev, TASKDEV_ST_ADDREQ)) {
-			mutex_unlock(&dev->usecount_lock);
-			/* out of control ??? */
-			return -EINTR;
-		}
-		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
-		ret = -EINTR;
-		goto change_out;
-	}
-	if (dev->state & TASKDEV_ST_ADDFAIL) {
-		printk(KERN_ERR "omapdsp: task attach failed for %s!\n",
-		       dev->name);
-		ret = -EBUSY;
-		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
-		goto change_out;
-	}
-
- attached:
-	ret = proc_list_add(&dev->proc_list_lock,
-			    &dev->proc_list, current, file);
-	if (ret)
-		goto out;
-
-	dev->usecount++;
-	file->f_op = &dev->fops;
-	up_write(&dev->state_sem);
-	mutex_unlock(&dev->usecount_lock);
-
-#ifdef DSP_PTE_FREE	/* not used currently. */
-	dsp_map_update(current);
-	dsp_cur_users_add(current);
-#endif /* DSP_PTE_FREE */
-	return 0;
-
- change_out:
-	wake_up_interruptible_all(&dev->state_wait_q);
- out:
-	up_write(&dev->state_sem);
-	mutex_unlock(&dev->usecount_lock);
-	return ret;
-}
-
-static int dsp_task_release(struct inode *inode, struct file *file)
-{
-	unsigned int minor = MINOR(inode->i_rdev);
-	struct taskdev *dev = taskdev[minor];
-
-#ifdef DSP_PTE_FREE	/* not used currently. */
-	dsp_cur_users_del(current);
-#endif /* DSP_PTE_FREE */
-
-	if (has_taskdev_lock(dev))
-		taskdev_unlock(dev);
-
-	proc_list_del(&dev->proc_list_lock, &dev->proc_list, current, file);
-	mutex_lock(&dev->usecount_lock);
-	if (--dev->usecount > 0) {
-		/* other processes are using this device. no state change. */
-		mutex_unlock(&dev->usecount_lock);
-		return 0;
-	}
-
-	/* usecount == 0 */
-	down_write(&dev->state_sem);
-
-	/* state can be ATTACHED/FREEZED, KILLING or GARBAGE here. */
-	switch (dev->state & TASKDEV_ST_STATE_MASK) {
-
-	case TASKDEV_ST_KILLING:
-		break;
-
-	case TASKDEV_ST_GARBAGE:
-		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
-		wake_up_interruptible_all(&dev->state_wait_q);
-		break;
-
-	case TASKDEV_ST_ATTACHED:
-	case TASKDEV_ST_FREEZED:
-		if (is_dynamic_task(minor)) {
-			set_taskdev_state(dev, TASKDEV_ST_DELREQ);
-			/* wake up twch daemon for tdel */
-			dsp_twch_touch();
-		}
-		break;
-
-	}
-
-	up_write(&dev->state_sem);
-	mutex_unlock(&dev->usecount_lock);
-	return 0;
-}
-
-/*
- * mkdev / rmdev
- */
-int dsp_mkdev(char *name)
-{
-	struct taskdev *dev;
-	int status;
-	unsigned char minor;
-	int ret;
-
-	if (dsp_cfgstat_get_stat() != CFGSTAT_READY) {
-		printk(KERN_ERR "omapdsp: dsp has not been configured.\n");
-		return -EINVAL;
-	}
-
-	if (mutex_lock_interruptible(&devmgr_lock))
-		return -EINTR;
-
-	/* naming check */
-	for (minor = 0; minor < TASKDEV_MAX; minor++) {
-		if (taskdev[minor] && !strcmp(taskdev[minor]->name, name)) {
-			printk(KERN_ERR
-			       "omapdsp: task device name %s is already "
-			       "in use.\n", name);
-			ret = -EINVAL;
-			goto out;
-		}
-	}
-
-	/* find free minor number */
-	for (minor = n_task; minor < TASKDEV_MAX; minor++) {
-		if (taskdev[minor] == NULL)
-			goto do_make;
-	}
-	printk(KERN_ERR "omapdsp: Too many task devices.\n");
-	ret = -EBUSY;
-	goto out;
-
-do_make:
-	if ((dev = kzalloc(sizeof(struct taskdev), GFP_KERNEL)) == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	if ((status = taskdev_init(dev, name, minor)) < 0) {
-		kfree(dev);
-		ret = status;
-		goto out;
-	}
-	ret = minor;
-
-out:
-	mutex_unlock(&devmgr_lock);
-	return ret;
-}
-
-int dsp_rmdev(char *name)
-{
-	unsigned char minor;
-	int status;
-	int ret;
-
-	if (dsp_cfgstat_get_stat() != CFGSTAT_READY) {
-		printk(KERN_ERR "omapdsp: dsp has not been configured.\n");
-		return -EINVAL;
-	}
-
-	if (mutex_lock_interruptible(&devmgr_lock))
-		return -EINTR;
-
-	/* find in dynamic devices */
-	for (minor = n_task; minor < TASKDEV_MAX; minor++) {
-		if (taskdev[minor] && !strcmp(taskdev[minor]->name, name))
-			goto do_remove;
-	}
-
-	/* find in static devices */
-	for (minor = 0; minor < n_task; minor++) {
-		if (taskdev[minor] && !strcmp(taskdev[minor]->name, name)) {
-			printk(KERN_ERR
-			       "omapdsp: task device %s is static.\n", name);
-			ret = -EINVAL;
-			goto out;
-		}
-	}
-
-	printk(KERN_ERR "omapdsp: task device %s not found.\n", name);
-	return -EINVAL;
-
-do_remove:
-	ret = minor;
-	if ((status = dsp_rmdev_minor(minor)) < 0)
-		ret = status;
-out:
-	mutex_unlock(&devmgr_lock);
-	return ret;
-}
-
-static int dsp_rmdev_minor(unsigned char minor)
-{
-	struct taskdev *dev = taskdev[minor];
-
-	while (!down_write_trylock(&dev->state_sem)) {
-		down_read(&dev->state_sem);
-		if (dev->state & (TASKDEV_ST_ATTACHED |
-				  TASKDEV_ST_FREEZED)) {
-			/*
-			 * task is working. kill it.
-			 * ATTACHED -> FREEZED can be changed under
-			 * down_read of state_sem..
-			 */
-			set_taskdev_state(dev, TASKDEV_ST_FREEZED);
-			wake_up_interruptible_all(&dev->read_wait_q);
-			wake_up_interruptible_all(&dev->write_wait_q);
-			wake_up_interruptible_all(&dev->tctl_wait_q);
-		}
-		up_read(&dev->state_sem);
-		schedule();
-	}
-
-	switch (dev->state & TASKDEV_ST_STATE_MASK) {
-
-	case TASKDEV_ST_NOTASK:
-	case TASKDEV_ST_INVALID:
-		/* fine */
-		goto notask;
-
-	case TASKDEV_ST_ATTACHED:
-	case TASKDEV_ST_FREEZED:
-		/* task is working. kill it. */
-		set_taskdev_state(dev, TASKDEV_ST_KILLING);
-		up_write(&dev->state_sem);
-		dsp_tdel_bh(dev, TDEL_KILL);
-		goto invalidate;
-
-	case TASKDEV_ST_ADDREQ:
-		/* open() is waiting. drain it. */
-		set_taskdev_state(dev, TASKDEV_ST_ADDFAIL);
-		wake_up_interruptible_all(&dev->state_wait_q);
-		break;
-
-	case TASKDEV_ST_DELREQ:
-		/* nobody is waiting. */
-		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
-		wake_up_interruptible_all(&dev->state_wait_q);
-		break;
-
-	case TASKDEV_ST_ADDING:
-	case TASKDEV_ST_DELING:
-	case TASKDEV_ST_KILLING:
-	case TASKDEV_ST_GARBAGE:
-	case TASKDEV_ST_ADDFAIL:
-		/* transient state. wait for a moment. */
-		break;
-
-	}
-
-	up_write(&dev->state_sem);
-
-invalidate:
-	/* wait for some time and hope the state is settled */
-	devstate_read_lock_timeout(dev, TASKDEV_ST_NOTASK, 5 * HZ);
-	if (!(dev->state & TASKDEV_ST_NOTASK)) {
-		printk(KERN_WARNING
-		       "omapdsp: illegal device state (%s) on rmdev %s.\n",
-		       devstate_name(dev->state), dev->name);
-	}
-notask:
-	set_taskdev_state(dev, TASKDEV_ST_INVALID);
-	devstate_read_unlock(dev);
-
-	taskdev_delete(minor);
-	kfree(dev);
-
-	return 0;
-}
-
-static struct file_operations dsp_task_fops = {
-	.owner   = THIS_MODULE,
-	.poll    = dsp_task_poll,
-	.ioctl   = dsp_task_ioctl,
-	.open    = dsp_task_open,
-	.release = dsp_task_release,
-};
-
-static void dsptask_dev_release(struct device *dev)
-{
-}
-
-static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor)
-{
-	int ret;
-	struct device *task_dev;
-
-	taskdev[minor] = dev;
-
-	spin_lock_init(&dev->proc_list_lock);
-	INIT_LIST_HEAD(&dev->proc_list);
-	init_waitqueue_head(&dev->read_wait_q);
-	init_waitqueue_head(&dev->write_wait_q);
-	init_waitqueue_head(&dev->tctl_wait_q);
-	mutex_init(&dev->read_mutex);
-	mutex_init(&dev->write_mutex);
-	mutex_init(&dev->tctl_mutex);
-	mutex_init(&dev->lock);
-	spin_lock_init(&dev->wsz_lock);
-	dev->tctl_ret = -EINVAL;
-	dev->lock_pid = 0;
-
-	strncpy(dev->name, name, TNM_LEN);
-	dev->name[TNM_LEN-1] = '\0';
-	set_taskdev_state(dev, (minor < n_task) ? TASKDEV_ST_ATTACHED : TASKDEV_ST_NOTASK);
-	dev->usecount = 0;
-	mutex_init(&dev->usecount_lock);
-	memcpy(&dev->fops, &dsp_task_fops, sizeof(struct file_operations));
-
-	dev->dev.parent = omap_dsp->dev;
-	dev->dev.bus = &dsptask_bus;
-	sprintf(dev->dev.bus_id, "dsptask%d", minor);
-	dev->dev.release = dsptask_dev_release;
-	ret = device_register(&dev->dev);
-	if (ret) {
-		printk(KERN_ERR "device_register failed: %d\n", ret);
-		return ret;
-	}
-	ret = device_create_file(&dev->dev, &dev_attr_devname);
-	if (ret)
-		goto fail_create_devname;
-	ret = device_create_file(&dev->dev, &dev_attr_devstate);
-	if (ret)
-		goto fail_create_devstate;
-	ret = device_create_file(&dev->dev, &dev_attr_proc_list);
-	if (ret)
-		goto fail_create_proclist;
-
-	task_dev = device_create(dsp_task_class, NULL,
-				 MKDEV(OMAP_DSP_TASK_MAJOR, minor),
-				 "dsptask%d", (int)minor);
-
-	if (unlikely(IS_ERR(task_dev))) {
-		ret = -EINVAL;
-		goto fail_create_taskclass;
-	}
-
-	init_waitqueue_head(&dev->state_wait_q);
-	init_rwsem(&dev->state_sem);
-
-	return 0;
-
- fail_create_taskclass:
-	device_remove_file(&dev->dev, &dev_attr_proc_list);
- fail_create_proclist:
-	device_remove_file(&dev->dev, &dev_attr_devstate);
- fail_create_devstate:
-	device_remove_file(&dev->dev, &dev_attr_devname);
- fail_create_devname:
-	device_unregister(&dev->dev);
-	return ret;
-}
-
-static void taskdev_delete(unsigned char minor)
-{
-	struct taskdev *dev = taskdev[minor];
-
-	if (!dev)
-		return;
-	device_remove_file(&dev->dev, &dev_attr_devname);
-	device_remove_file(&dev->dev, &dev_attr_devstate);
-	device_remove_file(&dev->dev, &dev_attr_proc_list);
-	device_destroy(dsp_task_class, MKDEV(OMAP_DSP_TASK_MAJOR, minor));
-	device_unregister(&dev->dev);
-	proc_list_flush(&dev->proc_list_lock, &dev->proc_list);
-	taskdev[minor] = NULL;
-}
-
-static int taskdev_attach_task(struct taskdev *dev, struct dsptask *task)
-{
-	u16 ttyp = task->ttyp;
-	int ret;
-
-	dev->fops.read =
-		sndtyp_acv(ttyp) ?
-		sndtyp_wd(ttyp) ? dsp_task_read_wd_acv:
-		/* sndtyp_bk */   dsp_task_read_bk_acv:
-		/* sndtyp_psv */
-		sndtyp_wd(ttyp) ? dsp_task_read_wd_psv:
-		/* sndtyp_bk */   dsp_task_read_bk_psv;
-	if (sndtyp_wd(ttyp)) {
-		/* word */
-		size_t fifosz = sndtyp_psv(ttyp) ? 2:32; /* passive:active */
-
-		dev->rcvdt.fifo = kfifo_alloc(fifosz, GFP_KERNEL,
-					      &dev->read_lock);
-		if (IS_ERR(dev->rcvdt.fifo)) {
-			printk(KERN_ERR
-			       "omapdsp: unable to allocate receive buffer. "
-			       "(%d bytes for %s)\n", fifosz, dev->name);
-			return -ENOMEM;
-		}
-	} else {
-		/* block */
-		INIT_IPBLINK(&dev->rcvdt.bk.link);
-		dev->rcvdt.bk.rp = 0;
-	}
-
-	dev->fops.write =
-		rcvtyp_wd(ttyp) ? dsp_task_write_wd:
-		/* rcvbyp_bk */	  dsp_task_write_bk;
-	dev->wsz = rcvtyp_acv(ttyp) ? 0 :		/* active */
-		rcvtyp_wd(ttyp)  ? 2 :		/* passive word */
-		ipbcfg.lsz*2;	/* passive block */
-
-	if (task->map_length)
-		dev->fops.mmap = dsp_task_mmap;
-
-	ret = device_create_file(&dev->dev, &dev_attr_taskname);
-	if (unlikely(ret))
-		goto fail_create_taskname;
-	ret = device_create_file(&dev->dev, &dev_attr_ttyp);
-	if (unlikely(ret))
-		goto fail_create_ttyp;
-	ret = device_create_file(&dev->dev, &dev_attr_wsz);
-	if (unlikely(ret))
-		goto fail_create_wsz;
-	if (task->map_length) {
-		ret = device_create_file(&dev->dev, &dev_attr_mmap);
-		if (unlikely(ret))
-			goto fail_create_mmap;
-	}
-	if (sndtyp_wd(ttyp)) {
-		ret = device_create_file(&dev->dev, &dev_attr_fifosz);
-		if (unlikely(ret))
-			goto fail_create_fifosz;
-		ret = device_create_file(&dev->dev, &dev_attr_fifocnt);
-		if (unlikely(ret))
-			goto fail_create_fifocnt;
-	} else {
-		ret = device_create_file(&dev->dev, &dev_attr_ipblink);
-		if (unlikely(ret))
-			goto fail_create_ipblink;
-	}
-
-	dev->task = task;
-	task->dev = dev;
-
-	return 0;
-
- fail_create_fifocnt:
-	device_remove_file(&dev->dev, &dev_attr_fifosz);
- fail_create_ipblink:
- fail_create_fifosz:
-	if (task->map_length)
-		device_remove_file(&dev->dev, &dev_attr_mmap);
- fail_create_mmap:
-	device_remove_file(&dev->dev, &dev_attr_wsz);
- fail_create_wsz:
-	device_remove_file(&dev->dev, &dev_attr_ttyp);
- fail_create_ttyp:
-	device_remove_file(&dev->dev, &dev_attr_taskname);
- fail_create_taskname:
-	if (task->map_length)
-		dev->fops.mmap = NULL;
-
-	dev->fops.write = NULL;
-	dev->wsz = 0;
-
-	dev->fops.read = NULL;
-	taskdev_flush_buf(dev);
-
-	if (sndtyp_wd(ttyp))
-		kfifo_free(dev->rcvdt.fifo);
-
-	dev->task = NULL;
-
-	return ret;
-}
-
-static void taskdev_detach_task(struct taskdev *dev)
-{
-	u16 ttyp = dev->task->ttyp;
-
-	device_remove_file(&dev->dev, &dev_attr_taskname);
-	device_remove_file(&dev->dev, &dev_attr_ttyp);
-	if (sndtyp_wd(ttyp)) {
-		device_remove_file(&dev->dev, &dev_attr_fifosz);
-		device_remove_file(&dev->dev, &dev_attr_fifocnt);
-	} else
-		device_remove_file(&dev->dev, &dev_attr_ipblink);
-	device_remove_file(&dev->dev, &dev_attr_wsz);
-	if (dev->task->map_length) {
-		device_remove_file(&dev->dev, &dev_attr_mmap);
-		dev->fops.mmap = NULL;
-	}
-
-	dev->fops.read = NULL;
-	taskdev_flush_buf(dev);
-	if (sndtyp_wd(ttyp))
-		kfifo_free(dev->rcvdt.fifo);
-
-	dev->fops.write = NULL;
-	dev->wsz = 0;
-
-	pr_info("omapdsp: taskdev %s disabled.\n", dev->name);
-	dev->task = NULL;
-}
-
-/*
- * tadd / tdel / tkill
- */
-static int dsp_tadd(struct taskdev *dev, dsp_long_t adr)
-{
-	struct dsptask *task;
-	struct mb_exarg arg;
-	u8 tid, tid_response;
-	u16 argv[2];
-	int ret = 0;
-
-	if (!devstate_write_lock_and_test(dev, TASKDEV_ST_ADDREQ)) {
-		printk(KERN_ERR
-		       "omapdsp: taskdev %s is not requesting for tadd. "
-		       "(state is %s)\n", dev->name, devstate_name(dev->state));
-		return -EINVAL;
-	}
-	set_taskdev_state(dev, TASKDEV_ST_ADDING);
-	devstate_write_unlock(dev);
-
-	if (adr == TADD_ABORTADR) {
-		/* aborting tadd intentionally */
-		pr_info("omapdsp: tadd address is ABORTADR.\n");
-		goto fail_out;
-	}
-	if (adr >= DSPSPACE_SIZE) {
-		printk(KERN_ERR
-		       "omapdsp: illegal address 0x%08x for tadd\n", adr);
-		ret = -EINVAL;
-		goto fail_out;
-	}
-
-	adr >>= 1;	/* word address */
-	argv[0] = adr >> 16;	/* addrh */
-	argv[1] = adr & 0xffff;	/* addrl */
-
-	if (mutex_lock_interruptible(&cfg_lock)) {
-		ret = -EINTR;
-		goto fail_out;
-	}
-	cfg_tid = TID_ANON;
-	cfg_cmd = MBOX_CMD_DSP_TADD;
-	arg.tid  = TID_ANON;
-	arg.argc = 2;
-	arg.argv = argv;
-
-	if (dsp_mem_sync_inc() < 0) {
-		printk(KERN_ERR "omapdsp: memory sync failed!\n");
-		ret = -EBUSY;
-		goto fail_out;
-	}
-	mbcompose_send_and_wait_exarg(TADD, 0, 0, &arg, &cfg_wait_q);
-
-	tid = cfg_tid;
-	cfg_tid = TID_ANON;
-	cfg_cmd = 0;
-	mutex_unlock(&cfg_lock);
-
-	if (tid == TID_ANON) {
-		printk(KERN_ERR "omapdsp: tadd failed!\n");
-		ret = -EINVAL;
-		goto fail_out;
-	}
-	if ((tid < n_task) || dsptask[tid]) {
-		printk(KERN_ERR "omapdsp: illegal tid (%d)!\n", tid);
-		ret = -EINVAL;
-		goto fail_out;
-	}
-	if ((task = kzalloc(sizeof(struct dsptask), GFP_KERNEL)) == NULL) {
-		ret = -ENOMEM;
-		goto del_out;
-	}
-
-	if ((ret = dsp_task_config(task, tid)) < 0)
-		goto free_out;
-
-	if (strcmp(dev->name, task->name)) {
-		printk(KERN_ERR
-		       "omapdsp: task name (%s) doesn't match with "
-		       "device name (%s).\n", task->name, dev->name);
-		ret = -EINVAL;
-		goto free_out;
-	}
-
-	if ((ret = taskdev_attach_task(dev, task)) < 0)
-		goto free_out;
-
-	dsp_task_init(task);
-	pr_info("omapdsp: taskdev %s enabled.\n", dev->name);
-	set_taskdev_state(dev, TASKDEV_ST_ATTACHED);
-	wake_up_interruptible_all(&dev->state_wait_q);
-	return 0;
-
-free_out:
-	kfree(task);
-
-del_out:
-	printk(KERN_ERR "omapdsp: deleting the task...\n");
-
-	set_taskdev_state(dev, TASKDEV_ST_DELING);
-
-	if (mutex_lock_interruptible(&cfg_lock)) {
-		printk(KERN_ERR "omapdsp: aborting tdel process. "
-				"DSP side could be corrupted.\n");
-		goto fail_out;
-	}
-	cfg_tid = TID_ANON;
-	cfg_cmd = MBOX_CMD_DSP_TDEL;
-	mbcompose_send_and_wait(TDEL, tid, TDEL_KILL, &cfg_wait_q);
-	tid_response = cfg_tid;
-	cfg_tid = TID_ANON;
-	cfg_cmd = 0;
-	mutex_unlock(&cfg_lock);
-
-	if (tid_response != tid)
-		printk(KERN_ERR "omapdsp: tdel failed. "
-				"DSP side could be corrupted.\n");
-
-fail_out:
-	set_taskdev_state(dev, TASKDEV_ST_ADDFAIL);
-	wake_up_interruptible_all(&dev->state_wait_q);
-	return ret;
-}
-
-int dsp_tadd_minor(unsigned char minor, dsp_long_t adr)
-{
-	struct taskdev *dev;
-	int status;
-	int ret;
-
-	if (mutex_lock_interruptible(&devmgr_lock))
-		return -EINTR;
-
-	if ((minor >= TASKDEV_MAX) || ((dev = taskdev[minor]) == NULL)) {
-		printk(KERN_ERR
-		       "omapdsp: no task device with minor %d\n", minor);
-		ret = -EINVAL;
-		goto out;
-	}
-	ret = minor;
-	if ((status = dsp_tadd(dev, adr)) < 0)
-		ret = status;
-
-out:
-	mutex_unlock(&devmgr_lock);
-	return ret;
-}
-
-static int dsp_tdel(struct taskdev *dev)
-{
-	if (!devstate_write_lock_and_test(dev, TASKDEV_ST_DELREQ)) {
-		printk(KERN_ERR
-		       "omapdsp: taskdev %s is not requesting for tdel. "
-		       "(state is %s)\n", dev->name, devstate_name(dev->state));
-		return -EINVAL;
-	}
-	set_taskdev_state(dev, TASKDEV_ST_DELING);
-	devstate_write_unlock(dev);
-
-	return dsp_tdel_bh(dev, TDEL_SAFE);
-}
-
-int dsp_tdel_minor(unsigned char minor)
-{
-	struct taskdev *dev;
-	int status;
-	int ret;
-
-	if (mutex_lock_interruptible(&devmgr_lock))
-		return -EINTR;
-
-	if ((minor >= TASKDEV_MAX) || ((dev = taskdev[minor]) == NULL)) {
-		printk(KERN_ERR
-		       "omapdsp: no task device with minor %d\n", minor);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = minor;
-	if ((status = dsp_tdel(dev)) < 0)
-		ret = status;
-
-out:
-	mutex_unlock(&devmgr_lock);
-	return ret;
-}
-
-static int dsp_tkill(struct taskdev *dev)
-{
-	while (!down_write_trylock(&dev->state_sem)) {
-		if (!devstate_read_lock_and_test(dev, (TASKDEV_ST_ATTACHED |
-						       TASKDEV_ST_FREEZED))) {
-			printk(KERN_ERR
-			       "omapdsp: task has not been attached for "
-			       "taskdev %s\n", dev->name);
-			return -EINVAL;
-		}
-		/* ATTACHED -> FREEZED can be changed under read semaphore. */
-		set_taskdev_state(dev, TASKDEV_ST_FREEZED);
-		wake_up_interruptible_all(&dev->read_wait_q);
-		wake_up_interruptible_all(&dev->write_wait_q);
-		wake_up_interruptible_all(&dev->tctl_wait_q);
-		devstate_read_unlock(dev);
-		schedule();
-	}
-
-	if (!(dev->state & (TASKDEV_ST_ATTACHED |
-			    TASKDEV_ST_FREEZED))) {
-		printk(KERN_ERR
-		       "omapdsp: task has not been attached for taskdev %s\n",
-		       dev->name);
-		devstate_write_unlock(dev);
-		return -EINVAL;
-	}
-	if (!is_dynamic_task(dev->task->tid)) {
-		printk(KERN_ERR "omapdsp: task %s is not a dynamic task.\n",
-		       dev->name);
-		devstate_write_unlock(dev);
-		return -EINVAL;
-	}
-	set_taskdev_state(dev, TASKDEV_ST_KILLING);
-	devstate_write_unlock(dev);
-
-	return dsp_tdel_bh(dev, TDEL_KILL);
-}
-
-int dsp_tkill_minor(unsigned char minor)
-{
-	struct taskdev *dev;
-	int status;
-	int ret;
-
-	if (mutex_lock_interruptible(&devmgr_lock))
-		return -EINTR;
-
-	if ((minor >= TASKDEV_MAX) || ((dev = taskdev[minor]) == NULL)) {
-		printk(KERN_ERR
-		       "omapdsp: no task device with minor %d\n", minor);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = minor;
-	if ((status = dsp_tkill(dev)) < 0)
-		ret = status;
-
-out:
-	mutex_unlock(&devmgr_lock);
-	return ret;
-}
-
-static int dsp_tdel_bh(struct taskdev *dev, u16 type)
-{
-	struct dsptask *task;
-	u8 tid, tid_response;
-	int ret = 0;
-
-	task = dev->task;
-	tid = task->tid;
-	if (mutex_lock_interruptible(&cfg_lock)) {
-		if (type == TDEL_SAFE) {
-			set_taskdev_state(dev, TASKDEV_ST_DELREQ);
-			return -EINTR;
-		} else {
-			tid_response = TID_ANON;
-			ret = -EINTR;
-			goto detach_out;
-		}
-	}
-	cfg_tid = TID_ANON;
-	cfg_cmd = MBOX_CMD_DSP_TDEL;
-	mbcompose_send_and_wait(TDEL, tid, type, &cfg_wait_q);
-	tid_response = cfg_tid;
-	cfg_tid = TID_ANON;
-	cfg_cmd = 0;
-	mutex_unlock(&cfg_lock);
-
-detach_out:
-	taskdev_detach_task(dev);
-	dsp_task_unconfig(task);
-	kfree(task);
-
-	if (tid_response != tid) {
-		printk(KERN_ERR "omapdsp: %s failed!\n",
-		       (type == TDEL_SAFE) ? "tdel" : "tkill");
-		ret = -EINVAL;
-	}
-	down_write(&dev->state_sem);
-	set_taskdev_state(dev, (dev->usecount > 0) ? TASKDEV_ST_GARBAGE :
-					   TASKDEV_ST_NOTASK);
-	wake_up_interruptible_all(&dev->state_wait_q);
-	up_write(&dev->state_sem);
-
-	return ret;
-}
-
-/*
- * state inquiry
- */
-long taskdev_state_stale(unsigned char minor)
-{
-	if (taskdev[minor]) {
-		long state = taskdev[minor]->state;
-		taskdev[minor]->state |= TASKDEV_ST_STALE;
-		return state;
-	} else
-		return TASKDEV_ST_NOTASK;
-}
-
-/*
- * functions called from mailbox interrupt routine
- */
-void mbox_wdsnd(struct mbcmd *mb)
-{
-	unsigned int n;
-	u8 tid = mb->cmd_l;
-	u16 data = mb->data;
-	struct dsptask *task = dsptask[tid];
-
-	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
-		printk(KERN_ERR "mbox: WDSND with illegal tid! %d\n", tid);
-		return;
-	}
-	if (sndtyp_bk(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: WDSND from block sending task! (task%d)\n", tid);
-		return;
-	}
-	if (sndtyp_psv(task->ttyp) &&
-	    !waitqueue_active(&task->dev->read_wait_q)) {
-		printk(KERN_WARNING
-		       "mbox: WDSND from passive sending task (task%d) "
-		       "without request!\n", tid);
-		return;
-	}
-
-	n = kfifo_put(task->dev->rcvdt.fifo, (unsigned char *)&data,
-		      sizeof(data));
-	if (n != sizeof(data))
-		printk(KERN_WARNING "Receive FIFO(%d) is full\n", tid);
-
-	wake_up_interruptible(&task->dev->read_wait_q);
-}
-
-void mbox_wdreq(struct mbcmd *mb)
-{
-	u8 tid = mb->cmd_l;
-	struct dsptask *task = dsptask[tid];
-	struct taskdev *dev;
-
-	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
-		printk(KERN_ERR "mbox: WDREQ with illegal tid! %d\n", tid);
-		return;
-	}
-	if (rcvtyp_psv(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: WDREQ from passive receiving task! (task%d)\n",
-		       tid);
-		return;
-	}
-
-	dev = task->dev;
-	spin_lock(&dev->wsz_lock);
-	dev->wsz = 2;
-	spin_unlock(&dev->wsz_lock);
-	wake_up_interruptible(&dev->write_wait_q);
-}
-
-void mbox_bksnd(struct mbcmd *mb)
-{
-	u8 tid = mb->cmd_l;
-	u16 bid = mb->data;
-	struct dsptask *task = dsptask[tid];
-	struct ipbuf_head *ipb_h;
-	u16 cnt;
-
-	if (bid >= ipbcfg.ln) {
-		printk(KERN_ERR "mbox: BKSND with illegal bid! %d\n", bid);
-		return;
-	}
-	ipb_h = bid_to_ipbuf(bid);
-	ipb_bsycnt_dec(&ipbcfg);
-	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
-		printk(KERN_ERR "mbox: BKSND with illegal tid! %d\n", tid);
-		goto unuse_ipbuf_out;
-	}
-	if (sndtyp_wd(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: BKSND from word sending task! (task%d)\n", tid);
-		goto unuse_ipbuf_out;
-	}
-	if (sndtyp_pvt(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: BKSND from private sending task! (task%d)\n", tid);
-		goto unuse_ipbuf_out;
-	}
-	if (sync_with_dsp(&ipb_h->p->sd, tid, 10) < 0) {
-		printk(KERN_ERR "mbox: BKSND - IPBUF sync failed!\n");
-		return;
-	}
-
-	/* should be done in DSP, but just in case. */
-	ipb_h->p->next = BID_NULL;
-
-	cnt = ipb_h->p->c;
-	if (cnt > ipbcfg.lsz) {
-		printk(KERN_ERR "mbox: BKSND cnt(%d) > ipbuf line size(%d)!\n",
-		       cnt, ipbcfg.lsz);
-		goto unuse_ipbuf_out;
-	}
-
-	if (cnt == 0) {
-		/* 0-byte send from DSP */
-		unuse_ipbuf_nowait(ipb_h);
-		goto done;
-	}
-	ipblink_add_tail(&task->dev->rcvdt.bk.link, bid);
-	/* we keep coming bid and return alternative line to DSP. */
-	balance_ipbuf();
-
-done:
-	wake_up_interruptible(&task->dev->read_wait_q);
-	return;
-
-unuse_ipbuf_out:
-	unuse_ipbuf_nowait(ipb_h);
-	return;
-}
-
-void mbox_bkreq(struct mbcmd *mb)
-{
-	u8 tid = mb->cmd_l;
-	u16 cnt = mb->data;
-	struct dsptask *task = dsptask[tid];
-	struct taskdev *dev;
-
-	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
-		printk(KERN_ERR "mbox: BKREQ with illegal tid! %d\n", tid);
-		return;
-	}
-	if (rcvtyp_wd(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: BKREQ from word receiving task! (task%d)\n", tid);
-		return;
-	}
-	if (rcvtyp_pvt(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: BKREQ from private receiving task! (task%d)\n",
-		       tid);
-		return;
-	}
-	if (rcvtyp_psv(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: BKREQ from passive receiving task! (task%d)\n",
-		       tid);
-		return;
-	}
-
-	dev = task->dev;
-	spin_lock(&dev->wsz_lock);
-	dev->wsz = cnt*2;
-	spin_unlock(&dev->wsz_lock);
-	wake_up_interruptible(&dev->write_wait_q);
-}
-
-void mbox_bkyld(struct mbcmd *mb)
-{
-	u16 bid = mb->data;
-	struct ipbuf_head *ipb_h;
-
-	if (bid >= ipbcfg.ln) {
-		printk(KERN_ERR "mbox: BKYLD with illegal bid! %d\n", bid);
-		return;
-	}
-	ipb_h = bid_to_ipbuf(bid);
-
-	/* should be done in DSP, but just in case. */
-	ipb_h->p->next = BID_NULL;
-
-	/* we don't need to sync with DSP */
-	ipb_bsycnt_dec(&ipbcfg);
-	release_ipbuf(ipb_h);
-}
-
-void mbox_bksndp(struct mbcmd *mb)
-{
-	u8 tid = mb->cmd_l;
-	struct dsptask *task = dsptask[tid];
-	struct ipbuf_p *ipbp;
-
-	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
-		printk(KERN_ERR "mbox: BKSNDP with illegal tid! %d\n", tid);
-		return;
-	}
-	if (sndtyp_wd(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: BKSNDP from word sending task! (task%d)\n", tid);
-		return;
-	}
-	if (sndtyp_gbl(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: BKSNDP from non-private sending task! (task%d)\n",
-		       tid);
-		return;
-	}
-
-	/*
-	 * we should not have delayed block at this point
-	 * because read() routine releases the lock of the buffer and
-	 * until then DSP can't send next data.
-	 */
-
-	ipbp = task->ipbuf_pvt_r;
-	if (sync_with_dsp(&ipbp->s, tid, 10) < 0) {
-		printk(KERN_ERR "mbox: BKSNDP - IPBUF sync failed!\n");
-		return;
-	}
-	pr_debug("mbox: ipbuf_pvt_r->a = 0x%08lx\n",
-	       MKLONG(ipbp->ah, ipbp->al));
-	ipblink_add_pvt(&task->dev->rcvdt.bk.link);
-	wake_up_interruptible(&task->dev->read_wait_q);
-}
-
-void mbox_bkreqp(struct mbcmd *mb)
-{
-	u8 tid = mb->cmd_l;
-	struct dsptask *task = dsptask[tid];
-	struct taskdev *dev;
-	struct ipbuf_p *ipbp;
-
-	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
-		printk(KERN_ERR "mbox: BKREQP with illegal tid! %d\n", tid);
-		return;
-	}
-	if (rcvtyp_wd(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: BKREQP from word receiving task! (task%d)\n", tid);
-		return;
-	}
-	if (rcvtyp_gbl(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: BKREQP from non-private receiving task! (task%d)\n", tid);
-		return;
-	}
-	if (rcvtyp_psv(task->ttyp)) {
-		printk(KERN_ERR
-		       "mbox: BKREQP from passive receiving task! (task%d)\n", tid);
-		return;
-	}
-
-	ipbp = task->ipbuf_pvt_w;
-	if (sync_with_dsp(&ipbp->s, TID_FREE, 10) < 0) {
-		printk(KERN_ERR "mbox: BKREQP - IPBUF sync failed!\n");
-		return;
-	}
-	pr_debug("mbox: ipbuf_pvt_w->a = 0x%08lx\n",
-	       MKLONG(ipbp->ah, ipbp->al));
-	dev = task->dev;
-	spin_lock(&dev->wsz_lock);
-	dev->wsz = ipbp->c*2;
-	spin_unlock(&dev->wsz_lock);
-	wake_up_interruptible(&dev->write_wait_q);
-}
-
-void mbox_tctl(struct mbcmd *mb)
-{
-	u8 tid = mb->cmd_l;
-	struct dsptask *task = dsptask[tid];
-
-	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
-		printk(KERN_ERR "mbox: TCTL with illegal tid! %d\n", tid);
-		return;
-	}
-
-	if (!waitqueue_active(&task->dev->tctl_wait_q)) {
-		printk(KERN_WARNING "mbox: unexpected TCTL from DSP!\n");
-		return;
-	}
-
-	task->dev->tctl_stat = mb->data;
-	wake_up_interruptible(&task->dev->tctl_wait_q);
-}
-
-void mbox_tcfg(struct mbcmd *mb)
-{
-	u8 tid = mb->cmd_l;
-	struct dsptask *task = dsptask[tid];
-	u16 *tnm;
-	volatile u16 *buf;
-	int i;
-
-	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
-		printk(KERN_ERR "mbox: TCFG with illegal tid! %d\n", tid);
-		return;
-	}
-	if ((task->state != TASK_ST_CFGREQ) || (cfg_cmd != MBOX_CMD_DSP_TCFG)) {
-		printk(KERN_WARNING "mbox: unexpected TCFG from DSP!\n");
-		return;
-	}
-
-	if (dsp_mem_enable(ipbuf_sys_da) < 0) {
-		printk(KERN_ERR "mbox: TCFG - ipbuf_sys_da read failed!\n");
-		dsp_mem_disable(ipbuf_sys_da);
-		goto out;
-	}
-	if (sync_with_dsp(&ipbuf_sys_da->s, tid, 10) < 0) {
-		printk(KERN_ERR "mbox: TCFG - IPBUF sync failed!\n");
-		dsp_mem_disable(ipbuf_sys_da);
-		goto out;
-	}
-
-	/*
-	 * read configuration data on system IPBUF
-	 */
-	buf = ipbuf_sys_da->d;
-	task->ttyp        = buf[0];
-	task->ipbuf_pvt_r = MKVIRT(buf[1], buf[2]);
-	task->ipbuf_pvt_w = MKVIRT(buf[3], buf[4]);
-	task->map_base    = MKVIRT(buf[5], buf[6]);
-	task->map_length  = MKLONG(buf[7], buf[8]) << 1;	/* word -> byte */
-	tnm               = MKVIRT(buf[9], buf[10]);
-	release_ipbuf_pvt(ipbuf_sys_da);
-	dsp_mem_disable(ipbuf_sys_da);
-
-	/*
-	 * copy task name string
-	 */
-	if (dsp_address_validate(tnm, TNM_LEN, "task name buffer") < 0) {
-		task->name[0] = '\0';
-		goto out;
-	}
-
-	for (i = 0; i < TNM_LEN-1; i++) {
-		/* avoiding byte access */
-		u16 tmp = tnm[i];
-		task->name[i] = tmp & 0x00ff;
-		if (!tmp)
-			break;
-	}
-	task->name[TNM_LEN-1] = '\0';
-
-	task->state = TASK_ST_READY;
-out:
-	wake_up_interruptible(&cfg_wait_q);
-}
-
-void mbox_tadd(struct mbcmd *mb)
-{
-	u8 tid = mb->cmd_l;
-
-	if ((!waitqueue_active(&cfg_wait_q)) || (cfg_cmd != MBOX_CMD_DSP_TADD)) {
-		printk(KERN_WARNING "mbox: unexpected TADD from DSP!\n");
-		return;
-	}
-	cfg_tid = tid;
-	wake_up_interruptible(&cfg_wait_q);
-}
-
-void mbox_tdel(struct mbcmd *mb)
-{
-	u8 tid = mb->cmd_l;
-
-	if ((!waitqueue_active(&cfg_wait_q)) || (cfg_cmd != MBOX_CMD_DSP_TDEL)) {
-		printk(KERN_WARNING "mbox: unexpected TDEL from DSP!\n");
-		return;
-	}
-	cfg_tid = tid;
-	wake_up_interruptible(&cfg_wait_q);
-}
-
-void mbox_err_fatal(u8 tid)
-{
-	struct dsptask *task = dsptask[tid];
-	struct taskdev *dev;
-
-	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
-		printk(KERN_ERR "mbox: FATAL ERR with illegal tid! %d\n", tid);
-		return;
-	}
-
-	/* wake up waiting processes */
-	dev = task->dev;
-	wake_up_interruptible_all(&dev->read_wait_q);
-	wake_up_interruptible_all(&dev->write_wait_q);
-	wake_up_interruptible_all(&dev->tctl_wait_q);
-}
-
-static u16 *dbg_buf;
-static u16 dbg_buf_sz, dbg_line_sz;
-static int dbg_rp;
-
-int dsp_dbg_config(u16 *buf, u16 sz, u16 lsz)
-{
-#ifdef OLD_BINARY_SUPPORT
-	if ((mbox_revision == MBREV_3_0) || (mbox_revision == MBREV_3_2)) {
-		dbg_buf = NULL;
-		dbg_buf_sz = 0;
-		dbg_line_sz = 0;
-		dbg_rp = 0;
-		return 0;
-	}
-#endif
-
-	if (dsp_address_validate(buf, sz, "debug buffer") < 0)
-		return -1;
-
-	if (lsz > sz) {
-		printk(KERN_ERR
-		       "omapdsp: dbg_buf lsz (%d) is greater than its "
-		       "buffer size (%d)\n", lsz, sz);
-		return -1;
-	}
-
-	dbg_buf = buf;
-	dbg_buf_sz = sz;
-	dbg_line_sz = lsz;
-	dbg_rp = 0;
-
-	return 0;
-}
-
-void dsp_dbg_stop(void)
-{
-	dbg_buf = NULL;
-}
-
-#ifdef OLD_BINARY_SUPPORT
-static void mbox_dbg_old(struct mbcmd *mb);
-#endif
-
-void mbox_dbg(struct mbcmd *mb)
-{
-	u8 tid = mb->cmd_l;
-	int cnt = mb->data;
-	char s[80], *s_end = &s[79], *p;
-	u16 *src;
-	int i;
-
-#ifdef OLD_BINARY_SUPPORT
-	if ((mbox_revision == MBREV_3_0) || (mbox_revision == MBREV_3_2)) {
-		mbox_dbg_old(mb);
-		return;
-	}
-#endif
-
-	if (((tid >= TASKDEV_MAX) || (dsptask[tid] == NULL)) &&
-	    (tid != TID_ANON)) {
-		printk(KERN_ERR "mbox: DBG with illegal tid! %d\n", tid);
-		return;
-	}
-	if (dbg_buf == NULL) {
-		printk(KERN_ERR "mbox: DBG command received, but "
-		       "dbg_buf has not been configured yet.\n");
-		return;
-	}
-
-	if (dsp_mem_enable(dbg_buf) < 0)
-		return;
-
-	src = &dbg_buf[dbg_rp];
-	p = s;
-	for (i = 0; i < cnt; i++) {
-		u16 tmp;
-		/*
-		 * Be carefull that dbg_buf should not be read with
-		 * 1-byte access since it might be placed in DARAM/SARAM
-		 * and it can cause unexpected byteswap.
-		 * For example,
-		 *   *(p++) = *(src++) & 0xff;
-		 * causes 1-byte access!
-		 */
-		tmp = *src++;
-		*(p++) = tmp & 0xff;
-		if (*(p-1) == '\n') {
-			*p = '\0';
-			pr_info("%s", s);
-			p = s;
-			continue;
-		}
-		if (p == s_end) {
-			*p = '\0';
-			pr_info("%s\n", s);
-			p = s;
-			continue;
-		}
-	}
-	if (p > s) {
-		*p = '\0';
-		pr_info("%s\n", s);
-	}
-	if ((dbg_rp += cnt + 1) > dbg_buf_sz - dbg_line_sz)
-		dbg_rp = 0;
-
-	dsp_mem_disable(dbg_buf);
-}
-
-#ifdef OLD_BINARY_SUPPORT
-static void mbox_dbg_old(struct mbcmd *mb)
-{
-	u8 tid = mb->cmd_l;
-	char s[80], *s_end = &s[79], *p;
-	u16 *src;
-	volatile u16 *buf;
-	int cnt;
-	int i;
-
-	if (((tid >= TASKDEV_MAX) || (dsptask[tid] == NULL)) &&
-	    (tid != TID_ANON)) {
-		printk(KERN_ERR "mbox: DBG with illegal tid! %d\n", tid);
-		return;
-	}
-	if (dsp_mem_enable(ipbuf_sys_da) < 0) {
-		printk(KERN_ERR "mbox: DBG - ipbuf_sys_da read failed!\n");
-		return;
-	}
-	if (sync_with_dsp(&ipbuf_sys_da->s, tid, 10) < 0) {
-		printk(KERN_ERR "mbox: DBG - IPBUF sync failed!\n");
-		goto out1;
-	}
-	buf = ipbuf_sys_da->d;
-	cnt = buf[0];
-	src = MKVIRT(buf[1], buf[2]);
-	if (dsp_address_validate(src, cnt, "dbg buffer") < 0)
-		goto out2;
-
-	if (dsp_mem_enable(src) < 0)
-		goto out2;
-
-	p = s;
-	for (i = 0; i < cnt; i++) {
-		u16 tmp;
-		/*
-		 * Be carefull that ipbuf should not be read with
-		 * 1-byte access since it might be placed in DARAM/SARAM
-		 * and it can cause unexpected byteswap.
-		 * For example,
-		 *   *(p++) = *(src++) & 0xff;
-		 * causes 1-byte access!
-		 */
-		tmp = *src++;
-		*(p++) = tmp & 0xff;
-		if (*(p-1) == '\n') {
-			*p = '\0';
-			pr_info("%s", s);
-			p = s;
-			continue;
-		}
-		if (p == s_end) {
-			*p = '\0';
-			pr_info("%s\n", s);
-			p = s;
-			continue;
-		}
-	}
-	if (p > s) {
-		*p = '\0';
-		pr_info("%s\n", s);
-	}
-
-	dsp_mem_disable(src);
-out2:
-	release_ipbuf_pvt(ipbuf_sys_da);
-out1:
-	dsp_mem_disable(ipbuf_sys_da);
-}
-#endif /* OLD_BINARY_SUPPORT */
-
-/*
- * sysfs files: for each device
- */
-
-/* devname */
-static ssize_t devname_show(struct device *d, struct device_attribute *attr,
-			    char *buf)
-{
-	return sprintf(buf, "%s\n", to_taskdev(d)->name);
-}
-
-/* devstate */
-static ssize_t devstate_show(struct device *d, struct device_attribute *attr,
-			     char *buf)
-{
-	return sprintf(buf, "%s\n", devstate_name(to_taskdev(d)->state));
-}
-
-/* proc_list */
-static ssize_t proc_list_show(struct device *d, struct device_attribute *attr,
-			      char *buf)
-{
-	struct taskdev *dev;
-	struct proc_list *pl;
-	int len = 0;
-
-	dev = to_taskdev(d);
-	spin_lock(&dev->proc_list_lock);
-	list_for_each_entry(pl, &dev->proc_list, list_head) {
-		/* need to lock tasklist_lock before calling
-		 * find_task_by_pid_type. */
-		if (find_task_by_pid(pl->pid) != NULL)
-			len += sprintf(buf + len, "%d\n", pl->pid);
-		read_unlock(&tasklist_lock);
-	}
-	spin_unlock(&dev->proc_list_lock);
-
-	return len;
-}
-
-/* taskname */
-static ssize_t taskname_show(struct device *d, struct device_attribute *attr,
-			     char *buf)
-{
-	struct taskdev *dev = to_taskdev(d);
-	int len;
-
-	if (!devstate_read_lock_and_test(dev, TASKDEV_ST_ATTACHED))
-		return -ENODEV;
-
-	len = sprintf(buf, "%s\n", dev->task->name);
-
-	devstate_read_unlock(dev);
-	return len;
-}
-
-/* ttyp */
-static ssize_t ttyp_show(struct device *d, struct device_attribute *attr,
-			 char *buf)
-{
-	struct taskdev *dev = to_taskdev(d);
-	u16 ttyp;
-	int len = 0;
-
-	if (!devstate_read_lock_and_test(dev, TASKDEV_ST_ATTACHED))
-		return -ENODEV;
-
-	ttyp = dev->task->ttyp;
-	len += sprintf(buf + len, "0x%04x\n", ttyp);
-	len += sprintf(buf + len, "%s %s send\n",
-			(sndtyp_acv(ttyp)) ? "active" :
-					     "passive",
-			(sndtyp_wd(ttyp))  ? "word" :
-			(sndtyp_pvt(ttyp)) ? "private block" :
-					     "global block");
-	len += sprintf(buf + len, "%s %s receive\n",
-			(rcvtyp_acv(ttyp)) ? "active" :
-					     "passive",
-			(rcvtyp_wd(ttyp))  ? "word" :
-			(rcvtyp_pvt(ttyp)) ? "private block" :
-					     "global block");
-
-	devstate_read_unlock(dev);
-	return len;
-}
-
-/* fifosz */
-static ssize_t fifosz_show(struct device *d, struct device_attribute *attr,
-			   char *buf)
-{
-	struct kfifo *fifo = to_taskdev(d)->rcvdt.fifo;
-	return sprintf(buf, "%d\n", fifo->size);
-}
-
-static int fifosz_store(struct device *d, struct device_attribute *attr,
-			const char *buf, size_t count)
-{
-	struct taskdev *dev = to_taskdev(d);
-	unsigned long fifosz;
-	int ret;
-
-	fifosz = simple_strtol(buf, NULL, 10);
-	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
-		return -ENODEV;
-	ret = taskdev_set_fifosz(dev, fifosz);
-	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
-
-	return (ret < 0) ? ret : strlen(buf);
-}
-
-/* fifocnt */
-static ssize_t fifocnt_show(struct device *d, struct device_attribute *attr,
-			    char *buf)
-{
-	struct kfifo *fifo = to_taskdev(d)->rcvdt.fifo;
-	return sprintf(buf, "%d\n", fifo->size);
-}
-
-/* ipblink */
-static inline char *bid_name(u16 bid)
-{
-	static char s[6];
-
-	switch (bid) {
-	case BID_NULL:
-		return "NULL";
-	case BID_PVT:
-		return "PRIVATE";
-	default:
-		sprintf(s, "%d", bid);
-		return s;
-	}
-}
-
-static ssize_t ipblink_show(struct device *d, struct device_attribute *attr,
-			    char *buf)
-{
-	struct rcvdt_bk_struct *rcvdt = &to_taskdev(d)->rcvdt.bk;
-	int len;
-
-	spin_lock(&rcvdt->link.lock);
-	len = sprintf(buf, "top  %s\ntail %s\n",
-		      bid_name(rcvdt->link.top), bid_name(rcvdt->link.tail));
-	spin_unlock(&rcvdt->link.lock);
-
-	return len;
-}
-
-/* wsz */
-static ssize_t wsz_show(struct device *d, struct device_attribute *attr,
-			char *buf)
-{
-	return sprintf(buf, "%d\n", to_taskdev(d)->wsz);
-}
-
-/* mmap */
-static ssize_t mmap_show(struct device *d, struct device_attribute *attr,
-			 char *buf)
-{
-	struct dsptask *task = to_taskdev(d)->task;
-	return sprintf(buf, "0x%p 0x%x\n", task->map_base, task->map_length);
-}
-
-/*
- * called from ipbuf_show()
- */
-int ipbuf_is_held(u8 tid, u16 bid)
-{
-	struct dsptask *task = dsptask[tid];
-	struct ipblink *link;
-	u16 b;
-	int ret = 0;
-
-	if (task == NULL)
-		return 0;
-
-	link = &task->dev->rcvdt.bk.link;
-	spin_lock(&link->lock);
-	ipblink_for_each(b, link) {
-		if (b == bid) {	/* found */
-			ret = 1;
-			break;
-		}
-	}
-	spin_unlock(&link->lock);
-
-	return ret;
-}
-
-int __init dsp_taskmod_init(void)
-{
-	int retval;
-
-	memset(taskdev, 0, sizeof(void *) * TASKDEV_MAX);
-	memset(dsptask, 0, sizeof(void *) * TASKDEV_MAX);
-
-	retval = register_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask",
-				 &dsp_task_fops);
-	if (retval < 0) {
-		printk(KERN_ERR
-		       "omapdsp: failed to register task device: %d\n", retval);
-		return retval;
-	}
-
-	retval = bus_register(&dsptask_bus);
-	if (retval) {
-		printk(KERN_ERR
-		       "omapdsp: failed to register DSP task bus: %d\n",
-		       retval);
-		unregister_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask");
-		return -EINVAL;
-	}
-	retval = driver_register(&dsptask_driver);
-	if (retval) {
-		printk(KERN_ERR
-		       "omapdsp: failed to register DSP task driver: %d\n",
-		       retval);
-		bus_unregister(&dsptask_bus);
-		unregister_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask");
-		return -EINVAL;
-	}
-	dsp_task_class = class_create(THIS_MODULE, "dsptask");
-	if (IS_ERR(dsp_task_class)) {
-		printk(KERN_ERR "omapdsp: failed to create DSP task class\n");
-		driver_unregister(&dsptask_driver);
-		bus_unregister(&dsptask_bus);
-		unregister_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-void dsp_taskmod_exit(void)
-{
-	class_destroy(dsp_task_class);
-	driver_unregister(&dsptask_driver);
-	bus_unregister(&dsptask_bus);
-	unregister_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask");
-}
diff --git a/arch/arm/plat-omap/dsp/taskwatch.c b/arch/arm/plat-omap/dsp/taskwatch.c
deleted file mode 100644
index 4297b51..0000000
--- a/arch/arm/plat-omap/dsp/taskwatch.c
+++ /dev/null
@@ -1,163 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/poll.h>
-#include <linux/sched.h>
-#include <asm/uaccess.h>
-#include <asm/arch/dsp.h>
-#include "dsp_mbcmd.h"
-#include "dsp.h"
-
-static DECLARE_WAIT_QUEUE_HEAD(read_wait_q);
-static unsigned int change_cnt;
-
-void dsp_twch_touch(void)
-{
-	change_cnt++;
-	wake_up_interruptible(&read_wait_q);
-}
-
-/*
- * @count: represents the device counts of the user's interst
- */
-static ssize_t dsp_twch_read(struct file *file, char __user *buf, size_t count,
-			     loff_t *ppos)
-{
-	long taskstat[TASKDEV_MAX];
-	int devcount = count / sizeof(long);
-	int i;
-	DEFINE_WAIT(wait);
-
-	if (dsp_cfgstat_get_stat() != CFGSTAT_READY) {
-		printk(KERN_ERR "omapdsp: dsp has not been configured.\n");
-		return -EINVAL;
-	}
-
-	prepare_to_wait(&read_wait_q, &wait, TASK_INTERRUPTIBLE);
-	if (change_cnt == 0)	/* last check */
-		schedule();
-	finish_wait(&read_wait_q, &wait);
-
-	/* unconfigured while waiting ;-( */
-	if ((change_cnt == 0) && (dsp_cfgstat_get_stat() != CFGSTAT_READY))
-		return -EINVAL;
-
-	if (devcount > TASKDEV_MAX)
-		devcount = TASKDEV_MAX;
-
-	count = devcount * sizeof(long);
-	change_cnt = 0;
-	for (i = 0; i < devcount; i++) {
-		/*
-		 * once the device state is read, the 'STALE' bit will be set
-		 * so that the Dynamic Loader can distinguish the new request
-		 * from the old one.
-		 */
-		taskstat[i] = taskdev_state_stale(i);
-	}
-
-	if (copy_to_user(buf, taskstat, count))
-		return -EFAULT;
-
-	return count;
-}
-
-static unsigned int dsp_twch_poll(struct file *file, poll_table *wait)
-{
-	unsigned int mask = 0;
-
-	poll_wait(file, &read_wait_q, wait);
-	if (change_cnt)
-		mask |= POLLIN | POLLRDNORM;
-
-	return mask;
-}
-
-static int dsp_twch_ioctl(struct inode *inode, struct file *file,
-			  unsigned int cmd, unsigned long arg)
-{
-	int ret;
-
-	switch (cmd) {
-	case TWCH_IOCTL_MKDEV:
-		{
-			char name[TNM_LEN];
-			if (copy_from_user(name, (void __user *)arg, TNM_LEN))
-				return -EFAULT;
-			name[TNM_LEN-1] = '\0';
-			ret = dsp_mkdev(name);
-			break;
-		}
-
-	case TWCH_IOCTL_RMDEV:
-		{
-			char name[TNM_LEN];
-			if (copy_from_user(name, (void __user *)arg, TNM_LEN))
-				return -EFAULT;
-			name[TNM_LEN-1] = '\0';
-			ret = dsp_rmdev(name);
-			break;
-		}
-
-	case TWCH_IOCTL_TADD:
-		{
-			struct omap_dsp_taddinfo ti;
-			if (copy_from_user(&ti, (void __user *)arg, sizeof(ti)))
-				return -EFAULT;
-			ret = dsp_tadd_minor(ti.minor, ti.taskadr);
-			break;
-		}
-
-	case TWCH_IOCTL_TDEL:
-		ret = dsp_tdel_minor(arg);
-		break;
-
-	case TWCH_IOCTL_TKILL:
-		ret = dsp_tkill_minor(arg);
-		break;
-
-	default:
-		return -ENOIOCTLCMD;
-	}
-
-	return ret;
-}
-
-struct file_operations dsp_twch_fops = {
-	.owner = THIS_MODULE,
-	.read  = dsp_twch_read,
-	.poll  = dsp_twch_poll,
-	.ioctl = dsp_twch_ioctl,
-};
-
-void dsp_twch_start(void)
-{
-	change_cnt = 1;		/* first read will not wait */
-}
-
-void dsp_twch_stop(void)
-{
-	wake_up_interruptible(&read_wait_q);
-}
diff --git a/arch/arm/plat-omap/dsp/uaccess_dsp.S b/arch/arm/plat-omap/dsp/uaccess_dsp.S
deleted file mode 100644
index bcf4a54..0000000
--- a/arch/arm/plat-omap/dsp/uaccess_dsp.S
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2004-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-
-		.text
-
-/* Prototype: int __copy_to_user_dsp_2b(void *to, const char *from)
- * Purpose  : copy 2 bytes to user memory from kernel(DSP) memory
- *            escaping from unexpected byte swap using __copy_to_user()
- *            in OMAP architecture.
- * Params   : to   - user memory
- *          : from - kernel(DSP) memory
- * Returns  : success = 0, failure = 2
- */
-
-ENTRY(__copy_to_user_dsp_2b)
-		stmfd	sp!, {r4, lr}
-		ldrb	r3, [r1], #1
-		ldrb	r4, [r1], #1
-USER(		strbt	r4, [r0], #1)			@ May fault
-USER(		strbt	r3, [r0], #1)			@ May fault
-		mov	r0, #0
-		ldmfd	sp!, {r4, pc}
-
-		.section .fixup,"ax"
-		.align	0
-9001:		mov	r0, #2
-		ldmfd	sp!, {r4, pc}
-		.previous
-
-/* Prototype: unsigned long __copy_from_user_dsp_2b(void *to, const void *from);
- * Purpose  : copy 2 bytes from user memory to kernel(DSP) memory
- *            escaping from unexpected byte swap using __copy_to_user()
- *            in OMAP architecture.
- * Params   : to   - kernel (DSP) memory
- *          : from - user memory
- * Returns  : success = 0, failure = 2
- */
-
-ENTRY(__copy_from_user_dsp_2b)
-		stmfd	sp!, {r4, lr}
-USER(		ldrbt	r3, [r1], #1)			@ May fault
-USER(		ldrbt	r4, [r1], #1)			@ May fault
-		strb	r4, [r0], #1
-		strb	r3, [r0], #1
-		mov	r0, #0
-		ldmfd	sp!, {r4, pc}
-
-		.section .fixup,"ax"
-		.align	0
-9001:		mov	r3, #0
-		strh	r3, [r0], #2
-		mov	r0, #2
-		ldmfd	sp!, {r4, pc}
-		.previous
diff --git a/arch/arm/plat-omap/dsp/uaccess_dsp.h b/arch/arm/plat-omap/dsp/uaccess_dsp.h
deleted file mode 100644
index 028814f..0000000
--- a/arch/arm/plat-omap/dsp/uaccess_dsp.h
+++ /dev/null
@@ -1,176 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef _OMAP_DSP_UACCESS_DSP_H
-#define _OMAP_DSP_UACCESS_DSP_H
-
-#include <asm/uaccess.h>
-#include <asm/arch/dsp_common.h>
-#include "dsp.h"
-
-#define HAVE_ASM_COPY_FROM_USER_DSP_2B
-
-#ifdef HAVE_ASM_COPY_FROM_USER_DSP_2B
-extern unsigned long __copy_from_user_dsp_2b(void *to,
-						  const void __user *from);
-extern unsigned long __copy_to_user_dsp_2b(void __user *to,
-						const void *from);
-#endif
-
-#ifndef HAVE_ASM_COPY_FROM_USER_DSP_2B
-static inline unsigned long copy_from_user_dsp_2b(void *to,
-						      const void *from)
-{
-	unsigned short tmp;
-
-	if (__copy_from_user(&tmp, from, 2))
-		return 2;
-	/* expecting compiler to generate "strh" instruction */
-	*((unsigned short *)to) = tmp;
-	return 0;
-}
-#endif
-
-/*
- * @n must be multiple of 2
- */
-static inline unsigned long copy_from_user_dsp(void *to, const void *from,
-						   unsigned long n)
-{
-	if (access_ok(VERIFY_READ, from, n)) {
-		if ((is_dsp_internal_mem(to)) &&
-		    (((unsigned long)to & 2) || (n & 2))) {
-			/*
-			 * DARAM/SARAM with odd word alignment
-			 */
-			unsigned long n4;
-			unsigned long last_n;
-
-			/* dest not aligned -- copy 2 bytes */
-			if (((unsigned long)to & 2) && (n >= 2)) {
-#ifdef HAVE_ASM_COPY_FROM_USER_DSP_2B
-				if (__copy_from_user_dsp_2b(to, from))
-#else
-				if (copy_from_user_dsp_2b(to, from))
-#endif
-					return n;
-				to += 2;
-				from += 2;
-				n -= 2;
-			}
-			/* middle 4*n bytes */
-			last_n = n & 2;
-			n4 = n - last_n;
-			if ((n = __copy_from_user(to, from, n4)) != 0)
-				return n + last_n;
-			/* last 2 bytes */
-			if (last_n) {
-				to += n4;
-				from += n4;
-#ifdef HAVE_ASM_COPY_FROM_USER_DSP_2B
-				if (__copy_from_user_dsp_2b(to, from))
-#else
-				if (copy_from_user_dsp_2b(to, from))
-#endif
-					return 2;
-				n = 0;
-			}
-		} else {
-			/*
-			 * DARAM/SARAM with 4-byte alignment or
-			 * external memory
-			 */
-			n = __copy_from_user(to, from, n);
-		}
-	}
-	else	/* security hole - plug it */
-		memzero(to, n);
-	return n;
-}
-
-#ifndef HAVE_ASM_COPY_FROM_USER_DSP_2B
-static inline unsigned long copy_to_user_dsp_2b(void *to, const void *from)
-{
-	/* expecting compiler to generate "strh" instruction */
-	unsigned short tmp = *(unsigned short *)from;
-
-	return __copy_to_user(to, &tmp, 2);
-}
-#endif
-
-/*
- * @n must be multiple of 2
- */
-static inline unsigned long copy_to_user_dsp(void *to, const void *from,
-						 unsigned long n)
-{
-	if (access_ok(VERIFY_WRITE, to, n)) {
-		if ((is_dsp_internal_mem(from)) &&
-		    (((unsigned long)to & 2) || (n & 2))) {
-			/*
-			 * DARAM/SARAM with odd word alignment
-			 */
-			unsigned long n4;
-			unsigned long last_n;
-
-			/* dest not aligned -- copy 2 bytes */
-			if (((unsigned long)to & 2) && (n >= 2)) {
-#ifdef HAVE_ASM_COPY_FROM_USER_DSP_2B
-				if (__copy_to_user_dsp_2b(to, from))
-#else
-				if (copy_to_user_dsp_2b(to, from))
-#endif
-					return n;
-				to += 2;
-				from += 2;
-				n -= 2;
-			}
-			/* middle 4*n bytes */
-			last_n = n & 2;
-			n4 = n - last_n;
-			if ((n = __copy_to_user(to, from, n4)) != 0)
-				return n + last_n;
-			/* last 2 bytes */
-			if (last_n) {
-				to += n4;
-				from += n4;
-#ifdef HAVE_ASM_COPY_FROM_USER_DSP_2B
-				if (__copy_to_user_dsp_2b(to, from))
-#else
-				if (copy_to_user_dsp_2b(to, from))
-#endif
-					return 2;
-				n = 0;
-			}
-		} else {
-			/*
-			 * DARAM/SARAM with 4-byte alignment or
-			 * external memory
-			 */
-			n = __copy_to_user(to, from, n);
-		}
-	}
-	return n;
-}
-
-#endif /* _OMAP_DSP_UACCESS_DSP_H */
diff --git a/drivers/Makefile b/drivers/Makefile
index 94b4442..b10394e 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_PARPORT)		+= parport/
 obj-y				+= base/ block/ misc/ mfd/ net/ media/ cbus/
 obj-$(CONFIG_I2C)		+= i2c/
 obj-y				+= cbus/
+obj-y				+= dsp/dspgateway/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
 obj-y				+= macintosh/
diff --git a/drivers/dsp/dspgateway/Kconfig b/drivers/dsp/dspgateway/Kconfig
new file mode 100644
index 0000000..122164a
--- /dev/null
+++ b/drivers/dsp/dspgateway/Kconfig
@@ -0,0 +1,24 @@
+
+config OMAP_DSP
+	tristate "OMAP DSP driver (DSP Gateway)"
+	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP24XX
+	select OMAP_MMU_FWK
+	select OMAP_MBOX_FWK
+	help
+	  This enables OMAP DSP driver, DSP Gateway.
+
+config OMAP_DSP_MBCMD_VERBOSE
+	bool "Mailbox Command Verbose LOG"
+	depends on OMAP_DSP
+	help
+          This enables kernel log output in the Mailbox command exchanges
+	  in the DSP Gateway driver.
+
+config OMAP_DSP_FBEXPORT
+	bool "Framebuffer export to DSP"
+	depends on OMAP_DSP && FB
+	help
+          This enables to map the frame buffer to DSP.
+	  By doing this, DSP can access the frame buffer directly without
+	  bothering ARM.
+
diff --git a/drivers/dsp/dspgateway/Makefile b/drivers/dsp/dspgateway/Makefile
new file mode 100644
index 0000000..c7d86f3
--- /dev/null
+++ b/drivers/dsp/dspgateway/Makefile
@@ -0,0 +1,15 @@
+#
+# Makefile for the OMAP DSP driver.
+#
+
+# The target object and module list name.
+
+obj-y := dsp_common.o
+
+obj-$(CONFIG_OMAP_DSP) += dsp.o
+
+# Declare multi-part drivers
+
+dsp-objs	:= dsp_core.o ipbuf.o mblog.o task.o \
+		   dsp_ctl_core.o dsp_ctl.o taskwatch.o error.o dsp_mem.o \
+		   uaccess_dsp.o
diff --git a/drivers/dsp/dspgateway/dsp.h b/drivers/dsp/dspgateway/dsp.h
new file mode 100644
index 0000000..23321be
--- /dev/null
+++ b/drivers/dsp/dspgateway/dsp.h
@@ -0,0 +1,391 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __PLAT_OMAP_DSP_DSP_H
+#define __PLAT_OMAP_DSP_DSP_H
+
+#include "hardware_dsp.h"
+#include <asm/arch/dsp_common.h>
+#include <asm/arch/mmu.h>
+
+
+#ifdef CONFIG_ARCH_OMAP2
+#include "../../../arch/arm/mach-omap2/prm.h"
+#include "../../../arch/arm/mach-omap2/prm_regbits_24xx.h"
+#include "../../../arch/arm/mach-omap2/cm.h"
+#include "../../../arch/arm/mach-omap2/cm_regbits_24xx.h"
+#endif
+
+/*
+ * MAJOR device number: !! allocated arbitrary !!
+ */
+#define OMAP_DSP_CTL_MAJOR		96
+#define OMAP_DSP_TASK_MAJOR		97
+
+#define OLD_BINARY_SUPPORT	y
+
+#ifdef OLD_BINARY_SUPPORT
+#define MBREV_3_0	0x0017
+#define MBREV_3_2	0x0018
+#endif
+
+#define DSP_INIT_PAGE	0xfff000
+
+#ifdef CONFIG_ARCH_OMAP1
+/* idle program will be placed at IDLEPG_BASE. */
+#define IDLEPG_BASE	0xfffe00
+#define IDLEPG_SIZE	0x100
+#endif /* CONFIG_ARCH_OMAP1 */
+
+/* timeout value for DSP response */
+#define DSP_TIMEOUT	(10 * HZ)
+
+enum dsp_mem_type_e {
+	MEM_TYPE_CROSSING = -1,
+	MEM_TYPE_NONE = 0,
+	MEM_TYPE_DARAM,
+	MEM_TYPE_SARAM,
+	MEM_TYPE_EXTERN,
+};
+
+
+typedef int __bitwise arm_dsp_dir_t;
+#define DIR_A2D	((__force arm_dsp_dir_t) 1)
+#define DIR_D2A	((__force arm_dsp_dir_t) 2)
+
+enum cfgstat_e {
+	CFGSTAT_CLEAN = 0,
+	CFGSTAT_READY,
+	CFGSTAT_SUSPEND,
+	CFGSTAT_RESUME,	/* request only */
+	CFGSTAT_MAX
+};
+
+enum errcode_e {
+	ERRCODE_WDT = 0,
+	ERRCODE_MMU,
+	ERRCODE_MAX
+};
+
+/* keep 2 entries for TID_FREE and TID_ANON */
+#define TASKDEV_MAX	254
+
+#define MK32(uw,lw)	(((u32)(uw)) << 16 | (lw))
+#define MKLONG(uw,lw)	(((unsigned long)(uw)) << 16 | (lw))
+#define MKVIRT(uw,lw)	dspword_to_virt(MKLONG((uw), (lw)));
+
+struct sync_seq {
+	u16 da_dsp;
+	u16 da_arm;
+	u16 ad_dsp;
+	u16 ad_arm;
+};
+
+struct mem_sync_struct {
+	struct sync_seq *DARAM;
+	struct sync_seq *SARAM;
+	struct sync_seq *SDRAM;
+};
+
+/* struct mbcmd and union mbcmd_hw must be compatible */
+struct mbcmd {
+	u32 data:16;
+	u32 cmd_l:8;
+	u32 cmd_h:7;
+	u32 seq:1;
+};
+
+#define MBCMD_INIT(h, l, d) { \
+		.cmd_h = (h), \
+		.cmd_l = (l), \
+		.data  = (d), \
+	}
+
+struct mb_exarg {
+	u8 tid;
+	int argc;
+	u16 *argv;
+};
+
+typedef u32 dsp_long_t;	/* must have ability to carry TADD_ABORTADR */
+
+extern void dsp_mbox_start(void);
+extern void dsp_mbox_stop(void);
+extern int dsp_mbox_config(void *p);
+extern int sync_with_dsp(u16 *syncwd, u16 tid, int try_cnt);
+extern int __dsp_mbcmd_send_exarg(struct mbcmd *mb, struct mb_exarg *arg,
+				  int recovery_flag);
+#define dsp_mbcmd_send(mb)		__dsp_mbcmd_send_exarg((mb), NULL, 0)
+#define dsp_mbcmd_send_exarg(mb, arg)	__dsp_mbcmd_send_exarg((mb), (arg), 0)
+extern int dsp_mbcmd_send_and_wait_exarg(struct mbcmd *mb, struct mb_exarg *arg,
+					 wait_queue_head_t *q);
+#define dsp_mbcmd_send_and_wait(mb, q) \
+	dsp_mbcmd_send_and_wait_exarg((mb), NULL, (q))
+
+static inline int __mbcompose_send_exarg(u8 cmd_h, u8 cmd_l, u16 data,
+					     struct mb_exarg *arg,
+					     int recovery_flag)
+{
+	struct mbcmd mb = MBCMD_INIT(cmd_h, cmd_l, data);
+	return __dsp_mbcmd_send_exarg(&mb, arg, recovery_flag);
+}
+#define mbcompose_send(cmd_h, cmd_l, data) \
+	__mbcompose_send_exarg(MBOX_CMD_DSP_##cmd_h, (cmd_l), (data), NULL, 0)
+#define mbcompose_send_exarg(cmd_h, cmd_l, data, arg) \
+	__mbcompose_send_exarg(MBOX_CMD_DSP_##cmd_h, (cmd_l), (data), arg, 0)
+#define mbcompose_send_recovery(cmd_h, cmd_l, data) \
+	__mbcompose_send_exarg(MBOX_CMD_DSP_##cmd_h, (cmd_l), (data), NULL, 1)
+
+static inline int __mbcompose_send_and_wait_exarg(u8 cmd_h, u8 cmd_l,
+						      u16 data,
+						      struct mb_exarg *arg,
+						      wait_queue_head_t *q)
+{
+	struct mbcmd mb = MBCMD_INIT(cmd_h, cmd_l, data);
+	return dsp_mbcmd_send_and_wait_exarg(&mb, arg, q);
+}
+#define mbcompose_send_and_wait(cmd_h, cmd_l, data, q) \
+	__mbcompose_send_and_wait_exarg(MBOX_CMD_DSP_##cmd_h, (cmd_l), (data), \
+					NULL, (q))
+#define mbcompose_send_and_wait_exarg(cmd_h, cmd_l, data, arg, q) \
+	__mbcompose_send_and_wait_exarg(MBOX_CMD_DSP_##cmd_h, (cmd_l), (data), \
+					(arg), (q))
+
+extern struct ipbuf_head *bid_to_ipbuf(u16 bid);
+extern void ipbuf_start(void);
+extern void ipbuf_stop(void);
+extern int ipbuf_config(u16 ln, u16 lsz, void *base);
+extern int ipbuf_sys_config(void *p, arm_dsp_dir_t dir);
+extern int ipbuf_p_validate(void *p, arm_dsp_dir_t dir);
+extern struct ipbuf_head *get_free_ipbuf(u8 tid);
+extern void release_ipbuf(struct ipbuf_head *ipb_h);
+extern void balance_ipbuf(void);
+extern void unuse_ipbuf(struct ipbuf_head *ipb_h);
+extern void unuse_ipbuf_nowait(struct ipbuf_head *ipb_h);
+
+#define release_ipbuf_pvt(ipbuf_pvt) \
+	do { \
+		(ipbuf_pvt)->s = TID_FREE; \
+	} while(0)
+
+extern int mbox_revision;
+
+extern int dsp_cfgstat_request(enum cfgstat_e st);
+extern enum cfgstat_e dsp_cfgstat_get_stat(void);
+extern int dsp_set_runlevel(u8 level);
+
+extern int dsp_task_config_all(u8 n);
+extern void dsp_task_unconfig_all(void);
+extern u8 dsp_task_count(void);
+extern int dsp_taskmod_busy(void);
+extern int dsp_mkdev(char *name);
+extern int dsp_rmdev(char *name);
+extern int dsp_tadd_minor(unsigned char minor, dsp_long_t adr);
+extern int dsp_tdel_minor(unsigned char minor);
+extern int dsp_tkill_minor(unsigned char minor);
+extern long taskdev_state_stale(unsigned char minor);
+extern int dsp_dbg_config(u16 *buf, u16 sz, u16 lsz);
+extern void dsp_dbg_stop(void);
+
+extern int ipbuf_is_held(u8 tid, u16 bid);
+
+extern int dsp_mem_sync_inc(void);
+extern int dsp_mem_sync_config(struct mem_sync_struct *sync);
+extern enum dsp_mem_type_e dsp_mem_type(void *vadr, size_t len);
+extern int dsp_address_validate(void *p, size_t len, char *fmt, ...);
+#ifdef CONFIG_ARCH_OMAP1
+extern void dsp_mem_usecount_clear(void);
+#endif
+extern void exmap_use(void *vadr, size_t len);
+extern void exmap_unuse(void *vadr, size_t len);
+extern unsigned long dsp_virt_to_phys(void *vadr, size_t *len);
+extern void dsp_mem_start(void);
+extern void dsp_mem_stop(void);
+
+extern void dsp_twch_start(void);
+extern void dsp_twch_stop(void);
+extern void dsp_twch_touch(void);
+
+extern void dsp_err_start(void);
+extern void dsp_err_stop(void);
+extern void dsp_err_set(enum errcode_e code, unsigned long arg);
+extern void dsp_err_clear(enum errcode_e code);
+extern int dsp_err_isset(enum errcode_e code);
+
+enum cmd_l_type_e {
+	CMD_L_TYPE_NULL,
+	CMD_L_TYPE_TID,
+	CMD_L_TYPE_SUBCMD,
+};
+
+struct cmdinfo {
+	char *name;
+	enum cmd_l_type_e cmd_l_type;
+	void (*handler)(struct mbcmd *mb);
+};
+
+extern const struct cmdinfo *cmdinfo[];
+
+#define cmd_name(mb)	(cmdinfo[(mb).cmd_h]->name)
+extern char *subcmd_name(struct mbcmd *mb);
+
+extern void mblog_add(struct mbcmd *mb, arm_dsp_dir_t dir);
+
+extern struct omap_mmu dsp_mmu;
+
+#define dsp_mem_enable(addr)	omap_mmu_mem_enable(&dsp_mmu, (addr))
+#define dsp_mem_disable(addr)	omap_mmu_mem_disable(&dsp_mmu, (addr))
+
+#define DSPSPACE_SIZE	0x1000000
+
+#define omap_set_bit_regw(b,r) \
+	do { omap_writew(omap_readw(r) | (b), (r)); } while(0)
+#define omap_clr_bit_regw(b,r) \
+	do { omap_writew(omap_readw(r) & ~(b), (r)); } while(0)
+#define omap_set_bit_regl(b,r) \
+	do { omap_writel(omap_readl(r) | (b), (r)); } while(0)
+#define omap_clr_bit_regl(b,r) \
+	do { omap_writel(omap_readl(r) & ~(b), (r)); } while(0)
+#define omap_set_bits_regl(val,mask,r) \
+	do { omap_writel((omap_readl(r) & ~(mask)) | (val), (r)); } while(0)
+
+#define dspword_to_virt(dw)	((void *)(dspmem_base + ((dw) << 1)))
+#define dspbyte_to_virt(db)	((void *)(dspmem_base + (db)))
+#define virt_to_dspword(va) \
+	((dsp_long_t)(((unsigned long)(va) - dspmem_base) >> 1))
+#define virt_to_dspbyte(va) \
+	((dsp_long_t)((unsigned long)(va) - dspmem_base))
+#define is_dsp_internal_mem(va) \
+	(((unsigned long)(va) >= dspmem_base) &&  \
+	 ((unsigned long)(va) < dspmem_base + dspmem_size))
+#define is_dspbyte_internal_mem(db)	((db) < dspmem_size)
+#define is_dspword_internal_mem(dw)	(((dw) << 1) < dspmem_size)
+
+#ifdef CONFIG_ARCH_OMAP1
+/*
+ * MPUI byteswap/wordswap on/off
+ *   default setting: wordswap = all, byteswap = APIMEM only
+ */
+#define mpui_wordswap_on() \
+	omap_set_bits_regl(MPUI_CTRL_WORDSWAP_ALL, MPUI_CTRL_WORDSWAP_MASK, \
+			   MPUI_CTRL)
+
+#define mpui_wordswap_off() \
+	omap_set_bits_regl(MPUI_CTRL_WORDSWAP_NONE, MPUI_CTRL_WORDSWAP_MASK, \
+			   MPUI_CTRL)
+
+#define mpui_byteswap_on() \
+	omap_set_bits_regl(MPUI_CTRL_BYTESWAP_API, MPUI_CTRL_BYTESWAP_MASK, \
+			   MPUI_CTRL)
+
+#define mpui_byteswap_off() \
+	omap_set_bits_regl(MPUI_CTRL_BYTESWAP_NONE, MPUI_CTRL_BYTESWAP_MASK, \
+			   MPUI_CTRL)
+
+/*
+ * TC wordswap on / off
+ */
+#define tc_wordswap() \
+	do { \
+		omap_writel(TC_ENDIANISM_SWAP_WORD | TC_ENDIANISM_EN, \
+			    TC_ENDIANISM); \
+	} while(0)
+
+#define tc_noswap()	omap_clr_bit_regl(TC_ENDIANISM_EN, TC_ENDIANISM)
+
+/*
+ * enable priority registers, EMIF, MPUI control logic
+ */
+#define __dsp_enable()	omap_set_bit_regw(ARM_RSTCT1_DSP_RST, ARM_RSTCT1)
+#define __dsp_disable()	omap_clr_bit_regw(ARM_RSTCT1_DSP_RST, ARM_RSTCT1)
+#define __dsp_run()	omap_set_bit_regw(ARM_RSTCT1_DSP_EN, ARM_RSTCT1)
+#define __dsp_reset()	omap_clr_bit_regw(ARM_RSTCT1_DSP_EN, ARM_RSTCT1)
+#endif /* CONFIG_ARCH_OMAP1 */
+
+#ifdef CONFIG_ARCH_OMAP2
+/*
+ * PRCM / IPI control logic
+ *
+ * REVISIT: these macros should probably be static inline functions
+ */
+#define __dsp_core_enable() \
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     & ~OMAP24XX_RST1_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
+#define __dsp_core_disable() \
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     | OMAP24XX_RST1_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
+#define __dsp_per_enable() \
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     & ~OMAP24XX_RST2_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
+#define __dsp_per_disable() \
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     | OMAP24XX_RST2_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
+#endif /* CONFIG_ARCH_OMAP2 */
+
+#if defined(CONFIG_ARCH_OMAP1)
+extern struct clk *dsp_ck_handle;
+extern struct clk *api_ck_handle;
+#elif defined(CONFIG_ARCH_OMAP2)
+extern struct clk *dsp_fck_handle;
+extern struct clk *dsp_ick_handle;
+#endif
+extern dsp_long_t dspmem_base, dspmem_size,
+		  daram_base, daram_size,
+		  saram_base, saram_size;
+
+enum cpustat_e {
+	CPUSTAT_RESET = 0,
+#ifdef CONFIG_ARCH_OMAP1
+	CPUSTAT_GBL_IDLE,
+	CPUSTAT_CPU_IDLE,
+#endif
+	CPUSTAT_RUN,
+	CPUSTAT_MAX
+};
+
+int dsp_set_rstvect(dsp_long_t adr);
+dsp_long_t dsp_get_rstvect(void);
+void dsp_set_idle_boot_base(dsp_long_t adr, size_t size);
+void dsp_reset_idle_boot_base(void);
+void dsp_cpustat_request(enum cpustat_e req);
+enum cpustat_e dsp_cpustat_get_stat(void);
+u16 dsp_cpustat_get_icrmask(void);
+void dsp_cpustat_set_icrmask(u16 mask);
+void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void));
+void dsp_unregister_mem_cb(void);
+
+#if defined(CONFIG_ARCH_OMAP1)
+#define command_dvfs_stop(m) (0)
+#define command_dvfs_start(m) (0)
+#elif defined(CONFIG_ARCH_OMAP2)
+#define command_dvfs_stop(m) \
+	(((m)->cmd_l == KFUNC_POWER) && ((m)->data == DVFS_STOP))
+#define command_dvfs_start(m) \
+	(((m)->cmd_l == KFUNC_POWER) && ((m)->data == DVFS_START))
+#endif
+
+extern struct omap_dsp *omap_dsp;
+
+extern int dsp_late_init(void);
+
+#endif /* __PLAT_OMAP_DSP_DSP_H */
diff --git a/drivers/dsp/dspgateway/dsp_common.c b/drivers/dsp/dspgateway/dsp_common.c
new file mode 100644
index 0000000..99be995
--- /dev/null
+++ b/drivers/dsp/dspgateway/dsp_common.c
@@ -0,0 +1,627 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/mm.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <asm/io.h>
+#include <asm/tlbflush.h>
+#include <asm/irq.h>
+#include <asm/arch/dsp_common.h>
+#include "dsp.h"
+
+#ifdef CONFIG_ARCH_OMAP1
+#include <asm/arch/tc.h>
+#endif
+
+#if defined(CONFIG_ARCH_OMAP1)
+#define dsp_boot_config(mode)	omap_writew((mode), MPUI_DSP_BOOT_CONFIG)
+#endif
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#define dsp_boot_config(mode)	writel((mode), DSP_IPI_DSPBOOTCONFIG)
+#endif
+
+struct omap_dsp *omap_dsp;
+
+#if defined(CONFIG_ARCH_OMAP1)
+struct clk *dsp_ck_handle;
+struct clk *api_ck_handle;
+#elif defined(CONFIG_ARCH_OMAP2)
+struct clk *dsp_fck_handle;
+struct clk *dsp_ick_handle;
+#endif
+dsp_long_t dspmem_base, dspmem_size,
+	   daram_base, daram_size,
+	   saram_base, saram_size;
+
+static struct cpustat {
+	struct mutex lock;
+	enum cpustat_e stat;
+	enum cpustat_e req;
+	u16 icrmask;
+#ifdef CONFIG_ARCH_OMAP1
+	struct {
+		int mpui;
+		int mem;
+		int mem_delayed;
+	} usecount;
+	int (*mem_req_cb)(void);
+	void (*mem_rel_cb)(void);
+#endif
+} cpustat = {
+	.stat = CPUSTAT_RESET,
+	.icrmask = 0xffff,
+};
+
+int dsp_set_rstvect(dsp_long_t adr)
+{
+	unsigned long *dst_adr;
+
+	if (adr >= DSPSPACE_SIZE)
+		return -EINVAL;
+
+	dst_adr = dspbyte_to_virt(DSP_BOOT_ADR_DIRECT);
+	/* word swap */
+	*dst_adr = ((adr & 0xffff) << 16) | (adr >> 16);
+	/* fill 8 bytes! */
+	*(dst_adr + 1) = 0;
+	/* direct boot */
+	dsp_boot_config(DSP_BOOT_CONFIG_DIRECT);
+
+	return 0;
+}
+
+dsp_long_t dsp_get_rstvect(void)
+{
+	unsigned long *dst_adr;
+
+	dst_adr = dspbyte_to_virt(DSP_BOOT_ADR_DIRECT);
+	return ((*dst_adr & 0xffff) << 16) | (*dst_adr >> 16);
+}
+
+#ifdef CONFIG_ARCH_OMAP1
+static void simple_load_code(unsigned char *src_c, u16 *dst, int len)
+{
+	int i;
+	u16 *src = (u16 *)src_c;
+	int len_w;
+
+	/* len must be multiple of 2. */
+	if (len & 1)
+		BUG();
+
+	len_w = len / 2;
+	for (i = 0; i < len_w; i++) {
+		/* byte swap copy */
+		*dst = ((*src & 0x00ff) << 8) |
+		       ((*src & 0xff00) >> 8);
+		src++;
+		dst++;
+	}
+}
+
+/* program size must be multiple of 2 */
+#define GBL_IDLE_TEXT_SIZE	52
+#define GBL_IDLE_TEXT_INIT { \
+	/* SAM */ \
+	0x3c, 0x4a,			/* 0x3c4a:     MOV 0x4, AR2 */ \
+	0xf4, 0x41, 0xfc, 0xff,		/* 0xf441fcff: AND 0xfcff, *AR2 */ \
+	/* disable WDT */ \
+	0x76, 0x34, 0x04, 0xb8,		/* 0x763404b8: MOV 0x3404, AR3 */ \
+	0xfb, 0x61, 0x00, 0xf5,		/* 0xfb6100f5: MOV 0x00f5, *AR3 */ \
+	0x9a,				/* 0x9a:       PORT */ \
+	0xfb, 0x61, 0x00, 0xa0,		/* 0xfb6100a0: MOV 0x00a0, *AR3 */ \
+	0x9a,				/* 0x9a:       PORT */ \
+	/* *IER0 = 0, *IER1 = 0 */ \
+	0x3c, 0x0b,			/* 0x3c0b:     MOV 0x0, AR3 */ \
+	0xe6, 0x61, 0x00,		/* 0xe66100:   MOV 0, *AR3 */ \
+	0x76, 0x00, 0x45, 0xb8,		/* 0x76004508: MOV 0x45, AR3 */ \
+	0xe6, 0x61, 0x00,		/* 0xe66100:   MOV 0, *AR3 */ \
+	/* *ICR = 0xffff */ \
+	0x3c, 0x1b,			/* 0x3c1b:     MOV 0x1, AR3 */ \
+	0xfb, 0x61, 0xff, 0xff,		/* 0xfb61ffff: MOV 0xffff, *AR3 */ \
+	0x9a,				/* 0x9a:       PORT */ \
+	/* HOM */ \
+	0xf5, 0x41, 0x03, 0x00,		/* 0xf5410300: OR 0x0300, *AR2 */ \
+	/* idle and loop forever */ \
+	0x7a, 0x00, 0x00, 0x0c,		/* 0x7a00000c: IDLE */ \
+	0x4a, 0x7a,			/* 0x4a7a:     B -6 (infinite loop) */ \
+	0x20, 0x20, 0x20,		/* 0x20:       NOP */ \
+}
+
+/* program size must be multiple of 2 */
+#define CPU_IDLE_TEXT_SIZE	48
+#define CPU_IDLE_TEXT_INIT(icrh, icrl) { \
+	/* SAM */ \
+	0x3c, 0x4b,			/* 0x3c4b:     MOV 0x4, AR3 */ \
+	0xf4, 0x61, 0xfc, 0xff,		/* 0xf461fcff: AND 0xfcff, *AR3 */ \
+	/* disable WDT */ \
+	0x76, 0x34, 0x04, 0xb8,		/* 0x763404b8: MOV 0x3404, AR3 */ \
+	0xfb, 0x61, 0x00, 0xf5,		/* 0xfb6100f5: MOV 0x00f5, *AR3 */ \
+	0x9a,				/* 0x9a:       PORT */ \
+	0xfb, 0x61, 0x00, 0xa0,		/* 0xfb6100a0: MOV 0x00a0, *AR3 */ \
+	0x9a,				/* 0x9a:       PORT */ \
+	/* *IER0 = 0, *IER1 = 0 */ \
+	0x3c, 0x0b,			/* 0x3c0b:     MOV 0x0, AR3 */ \
+	0xe6, 0x61, 0x00,		/* 0xe66100:   MOV 0, *AR3 */ \
+	0x76, 0x00, 0x45, 0xb8,		/* 0x76004508: MOV 0x45, AR3 */ \
+	0xe6, 0x61, 0x00,		/* 0xe66100:   MOV 0, *AR3 */ \
+	/* set ICR = icr */ \
+	0x3c, 0x1b,			/* 0x3c1b:     MOV AR3 0x1 */ \
+	0xfb, 0x61, (icrh), (icrl),	/* 0xfb61****: MOV *AR3, icr */ \
+	0x9a,				/* 0x9a:       PORT */ \
+	/* idle and loop forever */ \
+	0x7a, 0x00, 0x00, 0x0c,		/* 0x7a00000c: IDLE */ \
+	0x4a, 0x7a,			/* 0x4a7a:     B -6 (infinite loop) */ \
+	0x20, 0x20, 0x20		/* 0x20: nop */ \
+}
+
+/*
+ * idle_boot base:
+ * Initialized with DSP_BOOT_ADR_MPUI (=0x010000).
+ * This value is used before DSP Gateway driver is initialized.
+ * DSP Gateway driver will overwrite this value with other value,
+ * to avoid confliction with the user program.
+ */
+static dsp_long_t idle_boot_base = DSP_BOOT_ADR_MPUI;
+
+static void dsp_gbl_idle(void)
+{
+	unsigned char idle_text[GBL_IDLE_TEXT_SIZE] = GBL_IDLE_TEXT_INIT;
+
+	__dsp_reset();
+	clk_enable(api_ck_handle);
+
+#if 0
+	dsp_boot_config(DSP_BOOT_CONFIG_IDLE);
+#endif
+	simple_load_code(idle_text, dspbyte_to_virt(idle_boot_base),
+			 GBL_IDLE_TEXT_SIZE);
+	if (idle_boot_base == DSP_BOOT_ADR_MPUI)
+		dsp_boot_config(DSP_BOOT_CONFIG_MPUI);
+	else
+		dsp_set_rstvect(idle_boot_base);
+
+	__dsp_run();
+	udelay(100);	/* to make things stable */
+	clk_disable(api_ck_handle);
+}
+
+static void dsp_cpu_idle(void)
+{
+	u16 icr_tmp;
+	unsigned char icrh, icrl;
+
+	__dsp_reset();
+	clk_enable(api_ck_handle);
+
+	/*
+	 * icr settings:
+	 * DMA should not sleep for DARAM/SARAM access
+	 * DPLL should not sleep while any other domain is active
+	 */
+	icr_tmp = cpustat.icrmask & ~(DSPREG_ICR_DMA | DSPREG_ICR_DPLL);
+	icrh = icr_tmp >> 8;
+	icrl = icr_tmp & 0xff;
+	{
+		unsigned char idle_text[CPU_IDLE_TEXT_SIZE] = CPU_IDLE_TEXT_INIT(icrh, icrl);
+		simple_load_code(idle_text, dspbyte_to_virt(idle_boot_base),
+				 CPU_IDLE_TEXT_SIZE);
+	}
+	if (idle_boot_base == DSP_BOOT_ADR_MPUI)
+		dsp_boot_config(DSP_BOOT_CONFIG_MPUI);
+	else
+		dsp_set_rstvect(idle_boot_base);
+	__dsp_run();
+	udelay(100);	/* to make things stable */
+	clk_disable(api_ck_handle);
+}
+
+void dsp_set_idle_boot_base(dsp_long_t adr, size_t size)
+{
+	if (adr == idle_boot_base)
+		return;
+	idle_boot_base = adr;
+	if ((size < GBL_IDLE_TEXT_SIZE) ||
+	    (size < CPU_IDLE_TEXT_SIZE)) {
+		printk(KERN_ERR
+		       "omapdsp: size for idle program is not enough!\n");
+		BUG();
+	}
+
+	/* restart idle program with new base address */
+	if (cpustat.stat == CPUSTAT_GBL_IDLE)
+		dsp_gbl_idle();
+	if (cpustat.stat == CPUSTAT_CPU_IDLE)
+		dsp_cpu_idle();
+}
+
+void dsp_reset_idle_boot_base(void)
+{
+	idle_boot_base = DSP_BOOT_ADR_MPUI;
+}
+#else
+void dsp_reset_idle_boot_base(void) { }
+#endif /* CONFIG_ARCH_OMAP1 */
+
+static int init_done;
+
+static int omap_dsp_init(void)
+{
+	mutex_init(&cpustat.lock);
+
+	dspmem_size = 0;
+#ifdef CONFIG_ARCH_OMAP15XX
+	if (cpu_is_omap15xx()) {
+		dspmem_base = OMAP1510_DSP_BASE;
+		dspmem_size = OMAP1510_DSP_SIZE;
+		daram_base = OMAP1510_DARAM_BASE;
+		daram_size = OMAP1510_DARAM_SIZE;
+		saram_base = OMAP1510_SARAM_BASE;
+		saram_size = OMAP1510_SARAM_SIZE;
+	}
+#endif
+#ifdef CONFIG_ARCH_OMAP16XX
+	if (cpu_is_omap16xx()) {
+		dspmem_base = OMAP16XX_DSP_BASE;
+		dspmem_size = OMAP16XX_DSP_SIZE;
+		daram_base = OMAP16XX_DARAM_BASE;
+		daram_size = OMAP16XX_DARAM_SIZE;
+		saram_base = OMAP16XX_SARAM_BASE;
+		saram_size = OMAP16XX_SARAM_SIZE;
+	}
+#endif
+#ifdef CONFIG_ARCH_OMAP24XX
+	if (cpu_is_omap24xx()) {
+		dspmem_base = DSP_MEM_24XX_VIRT;
+		dspmem_size = DSP_MEM_24XX_SIZE;
+		daram_base = OMAP24XX_DARAM_BASE;
+		daram_size = OMAP24XX_DARAM_SIZE;
+		saram_base = OMAP24XX_SARAM_BASE;
+		saram_size = OMAP24XX_SARAM_SIZE;
+	}
+#endif
+#ifdef CONFIG_ARCH_OMAP34XX
+	/* To be Revisited for 3430 */
+	if (cpu_is_omap34xx()) {
+		return -ENODEV;
+	}
+#endif
+	if (dspmem_size == 0) {
+		printk(KERN_ERR "omapdsp: unsupported omap architecture.\n");
+		return -ENODEV;
+	}
+
+#if defined(CONFIG_ARCH_OMAP1)
+	dsp_ck_handle = clk_get(NULL, "dsp_ck");
+	if (IS_ERR(dsp_ck_handle)) {
+		printk(KERN_ERR "omapdsp: could not acquire dsp_ck handle.\n");
+		return PTR_ERR(dsp_ck_handle);
+	}
+
+	api_ck_handle = clk_get(NULL, "api_ck");
+	if (IS_ERR(api_ck_handle)) {
+		printk(KERN_ERR "omapdsp: could not acquire api_ck handle.\n");
+		if (dsp_ck_handle != NULL)
+			clk_put(dsp_ck_handle);
+		return PTR_ERR(api_ck_handle);
+	}
+
+	/* This is needed for McBSP init, released in late_initcall */
+	clk_enable(api_ck_handle);
+
+	__dsp_enable();
+	mpui_byteswap_off();
+	mpui_wordswap_on();
+	tc_wordswap();
+#elif defined(CONFIG_ARCH_OMAP2)
+	dsp_fck_handle = clk_get(NULL, "dsp_fck");
+	if (IS_ERR(dsp_fck_handle)) {
+		printk(KERN_ERR "omapdsp: could not acquire dsp_fck handle.\n");
+		return PTR_ERR(dsp_fck_handle);
+	}
+
+	dsp_ick_handle = clk_get(NULL, "dsp_ick");
+	if (IS_ERR(dsp_ick_handle)) {
+		printk(KERN_ERR "omapdsp: could not acquire dsp_ick handle.\n");
+		if (dsp_fck_handle != NULL)
+			clk_put(dsp_fck_handle);
+		return PTR_ERR(dsp_ick_handle);
+	}
+#endif
+
+	init_done = 1;
+	pr_info("omap_dsp_init() done\n");
+	return 0;
+}
+
+#if defined(CONFIG_ARCH_OMAP1)
+static int __dsp_late_init(void)
+{
+	clk_disable(api_ck_handle);
+	return 0;
+}
+late_initcall(__dsp_late_init);
+#endif
+
+static void dsp_cpustat_update(void)
+{
+	if (!init_done)
+		omap_dsp_init();
+
+	if (cpustat.req == CPUSTAT_RUN) {
+		if (cpustat.stat < CPUSTAT_RUN) {
+#if defined(CONFIG_ARCH_OMAP1)
+			__dsp_reset();
+			clk_enable(api_ck_handle);
+			udelay(10);
+			__dsp_run();
+#elif defined(CONFIG_ARCH_OMAP2)
+			__dsp_core_disable();
+			udelay(10);
+			__dsp_core_enable();
+#endif
+			cpustat.stat = CPUSTAT_RUN;
+		}
+		return;
+	}
+
+	/* cpustat.req < CPUSTAT_RUN */
+
+	if (cpustat.stat == CPUSTAT_RUN) {
+#ifdef CONFIG_ARCH_OMAP1
+		clk_disable(api_ck_handle);
+#endif
+	}
+
+#ifdef CONFIG_ARCH_OMAP1
+	/*
+	 * (1) when ARM wants DARAM access, MPUI should be SAM and
+	 *     DSP needs to be on.
+	 * (2) if any bits of icr is masked, we can not enter global idle.
+	 */
+	if ((cpustat.req == CPUSTAT_CPU_IDLE) ||
+	    (cpustat.usecount.mem > 0) ||
+	    (cpustat.usecount.mem_delayed > 0) ||
+	    ((cpustat.usecount.mpui > 0) && (cpustat.icrmask != 0xffff))) {
+		if (cpustat.stat != CPUSTAT_CPU_IDLE) {
+			dsp_cpu_idle();
+			cpustat.stat = CPUSTAT_CPU_IDLE;
+		}
+		return;
+	}
+
+	/*
+	 * when ARM only needs MPUI access, MPUI can be HOM and
+	 * DSP can be idling.
+	 */
+	if ((cpustat.req == CPUSTAT_GBL_IDLE) ||
+	    (cpustat.usecount.mpui > 0)) {
+		if (cpustat.stat != CPUSTAT_GBL_IDLE) {
+			dsp_gbl_idle();
+			cpustat.stat = CPUSTAT_GBL_IDLE;
+		}
+		return;
+	}
+#endif /* CONFIG_ARCH_OMAP1 */
+
+	/*
+	 * no user, no request
+	 */
+	if (cpustat.stat != CPUSTAT_RESET) {
+#if defined(CONFIG_ARCH_OMAP1)
+		__dsp_reset();
+#elif defined(CONFIG_ARCH_OMAP2)
+		__dsp_core_disable();
+#endif
+		cpustat.stat = CPUSTAT_RESET;
+	}
+}
+
+void dsp_cpustat_request(enum cpustat_e req)
+{
+	mutex_lock(&cpustat.lock);
+	cpustat.req = req;
+	dsp_cpustat_update();
+	mutex_unlock(&cpustat.lock);
+}
+
+enum cpustat_e dsp_cpustat_get_stat(void)
+{
+	return cpustat.stat;
+}
+
+u16 dsp_cpustat_get_icrmask(void)
+{
+	return cpustat.icrmask;
+}
+
+void dsp_cpustat_set_icrmask(u16 mask)
+{
+	mutex_lock(&cpustat.lock);
+	cpustat.icrmask = mask;
+	dsp_cpustat_update();
+	mutex_unlock(&cpustat.lock);
+}
+
+#ifdef CONFIG_ARCH_OMAP1
+void omap_dsp_request_mpui(void)
+{
+	mutex_lock(&cpustat.lock);
+	if (cpustat.usecount.mpui++ == 0)
+		dsp_cpustat_update();
+	mutex_unlock(&cpustat.lock);
+}
+
+void omap_dsp_release_mpui(void)
+{
+	mutex_lock(&cpustat.lock);
+	if (cpustat.usecount.mpui-- == 0) {
+		printk(KERN_ERR
+		       "omapdsp: unbalanced mpui request/release detected.\n"
+		       "         cpustat.usecount.mpui is going to be "
+		       "less than zero! ... fixed to be zero.\n");
+		cpustat.usecount.mpui = 0;
+	}
+	if (cpustat.usecount.mpui == 0)
+		dsp_cpustat_update();
+	mutex_unlock(&cpustat.lock);
+}
+
+int omap_dsp_request_mem(void)
+{
+	int ret = 0;
+
+	mutex_lock(&cpustat.lock);
+	if ((cpustat.usecount.mem++ == 0) &&
+	    (cpustat.usecount.mem_delayed == 0)) {
+		if (cpustat.mem_req_cb) {
+			if ((ret = cpustat.mem_req_cb()) < 0) {
+				cpustat.usecount.mem--;
+				goto out;
+			}
+		}
+		dsp_cpustat_update();
+	}
+out:
+	mutex_unlock(&cpustat.lock);
+
+	return ret;
+}
+
+/*
+ * release_mem will be delayed.
+ */
+static void do_release_mem(struct work_struct *dummy)
+{
+	mutex_lock(&cpustat.lock);
+	cpustat.usecount.mem_delayed = 0;
+	if (cpustat.usecount.mem == 0) {
+		dsp_cpustat_update();
+		if (cpustat.mem_rel_cb)
+			cpustat.mem_rel_cb();
+	}
+	mutex_unlock(&cpustat.lock);
+}
+
+static DECLARE_DELAYED_WORK(mem_rel_work, do_release_mem);
+
+int omap_dsp_release_mem(void)
+{
+	mutex_lock(&cpustat.lock);
+
+	/* cancel previous release work */
+	cancel_delayed_work(&mem_rel_work);
+	cpustat.usecount.mem_delayed = 0;
+
+	if (cpustat.usecount.mem-- == 0) {
+		printk(KERN_ERR
+		       "omapdsp: unbalanced memory request/release detected.\n"
+		       "         cpustat.usecount.mem is going to be "
+		       "less than zero! ... fixed to be zero.\n");
+		cpustat.usecount.mem = 0;
+	}
+	if (cpustat.usecount.mem == 0) {
+		cpustat.usecount.mem_delayed = 1;
+		schedule_delayed_work(&mem_rel_work, HZ);
+	}
+
+	mutex_unlock(&cpustat.lock);
+
+	return 0;
+}
+
+void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void))
+{
+	mutex_lock(&cpustat.lock);
+
+	cpustat.mem_req_cb = req_cb;
+	cpustat.mem_rel_cb = rel_cb;
+
+	/*
+	 * This function must be called while mem is enabled!
+	 */
+	BUG_ON(cpustat.usecount.mem == 0);
+
+	mutex_unlock(&cpustat.lock);
+}
+
+void dsp_unregister_mem_cb(void)
+{
+	mutex_lock(&cpustat.lock);
+	cpustat.mem_req_cb = NULL;
+	cpustat.mem_rel_cb = NULL;
+	mutex_unlock(&cpustat.lock);
+}
+#else
+void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void)) { }
+void dsp_unregister_mem_cb(void) { }
+#endif /* CONFIG_ARCH_OMAP1 */
+
+arch_initcall(omap_dsp_init);
+
+#ifdef CONFIG_ARCH_OMAP1
+EXPORT_SYMBOL(omap_dsp_request_mpui);
+EXPORT_SYMBOL(omap_dsp_release_mpui);
+EXPORT_SYMBOL(omap_dsp_request_mem);
+EXPORT_SYMBOL(omap_dsp_release_mem);
+#endif /* CONFIG_ARCH_OMAP1 */
+
+#ifdef CONFIG_OMAP_DSP_MODULE
+#if defined(CONFIG_ARCH_OMAP1)
+EXPORT_SYMBOL(dsp_ck_handle);
+EXPORT_SYMBOL(api_ck_handle);
+#elif defined(CONFIG_ARCH_OMAP2)
+EXPORT_SYMBOL(dsp_fck_handle);
+EXPORT_SYMBOL(dsp_ick_handle);
+#endif
+EXPORT_SYMBOL(omap_dsp);
+EXPORT_SYMBOL(dspmem_base);
+EXPORT_SYMBOL(dspmem_size);
+EXPORT_SYMBOL(daram_base);
+EXPORT_SYMBOL(daram_size);
+EXPORT_SYMBOL(saram_base);
+EXPORT_SYMBOL(saram_size);
+EXPORT_SYMBOL(dsp_set_rstvect);
+EXPORT_SYMBOL(dsp_get_rstvect);
+#ifdef CONFIG_ARCH_OMAP1
+EXPORT_SYMBOL(dsp_set_idle_boot_base);
+EXPORT_SYMBOL(dsp_reset_idle_boot_base);
+#endif /* CONFIG_ARCH_OMAP1 */
+EXPORT_SYMBOL(dsp_cpustat_request);
+EXPORT_SYMBOL(dsp_cpustat_get_stat);
+EXPORT_SYMBOL(dsp_cpustat_get_icrmask);
+EXPORT_SYMBOL(dsp_cpustat_set_icrmask);
+EXPORT_SYMBOL(dsp_register_mem_cb);
+EXPORT_SYMBOL(dsp_unregister_mem_cb);
+
+EXPORT_SYMBOL(__cpu_flush_kern_tlb_range);
+EXPORT_SYMBOL(cpu_architecture);
+EXPORT_SYMBOL(pmd_clear_bad);
+#endif
diff --git a/drivers/dsp/dspgateway/dsp_core.c b/drivers/dsp/dspgateway/dsp_core.c
new file mode 100644
index 0000000..05274be
--- /dev/null
+++ b/drivers/dsp/dspgateway/dsp_core.c
@@ -0,0 +1,663 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <asm/delay.h>
+#include <asm/arch/mailbox.h>
+#include <asm/arch/dsp.h>
+#include <asm/arch/dsp_common.h>
+#include "dsp_mbcmd.h"
+#include "dsp.h"
+#include "ipbuf.h"
+
+MODULE_AUTHOR("Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>");
+MODULE_DESCRIPTION("OMAP DSP driver module");
+MODULE_LICENSE("GPL");
+
+static struct sync_seq *mbseq;
+static u16 mbseq_expect_tmp;
+static u16 *mbseq_expect = &mbseq_expect_tmp;
+
+extern int dsp_mem_late_init(void);
+
+/*
+ * mailbox commands
+ */
+extern void mbox_wdsnd(struct mbcmd *mb);
+extern void mbox_wdreq(struct mbcmd *mb);
+extern void mbox_bksnd(struct mbcmd *mb);
+extern void mbox_bkreq(struct mbcmd *mb);
+extern void mbox_bkyld(struct mbcmd *mb);
+extern void mbox_bksndp(struct mbcmd *mb);
+extern void mbox_bkreqp(struct mbcmd *mb);
+extern void mbox_tctl(struct mbcmd *mb);
+extern void mbox_poll(struct mbcmd *mb);
+#ifdef OLD_BINARY_SUPPORT
+/* v3.3 obsolete */
+extern void mbox_wdt(struct mbcmd *mb);
+#endif
+extern void mbox_suspend(struct mbcmd *mb);
+static void mbox_kfunc(struct mbcmd *mb);
+extern void mbox_tcfg(struct mbcmd *mb);
+extern void mbox_tadd(struct mbcmd *mb);
+extern void mbox_tdel(struct mbcmd *mb);
+extern void mbox_dspcfg(struct mbcmd *mb);
+extern void mbox_regrw(struct mbcmd *mb);
+extern void mbox_getvar(struct mbcmd *mb);
+extern void mbox_err(struct mbcmd *mb);
+extern void mbox_dbg(struct mbcmd *mb);
+
+static const struct cmdinfo
+	cif_wdsnd    = { "WDSND",    CMD_L_TYPE_TID,    mbox_wdsnd   },
+	cif_wdreq    = { "WDREQ",    CMD_L_TYPE_TID,    mbox_wdreq   },
+	cif_bksnd    = { "BKSND",    CMD_L_TYPE_TID,    mbox_bksnd   },
+	cif_bkreq    = { "BKREQ",    CMD_L_TYPE_TID,    mbox_bkreq   },
+	cif_bkyld    = { "BKYLD",    CMD_L_TYPE_NULL,   mbox_bkyld   },
+	cif_bksndp   = { "BKSNDP",   CMD_L_TYPE_TID,    mbox_bksndp  },
+	cif_bkreqp   = { "BKREQP",   CMD_L_TYPE_TID,    mbox_bkreqp  },
+	cif_tctl     = { "TCTL",     CMD_L_TYPE_TID,    mbox_tctl    },
+	cif_poll     = { "POLL",     CMD_L_TYPE_NULL,   mbox_poll    },
+#ifdef OLD_BINARY_SUPPORT
+	/* v3.3 obsolete */
+	cif_wdt      = { "WDT",      CMD_L_TYPE_NULL,   mbox_wdt     },
+#endif
+	cif_runlevel = { "RUNLEVEL", CMD_L_TYPE_SUBCMD, NULL        },
+	cif_pm       = { "PM",       CMD_L_TYPE_SUBCMD, NULL        },
+	cif_suspend  = { "SUSPEND",  CMD_L_TYPE_NULL,   mbox_suspend },
+	cif_kfunc    = { "KFUNC",    CMD_L_TYPE_SUBCMD, mbox_kfunc   },
+	cif_tcfg     = { "TCFG",     CMD_L_TYPE_TID,    mbox_tcfg    },
+	cif_tadd     = { "TADD",     CMD_L_TYPE_TID,    mbox_tadd    },
+	cif_tdel     = { "TDEL",     CMD_L_TYPE_TID,    mbox_tdel    },
+	cif_tstop    = { "TSTOP",    CMD_L_TYPE_TID,    NULL        },
+	cif_dspcfg   = { "DSPCFG",   CMD_L_TYPE_SUBCMD, mbox_dspcfg  },
+	cif_regrw    = { "REGRW",    CMD_L_TYPE_SUBCMD, mbox_regrw   },
+	cif_getvar   = { "GETVAR",   CMD_L_TYPE_SUBCMD, mbox_getvar  },
+	cif_setvar   = { "SETVAR",   CMD_L_TYPE_SUBCMD, NULL        },
+	cif_err      = { "ERR",      CMD_L_TYPE_SUBCMD, mbox_err     },
+	cif_dbg      = { "DBG",      CMD_L_TYPE_NULL,   mbox_dbg     };
+
+#define MBOX_CMD_MAX	0x80
+const struct cmdinfo *cmdinfo[MBOX_CMD_MAX] = {
+	[MBOX_CMD_DSP_WDSND]    = &cif_wdsnd,
+	[MBOX_CMD_DSP_WDREQ]    = &cif_wdreq,
+	[MBOX_CMD_DSP_BKSND]    = &cif_bksnd,
+	[MBOX_CMD_DSP_BKREQ]    = &cif_bkreq,
+	[MBOX_CMD_DSP_BKYLD]    = &cif_bkyld,
+	[MBOX_CMD_DSP_BKSNDP]   = &cif_bksndp,
+	[MBOX_CMD_DSP_BKREQP]   = &cif_bkreqp,
+	[MBOX_CMD_DSP_TCTL]     = &cif_tctl,
+	[MBOX_CMD_DSP_POLL]     = &cif_poll,
+#ifdef OLD_BINARY_SUPPORT
+	[MBOX_CMD_DSP_WDT]      = &cif_wdt, /* v3.3 obsolete */
+#endif
+	[MBOX_CMD_DSP_RUNLEVEL] = &cif_runlevel,
+	[MBOX_CMD_DSP_PM]       = &cif_pm,
+	[MBOX_CMD_DSP_SUSPEND]  = &cif_suspend,
+	[MBOX_CMD_DSP_KFUNC]    = &cif_kfunc,
+	[MBOX_CMD_DSP_TCFG]     = &cif_tcfg,
+	[MBOX_CMD_DSP_TADD]     = &cif_tadd,
+	[MBOX_CMD_DSP_TDEL]     = &cif_tdel,
+	[MBOX_CMD_DSP_TSTOP]    = &cif_tstop,
+	[MBOX_CMD_DSP_DSPCFG]   = &cif_dspcfg,
+	[MBOX_CMD_DSP_REGRW]    = &cif_regrw,
+	[MBOX_CMD_DSP_GETVAR]   = &cif_getvar,
+	[MBOX_CMD_DSP_SETVAR]   = &cif_setvar,
+	[MBOX_CMD_DSP_ERR]      = &cif_err,
+	[MBOX_CMD_DSP_DBG]      = &cif_dbg,
+};
+
+#define list_for_each_entry_safe_natural(p,n,h,m) \
+			list_for_each_entry_safe(p,n,h,m)
+#define __BUILD_KFUNC(fn, dir)							\
+static int __dsp_kfunc_##fn##_devices(struct omap_dsp *dsp, int type, int stage)\
+{										\
+	struct dsp_kfunc_device *p, *tmp;					\
+	int ret, fail = 0;							\
+										\
+	list_for_each_entry_safe_##dir(p, tmp, dsp->kdev_list, entry) {		\
+		if (type && (p->type != type))					\
+			continue;						\
+		if (p->fn == NULL)						\
+			continue;						\
+		ret = p->fn(p, stage);						\
+		if (ret) {							\
+			printk(KERN_ERR "%s %s failed\n", #fn, p->name);	\
+			fail++;							\
+		}								\
+	}									\
+	return fail;								\
+}
+#define BUILD_KFUNC(fn, dir)						\
+__BUILD_KFUNC(fn, dir)							\
+static inline int dsp_kfunc_##fn##_devices(struct omap_dsp *dsp)	\
+{									\
+	return __dsp_kfunc_##fn##_devices(dsp, 0, 0);			\
+}
+#define BUILD_KFUNC_CTL(fn, dir)							\
+__BUILD_KFUNC(fn, dir)									\
+static inline int dsp_kfunc_##fn##_devices(struct omap_dsp *dsp, int type, int stage)	\
+{											\
+	return __dsp_kfunc_##fn##_devices(dsp, type, stage);				\
+}
+
+BUILD_KFUNC(probe, natural)
+BUILD_KFUNC(remove, reverse)
+BUILD_KFUNC_CTL(enable, natural)
+BUILD_KFUNC_CTL(disable, reverse)
+
+int sync_with_dsp(u16 *adr, u16 val, int try_cnt)
+{
+	int try;
+
+	if (*(volatile u16 *)adr == val)
+		return 0;
+
+	for (try = 0; try < try_cnt; try++) {
+		udelay(1);
+		if (*(volatile u16 *)adr == val) {
+			/* success! */
+			pr_info("omapdsp: sync_with_dsp(): try = %d\n", try);
+			return 0;
+		}
+	}
+
+	/* fail! */
+	return -1;
+}
+
+static int mbcmd_sender_prepare(void *data)
+{
+	struct mb_exarg *arg = data;
+	int i, ret = 0;
+	/*
+	 * even if ipbuf_sys_ad is in DSP internal memory,
+	 * dsp_mem_enable() never cause to call PM mailbox command
+	 * because in that case DSP memory should be always enabled.
+	 * (see ipbuf_sys_hold_mem_active in ipbuf.c)
+	 *
+	 * Therefore, we can call this function here safely.
+	 */
+	dsp_mem_enable(ipbuf_sys_ad);
+	if (sync_with_dsp(&ipbuf_sys_ad->s, TID_FREE, 10) < 0) {
+		printk(KERN_ERR "omapdsp: ipbuf_sys_ad is busy.\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	for (i = 0; i < arg->argc; i++) {
+		ipbuf_sys_ad->d[i] = arg->argv[i];
+	}
+	ipbuf_sys_ad->s = arg->tid;
+ out:
+	dsp_mem_disable(ipbuf_sys_ad);
+	return ret;
+}
+
+/*
+ * __dsp_mbcmd_send_exarg(): mailbox dispatcher
+ */
+int __dsp_mbcmd_send_exarg(struct mbcmd *mb, struct mb_exarg *arg,
+			   int recovery_flag)
+{
+	int ret = 0;
+
+	if (unlikely(omap_dsp->enabled == 0)) {
+		ret = dsp_kfunc_enable_devices(omap_dsp,
+					       DSP_KFUNC_DEV_TYPE_COMMON, 0);
+		if (ret == 0)
+			omap_dsp->enabled = 1;
+	}
+
+	/*
+	 * while MMU fault is set,
+	 * only recovery command can be executed
+	 */
+	if (dsp_err_isset(ERRCODE_MMU) && !recovery_flag) {
+		printk(KERN_ERR
+		       "mbox: mmu interrupt is set. %s is aborting.\n",
+		       cmd_name(*mb));
+		goto out;
+	}
+
+	ret = omap_mbox_msg_send(omap_dsp->mbox,
+				 *(mbox_msg_t *)mb, (void*)arg);
+	if (ret)
+		goto out;
+
+	if (mbseq)
+		mbseq->ad_arm++;
+
+	mblog_add(mb, DIR_A2D);
+ out:
+	return ret;
+}
+
+int dsp_mbcmd_send_and_wait_exarg(struct mbcmd *mb, struct mb_exarg *arg,
+				  wait_queue_head_t *q)
+{
+	int ret;
+
+	DEFINE_WAIT(wait);
+	prepare_to_wait(q, &wait, TASK_INTERRUPTIBLE);
+	ret = dsp_mbcmd_send_exarg(mb, arg);
+	if (ret < 0)
+		goto out;
+	schedule_timeout(DSP_TIMEOUT);
+ out:
+	finish_wait(q, &wait);
+	return ret;
+}
+
+/*
+ * mbcmd receiver
+ */
+static int mbcmd_receiver(void* msg)
+{
+	struct mbcmd *mb = (struct mbcmd *)&msg;
+
+	if (cmdinfo[mb->cmd_h] == NULL) {
+		printk(KERN_ERR
+		       "invalid message (%08x) for mbcmd_receiver().\n",
+		       (mbox_msg_t)msg);
+		return -1;
+	}
+
+	(*mbseq_expect)++;
+
+	mblog_add(mb, DIR_D2A);
+
+	/* call handler for the command */
+	if (cmdinfo[mb->cmd_h]->handler)
+		cmdinfo[mb->cmd_h]->handler(mb);
+	else
+		printk(KERN_ERR "mbox: %s is not allowed from DSP.\n",
+		       cmd_name(*mb));
+	return 0;
+}
+
+static int mbsync_hold_mem_active;
+
+void dsp_mbox_start(void)
+{
+	omap_mbox_init_seq(omap_dsp->mbox);
+	mbseq_expect_tmp = 0;
+}
+
+void dsp_mbox_stop(void)
+{
+	mbseq = NULL;
+	mbseq_expect = &mbseq_expect_tmp;
+}
+
+int dsp_mbox_config(void *p)
+{
+	unsigned long flags;
+
+	if (dsp_address_validate(p, sizeof(struct sync_seq), "mbseq") < 0)
+		return -1;
+	if (dsp_mem_type(p, sizeof(struct sync_seq)) != MEM_TYPE_EXTERN) {
+		printk(KERN_WARNING
+		       "omapdsp: mbseq is placed in DSP internal memory.\n"
+		       "         It will prevent DSP from idling.\n");
+		mbsync_hold_mem_active = 1;
+		/*
+		 * dsp_mem_enable() never fails because
+		 * it has been already enabled in dspcfg process and
+		 * this will just increment the usecount.
+		 */
+		dsp_mem_enable((void *)daram_base);
+	}
+
+	local_irq_save(flags);
+	mbseq = p;
+	mbseq->da_arm = mbseq_expect_tmp;
+	mbseq_expect = &mbseq->da_arm;
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static int __init dsp_mbox_init(void)
+{
+	omap_dsp->mbox = omap_mbox_get("dsp");
+	if (IS_ERR(omap_dsp->mbox)) {
+		printk(KERN_ERR "failed to get mailbox handler for DSP.\n");
+		return -ENODEV;
+	}
+
+	omap_dsp->mbox->rxq->callback = mbcmd_receiver;
+	omap_dsp->mbox->txq->callback = mbcmd_sender_prepare;
+
+	return 0;
+}
+
+static void dsp_mbox_exit(void)
+{
+	omap_dsp->mbox->txq->callback = NULL;
+	omap_dsp->mbox->rxq->callback = NULL;
+
+	omap_mbox_put(omap_dsp->mbox);
+
+	if (mbsync_hold_mem_active) {
+		dsp_mem_disable((void *)daram_base);
+		mbsync_hold_mem_active = 0;
+	}
+}
+
+/*
+ * kernel function dispatcher
+ */
+extern void mbox_fbctl_upd(void);
+extern void mbox_fbctl_disable(struct mbcmd *mb);
+
+static void mbox_kfunc_fbctl(struct mbcmd *mb)
+{
+	switch (mb->data) {
+	case FBCTL_UPD:
+		mbox_fbctl_upd();
+		break;
+	case FBCTL_DISABLE:
+		mbox_fbctl_disable(mb);
+		break;
+	default:
+		printk(KERN_ERR
+		       "mbox: Unknown FBCTL from DSP: 0x%04x\n", mb->data);
+	}
+}
+
+/*
+ * dspgw: KFUNC message handler
+ */
+static void mbox_kfunc_power(unsigned short data)
+{
+	int ret = -1;
+
+	switch (data) {
+	case DVFS_START: /* ACK from DSP */
+		/* TBD */
+		break;
+	case AUDIO_PWR_UP:
+		ret = dsp_kfunc_enable_devices(omap_dsp,
+					       DSP_KFUNC_DEV_TYPE_AUDIO, 0);
+		if (ret == 0)
+			ret++;
+		break;
+	case AUDIO_PWR_DOWN: /* == AUDIO_PWR_DOWN1 */
+		ret = dsp_kfunc_disable_devices(omap_dsp,
+						DSP_KFUNC_DEV_TYPE_AUDIO, 1);
+		break;
+	case AUDIO_PWR_DOWN2:
+		ret = dsp_kfunc_disable_devices(omap_dsp,
+						DSP_KFUNC_DEV_TYPE_AUDIO, 2);
+		break;
+	case DSP_PWR_DOWN:
+		ret = dsp_kfunc_disable_devices(omap_dsp,
+						DSP_KFUNC_DEV_TYPE_COMMON, 0);
+		if (ret == 0)
+			omap_dsp->enabled = 0;
+		break;
+	default:
+		printk(KERN_ERR
+		       "mailbox: Unknown PWR from DSP: 0x%04x\n", data);
+		break;
+	}
+
+	if (unlikely(ret < 0)) {
+		printk(KERN_ERR "mailbox: PWR(0x%04x) failed\n", data);
+		return;
+	}
+
+	if (likely(ret == 0))
+		return;
+
+	mbcompose_send(KFUNC, KFUNC_POWER, data);
+}
+
+static void mbox_kfunc(struct mbcmd *mb)
+{
+	switch (mb->cmd_l) {
+	case KFUNC_FBCTL:
+		mbox_kfunc_fbctl(mb);
+		break;
+	case KFUNC_POWER:
+		mbox_kfunc_power(mb->data);
+		break;
+	default:
+		printk(KERN_ERR
+		       "mbox: Unknown KFUNC from DSP: 0x%02x\n", mb->cmd_l);
+	}
+}
+
+#if defined(CONFIG_ARCH_OMAP1)
+static inline void dsp_clk_enable(void) {}
+static inline void dsp_clk_disable(void) {}
+#elif defined(CONFIG_ARCH_OMAP2)
+static inline void dsp_clk_enable(void)
+{
+	u32 r;
+
+	/*XXX should be handled in mach-omap[1,2] XXX*/
+	prm_write_mod_reg(OMAP24XX_FORCESTATE | (1 << OMAP_POWERSTATE_SHIFT),
+			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
+
+	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
+	r |= OMAP2420_AUTO_DSP_IPI;
+	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_AUTOIDLE);
+
+	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
+	r |= OMAP24XX_AUTOSTATE_DSP;
+	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
+
+	clk_enable(dsp_fck_handle);
+	clk_enable(dsp_ick_handle);
+	__dsp_per_enable();
+}
+static inline void dsp_clk_disable(void)
+{
+	__dsp_per_disable();
+	clk_disable(dsp_ick_handle);
+	clk_disable(dsp_fck_handle);
+
+	prm_write_mod_reg(OMAP24XX_FORCESTATE | (3 << OMAP_POWERSTATE_SHIFT),
+			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
+}
+#endif
+
+int dsp_late_init(void)
+{
+	int ret;
+
+	dsp_clk_enable();
+	ret = dsp_mem_late_init();
+	if (ret)
+		return ret;
+	ret = dsp_mbox_init();
+	if (ret)
+		goto fail_mbox;
+#ifdef CONFIG_ARCH_OMAP1
+	dsp_set_idle_boot_base(IDLEPG_BASE, IDLEPG_SIZE);
+#endif
+	ret = dsp_kfunc_enable_devices(omap_dsp,
+				       DSP_KFUNC_DEV_TYPE_COMMON, 0);
+	if (ret)
+		goto fail_kfunc;
+	omap_dsp->enabled = 1;
+
+	return 0;
+
+ fail_kfunc:
+	dsp_mbox_exit();
+ fail_mbox:
+	dsp_clk_disable();
+
+	return ret;
+}
+
+extern int  dsp_ctl_core_init(void);
+extern void dsp_ctl_core_exit(void);
+extern int dsp_ctl_init(void);
+extern void dsp_ctl_exit(void);
+extern int  dsp_mem_init(void);
+extern void dsp_mem_exit(void);
+extern void mblog_init(void);
+extern void mblog_exit(void);
+extern int  dsp_taskmod_init(void);
+extern void dsp_taskmod_exit(void);
+
+/*
+ * driver functions
+ */
+static int __init dsp_drv_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct omap_dsp *info;
+	struct dsp_platform_data *pdata = pdev->dev.platform_data;
+
+	dev_info(&pdev->dev, "OMAP DSP driver initialization\n");
+
+	info = kzalloc(sizeof(struct omap_dsp), GFP_KERNEL);
+	if (unlikely(info == NULL)) {
+		dev_dbg(&pdev->dev, "no memory for info\n");
+		return -ENOMEM;
+	}
+	platform_set_drvdata(pdev, info);
+	omap_dsp = info;
+
+	mutex_init(&info->lock);
+	info->dev = &pdev->dev;
+	info->kdev_list = &pdata->kdev_list;
+
+	ret = dsp_kfunc_probe_devices(info);
+	if (ret) {
+		ret = -ENXIO;
+		goto fail_kfunc;
+	}
+
+	ret = dsp_ctl_core_init();
+	if (ret)
+		goto fail_ctl_core;
+	ret = dsp_mem_init();
+	if (ret)
+		goto fail_mem;
+	ret = dsp_ctl_init();
+	if (unlikely(ret))
+		goto fail_ctl_init;
+	mblog_init();
+	ret = dsp_taskmod_init();
+	if (ret)
+		goto fail_taskmod;
+
+	return 0;
+
+ fail_taskmod:
+	mblog_exit();
+	dsp_ctl_exit();
+ fail_ctl_init:
+	dsp_mem_exit();
+ fail_mem:
+	dsp_ctl_core_exit();
+ fail_ctl_core:
+	dsp_kfunc_remove_devices(info);
+ fail_kfunc:
+	kfree(info);
+
+	return ret;
+}
+
+static int dsp_drv_remove(struct platform_device *pdev)
+{
+	struct omap_dsp *info = platform_get_drvdata(pdev);
+
+	dsp_cpustat_request(CPUSTAT_RESET);
+
+	dsp_cfgstat_request(CFGSTAT_CLEAN);
+	dsp_mbox_exit();
+	dsp_taskmod_exit();
+	mblog_exit();
+	dsp_ctl_exit();
+	dsp_mem_exit();
+
+	dsp_ctl_core_exit();
+
+#ifdef CONFIG_ARCH_OMAP2
+	__dsp_per_disable();
+	clk_disable(dsp_ick_handle);
+	clk_disable(dsp_fck_handle);
+#endif
+	dsp_kfunc_remove_devices(info);
+	kfree(info);
+
+	return 0;
+}
+
+#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP1)
+static int dsp_drv_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	dsp_cfgstat_request(CFGSTAT_SUSPEND);
+
+	return 0;
+}
+
+static int dsp_drv_resume(struct platform_device *pdev)
+{
+	dsp_cfgstat_request(CFGSTAT_RESUME);
+
+	return 0;
+}
+#else
+#define dsp_drv_suspend		NULL
+#define dsp_drv_resume		NULL
+#endif /* CONFIG_PM */
+
+static struct platform_driver dsp_driver = {
+	.probe		= dsp_drv_probe,
+	.remove		= dsp_drv_remove,
+	.suspend	= dsp_drv_suspend,
+	.resume		= dsp_drv_resume,
+	.driver		= {
+		.name	= "dsp",
+	},
+};
+
+static int __init omap_dsp_mod_init(void)
+{
+	return platform_driver_register(&dsp_driver);
+}
+
+static void __exit omap_dsp_mod_exit(void)
+{
+	platform_driver_unregister(&dsp_driver);
+}
+
+/* module dependency: need mailbox module that have mbox_dsp_info */
+extern struct omap_mbox mbox_dsp_info;
+struct omap_mbox *mbox_dep = &mbox_dsp_info;
+
+module_init(omap_dsp_mod_init);
+module_exit(omap_dsp_mod_exit);
diff --git a/drivers/dsp/dspgateway/dsp_ctl.c b/drivers/dsp/dspgateway/dsp_ctl.c
new file mode 100644
index 0000000..79c1fdf
--- /dev/null
+++ b/drivers/dsp/dspgateway/dsp_ctl.c
@@ -0,0 +1,1069 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/mutex.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/ioctls.h>
+#include <asm/arch/mailbox.h>
+#include <asm/arch/dsp.h>
+#include "hardware_dsp.h"
+#include "dsp_mbcmd.h"
+#include "dsp.h"
+#include "ipbuf.h"
+
+enum dsp_space_e {
+	SPACE_MEM,
+	SPACE_IO,
+};
+
+#ifdef CONFIG_OMAP_DSP_FBEXPORT
+static enum fbstat_e {
+	FBSTAT_DISABLED = 0,
+	FBSTAT_ENABLED,
+	FBSTAT_MAX,
+} fbstat = FBSTAT_ENABLED;
+#endif
+
+static enum cfgstat_e cfgstat;
+int mbox_revision;
+static u8 n_stask;
+
+static ssize_t ifver_show(struct device *dev, struct device_attribute *attr,
+			  char *buf);
+static ssize_t cpustat_show(struct device *dev, struct device_attribute *attr,
+			    char *buf);
+static ssize_t icrmask_show(struct device *dev, struct device_attribute *attr,
+			    char *buf);
+static ssize_t icrmask_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count);
+static ssize_t loadinfo_show(struct device *dev, struct device_attribute *attr,
+			     char *buf);
+
+#define __ATTR_RW(_name, _mode) { \
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
+	.show	= _name##_show,					\
+	.store	= _name##_store,					\
+}
+
+static struct device_attribute dev_attr_ifver     = __ATTR_RO(ifver);
+static struct device_attribute dev_attr_cpustat   = __ATTR_RO(cpustat);
+static struct device_attribute dev_attr_icrmask   = __ATTR_RW(icrmask, 0644);
+static struct device_attribute dev_attr_loadinfo  = __ATTR_RO(loadinfo);
+
+/*
+ * misc interactive mailbox command operations
+ */
+static struct misc_mb_wait_struct {
+	struct mutex lock;
+	wait_queue_head_t wait_q;
+	u8 cmd_h;
+	u8 cmd_l;
+	u16 *retvp;
+} misc_mb_wait = {
+	.lock = __MUTEX_INITIALIZER(misc_mb_wait.lock),
+	.wait_q = __WAIT_QUEUE_HEAD_INITIALIZER(misc_mb_wait.wait_q),
+};
+
+static int __misc_mbcompose_send_and_wait(u8 cmd_h, u8 cmd_l, u16 data,
+					  u16 *retvp)
+{
+	struct mbcmd mb = MBCMD_INIT(cmd_h, cmd_l, data);
+	int ret = 0;
+
+	if (mutex_lock_interruptible(&misc_mb_wait.lock))
+		return -EINTR;
+
+	misc_mb_wait.cmd_h = mb.cmd_h;
+	misc_mb_wait.cmd_l = mb.cmd_l;
+	misc_mb_wait.retvp = retvp;
+	dsp_mbcmd_send_and_wait(&mb, &misc_mb_wait.wait_q);
+
+	if (misc_mb_wait.cmd_h != 0)
+		ret = -EINVAL;
+
+	mutex_unlock(&misc_mb_wait.lock);
+	return ret;
+}
+
+#define misc_mbcompose_send_and_wait(cmd_h, cmd_l, data, retvp) \
+		__misc_mbcompose_send_and_wait(MBOX_CMD_DSP_##cmd_h, (cmd_l), \
+					       (data), (retvp));
+
+static int misc_mbcmd_response(struct mbcmd *mb, int argc, int match_cmd_l_flag)
+{
+	volatile u16 *buf;
+	int i;
+
+	/* if match_cmd_l_v flag is set, cmd_l needs to be matched as well. */
+	if (!waitqueue_active(&misc_mb_wait.wait_q) ||
+	    (misc_mb_wait.cmd_h != mb->cmd_h) ||
+	    (match_cmd_l_flag && (misc_mb_wait.cmd_l != mb->cmd_l))) {
+		const struct cmdinfo *ci = cmdinfo[mb->cmd_h];
+		char cmdstr[32];
+
+		if (ci->cmd_l_type == CMD_L_TYPE_SUBCMD)
+			sprintf(cmdstr, "%s:%s", ci->name, subcmd_name(mb));
+		else
+			strcpy(cmdstr, ci->name);
+		printk(KERN_WARNING
+		       "mbox: unexpected command %s received!\n", cmdstr);
+		return -1;
+	}
+
+	/*
+	 * if argc == 1, receive data through mbox:data register.
+	 * if argc > 1, receive through ipbuf_sys.
+	 */
+	if (argc == 1)
+		misc_mb_wait.retvp[0] = mb->data;
+	else if (argc > 1) {
+		if (dsp_mem_enable(ipbuf_sys_da) < 0) {
+			printk(KERN_ERR "mbox: %s - ipbuf_sys_da read failed!\n",
+			       cmdinfo[mb->cmd_h]->name);
+			return -1;
+		}
+		if (sync_with_dsp(&ipbuf_sys_da->s, TID_ANON, 10) < 0) {
+			printk(KERN_ERR "mbox: %s - IPBUF sync failed!\n",
+			       cmdinfo[mb->cmd_h]->name);
+			dsp_mem_disable(ipbuf_sys_da);
+			return -1;
+		}
+		/* need word access. do not use memcpy. */
+		buf = ipbuf_sys_da->d;
+		for (i = 0; i < argc; i++)
+			misc_mb_wait.retvp[i] = buf[i];
+		release_ipbuf_pvt(ipbuf_sys_da);
+		dsp_mem_disable(ipbuf_sys_da);
+	}
+
+	misc_mb_wait.cmd_h = 0;
+	wake_up_interruptible(&misc_mb_wait.wait_q);
+	return 0;
+}
+
+static int dsp_regread(enum dsp_space_e space, u16 adr, u16 *val)
+{
+	u8 cmd_l = (space == SPACE_MEM) ? REGRW_MEMR : REGRW_IOR;
+	int ret;
+
+	ret = misc_mbcompose_send_and_wait(REGRW, cmd_l, adr, val);
+	if ((ret < 0) && (ret != -EINTR))
+		printk(KERN_ERR "omapdsp: register read error!\n");
+
+	return ret;
+}
+
+static int dsp_regwrite(enum dsp_space_e space, u16 adr, u16 val)
+{
+	u8 cmd_l = (space == SPACE_MEM) ? REGRW_MEMW : REGRW_IOW;
+	struct mb_exarg arg = {
+		.tid  = TID_ANON,
+		.argc = 1,
+		.argv = &val,
+	};
+
+	mbcompose_send_exarg(REGRW, cmd_l, adr, &arg);
+	return 0;
+}
+
+static int dsp_getvar(u8 varid, u16 *val)
+{
+	int ret;
+
+	ret = misc_mbcompose_send_and_wait(GETVAR, varid, 0, val);
+	if ((ret < 0) && (ret != -EINTR))
+		printk(KERN_ERR "omapdsp: variable read error!\n");
+
+	return ret;
+}
+
+static int dsp_setvar(u8 varid, u16 val)
+{
+	mbcompose_send(SETVAR, varid, val);
+	return 0;
+}
+
+/*
+ * dsp_cfg() return value
+ *  = 0: OK
+ *  = 1: failed, but state is clear. (DSPCFG command failed)
+ *  < 0: failed. need cleanup.
+ */
+static int dsp_cfg(void)
+{
+	int ret = 0;
+
+#ifdef CONFIG_ARCH_OMAP1
+	/* for safety */
+	dsp_mem_usecount_clear();
+#endif
+
+	/*
+	 * DSPCFG command and dsp_mem_start() must be called
+	 * while internal mem is on.
+	 */
+	dsp_mem_enable((void *)dspmem_base);
+
+	dsp_mbox_start();
+	dsp_twch_start();
+	dsp_mem_start();
+	dsp_err_start();
+
+	mbox_revision = -1;
+
+	ret = misc_mbcompose_send_and_wait(DSPCFG, DSPCFG_REQ, 0, NULL);
+	if (ret < 0) {
+		if (ret != -EINTR)
+			printk(KERN_ERR "omapdsp: configuration error!\n");
+		ret = 1;
+		goto out;
+	}
+
+#if defined(CONFIG_ARCH_OMAP1) && defined(OLD_BINARY_SUPPORT)
+	/*
+	 * MBREV 3.2 or earlier doesn't assume DMA domain is on
+	 * when DSPCFG command is sent
+	 */
+	if ((mbox_revision == MBREV_3_0) ||
+	    (mbox_revision == MBREV_3_2)) {
+		if ((ret = mbcompose_send(PM, PM_ENABLE, DSPREG_ICR_DMA)) < 0)
+			goto out;
+	}
+#endif
+
+	if ((ret = dsp_task_config_all(n_stask)) < 0)
+		goto out;
+
+	/* initialization */
+#ifdef CONFIG_OMAP_DSP_FBEXPORT
+	fbstat = FBSTAT_ENABLED;
+#endif
+
+	/* send parameter */
+	ret = dsp_setvar(VARID_ICRMASK, dsp_cpustat_get_icrmask());
+	if (ret < 0)
+		goto out;
+
+	/* create runtime sysfs entries */
+	ret = device_create_file(omap_dsp->dev, &dev_attr_loadinfo);
+	if (ret)
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+ out:
+	dsp_mem_disable((void *)dspmem_base);
+	return ret;
+}
+
+static int dsp_uncfg(void)
+{
+	if (dsp_taskmod_busy()) {
+		printk(KERN_WARNING "omapdsp: tasks are busy.\n");
+		return -EBUSY;
+	}
+
+	/* FIXME: lock task module */
+
+	/* remove runtime sysfs entries */
+	device_remove_file(omap_dsp->dev, &dev_attr_loadinfo);
+
+	dsp_mbox_stop();
+	dsp_twch_stop();
+	dsp_mem_stop();
+	dsp_err_stop();
+	dsp_dbg_stop();
+	dsp_task_unconfig_all();
+	ipbuf_stop();
+
+	return 0;
+}
+
+static int dsp_suspend(void)
+{
+	int ret;
+
+	ret = misc_mbcompose_send_and_wait(SUSPEND, 0, 0, NULL);
+	if (ret < 0) {
+		if (ret != -EINVAL)
+			printk(KERN_ERR "omapdsp: DSP suspend error!\n");
+		return ret;
+	}
+
+	udelay(100);	/* wait for DSP-side execution */
+	return 0;
+}
+
+int dsp_cfgstat_request(enum cfgstat_e st_req)
+{
+	static DEFINE_MUTEX(cfgstat_lock);
+	int ret = 0, ret_override = 0;
+
+	if (mutex_lock_interruptible(&cfgstat_lock))
+		return -EINTR;
+
+again:
+	switch (st_req) {
+
+	/* cfgstat takes CLEAN, READY or SUSPEND,
+	   while st_req can take SUSPEND in addition. */
+
+	case CFGSTAT_CLEAN:
+		if (cfgstat == CFGSTAT_CLEAN)
+			goto up_out;
+		if ((ret = dsp_uncfg()) < 0)
+			goto up_out;
+		break;
+
+	case CFGSTAT_READY:
+		if (cfgstat != CFGSTAT_CLEAN) {
+			printk(KERN_ERR "omapdsp: DSP is ready already!\n");
+			ret = -EINVAL;
+			goto up_out;
+		}
+
+		ret = dsp_cfg();
+		if (ret > 0) {	/* failed, but state is clear. */
+			ret = -EINVAL;
+			goto up_out;
+		} else if (ret < 0) {	/* failed, need cleanup. */
+			st_req = CFGSTAT_CLEAN;
+			ret_override = ret;
+			goto again;
+		}
+		break;
+
+	/*
+	 * suspend / resume
+	 * DSP is not reset within this code, but done in omap_pm_suspend.
+	 * so if these functions are called from sysfs,
+	 * DSP should be reset / unreset out of these functions.
+	 */
+	case CFGSTAT_SUSPEND:
+		switch (cfgstat) {
+
+		case CFGSTAT_CLEAN:
+			if (dsp_cpustat_get_stat() == CPUSTAT_RUN) {
+				printk(KERN_WARNING
+				       "omapdsp: illegal operation -- trying "
+				       "suspend DSP while it is running but "
+				       "not configured.\n"
+				       "  Resetting DSP.\n");
+				dsp_cpustat_request(CPUSTAT_RESET);
+				ret = -EINVAL;
+			}
+			goto up_out;
+
+		case CFGSTAT_READY:
+			if ((ret = dsp_suspend()) < 0)
+				goto up_out;
+			break;
+
+		case CFGSTAT_SUSPEND:
+			goto up_out;
+
+		default:
+			BUG();
+
+		}
+
+		break;
+
+	case CFGSTAT_RESUME:
+		if (cfgstat != CFGSTAT_SUSPEND) {
+			printk(KERN_WARNING
+			       "omapdsp: DSP resume request, but DSP is not in "
+			       "suspend state.\n");
+			ret = -EINVAL;
+			goto up_out;
+		}
+		st_req = CFGSTAT_READY;
+		break;
+
+	default:
+		BUG();
+
+	}
+
+	cfgstat = st_req;
+up_out:
+	mutex_unlock(&cfgstat_lock);
+	return ret_override ? ret_override : ret;
+}
+
+enum cfgstat_e dsp_cfgstat_get_stat(void)
+{
+	return cfgstat;
+}
+
+/*
+ * polls all tasks
+ */
+static int dsp_poll(void)
+{
+	int ret;
+
+	ret = misc_mbcompose_send_and_wait(POLL, 0, 0, NULL);
+	if ((ret < 0) && (ret != -EINTR))
+		printk(KERN_ERR "omapdsp: poll error!\n");
+
+	return ret;
+}
+
+int dsp_set_runlevel(u8 level)
+{
+	if (level == RUNLEVEL_RECOVERY) {
+		if (mbcompose_send_recovery(RUNLEVEL, level, 0) < 0)
+			return -EINVAL;
+	} else {
+		if ((level < RUNLEVEL_USER) ||
+		    (level > RUNLEVEL_SUPER))
+			return -EINVAL;
+		if (mbcompose_send(RUNLEVEL, level, 0) < 0)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OMAP_DSP_FBEXPORT
+static void dsp_fbctl_enable(void)
+{
+	mbcompose_send(KFUNC, KFUNC_FBCTL, FBCTL_ENABLE);
+}
+
+static int dsp_fbctl_disable(void)
+{
+	int ret;
+
+	ret = misc_mbcompose_send_and_wait(KFUNC, KFUNC_FBCTL, FBCTL_DISABLE,
+					   NULL);
+	if ((ret < 0) && (ret != -EINTR))
+		printk(KERN_ERR "omapdsp: fb disable error!\n");
+
+	return 0;
+}
+
+static int dsp_fbstat_request(enum fbstat_e st)
+{
+	static DEFINE_MUTEX(fbstat_lock);
+	int ret = 0;
+
+	if (mutex_lock_interruptible(&fbstat_lock))
+		return -EINTR;
+
+	if (st == fbstat)
+		goto up_out;
+
+	switch (st) {
+	case FBSTAT_ENABLED:
+		dsp_fbctl_enable();
+		break;
+	case FBSTAT_DISABLED:
+		if ((ret = dsp_fbctl_disable()) < 0)
+			goto up_out;
+		break;
+	default:
+		BUG();
+	}
+
+	fbstat = st;
+up_out:
+	mutex_unlock(&fbstat_lock);
+	return 0;
+}
+#endif /* CONFIG_OMAP_DSP_FBEXPORT */
+
+/*
+ * DSP control device file operations
+ */
+static int dsp_ctl_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	/*
+	 * command level 1: commands which don't need lock
+	 */
+	case DSPCTL_IOCTL_RUN:
+		dsp_cpustat_request(CPUSTAT_RUN);
+		break;
+
+	case DSPCTL_IOCTL_RESET:
+		dsp_cpustat_request(CPUSTAT_RESET);
+		break;
+
+	case DSPCTL_IOCTL_SETRSTVECT:
+		ret = dsp_set_rstvect((dsp_long_t)arg);
+		break;
+
+#ifdef CONFIG_ARCH_OMAP1
+	case DSPCTL_IOCTL_CPU_IDLE:
+		dsp_cpustat_request(CPUSTAT_CPU_IDLE);
+		break;
+
+	case DSPCTL_IOCTL_GBL_IDLE:
+		dsp_cpustat_request(CPUSTAT_GBL_IDLE);
+		break;
+
+	case DSPCTL_IOCTL_MPUI_WORDSWAP_ON:
+		mpui_wordswap_on();
+		break;
+
+	case DSPCTL_IOCTL_MPUI_WORDSWAP_OFF:
+		mpui_wordswap_off();
+		break;
+
+	case DSPCTL_IOCTL_MPUI_BYTESWAP_ON:
+		mpui_byteswap_on();
+		break;
+
+	case DSPCTL_IOCTL_MPUI_BYTESWAP_OFF:
+		mpui_byteswap_off();
+		break;
+#endif /* CONFIG_ARCH_OMAP1 */
+
+	case DSPCTL_IOCTL_TASKCNT:
+		ret = dsp_task_count();
+		break;
+
+	case DSPCTL_IOCTL_MBSEND:
+		{
+			struct omap_dsp_mailbox_cmd u_cmd;
+			mbox_msg_t msg;
+			if (copy_from_user(&u_cmd, (void *)arg, sizeof(u_cmd)))
+				return -EFAULT;
+			msg = (u_cmd.cmd << 16) | u_cmd.data;
+			ret = dsp_mbcmd_send((struct mbcmd *)&msg);
+			break;
+		}
+
+	case DSPCTL_IOCTL_SETVAR:
+		{
+			struct omap_dsp_varinfo var;
+			if (copy_from_user(&var, (void *)arg, sizeof(var)))
+				return -EFAULT;
+			ret = dsp_setvar(var.varid, var.val[0]);
+			break;
+		}
+
+	case DSPCTL_IOCTL_RUNLEVEL:
+		ret = dsp_set_runlevel(arg);
+		break;
+
+#ifdef CONFIG_OMAP_DSP_FBEXPORT
+	case DSPCTL_IOCTL_FBEN:
+		ret = dsp_fbstat_request(FBSTAT_ENABLED);
+		break;
+#endif
+
+	/*
+	 * command level 2: commands which need lock
+	 */
+	case DSPCTL_IOCTL_DSPCFG:
+		ret = dsp_cfgstat_request(CFGSTAT_READY);
+		break;
+
+	case DSPCTL_IOCTL_DSPUNCFG:
+		ret = dsp_cfgstat_request(CFGSTAT_CLEAN);
+		break;
+
+	case DSPCTL_IOCTL_POLL:
+		ret = dsp_poll();
+		break;
+
+#ifdef CONFIG_OMAP_DSP_FBEXPORT
+	case DSPCTL_IOCTL_FBDIS:
+		ret = dsp_fbstat_request(FBSTAT_DISABLED);
+		break;
+#endif
+
+	case DSPCTL_IOCTL_SUSPEND:
+		if ((ret = dsp_cfgstat_request(CFGSTAT_SUSPEND)) < 0)
+			break;
+		dsp_cpustat_request(CPUSTAT_RESET);
+		break;
+
+	case DSPCTL_IOCTL_RESUME:
+		if ((ret = dsp_cfgstat_request(CFGSTAT_RESUME)) < 0)
+			break;
+		dsp_cpustat_request(CPUSTAT_RUN);
+		break;
+
+	case DSPCTL_IOCTL_REGMEMR:
+		{
+			struct omap_dsp_reginfo *u_reg = (void *)arg;
+			u16 adr, val;
+
+			if (copy_from_user(&adr, &u_reg->adr, sizeof(u16)))
+				return -EFAULT;
+			if ((ret = dsp_regread(SPACE_MEM, adr, &val)) < 0)
+				return ret;
+			if (copy_to_user(&u_reg->val, &val, sizeof(u16)))
+				return -EFAULT;
+			break;
+		}
+
+	case DSPCTL_IOCTL_REGMEMW:
+		{
+			struct omap_dsp_reginfo reg;
+
+			if (copy_from_user(&reg, (void *)arg, sizeof(reg)))
+				return -EFAULT;
+			ret = dsp_regwrite(SPACE_MEM, reg.adr, reg.val);
+			break;
+		}
+
+	case DSPCTL_IOCTL_REGIOR:
+		{
+			struct omap_dsp_reginfo *u_reg = (void *)arg;
+			u16 adr, val;
+
+			if (copy_from_user(&adr, &u_reg->adr, sizeof(u16)))
+				return -EFAULT;
+			if ((ret = dsp_regread(SPACE_IO, adr, &val)) < 0)
+				return ret;
+			if (copy_to_user(&u_reg->val, &val, sizeof(u16)))
+				return -EFAULT;
+			break;
+		}
+
+	case DSPCTL_IOCTL_REGIOW:
+		{
+			struct omap_dsp_reginfo reg;
+
+			if (copy_from_user(&reg, (void *)arg, sizeof(reg)))
+				return -EFAULT;
+			ret = dsp_regwrite(SPACE_IO, reg.adr, reg.val);
+			break;
+		}
+
+	case DSPCTL_IOCTL_GETVAR:
+		{
+			struct omap_dsp_varinfo *u_var = (void *)arg;
+			u8 varid;
+			u16 val[5]; /* maximum */
+			int argc;
+
+			if (copy_from_user(&varid, &u_var->varid, sizeof(u8)))
+				return -EFAULT;
+			switch (varid) {
+			case VARID_ICRMASK:
+				argc = 1;
+				break;
+			case VARID_LOADINFO:
+				argc = 5;
+				break;
+			default:
+				return -EINVAL;
+			}
+			if ((ret = dsp_getvar(varid, val)) < 0)
+				return ret;
+			if (copy_to_user(&u_var->val, val, sizeof(u16) * argc))
+				return -EFAULT;
+			break;
+		}
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return ret;
+}
+
+/*
+ * functions called from mailbox interrupt routine
+ */
+void mbox_suspend(struct mbcmd *mb)
+{
+	misc_mbcmd_response(mb, 0, 0);
+}
+
+void mbox_dspcfg(struct mbcmd *mb)
+{
+	u8 last   = mb->cmd_l & 0x80;
+	u8 cfgcmd = mb->cmd_l & 0x7f;
+	static dsp_long_t tmp_ipb_adr;
+
+	if (!waitqueue_active(&misc_mb_wait.wait_q) ||
+	    (misc_mb_wait.cmd_h != MBOX_CMD_DSP_DSPCFG)) {
+		printk(KERN_WARNING
+		       "mbox: DSPCFG command received, "
+		       "but nobody is waiting for it...\n");
+		return;
+	}
+
+	/* mailbox protocol check */
+	if (cfgcmd == DSPCFG_PROTREV) {
+		mbox_revision = mb->data;
+		if (mbox_revision == MBPROT_REVISION)
+			return;
+#ifdef OLD_BINARY_SUPPORT
+		else if ((mbox_revision == MBREV_3_0) ||
+			 (mbox_revision == MBREV_3_2)) {
+			printk(KERN_WARNING
+			       "mbox: ***** old DSP binary *****\n"
+			       "  Please update your DSP application.\n");
+			return;
+		}
+#endif
+		else {
+			printk(KERN_ERR
+			       "mbox: protocol revision check error!\n"
+			       "  expected=0x%04x, received=0x%04x\n",
+			       MBPROT_REVISION, mb->data);
+			mbox_revision = -1;
+			goto abort1;
+		}
+	}
+
+	/*
+	 * following commands are accepted only after
+	 * revision check has been passed.
+	 */
+	if (!mbox_revision < 0) {
+		pr_info("mbox: DSPCFG command received, "
+			"but revision check has not been passed.\n");
+		return;
+	}
+
+	switch (cfgcmd) {
+	case DSPCFG_SYSADRH:
+		tmp_ipb_adr = (u32)mb->data << 16;
+		break;
+
+	case DSPCFG_SYSADRL:
+		tmp_ipb_adr |= mb->data;
+		break;
+
+	case DSPCFG_ABORT:
+		goto abort1;
+
+	default:
+		printk(KERN_ERR
+		       "mbox: Unknown CFG command: cmd_l=0x%02x, data=0x%04x\n",
+		       mb->cmd_l, mb->data);
+		return;
+	}
+
+	if (last) {
+		void *badr;
+		u16 bln;
+		u16 bsz;
+		volatile u16 *buf;
+		void *ipb_sys_da, *ipb_sys_ad;
+		void *mbseq;	 /* FIXME: 3.4 obsolete */
+		short *dbg_buf;
+		u16 dbg_buf_sz, dbg_line_sz;
+		struct mem_sync_struct mem_sync, *mem_syncp;
+
+		ipb_sys_da = dspword_to_virt(tmp_ipb_adr);
+		if (ipbuf_sys_config(ipb_sys_da, DIR_D2A) < 0)
+			goto abort1;
+
+		if (dsp_mem_enable(ipbuf_sys_da) < 0) {
+			printk(KERN_ERR "mbox: DSPCFG - ipbuf_sys_da read failed!\n");
+			goto abort1;
+		}
+		if (sync_with_dsp(&ipbuf_sys_da->s, TID_ANON, 10) < 0) {
+			printk(KERN_ERR "mbox: DSPCFG - IPBUF sync failed!\n");
+			dsp_mem_disable(ipbuf_sys_da);
+			goto abort1;
+		}
+		/*
+		 * read configuration data on system IPBUF
+		 * we must read with 16bit-access
+		 */
+#ifdef OLD_BINARY_SUPPORT
+		if (mbox_revision == MBPROT_REVISION) {
+#endif
+			buf = ipbuf_sys_da->d;
+			n_stask        = buf[0];
+			bln            = buf[1];
+			bsz            = buf[2];
+			badr           = MKVIRT(buf[3], buf[4]);
+			/* ipb_sys_da     = MKVIRT(buf[5], buf[6]); */
+			ipb_sys_ad     = MKVIRT(buf[7], buf[8]);
+			mbseq          = MKVIRT(buf[9], buf[10]);
+			dbg_buf        = MKVIRT(buf[11], buf[12]);
+			dbg_buf_sz     = buf[13];
+			dbg_line_sz    = buf[14];
+			mem_sync.DARAM = MKVIRT(buf[15], buf[16]);
+			mem_sync.SARAM = MKVIRT(buf[17], buf[18]);
+			mem_sync.SDRAM = MKVIRT(buf[19], buf[20]);
+			mem_syncp = &mem_sync;
+#ifdef OLD_BINARY_SUPPORT
+		} else if (mbox_revision == MBREV_3_2) {
+			buf = ipbuf_sys_da->d;
+			n_stask     = buf[0];
+			bln         = buf[1];
+			bsz         = buf[2];
+			badr        = MKVIRT(buf[3], buf[4]);
+			/* ipb_sys_da  = MKVIRT(buf[5], buf[6]); */
+			ipb_sys_ad  = MKVIRT(buf[7], buf[8]);
+			mbseq       = MKVIRT(buf[9], buf[10]);
+			dbg_buf     = NULL;
+			dbg_buf_sz  = 0;
+			dbg_line_sz = 0;
+			mem_syncp   = NULL;
+		} else if (mbox_revision == MBREV_3_0) {
+			buf = ipbuf_sys_da->d;
+			n_stask     = buf[0];
+			bln         = buf[1];
+			bsz         = buf[2];
+			badr        = MKVIRT(buf[3], buf[4]);
+			/* bkeep       = buf[5]; */
+			/* ipb_sys_da  = MKVIRT(buf[6], buf[7]); */
+			ipb_sys_ad  = MKVIRT(buf[8], buf[9]);
+			mbseq       = MKVIRT(buf[10], buf[11]);
+			dbg_buf     = NULL;
+			dbg_buf_sz  = 0;
+			dbg_line_sz = 0;
+			mem_syncp   = NULL;
+		} else { /* should not occur */
+			dsp_mem_disable(ipbuf_sys_da);
+			goto abort1;
+		}
+#endif /* OLD_BINARY_SUPPORT */
+
+		release_ipbuf_pvt(ipbuf_sys_da);
+		dsp_mem_disable(ipbuf_sys_da);
+
+		/*
+		 * following configurations need to be done before
+		 * waking up the dspcfg initiator process.
+		 */
+		if (ipbuf_sys_config(ipb_sys_ad, DIR_A2D) < 0)
+			goto abort1;
+		if (ipbuf_config(bln, bsz, badr) < 0)
+			goto abort1;
+		if (dsp_mbox_config(mbseq) < 0)
+			goto abort2;
+		if (dsp_dbg_config(dbg_buf, dbg_buf_sz, dbg_line_sz) < 0)
+			goto abort2;
+		if (dsp_mem_sync_config(mem_syncp) < 0)
+			goto abort2;
+
+		misc_mb_wait.cmd_h = 0;
+		wake_up_interruptible(&misc_mb_wait.wait_q);
+	}
+	return;
+
+abort2:
+	ipbuf_stop();
+abort1:
+	wake_up_interruptible(&misc_mb_wait.wait_q);
+	return;
+}
+
+void mbox_poll(struct mbcmd *mb)
+{
+	misc_mbcmd_response(mb, 0, 0);
+}
+
+void mbox_regrw(struct mbcmd *mb)
+{
+	switch (mb->cmd_l) {
+	case REGRW_DATA:
+		misc_mbcmd_response(mb, 1, 0);
+		break;
+	default:
+		printk(KERN_ERR
+		       "mbox: Illegal REGRW command: "
+		       "cmd_l=0x%02x, data=0x%04x\n", mb->cmd_l, mb->data);
+		return;
+	}
+}
+
+void mbox_getvar(struct mbcmd *mb)
+{
+	switch (mb->cmd_l) {
+	case VARID_ICRMASK:
+		misc_mbcmd_response(mb, 1, 1);
+		break;
+	case VARID_LOADINFO:
+		misc_mbcmd_response(mb, 5, 1);
+		break;
+	default:
+		printk(KERN_ERR
+		       "mbox: Illegal GETVAR command: "
+		       "cmd_l=0x%02x, data=0x%04x\n", mb->cmd_l, mb->data);
+		return;
+	}
+}
+
+void mbox_fbctl_disable(struct mbcmd *mb)
+{
+	misc_mbcmd_response(mb, 0, 0);
+}
+
+struct file_operations dsp_ctl_fops = {
+	.owner   = THIS_MODULE,
+	.ioctl   = dsp_ctl_ioctl,
+};
+
+/*
+ * sysfs files
+ */
+
+/* ifver */
+static ssize_t ifver_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int len = 0;
+
+	/*
+	 * I/F VERSION descriptions:
+	 *
+	 * 3.2: sysfs / udev support
+	 *      KMEM_RESERVE / KMEM_RELEASE ioctls for mem device
+	 * 3.3: added following ioctls
+	 *      DSPCTL_IOCTL_GBL_IDLE
+	 *      DSPCTL_IOCTL_CPU_IDLE (instead of DSPCTL_IOCTL_IDLE)
+	 *      DSPCTL_IOCTL_POLL
+	 */
+
+	/*
+	 * print all supporting I/F VERSIONs, like followings.
+	 *
+	 * len += sprintf(buf, "3.2\n");
+	 * len += sprintf(buf, "3.3\n");
+	 */
+	len += sprintf(buf + len, "3.2\n");
+	len += sprintf(buf + len, "3.3\n");
+
+	return len;
+}
+
+/* cpustat */
+static char *cpustat_name[CPUSTAT_MAX] = {
+	[CPUSTAT_RESET]    = "reset",
+#ifdef CONFIG_ARCH_OMAP1
+	[CPUSTAT_GBL_IDLE] = "gbl_idle",
+	[CPUSTAT_CPU_IDLE] = "cpu_idle",
+#endif
+	[CPUSTAT_RUN]      = "run",
+};
+
+static ssize_t cpustat_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "%s\n", cpustat_name[dsp_cpustat_get_stat()]);
+}
+
+/* icrmask */
+static ssize_t icrmask_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "0x%04x\n", dsp_cpustat_get_icrmask());
+}
+
+static ssize_t icrmask_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	u16 mask;
+	int ret;
+
+	mask = simple_strtol(buf, NULL, 16);
+	dsp_cpustat_set_icrmask(mask);
+
+	if (dsp_cfgstat_get_stat() == CFGSTAT_READY) {
+		ret = dsp_setvar(VARID_ICRMASK, mask);
+		if (ret < 0)
+			return ret;
+	}
+
+	return count;
+}
+
+/* loadinfo */
+static ssize_t loadinfo_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	int len;
+	int ret;
+	u16 val[5];
+
+	if ((ret = dsp_getvar(VARID_LOADINFO, val)) < 0)
+		return ret;
+
+	/*
+	 * load info value range is 0(free) - 10000(busy):
+	 * if CPU load is not measured on DSP, it sets 0xffff at val[0].
+	 */
+
+	if (val[0] == 0xffff) {
+		len = sprintf(buf,
+			      "currently DSP load info is not available.\n");
+		goto out;
+	}
+
+	len = sprintf(buf,
+		      "DSP load info:\n"
+		      "  10ms average = %3d.%02d%%\n"
+		      "  1sec average = %3d.%02d%%  busiest 10ms = %3d.%02d%%\n"
+		      "  1min average = %3d.%02d%%  busiest 1s   = %3d.%02d%%\n",
+		      val[0]/100, val[0]%100,
+		      val[1]/100, val[1]%100, val[2]/100, val[2]%100,
+		      val[3]/100, val[3]%100, val[4]/100, val[4]%100);
+out:
+	return len;
+}
+
+int __init dsp_ctl_init(void)
+{
+	int ret;
+
+	ret = device_create_file(omap_dsp->dev, &dev_attr_ifver);
+	if (unlikely(ret))
+		return ret;
+	ret = device_create_file(omap_dsp->dev, &dev_attr_cpustat);
+	if (unlikely(ret))
+		goto fail_create_cpustat;
+	ret = device_create_file(omap_dsp->dev, &dev_attr_icrmask);
+	if (unlikely(ret))
+		goto fail_create_icrmask;
+
+	return 0;
+
+fail_create_icrmask:
+	device_remove_file(omap_dsp->dev, &dev_attr_cpustat);
+fail_create_cpustat:
+	device_remove_file(omap_dsp->dev, &dev_attr_ifver);
+
+	return ret;
+}
+
+void dsp_ctl_exit(void)
+{
+	device_remove_file(omap_dsp->dev, &dev_attr_ifver);
+	device_remove_file(omap_dsp->dev, &dev_attr_cpustat);
+	device_remove_file(omap_dsp->dev, &dev_attr_icrmask);
+}
diff --git a/drivers/dsp/dspgateway/dsp_ctl_core.c b/drivers/dsp/dspgateway/dsp_ctl_core.c
new file mode 100644
index 0000000..956ef26
--- /dev/null
+++ b/drivers/dsp/dspgateway/dsp_ctl_core.c
@@ -0,0 +1,132 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2004-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/major.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include "dsp.h"
+
+#define CTL_MINOR	0
+#define MEM_MINOR	1
+#define TWCH_MINOR	2
+#define ERR_MINOR	3
+
+static struct class *dsp_ctl_class;
+extern struct file_operations dsp_ctl_fops,
+			      dsp_mem_fops,
+			      dsp_twch_fops,
+			      dsp_err_fops;
+
+static int dsp_ctl_core_open(struct inode *inode, struct file *file)
+{
+	static DEFINE_MUTEX(open_lock);
+	int ret = 0;
+
+	if (mutex_lock_interruptible(&open_lock))
+		return -EINTR;
+	if (omap_dsp->initialized == 0) {
+		ret = dsp_late_init();
+		if (ret != 0) {
+			mutex_unlock(&open_lock);
+			return ret;
+		}
+		omap_dsp->initialized = 1;
+	}
+	mutex_unlock(&open_lock);
+
+	switch (iminor(inode)) {
+	case CTL_MINOR:
+		file->f_op = &dsp_ctl_fops;
+		break;
+	case MEM_MINOR:
+		file->f_op = &dsp_mem_fops;
+		break;
+	case TWCH_MINOR:
+		file->f_op = &dsp_twch_fops;
+		break;
+	case ERR_MINOR:
+		file->f_op = &dsp_err_fops;
+		break;
+	default:
+		return -ENXIO;
+	}
+	if (file->f_op && file->f_op->open)
+		return file->f_op->open(inode, file);
+	return 0;
+}
+
+static struct file_operations dsp_ctl_core_fops = {
+	.owner = THIS_MODULE,
+	.open  = dsp_ctl_core_open,
+};
+
+static const struct dev_list {
+	unsigned int	minor;
+	char		*devname;
+	umode_t		mode;
+} dev_list[] = {
+	{CTL_MINOR,  "dspctl",  S_IRUSR | S_IWUSR},
+	{MEM_MINOR,  "dspmem",  S_IRUSR | S_IWUSR | S_IRGRP},
+	{TWCH_MINOR, "dsptwch", S_IRUSR | S_IWUSR | S_IRGRP},
+	{ERR_MINOR,  "dsperr",  S_IRUSR | S_IRGRP},
+};
+
+int __init dsp_ctl_core_init(void)
+{
+	int retval;
+	int i;
+
+	retval = register_chrdev(OMAP_DSP_CTL_MAJOR, "dspctl",
+				 &dsp_ctl_core_fops);
+	if (retval < 0) {
+		printk(KERN_ERR
+		       "omapdsp: failed to register dspctl device: %d\n",
+		       retval);
+		return retval;
+	}
+
+	dsp_ctl_class = class_create(THIS_MODULE, "dspctl");
+	for (i = 0; i < ARRAY_SIZE(dev_list); i++) {
+		device_create(dsp_ctl_class, NULL,
+				    MKDEV(OMAP_DSP_CTL_MAJOR,
+					  dev_list[i].minor),
+				    dev_list[i].devname);
+	}
+
+	return 0;
+}
+
+void dsp_ctl_core_exit(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev_list); i++) {
+		device_destroy(dsp_ctl_class,
+				MKDEV(OMAP_DSP_CTL_MAJOR,
+					dev_list[i].minor));
+	}
+	class_destroy(dsp_ctl_class);
+
+	unregister_chrdev(OMAP_DSP_CTL_MAJOR, "dspctl");
+}
diff --git a/drivers/dsp/dspgateway/dsp_mbcmd.h b/drivers/dsp/dspgateway/dsp_mbcmd.h
new file mode 100644
index 0000000..fb35749
--- /dev/null
+++ b/drivers/dsp/dspgateway/dsp_mbcmd.h
@@ -0,0 +1,147 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __PLAT_OMAP_DSP_MBCMD_H
+#define __PLAT_OMAP_DSP_MBCMD_H
+/*
+ * mailbox command: 0x00 - 0x7f
+ * when a driver wants to use mailbox, it must reserve mailbox commands here.
+ */
+#define MBOX_CMD_DSP_WDSND	0x10
+#define MBOX_CMD_DSP_WDREQ	0x11
+#define MBOX_CMD_DSP_BKSND	0x20
+#define MBOX_CMD_DSP_BKREQ	0x21
+#define MBOX_CMD_DSP_BKYLD	0x23
+#define MBOX_CMD_DSP_BKSNDP	0x24
+#define MBOX_CMD_DSP_BKREQP	0x25
+#define MBOX_CMD_DSP_TCTL	0x30
+#define MBOX_CMD_DSP_TCTLDATA	0x31
+#define MBOX_CMD_DSP_POLL	0x32
+#define MBOX_CMD_DSP_WDT	0x50
+#define MBOX_CMD_DSP_RUNLEVEL	0x51
+#define MBOX_CMD_DSP_PM		0x52
+#define MBOX_CMD_DSP_SUSPEND	0x53
+#define MBOX_CMD_DSP_KFUNC	0x54
+#define MBOX_CMD_DSP_TCFG	0x60
+#define MBOX_CMD_DSP_TADD	0x62
+#define MBOX_CMD_DSP_TDEL	0x63
+#define MBOX_CMD_DSP_TSTOP	0x65
+#define MBOX_CMD_DSP_DSPCFG	0x70
+#define MBOX_CMD_DSP_REGRW	0x72
+#define MBOX_CMD_DSP_GETVAR	0x74
+#define MBOX_CMD_DSP_SETVAR	0x75
+#define MBOX_CMD_DSP_ERR	0x78
+#define MBOX_CMD_DSP_DBG	0x79
+
+/*
+ * DSP mailbox protocol definitions
+ */
+#define MBPROT_REVISION	0x0019
+
+#define TCTL_TINIT		0x0000
+#define TCTL_TEN		0x0001
+#define TCTL_TDIS		0x0002
+#define TCTL_TCLR		0x0003
+#define TCTL_TCLR_FORCE		0x0004
+
+#define RUNLEVEL_USER		0x01
+#define RUNLEVEL_SUPER		0x0e
+#define RUNLEVEL_RECOVERY	0x10
+
+#define PM_DISABLE		0x00
+#define PM_ENABLE		0x01
+
+#define KFUNC_FBCTL		0x00
+#define KFUNC_POWER		0x01
+
+#define FBCTL_UPD		0x0000
+#define FBCTL_ENABLE		0x0002
+#define FBCTL_DISABLE		0x0003
+
+/* KFUNC_POWER */
+#define AUDIO_PWR_UP		0x0000	/* ARM(exe/ack)	<->  DSP(req)	*/
+#define AUDIO_PWR_DOWN		0x0001	/* ARM(exe)	<-  DSP(req)	*/
+#define AUDIO_PWR_DOWN1		AUDIO_PWR_DOWN
+#define AUDIO_PWR_DOWN2		0x0002
+#define DSP_PWR_UP		0x0003	/* ARM(exe/snd)	->  DSP(exe)	*/
+#define DSP_PWR_DOWN		0x0004	/* ARM(exe)	<-  DSP(req)	*/
+#define DVFS_START		0x0006	/* ARM(req)	<-> DSP(exe/ack)*/
+#define DVFS_STOP		0x0007	/* ARM(req)	 -> DSP(exe)	*/
+
+#define TDEL_SAFE		0x0000
+#define TDEL_KILL		0x0001
+
+#define DSPCFG_REQ		0x00
+#define DSPCFG_SYSADRH		0x28
+#define DSPCFG_SYSADRL		0x29
+#define DSPCFG_PROTREV		0x70
+#define DSPCFG_ABORT		0x78
+#define DSPCFG_LAST		0x80
+
+#define REGRW_MEMR		0x00
+#define REGRW_MEMW		0x01
+#define REGRW_IOR		0x02
+#define REGRW_IOW		0x03
+#define REGRW_DATA		0x04
+
+#define VARID_ICRMASK		0x00
+#define VARID_LOADINFO		0x01
+
+#define TTYP_ARCV		0x0001
+#define TTYP_ASND		0x0002
+#define TTYP_BKMD		0x0004
+#define TTYP_BKDM		0x0008
+#define TTYP_PVMD		0x0010
+#define TTYP_PVDM		0x0020
+
+#define EID_BADTID		0x10
+#define EID_BADTCN		0x11
+#define EID_BADBID		0x20
+#define EID_BADCNT		0x21
+#define EID_NOTLOCKED		0x22
+#define EID_STVBUF		0x23
+#define EID_BADADR		0x24
+#define EID_BADTCTL		0x30
+#define EID_BADPARAM		0x50
+#define EID_FATAL		0x58
+#define EID_NOMEM		0xc0
+#define EID_NORES		0xc1
+#define EID_IPBFULL		0xc2
+#define EID_WDT			0xd0
+#define EID_TASKNOTRDY		0xe0
+#define EID_TASKBSY		0xe1
+#define EID_TASKERR		0xef
+#define EID_BADCFGTYP		0xf0
+#define EID_DEBUG		0xf8
+#define EID_BADSEQ		0xfe
+#define EID_BADCMD		0xff
+
+#define TNM_LEN			16
+
+#define TID_FREE		0xff
+#define TID_ANON		0xfe
+
+#define BID_NULL		0xffff
+#define BID_PVT			0xfffe
+
+#endif /* __PLAT_OMAP_DSP_MBCMD_H */
diff --git a/drivers/dsp/dspgateway/dsp_mem.c b/drivers/dsp/dspgateway/dsp_mem.c
new file mode 100644
index 0000000..6d3148f
--- /dev/null
+++ b/drivers/dsp/dspgateway/dsp_mem.c
@@ -0,0 +1,484 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * Conversion to mempool API and ARM MMU section mapping
+ * by Paul Mundt <paul.mundt@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/fb.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/mempool.h>
+#include <linux/clk.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/arch/tc.h>
+#include <asm/arch/omapfb.h>
+#include <asm/arch/dsp.h>
+#include <asm/arch/mailbox.h>
+#include <asm/arch/mmu.h>
+#include "dsp_mbcmd.h"
+#include "dsp.h"
+#include "ipbuf.h"
+
+#if 0
+#if defined(CONFIG_ARCH_OMAP1)
+#include "../../mach-omap1/mmu.h"
+#elif defined(CONFIG_ARCH_OMAP2)
+#include "../../mach-omap2/mmu.h"
+#endif
+#endif
+
+#include "mmu.h"
+
+static struct mem_sync_struct mem_sync;
+
+int dsp_mem_sync_inc(void)
+{
+	if (dsp_mem_enable((void *)dspmem_base) < 0)
+		return -1;
+	if (mem_sync.DARAM)
+		mem_sync.DARAM->ad_arm++;
+	if (mem_sync.SARAM)
+		mem_sync.SARAM->ad_arm++;
+	if (mem_sync.SDRAM)
+		mem_sync.SDRAM->ad_arm++;
+	dsp_mem_disable((void *)dspmem_base);
+
+	return 0;
+}
+
+/*
+ * dsp_mem_sync_config() is called from mbox1 workqueue
+ */
+int dsp_mem_sync_config(struct mem_sync_struct *sync)
+{
+	size_t sync_seq_sz = sizeof(struct sync_seq);
+
+#ifdef OLD_BINARY_SUPPORT
+	if (sync == NULL) {
+		memset(&mem_sync, 0, sizeof(struct mem_sync_struct));
+		return 0;
+	}
+#endif
+	if ((dsp_mem_type(sync->DARAM, sync_seq_sz) != MEM_TYPE_DARAM) ||
+	    (dsp_mem_type(sync->SARAM, sync_seq_sz) != MEM_TYPE_SARAM) ||
+	    (dsp_mem_type(sync->SDRAM, sync_seq_sz) != MEM_TYPE_EXTERN)) {
+		printk(KERN_ERR
+		       "omapdsp: mem_sync address validation failure!\n"
+		       "  mem_sync.DARAM = 0x%p,\n"
+		       "  mem_sync.SARAM = 0x%p,\n"
+		       "  mem_sync.SDRAM = 0x%p,\n",
+		       sync->DARAM, sync->SARAM, sync->SDRAM);
+		return -1;
+	}
+
+	memcpy(&mem_sync, sync, sizeof(struct mem_sync_struct));
+
+	return 0;
+}
+
+
+enum dsp_mem_type_e dsp_mem_type(void *vadr, size_t len)
+{
+	void *ds = (void *)daram_base;
+	void *de = (void *)daram_base + daram_size;
+	void *ss = (void *)saram_base;
+	void *se = (void *)saram_base + saram_size;
+	int ret;
+
+	if ((vadr >= ds) && (vadr < de)) {
+		if (vadr + len > de)
+			return MEM_TYPE_CROSSING;
+		else
+			return MEM_TYPE_DARAM;
+	} else if ((vadr >= ss) && (vadr < se)) {
+		if (vadr + len > se)
+			return MEM_TYPE_CROSSING;
+		else
+			return MEM_TYPE_SARAM;
+	} else {
+		down_read(&dsp_mmu.exmap_sem);
+		if (exmap_valid(&dsp_mmu, vadr, len))
+			ret = MEM_TYPE_EXTERN;
+		else
+			ret = MEM_TYPE_NONE;
+		up_read(&dsp_mmu.exmap_sem);
+		return ret;
+	}
+}
+
+int dsp_address_validate(void *p, size_t len, char *fmt, ...)
+{
+	char s[64];
+	va_list args;
+
+	if (dsp_mem_type(p, len) > 0)
+		return 0;
+
+	if (fmt == NULL)
+		goto out;
+
+	va_start(args, fmt);
+	vsprintf(s, fmt, args);
+	va_end(args);
+	printk(KERN_ERR
+	       "omapdsp: %s address(0x%p) and size(0x%x) is not valid!\n"
+	       "(crossing different type of memories, or external memory\n"
+	       "space where no actual memory is mapped)\n", s, p, len);
+ out:
+	return -1;
+}
+
+#ifdef CONFIG_OMAP_DSP_FBEXPORT
+
+static inline unsigned long lineup_offset(unsigned long adr,
+					  unsigned long ref,
+					  unsigned long mask)
+{
+	unsigned long newadr;
+
+	newadr = (adr & ~mask) | (ref & mask);
+	if (newadr < adr)
+		newadr += mask + 1;
+	return newadr;
+}
+
+/*
+ * fb update functions:
+ * fbupd_response() is executed by the workqueue.
+ * fbupd_cb() is called when fb update is done, in interrupt context.
+ * mbox_fbupd() is called when KFUNC:FBCTL:UPD is received from DSP.
+ */
+static void fbupd_response(struct work_struct *unused)
+{
+	int status;
+
+	status = mbcompose_send(KFUNC, KFUNC_FBCTL, FBCTL_UPD);
+	if (status == 0)
+		return;
+
+	/* FIXME: DSP is busy !! */
+	printk(KERN_ERR
+	       "omapdsp:"
+	       "DSP is busy when trying to send FBCTL:UPD response!\n");
+}
+
+static DECLARE_WORK(fbupd_response_work, fbupd_response);
+
+static void fbupd_cb(void *arg)
+{
+	schedule_work(&fbupd_response_work);
+}
+
+void mbox_fbctl_upd(void)
+{
+	struct omapfb_update_window win;
+	volatile unsigned short *buf = ipbuf_sys_da->d;
+
+	if (sync_with_dsp(&ipbuf_sys_da->s, TID_ANON, 5000) < 0) {
+		printk(KERN_ERR "mbox: FBCTL:UPD - IPBUF sync failed!\n");
+		return;
+	}
+	win.x = buf[0];
+	win.y = buf[1];
+	win.width = buf[2];
+	win.height = buf[3];
+	win.format = buf[4];
+	release_ipbuf_pvt(ipbuf_sys_da);
+
+#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
+	if (!omapfb_ready) {
+		printk(KERN_WARNING
+		       "omapdsp: fbupd() called while HWA742 is not ready!\n");
+		return;
+	}
+#endif
+	omapfb_update_window_async(registered_fb[0], &win, fbupd_cb, NULL);
+}
+
+#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
+static int omapfb_notifier_cb(struct notifier_block *omapfb_nb,
+			      unsigned long event, void *fbi)
+{
+	pr_info("omapfb_notifier_cb(): event = %s\n",
+		(event == OMAPFB_EVENT_READY)    ? "READY" :
+		(event == OMAPFB_EVENT_DISABLED) ? "DISABLED" : "Unknown");
+	if (event == OMAPFB_EVENT_READY)
+		omapfb_ready = 1;
+	else if (event == OMAPFB_EVENT_DISABLED)
+		omapfb_ready = 0;
+	return 0;
+}
+#endif
+
+static int dsp_fbexport(dsp_long_t *dspadr)
+{
+	dsp_long_t dspadr_actual;
+	unsigned long padr_sys, padr, fbsz_sys, fbsz;
+	int cnt;
+#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
+	int status;
+#endif
+
+	pr_debug( "omapdsp: frame buffer export\n");
+
+#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
+	if (omapfb_nb) {
+		printk(KERN_WARNING
+		       "omapdsp: frame buffer has been exported already!\n");
+		return -EBUSY;
+	}
+#endif
+
+	if (num_registered_fb == 0) {
+		pr_info("omapdsp: frame buffer not registered.\n");
+		return -EINVAL;
+	}
+	if (num_registered_fb != 1) {
+		pr_info("omapdsp: %d frame buffers found. we use first one.\n",
+			num_registered_fb);
+	}
+	padr_sys = registered_fb[0]->fix.smem_start;
+	fbsz_sys = registered_fb[0]->fix.smem_len;
+	if (fbsz_sys == 0) {
+		printk(KERN_ERR
+		       "omapdsp: framebuffer doesn't seem to be configured "
+		       "correctly! (size=0)\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * align padr and fbsz to 4kB boundary
+	 * (should be noted to the user afterwards!)
+	 */
+	padr = padr_sys & ~(SZ_4K-1);
+	fbsz = (fbsz_sys + padr_sys - padr + SZ_4K-1) & ~(SZ_4K-1);
+
+	/* line up dspadr offset with padr */
+	dspadr_actual =
+		(fbsz > SZ_1M) ?  lineup_offset(*dspadr, padr, SZ_1M-1) :
+		(fbsz > SZ_64K) ? lineup_offset(*dspadr, padr, SZ_64K-1) :
+		/* (fbsz > SZ_4KB) ? */ *dspadr;
+	if (dspadr_actual != *dspadr)
+		pr_debug(
+			"omapdsp: actual dspadr for FBEXPORT = %08x\n",
+			dspadr_actual);
+	*dspadr = dspadr_actual;
+
+	cnt = omap_mmu_exmap(&dsp_mmu, dspadr_actual, padr, fbsz,
+			     EXMAP_TYPE_FB);
+	if (cnt < 0) {
+		printk(KERN_ERR "omapdsp: exmap failure.\n");
+		return cnt;
+	}
+
+	if ((padr != padr_sys) || (fbsz != fbsz_sys)) {
+		printk(KERN_WARNING
+"  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
+"  !!  screen base address or size is not aligned in 4kB:           !!\n"
+"  !!    actual screen  adr = %08lx, size = %08lx                   !!\n"
+"  !!    exporting      adr = %08lx, size = %08lx                   !!\n"
+"  !!  Make sure that the framebuffer is allocated with 4kB-order!  !!\n"
+"  !!  Otherwise DSP can corrupt the kernel memory.                 !!\n"
+"  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n",
+		       padr_sys, fbsz_sys, padr, fbsz);
+	}
+
+	/* increase the DMA priority */
+	set_emiff_dma_prio(15);
+
+#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
+	omapfb_nb = kzalloc(sizeof(struct omapfb_notifier_block), GFP_KERNEL);
+	if (omapfb_nb == NULL) {
+		printk(KERN_ERR
+		       "omapdsp: failed to allocate memory for omapfb_nb!\n");
+		omap_mmu_exunmap(&dsp_mmu, (unsigned long)dspadr);
+		return -ENOMEM;
+	}
+
+	status = omapfb_register_client(omapfb_nb, omapfb_notifier_cb, NULL);
+	if (status)
+		pr_info("omapfb_register_client(): failure(%d)\n", status);
+#endif
+
+	return cnt;
+}
+#else
+void mbox_fbctl_upd(void) { }
+#endif
+
+/* dsp/mem fops: backward compatibility */
+static ssize_t dsp_mem_read(struct file *file, char __user *buf, size_t count,
+			    loff_t *ppos)
+{
+	struct bin_attribute attr;
+
+	return __omap_mmu_mem_read(&dsp_mmu, &attr,
+				   (char __user *)buf, *ppos, count);
+}
+
+static ssize_t dsp_mem_write(struct file *file, const char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	struct bin_attribute attr;
+
+	return __omap_mmu_mem_write(&dsp_mmu, &attr,
+				    (char __user *)buf, *ppos, count);
+}
+
+static int dsp_mem_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg)
+{
+	struct omap_dsp_mapinfo mapinfo;
+	__u32 size;
+
+	switch (cmd) {
+	case MEM_IOCTL_MMUINIT:
+		if (dsp_mmu.exmap_tbl)
+			omap_mmu_unregister(&dsp_mmu);
+		dsp_mem_ipi_init();
+		return omap_mmu_register(&dsp_mmu);
+
+	case MEM_IOCTL_EXMAP:
+		if (copy_from_user(&mapinfo, (void __user *)arg,
+				   sizeof(mapinfo)))
+			return -EFAULT;
+		return omap_mmu_exmap(&dsp_mmu, mapinfo.dspadr,
+				      0, mapinfo.size, EXMAP_TYPE_MEM);
+
+	case MEM_IOCTL_EXUNMAP:
+		return omap_mmu_exunmap(&dsp_mmu, (unsigned long)arg);
+
+	case MEM_IOCTL_EXMAP_FLUSH:
+		omap_mmu_exmap_flush(&dsp_mmu);
+		return 0;
+#ifdef CONFIG_OMAP_DSP_FBEXPORT
+	case MEM_IOCTL_FBEXPORT:
+	{
+		dsp_long_t dspadr;
+		int ret;
+		if (copy_from_user(&dspadr, (void __user *)arg,
+				   sizeof(dsp_long_t)))
+			return -EFAULT;
+		ret = dsp_fbexport(&dspadr);
+		if (copy_to_user((void __user *)arg, &dspadr,
+				 sizeof(dsp_long_t)))
+			return -EFAULT;
+		return ret;
+	}
+#endif
+	case MEM_IOCTL_MMUITACK:
+		return dsp_mmu_itack();
+
+	case MEM_IOCTL_KMEM_RESERVE:
+
+		if (copy_from_user(&size, (void __user *)arg,
+				   sizeof(__u32)))
+			return -EFAULT;
+		return omap_mmu_kmem_reserve(&dsp_mmu, size);
+
+
+	case MEM_IOCTL_KMEM_RELEASE:
+		omap_mmu_kmem_release();
+		return 0;
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+struct file_operations dsp_mem_fops = {
+	.owner   = THIS_MODULE,
+	.read	 = dsp_mem_read,
+	.write	 = dsp_mem_write,
+	.ioctl   = dsp_mem_ioctl,
+};
+
+void dsp_mem_start(void)
+{
+	dsp_register_mem_cb(intmem_enable, intmem_disable);
+}
+
+void dsp_mem_stop(void)
+{
+	memset(&mem_sync, 0, sizeof(struct mem_sync_struct));
+	dsp_unregister_mem_cb();
+}
+
+static void dsp_mmu_irq_work(struct work_struct *work)
+{
+	struct omap_mmu *mmu = container_of(work, struct omap_mmu, irq_work);
+
+	if (dsp_cfgstat_get_stat() == CFGSTAT_READY) {
+		dsp_err_set(ERRCODE_MMU, mmu->fault_address);
+		return;
+	}
+	omap_mmu_itack(mmu);
+	pr_info("Resetting DSP...\n");
+	dsp_cpustat_request(CPUSTAT_RESET);
+	omap_mmu_enable(mmu, 0);
+}
+
+/*
+ * later half of dsp memory initialization
+ */
+int dsp_mem_late_init(void)
+{
+	int ret;
+
+	dsp_mem_ipi_init();
+
+	INIT_WORK(&dsp_mmu.irq_work, dsp_mmu_irq_work);
+	ret = omap_mmu_register(&dsp_mmu);
+	if (ret) {
+		dsp_reset_idle_boot_base();
+		goto out;
+	}
+	omap_dsp->mmu = &dsp_mmu;
+ out:
+	return ret;
+}
+
+int __init dsp_mem_init(void)
+{
+#ifdef CONFIG_ARCH_OMAP2
+	dsp_mmu.clk    = dsp_fck_handle;
+	dsp_mmu.memclk = dsp_ick_handle;
+#elif defined(CONFIG_ARCH_OMAP1)
+	dsp_mmu.clk    = dsp_ck_handle;
+	dsp_mmu.memclk = api_ck_handle;
+#endif
+	return 0;
+}
+
+void dsp_mem_exit(void)
+{
+	dsp_reset_idle_boot_base();
+	omap_mmu_unregister(&dsp_mmu);
+}
diff --git a/drivers/dsp/dspgateway/error.c b/drivers/dsp/dspgateway/error.c
new file mode 100644
index 0000000..d2276f9
--- /dev/null
+++ b/drivers/dsp/dspgateway/error.c
@@ -0,0 +1,227 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <asm/arch/mailbox.h>
+#include <asm/uaccess.h>
+#include "dsp_mbcmd.h"
+#include "dsp.h"
+
+/*
+ * value seen through read()
+ */
+#define DSP_ERR_WDT	0x00000001
+#define DSP_ERR_MMU	0x00000002
+static unsigned long errval;
+
+static DECLARE_WAIT_QUEUE_HEAD(err_wait_q);
+static int errcnt;
+static u16 wdtval;	/* FIXME: read through ioctl */
+static u32 mmu_fadr;	/* FIXME: read through ioctl */
+
+/*
+ * DSP error detection device file operations
+ */
+static ssize_t dsp_err_read(struct file *file, char __user *buf, size_t count,
+			    loff_t *ppos)
+{
+	unsigned long flags;
+	int status;
+	DEFINE_WAIT(wait);
+
+	if (count < 4)
+		return 0;
+
+	prepare_to_wait(&err_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (errcnt == 0)
+		schedule();
+	finish_wait(&err_wait_q, &wait);
+	if (signal_pending(current))
+		return -EINTR;
+
+	local_irq_save(flags);
+	status = copy_to_user(buf, &errval, 4);
+	if (status) {
+		local_irq_restore(flags);
+		return -EFAULT;
+	}
+	errcnt = 0;
+	local_irq_restore(flags);
+
+	return 4;
+}
+
+static unsigned int dsp_err_poll(struct file *file, poll_table *wait)
+{
+	unsigned int mask = 0;
+
+	poll_wait(file, &err_wait_q, wait);
+	if (errcnt != 0)
+		mask |= POLLIN | POLLRDNORM;
+
+	return mask;
+}
+
+struct file_operations dsp_err_fops = {
+	.owner = THIS_MODULE,
+	.poll  = dsp_err_poll,
+	.read  = dsp_err_read,
+};
+
+/*
+ * set / clear functions
+ */
+
+/* DSP MMU */
+static void dsp_err_mmu_set(unsigned long arg)
+{
+	disable_irq(omap_dsp->mmu->irq);
+	mmu_fadr = (u32)arg;
+}
+
+static void dsp_err_mmu_clr(void)
+{
+	enable_irq(omap_dsp->mmu->irq);
+}
+
+/* WDT */
+static void dsp_err_wdt_set(unsigned long arg)
+{
+	wdtval = (u16)arg;
+}
+
+/*
+ * error code handler
+ */
+static struct {
+	unsigned long val;
+	void (*set)(unsigned long arg);
+	void (*clr)(void);
+} dsp_err_desc[ERRCODE_MAX] = {
+	[ERRCODE_MMU] = { DSP_ERR_MMU, dsp_err_mmu_set, dsp_err_mmu_clr },
+	[ERRCODE_WDT] = { DSP_ERR_WDT, dsp_err_wdt_set, NULL },
+};
+
+void dsp_err_set(enum errcode_e code, unsigned long arg)
+{
+	if (dsp_err_desc[code].set != NULL)
+		dsp_err_desc[code].set(arg);
+
+	errval |= dsp_err_desc[code].val;
+	errcnt++;
+	wake_up_interruptible(&err_wait_q);
+}
+
+void dsp_err_clear(enum errcode_e code)
+{
+	errval &= ~dsp_err_desc[code].val;
+
+	if (dsp_err_desc[code].clr != NULL)
+		dsp_err_desc[code].clr();
+}
+
+int dsp_err_isset(enum errcode_e code)
+{
+	return (errval & dsp_err_desc[code].val) ? 1 : 0;
+}
+
+void dsp_err_notify(void)
+{
+	/* new error code should be assigned */
+	dsp_err_set(DSP_ERR_WDT, 0);
+}
+
+/*
+ * functions called from mailbox interrupt routine
+ */
+static void mbox_err_wdt(u16 data)
+{
+	dsp_err_set(DSP_ERR_WDT, (unsigned long)data);
+}
+
+#ifdef OLD_BINARY_SUPPORT
+/* v3.3 obsolete */
+void mbox_wdt(struct mbcmd *mb)
+{
+	mbox_err_wdt(mb->data);
+}
+#endif
+
+extern void mbox_err_ipbfull(void);
+extern void mbox_err_fatal(u8 tid);
+
+void mbox_err(struct mbcmd *mb)
+{
+	u8 eid = mb->cmd_l;
+	char *eidnm = subcmd_name(mb);
+	u8 tid;
+
+	if (eidnm) {
+		printk(KERN_WARNING
+		       "mbox: ERR from DSP (%s): 0x%04x\n", eidnm, mb->data);
+	} else {
+		printk(KERN_WARNING
+		       "mbox: ERR from DSP (unknown EID=%02x): %04x\n",
+		       eid, mb->data);
+	}
+
+	switch (eid) {
+	case EID_IPBFULL:
+		mbox_err_ipbfull();
+		break;
+
+	case EID_FATAL:
+		tid = mb->data & 0x00ff;
+		mbox_err_fatal(tid);
+		break;
+
+	case EID_WDT:
+		mbox_err_wdt(mb->data);
+		break;
+	}
+}
+
+/*
+ *
+ */
+void dsp_err_start(void)
+{
+	enum errcode_e i;
+
+	for (i = 0; i < ERRCODE_MAX; i++) {
+		if (dsp_err_isset(i))
+			dsp_err_clear(i);
+	}
+	omap_dsp->mbox->err_notify = dsp_err_notify;
+	errcnt = 0;
+}
+
+void dsp_err_stop(void)
+{
+	wake_up_interruptible(&err_wait_q);
+	omap_dsp->mbox->err_notify = NULL;
+}
diff --git a/drivers/dsp/dspgateway/hardware_dsp.h b/drivers/dsp/dspgateway/hardware_dsp.h
new file mode 100644
index 0000000..5af46f8
--- /dev/null
+++ b/drivers/dsp/dspgateway/hardware_dsp.h
@@ -0,0 +1,34 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __OMAP_DSP_HARDWARE_DSP_H
+#define __OMAP_DSP_HARDWARE_DSP_H
+
+#ifdef CONFIG_ARCH_OMAP1
+#include "omap1_dsp.h"
+#endif
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3430)
+#include "omap2_dsp.h"
+#endif
+
+#endif /* __OMAP_DSP_HARDWARE_DSP_H */
diff --git a/drivers/dsp/dspgateway/ipbuf.c b/drivers/dsp/dspgateway/ipbuf.c
new file mode 100644
index 0000000..aba8e74
--- /dev/null
+++ b/drivers/dsp/dspgateway/ipbuf.c
@@ -0,0 +1,353 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/sched.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <asm/arch/mailbox.h>
+#include "dsp_mbcmd.h"
+#include "dsp.h"
+#include "ipbuf.h"
+
+static struct ipbuf_head *g_ipbuf;
+struct ipbcfg ipbcfg;
+struct ipbuf_sys *ipbuf_sys_da, *ipbuf_sys_ad;
+static struct ipblink ipb_free = IPBLINK_INIT;
+static int ipbuf_sys_hold_mem_active;
+
+static ssize_t ipbuf_show(struct device *dev, struct device_attribute *attr,
+			  char *buf);
+static struct device_attribute dev_attr_ipbuf = __ATTR_RO(ipbuf);
+
+void ipbuf_stop(void)
+{
+	int i;
+
+	device_remove_file(omap_dsp->dev, &dev_attr_ipbuf);
+
+	spin_lock(&ipb_free.lock);
+	RESET_IPBLINK(&ipb_free);
+	spin_unlock(&ipb_free.lock);
+
+	ipbcfg.ln = 0;
+	if (g_ipbuf) {
+		kfree(g_ipbuf);
+		g_ipbuf = NULL;
+	}
+	for (i = 0; i < ipbuf_sys_hold_mem_active; i++) {
+		dsp_mem_disable((void *)daram_base);
+	}
+	ipbuf_sys_hold_mem_active = 0;
+}
+
+int ipbuf_config(u16 ln, u16 lsz, void *base)
+{
+	size_t lsz_byte = ((size_t)lsz) << 1;
+	size_t size;
+	int ret = 0;
+	int i;
+
+	/*
+	 * global IPBUF
+	 */
+	if (((unsigned long)base) & 0x3) {
+		printk(KERN_ERR
+		       "omapdsp: global ipbuf address(0x%p) is not "
+		       "32-bit aligned!\n", base);
+		return -EINVAL;
+	}
+	size = lsz_byte * ln;
+	if (dsp_address_validate(base, size, "global ipbuf") < 0)
+		return -EINVAL;
+
+	g_ipbuf = kmalloc(sizeof(struct ipbuf_head) * ln, GFP_KERNEL);
+	if (g_ipbuf == NULL) {
+		printk(KERN_ERR
+		       "omapdsp: memory allocation for ipbuf failed.\n");
+		return -ENOMEM;
+	}
+	for (i = 0; i < ln; i++) {
+		void *top, *btm;
+
+		top = base + (sizeof(struct ipbuf) + lsz_byte) * i;
+		btm = base + (sizeof(struct ipbuf) + lsz_byte) * (i+1) - 1;
+		g_ipbuf[i].p = (struct ipbuf *)top;
+		g_ipbuf[i].bid = i;
+		if (((unsigned long)top & 0xfffe0000) !=
+		    ((unsigned long)btm & 0xfffe0000)) {
+			/*
+			 * an ipbuf line should not cross
+			 * 64k-word boundary.
+			 */
+			printk(KERN_ERR
+			       "omapdsp: ipbuf[%d] crosses 64k-word boundary!\n"
+			       "  @0x%p, size=0x%08x\n", i, top, lsz_byte);
+			ret = -EINVAL;
+			goto free_out;
+		}
+	}
+	ipbcfg.ln       = ln;
+	ipbcfg.lsz      = lsz;
+	ipbcfg.base     = base;
+	ipbcfg.bsycnt   = ln;	/* DSP holds all ipbufs initially. */
+	ipbcfg.cnt_full = 0;
+
+	pr_info("omapdsp: IPBUF configuration\n"
+		"           %d words * %d lines at 0x%p.\n",
+		ipbcfg.lsz, ipbcfg.ln, ipbcfg.base);
+
+	ret = device_create_file(omap_dsp->dev, &dev_attr_ipbuf);
+	if (ret)
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+
+	return ret;
+
+ free_out:
+	kfree(g_ipbuf);
+	g_ipbuf = NULL;
+	return ret;
+}
+
+int ipbuf_sys_config(void *p, arm_dsp_dir_t dir)
+{
+	char *dir_str = (dir == DIR_D2A) ? "D2A" : "A2D";
+
+	if (((unsigned long)p) & 0x3) {
+		printk(KERN_ERR
+		       "omapdsp: system ipbuf(%s) address(0x%p) is "
+		       "not 32-bit aligned!\n", dir_str, p);
+		return -1;
+	}
+	if (dsp_address_validate(p, sizeof(struct ipbuf_sys),
+				 "system ipbuf(%s)", dir_str) < 0)
+		return -1;
+	if (dsp_mem_type(p, sizeof(struct ipbuf_sys)) != MEM_TYPE_EXTERN) {
+		printk(KERN_WARNING
+		       "omapdsp: system ipbuf(%s) is placed in"
+		       " DSP internal memory.\n"
+		       "         It will prevent DSP from idling.\n", dir_str);
+		ipbuf_sys_hold_mem_active++;
+		/*
+		 * dsp_mem_enable() never fails because
+		 * it has been already enabled in dspcfg process and
+		 * this will just increment the usecount.
+		 */
+		dsp_mem_enable((void *)daram_base);
+	}
+
+	if (dir == DIR_D2A)
+		ipbuf_sys_da = p;
+	else
+		ipbuf_sys_ad = p;
+
+	return 0;
+}
+
+int ipbuf_p_validate(void *p, arm_dsp_dir_t dir)
+{
+	char *dir_str = (dir == DIR_D2A) ? "D2A" : "A2D";
+
+	if (((unsigned long)p) & 0x3) {
+		printk(KERN_ERR
+		       "omapdsp: private ipbuf(%s) address(0x%p) is "
+		       "not 32-bit aligned!\n", dir_str, p);
+		return -1;
+	}
+	return dsp_address_validate(p, sizeof(struct ipbuf_p),
+				    "private ipbuf(%s)", dir_str);
+}
+
+/*
+ * Global IPBUF operations
+ */
+struct ipbuf_head *bid_to_ipbuf(u16 bid)
+{
+	return &g_ipbuf[bid];
+}
+
+struct ipbuf_head *get_free_ipbuf(u8 tid)
+{
+	struct ipbuf_head *ipb_h;
+
+	if (dsp_mem_enable_ipbuf() < 0)
+		return NULL;
+
+	spin_lock(&ipb_free.lock);
+
+	if (ipblink_empty(&ipb_free)) {
+		/* FIXME: wait on queue when not available.  */
+		ipb_h = NULL;
+		goto out;
+	}
+	ipb_h = &g_ipbuf[ipb_free.top];
+	ipb_h->p->la = tid;	/* lock */
+	__ipblink_del_top(&ipb_free);
+out:
+	spin_unlock(&ipb_free.lock);
+	dsp_mem_disable_ipbuf();
+
+	return ipb_h;
+}
+
+void release_ipbuf(struct ipbuf_head *ipb_h)
+{
+	if (ipb_h->p->la == TID_FREE) {
+		printk(KERN_WARNING
+		       "omapdsp: attempt to release unlocked IPBUF[%d].\n",
+		       ipb_h->bid);
+		/*
+		 * FIXME: re-calc bsycnt
+		 */
+		return;
+	}
+	ipb_h->p->la = TID_FREE;
+	ipb_h->p->sa = TID_FREE;
+	ipblink_add_tail(&ipb_free, ipb_h->bid);
+}
+
+static int try_yld(struct ipbuf_head *ipb_h)
+{
+	int status;
+
+	ipb_h->p->sa = TID_ANON;
+	status = mbcompose_send(BKYLD, 0, ipb_h->bid);
+	if (status < 0) {
+		/* DSP is busy and ARM keeps this line. */
+		release_ipbuf(ipb_h);
+		return status;
+	}
+
+	ipb_bsycnt_inc(&ipbcfg);
+	return 0;
+}
+
+/*
+ * balancing ipbuf lines with DSP
+ */
+static void do_balance_ipbuf(struct work_struct *unused)
+{
+	while (ipbcfg.bsycnt <= ipbcfg.ln / 4) {
+		struct ipbuf_head *ipb_h;
+
+		if ((ipb_h = get_free_ipbuf(TID_ANON)) == NULL)
+			return;
+		if (try_yld(ipb_h) < 0)
+			return;
+	}
+}
+
+static DECLARE_WORK(balance_ipbuf_work, do_balance_ipbuf);
+
+void balance_ipbuf(void)
+{
+	schedule_work(&balance_ipbuf_work);
+}
+
+/* for process context */
+void unuse_ipbuf(struct ipbuf_head *ipb_h)
+{
+	if (ipbcfg.bsycnt > ipbcfg.ln / 4) {
+		/* we don't have enough IPBUF lines. let's keep it. */
+		release_ipbuf(ipb_h);
+	} else {
+		/* we have enough IPBUF lines. let's return this line to DSP. */
+		ipb_h->p->la = TID_ANON;
+		try_yld(ipb_h);
+		balance_ipbuf();
+	}
+}
+
+/* for interrupt context */
+void unuse_ipbuf_nowait(struct ipbuf_head *ipb_h)
+{
+	release_ipbuf(ipb_h);
+	balance_ipbuf();
+}
+
+/*
+ * functions called from mailbox interrupt routine
+ */
+
+void mbox_err_ipbfull(void)
+{
+	ipbcfg.cnt_full++;
+}
+
+/*
+ * sysfs files
+ */
+static ssize_t ipbuf_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int len = 0;
+	u16 bid;
+
+	for (bid = 0; bid < ipbcfg.ln; bid++) {
+		struct ipbuf_head *ipb_h = &g_ipbuf[bid];
+		u16 la = ipb_h->p->la;
+		u16 ld = ipb_h->p->ld;
+		u16 c  = ipb_h->p->c;
+
+		if (len > PAGE_SIZE - 100) {
+			len += sprintf(buf + len, "out of buffer.\n");
+			goto finish;
+		}
+
+		len += sprintf(buf + len, "ipbuf[%d]: adr = 0x%p\n",
+			       bid, ipb_h->p);
+		if (la == TID_FREE) {
+			len += sprintf(buf + len,
+				       "  DSPtask[%d]->Linux "
+				       "(already read and now free for Linux)\n",
+				       ld);
+		} else if (ld == TID_FREE) {
+			len += sprintf(buf + len,
+				       "  Linux->DSPtask[%d] "
+				       "(already read and now free for DSP)\n",
+				       la);
+		} else if (ipbuf_is_held(ld, bid)) {
+			len += sprintf(buf + len,
+				       "  DSPtask[%d]->Linux "
+				       "(waiting to be read)\n"
+				       "  count = %d\n", ld, c);
+		} else {
+			len += sprintf(buf + len,
+				       "  Linux->DSPtask[%d] "
+				       "(waiting to be read)\n"
+				       "  count = %d\n", la, c);
+		}
+	}
+
+	len += sprintf(buf + len, "\nFree IPBUF link: ");
+	spin_lock(&ipb_free.lock);
+	ipblink_for_each(bid, &ipb_free) {
+		len += sprintf(buf + len, "%d ", bid);
+	}
+	spin_unlock(&ipb_free.lock);
+	len += sprintf(buf + len, "\n");
+	len += sprintf(buf + len, "IPBFULL error count: %ld\n",
+		       ipbcfg.cnt_full);
+
+finish:
+	return len;
+}
diff --git a/drivers/dsp/dspgateway/ipbuf.h b/drivers/dsp/dspgateway/ipbuf.h
new file mode 100644
index 0000000..926d353
--- /dev/null
+++ b/drivers/dsp/dspgateway/ipbuf.h
@@ -0,0 +1,193 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __PLAT_OMAP_DSP_IPBUF_H
+#define __PLAT_OMAP_DSP_IPBUF_H
+
+struct ipbuf {
+	u16 c;			/* count */
+	u16 next;		/* link */
+	u16 la;			/* lock owner (ARM side) */
+	u16 sa;			/* sync word (ARM->DSP) */
+	u16 ld;			/* lock owner (DSP side) */
+	u16 sd;			/* sync word (DSP->ARM) */
+	unsigned char d[0];	/* data */
+};
+
+struct ipbuf_p {
+	u16 c;		/* count */
+	u16 s;		/* sync word */
+	u16 al;		/* data address lower */
+	u16 ah;		/* data address upper */
+};
+
+#define IPBUF_SYS_DLEN	31
+
+struct ipbuf_sys {
+	u16 s;			/* sync word */
+	u16 d[IPBUF_SYS_DLEN];	/* data */
+};
+
+struct ipbcfg {
+	u16 ln;
+	u16 lsz;
+	void *base;
+	u16 bsycnt;
+	unsigned long cnt_full;	/* count of IPBFULL error */
+};
+
+struct ipbuf_head {
+	u16 bid;
+	struct ipbuf *p;
+};
+
+extern struct ipbcfg ipbcfg;
+extern struct ipbuf_sys *ipbuf_sys_da, *ipbuf_sys_ad;
+
+#define ipb_bsycnt_inc(ipbcfg)	atomic_inc((atomic_t *)&((ipbcfg)->bsycnt))
+#define ipb_bsycnt_dec(ipbcfg)	atomic_dec((atomic_t *)&((ipbcfg)->bsycnt))
+
+#define dsp_mem_enable_ipbuf()	dsp_mem_enable(ipbcfg.base)
+#define dsp_mem_disable_ipbuf()	dsp_mem_disable(ipbcfg.base)
+
+struct ipblink {
+	spinlock_t lock;
+	u16 top;
+	u16 tail;
+};
+
+#define IPBLINK_INIT {				\
+		.lock = SPIN_LOCK_UNLOCKED,	\
+		.top  = BID_NULL,		\
+		.tail = BID_NULL,		\
+	}
+
+#define INIT_IPBLINK(link)			\
+	do {					\
+		spin_lock_init(&(link)->lock);	\
+		(link)->top  = BID_NULL;	\
+		(link)->tail = BID_NULL;	\
+	} while(0)
+
+#define RESET_IPBLINK(link)			\
+	do {					\
+		(link)->top  = BID_NULL;	\
+		(link)->tail = BID_NULL;	\
+	} while(0)
+
+#define ipblink_empty(link)	((link)->top == BID_NULL)
+
+static inline void __ipblink_del_top(struct ipblink *link)
+{
+	struct ipbuf_head *ipb_h = bid_to_ipbuf(link->top);
+
+	if ((link->top = ipb_h->p->next) == BID_NULL)
+		link->tail = BID_NULL;
+	else
+		ipb_h->p->next = BID_NULL;
+}
+
+static inline void ipblink_del_top(struct ipblink *link)
+{
+	spin_lock(&link->lock);
+	__ipblink_del_top(link);
+	spin_unlock(&link->lock);
+}
+
+static inline void __ipblink_add_tail(struct ipblink *link, u16 bid)
+{
+	if (ipblink_empty(link))
+		link->top = bid;
+	else
+		bid_to_ipbuf(link->tail)->p->next = bid;
+	link->tail = bid;
+}
+
+static inline void ipblink_add_tail(struct ipblink *link, u16 bid)
+{
+	spin_lock(&link->lock);
+	__ipblink_add_tail(link, bid);
+	spin_unlock(&link->lock);
+}
+
+static inline void __ipblink_flush(struct ipblink *link)
+{
+	u16 bid;
+
+	while (!ipblink_empty(link)) {
+		bid = link->top;
+		__ipblink_del_top(link);
+		unuse_ipbuf(bid_to_ipbuf(bid));
+	}
+}
+
+static inline void ipblink_flush(struct ipblink *link)
+{
+	spin_lock(&link->lock);
+	__ipblink_flush(link);
+	spin_unlock(&link->lock);
+}
+
+static inline void __ipblink_add_pvt(struct ipblink *link)
+{
+	link->top  = BID_PVT;
+	link->tail = BID_PVT;
+}
+
+static inline void ipblink_add_pvt(struct ipblink *link)
+{
+	spin_lock(&link->lock);
+	__ipblink_add_pvt(link);
+	spin_unlock(&link->lock);
+}
+
+static inline void __ipblink_del_pvt(struct ipblink *link)
+{
+	link->top  = BID_NULL;
+	link->tail = BID_NULL;
+}
+
+static inline void ipblink_del_pvt(struct ipblink *link)
+{
+	spin_lock(&link->lock);
+	__ipblink_del_pvt(link);
+	spin_unlock(&link->lock);
+}
+
+static inline void __ipblink_flush_pvt(struct ipblink *link)
+{
+	if (!ipblink_empty(link))
+		ipblink_del_pvt(link);
+}
+
+static inline void ipblink_flush_pvt(struct ipblink *link)
+{
+	spin_lock(&link->lock);
+	__ipblink_flush_pvt(link);
+	spin_unlock(&link->lock);
+}
+
+#define ipblink_for_each(bid, link) \
+	for (bid = (link)->top; bid != BID_NULL; bid = bid_to_ipbuf(bid)->p->next)
+
+#endif /* __PLAT_OMAP_DSP_IPBUF_H */
diff --git a/drivers/dsp/dspgateway/mblog.c b/drivers/dsp/dspgateway/mblog.c
new file mode 100644
index 0000000..2b1e113
--- /dev/null
+++ b/drivers/dsp/dspgateway/mblog.c
@@ -0,0 +1,280 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2003-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <asm/arch/mailbox.h>
+#include "dsp_mbcmd.h"
+#include "dsp.h"
+
+char *subcmd_name(struct mbcmd *mb)
+{
+	u8 cmd_h = mb->cmd_h;
+	u8 cmd_l = mb->cmd_l;
+	char *s;
+
+	switch (cmd_h) {
+	case MBOX_CMD_DSP_RUNLEVEL:
+		s = (cmd_l == RUNLEVEL_USER)     ? "USER":
+		    (cmd_l == RUNLEVEL_SUPER)    ? "SUPER":
+		    (cmd_l == RUNLEVEL_RECOVERY) ? "RECOVERY":
+		    NULL;
+		break;
+	case MBOX_CMD_DSP_PM:
+		s = (cmd_l == PM_DISABLE) ? "DISABLE":
+		    (cmd_l == PM_ENABLE)  ? "ENABLE":
+		    NULL;
+		break;
+	case MBOX_CMD_DSP_KFUNC:
+		s = (cmd_l == KFUNC_FBCTL) ? "FBCTL":
+			(cmd_l == KFUNC_POWER) ?
+			((mb->data == AUDIO_PWR_UP)	? "PWR AUD /UP":
+			 (mb->data == AUDIO_PWR_DOWN)	? "PWR AUD /DOWN":
+			 (mb->data == AUDIO_PWR_DOWN2)	? "PWR AUD /DOWN(2)":
+			 (mb->data == DSP_PWR_UP)	? "PWR DSP /UP":
+			 (mb->data == DSP_PWR_DOWN)	? "PWR DSP /DOWN":
+			 (mb->data == DVFS_START)	? "PWR DVFS/START":
+			 (mb->data == DVFS_STOP)	? "PWR DVFS/STOP":
+			 NULL):
+
+		    NULL;
+		break;
+	case MBOX_CMD_DSP_DSPCFG:
+		{
+			u8 cfgc = cmd_l & 0x7f;
+			s = (cfgc == DSPCFG_REQ)     ? "REQ":
+			    (cfgc == DSPCFG_SYSADRH) ? "SYSADRH":
+			    (cfgc == DSPCFG_SYSADRL) ? "SYSADRL":
+			    (cfgc == DSPCFG_ABORT)   ? "ABORT":
+			    (cfgc == DSPCFG_PROTREV) ? "PROTREV":
+			    NULL;
+			break;
+		}
+	case MBOX_CMD_DSP_REGRW:
+		s = (cmd_l == REGRW_MEMR) ? "MEMR":
+		    (cmd_l == REGRW_MEMW) ? "MEMW":
+		    (cmd_l == REGRW_IOR)  ? "IOR":
+		    (cmd_l == REGRW_IOW)  ? "IOW":
+		    (cmd_l == REGRW_DATA) ? "DATA":
+		    NULL;
+		break;
+	case MBOX_CMD_DSP_GETVAR:
+	case MBOX_CMD_DSP_SETVAR:
+		s = (cmd_l == VARID_ICRMASK)  ? "ICRMASK":
+		    (cmd_l == VARID_LOADINFO) ? "LOADINFO":
+		    NULL;
+		break;
+	case MBOX_CMD_DSP_ERR:
+		s = (cmd_l == EID_BADTID)     ? "BADTID":
+		    (cmd_l == EID_BADTCN)     ? "BADTCN":
+		    (cmd_l == EID_BADBID)     ? "BADBID":
+		    (cmd_l == EID_BADCNT)     ? "BADCNT":
+		    (cmd_l == EID_NOTLOCKED)  ? "NOTLOCKED":
+		    (cmd_l == EID_STVBUF)     ? "STVBUF":
+		    (cmd_l == EID_BADADR)     ? "BADADR":
+		    (cmd_l == EID_BADTCTL)    ? "BADTCTL":
+		    (cmd_l == EID_BADPARAM)   ? "BADPARAM":
+		    (cmd_l == EID_FATAL)      ? "FATAL":
+		    (cmd_l == EID_WDT)        ? "WDT":
+		    (cmd_l == EID_NOMEM)      ? "NOMEM":
+		    (cmd_l == EID_NORES)      ? "NORES":
+		    (cmd_l == EID_IPBFULL)    ? "IPBFULL":
+		    (cmd_l == EID_TASKNOTRDY) ? "TASKNOTRDY":
+		    (cmd_l == EID_TASKBSY)    ? "TASKBSY":
+		    (cmd_l == EID_TASKERR)    ? "TASKERR":
+		    (cmd_l == EID_BADCFGTYP)  ? "BADCFGTYP":
+		    (cmd_l == EID_DEBUG)      ? "DEBUG":
+		    (cmd_l == EID_BADSEQ)     ? "BADSEQ":
+		    (cmd_l == EID_BADCMD)     ? "BADCMD":
+		    NULL;
+		break;
+	default:
+		s = NULL;
+	}
+
+	return s;
+}
+
+/* output of show() method should fit to PAGE_SIZE */
+#define MBLOG_DEPTH	64
+
+struct mblogent {
+	unsigned long jiffies;
+	mbox_msg_t msg;
+	arm_dsp_dir_t dir;
+};
+
+static struct {
+	spinlock_t lock;
+	int wp;
+	unsigned long cnt, cnt_ad, cnt_da;
+	struct mblogent ent[MBLOG_DEPTH];
+} mblog = {
+	.lock = SPIN_LOCK_UNLOCKED,
+};
+
+#ifdef CONFIG_OMAP_DSP_MBCMD_VERBOSE
+static inline void mblog_print_cmd(struct mbcmd *mb, arm_dsp_dir_t dir)
+{
+	const struct cmdinfo *ci = cmdinfo[mb->cmd_h];
+	char *dir_str;
+	char *subname;
+
+	dir_str = (dir == DIR_A2D) ? "sending  " : "receiving";
+	switch (ci->cmd_l_type) {
+	case CMD_L_TYPE_SUBCMD:
+		subname = subcmd_name(mb);
+		if (unlikely(!subname))
+			subname = "Unknown";
+		pr_debug("mbox: %s seq=%d, cmd=%02x:%02x(%s:%s), data=%04x\n",
+			 dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
+			 ci->name, subname, mb->data);
+		break;
+	case CMD_L_TYPE_TID:
+		pr_debug("mbox: %s seq=%d, cmd=%02x:%02x(%s:task %d), data=%04x\n",
+			 dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
+			 ci->name, mb->cmd_l, mb->data);
+		break;
+	case CMD_L_TYPE_NULL:
+		pr_debug("mbox: %s seq=%d, cmd=%02x:%02x(%s), data=%04x\n",
+			 dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
+			 ci->name, mb->data);
+		break;
+	}
+}
+#else
+static inline void mblog_print_cmd(struct mbcmd *mb, arm_dsp_dir_t dir) { }
+#endif
+
+void mblog_add(struct mbcmd *mb, arm_dsp_dir_t dir)
+{
+	struct mblogent *ent;
+
+	spin_lock(&mblog.lock);
+	ent = &mblog.ent[mblog.wp];
+	ent->jiffies = jiffies;
+	ent->msg = *(mbox_msg_t *)mb;
+	ent->dir = dir;
+	if (mblog.cnt < 0xffffffff)
+		mblog.cnt++;
+	switch (dir) {
+	case DIR_A2D:
+		if (mblog.cnt_ad < 0xffffffff)
+			mblog.cnt_ad++;
+		break;
+	case DIR_D2A:
+		if (mblog.cnt_da < 0xffffffff)
+			mblog.cnt_da++;
+		break;
+	}
+	if (++mblog.wp == MBLOG_DEPTH)
+		mblog.wp = 0;
+	spin_unlock(&mblog.lock);
+
+	mblog_print_cmd(mb, dir);
+}
+
+/*
+ * sysfs file
+ */
+static ssize_t mblog_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int len = 0;
+	int wp;
+	int i;
+
+	spin_lock(&mblog.lock);
+
+	wp = mblog.wp;
+	len += sprintf(buf + len,
+		       "log count:%ld / ARM->DSP:%ld, DSP->ARM:%ld\n",
+		       mblog.cnt, mblog.cnt_ad, mblog.cnt_da);
+	if (mblog.cnt == 0)
+		goto done;
+
+	len += sprintf(buf + len, "           ARM->DSP   ARM<-DSP\n");
+	len += sprintf(buf + len, " jiffies  cmd  data  cmd  data\n");
+	i = (mblog.cnt >= MBLOG_DEPTH) ? wp : 0;
+	do {
+		struct mblogent *ent = &mblog.ent[i];
+		struct mbcmd *mb = (struct mbcmd *)&ent->msg;
+		char *subname;
+		struct cmdinfo ci_null = {
+			.name = "Unknown",
+			.cmd_l_type = CMD_L_TYPE_NULL,
+		};
+		const struct cmdinfo *ci;
+
+		len += sprintf(buf + len,
+			       (ent->dir == DIR_A2D) ?
+				"%08lx  %04x %04x            ":
+				"%08lx             %04x %04x ",
+			       ent->jiffies,
+			       (ent->msg >> 16) & 0x7fff, ent->msg & 0xffff);
+
+		if ((ci = cmdinfo[mb->cmd_h]) == NULL)
+			ci = &ci_null;
+
+		switch (ci->cmd_l_type) {
+		case CMD_L_TYPE_SUBCMD:
+			if ((subname = subcmd_name(mb)) == NULL)
+				subname = "Unknown";
+			len += sprintf(buf + len, "%s:%s\n",
+				       ci->name, subname);
+			break;
+		case CMD_L_TYPE_TID:
+			len += sprintf(buf + len, "%s:task %d\n",
+				       ci->name, mb->cmd_l);
+			break;
+		case CMD_L_TYPE_NULL:
+			len += sprintf(buf + len, "%s\n", ci->name);
+			break;
+		}
+
+		if (++i == MBLOG_DEPTH)
+			i = 0;
+	} while (i != wp);
+
+done:
+	spin_unlock(&mblog.lock);
+
+	return len;
+}
+
+static struct device_attribute dev_attr_mblog = __ATTR_RO(mblog);
+
+void __init mblog_init(void)
+{
+	int ret;
+
+	ret = device_create_file(omap_dsp->dev, &dev_attr_mblog);
+	if (ret)
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+}
+
+void mblog_exit(void)
+{
+	device_remove_file(omap_dsp->dev, &dev_attr_mblog);
+}
diff --git a/drivers/dsp/dspgateway/mmu.h b/drivers/dsp/dspgateway/mmu.h
new file mode 100644
index 0000000..9d60e9e
--- /dev/null
+++ b/drivers/dsp/dspgateway/mmu.h
@@ -0,0 +1,140 @@
+#ifndef __PLAT_OMAP_DSP_MMU_H
+#define __PLAT_OMAP_DSP_MMU_H
+
+#ifdef CONFIG_ARCH_OMAP1
+
+#ifdef CONFIG_ARCH_OMAP15XX
+struct omap_mmu dsp_mmu = {
+	.name		= "mmu:dsp",
+	.type		= OMAP_MMU_DSP,
+	.base		= IO_ADDRESS(OMAP1510_DSP_MMU_BASE),
+	.membase	= OMAP1510_DSP_BASE,
+	.memsize	= OMAP1510_DSP_SIZE,
+	.nr_tlb_entries	= 32,
+	.addrspace	= 24,
+	.irq		= INT_1510_DSP_MMU,
+	.ops		= &omap1_mmu_ops,
+};
+#endif
+#ifdef CONFIG_ARCH_OMAP16XX
+struct omap_mmu dsp_mmu = {
+	.name		= "mmu:dsp",
+	.type		= OMAP_MMU_DSP,
+	.base		= IO_ADDRESS(OMAP16XX_DSP_MMU_BASE),
+	.membase	= OMAP16XX_DSP_BASE,
+	.memsize	= OMAP16XX_DSP_SIZE,
+	.nr_tlb_entries	= 32,
+	.addrspace	= 24,
+	.irq		= INT_1610_DSP_MMU,
+	.ops		= &omap1_mmu_ops,
+};
+#endif
+#else /* OMAP2 */
+struct omap_mmu dsp_mmu = {
+	.name		= "mmu:dsp",
+	.type		= OMAP_MMU_DSP,
+	.base		= DSP_MMU_24XX_VIRT,
+	.membase	= DSP_MEM_24XX_VIRT,
+	.memsize	= DSP_MEM_24XX_SIZE,
+	.nr_tlb_entries	= 32,
+	.addrspace	= 24,
+	.irq		= INT_24XX_DSP_MMU,
+	.ops		= &omap2_mmu_ops,
+};
+
+#define IOMAP_VAL	0x3f
+#endif
+
+#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
+static struct omapfb_notifier_block *omapfb_nb;
+static int omapfb_ready;
+#endif
+
+/*
+ * OMAP1 EMIFF access
+ */
+#ifdef CONFIG_ARCH_OMAP1
+#define EMIF_PRIO_LB_MASK	0x0000f000
+#define EMIF_PRIO_LB_SHIFT	12
+#define EMIF_PRIO_DMA_MASK	0x00000f00
+#define EMIF_PRIO_DMA_SHIFT	8
+#define EMIF_PRIO_DSP_MASK	0x00000070
+#define EMIF_PRIO_DSP_SHIFT	4
+#define EMIF_PRIO_MPU_MASK	0x00000007
+#define EMIF_PRIO_MPU_SHIFT	0
+#define set_emiff_dma_prio(prio) \
+	do { \
+		omap_writel((omap_readl(OMAP_TC_OCPT1_PRIOR) & \
+			     ~EMIF_PRIO_DMA_MASK) | \
+			    ((prio) << EMIF_PRIO_DMA_SHIFT), \
+			    OMAP_TC_OCPT1_PRIOR); \
+	} while(0)
+#else
+#define set_emiff_dma_prio(prio)	do { } while (0)
+#endif /* CONFIG_ARCH_OMAP1 */
+
+#ifdef CONFIG_ARCH_OMAP1
+static int dsp_mmu_itack(void)
+{
+	unsigned long dspadr;
+
+	pr_info("omapdsp: sending DSP MMU interrupt ack.\n");
+	if (!dsp_err_isset(ERRCODE_MMU)) {
+		printk(KERN_ERR "omapdsp: DSP MMU error has not been set.\n");
+		return -EINVAL;
+	}
+	dspadr = dsp_mmu.fault_address & ~(SZ_4K-1);
+	/* FIXME: reserve TLB entry for this */
+	omap_mmu_exmap(&dsp_mmu, dspadr, 0, SZ_4K, EXMAP_TYPE_MEM);
+	pr_info("omapdsp: falling into recovery runlevel...\n");
+	dsp_set_runlevel(RUNLEVEL_RECOVERY);
+	omap_mmu_itack(&dsp_mmu);
+	udelay(100);
+	omap_mmu_exunmap(&dsp_mmu, dspadr);
+	dsp_err_clear(ERRCODE_MMU);
+	return 0;
+}
+
+/*
+ * intmem_enable() / disable():
+ * if the address is in DSP internal memories,
+ * we send PM mailbox commands so that DSP DMA domain won't go in idle
+ * when ARM is accessing to those memories.
+ */
+static int intmem_enable(void)
+{
+	int ret = 0;
+
+	if (dsp_cfgstat_get_stat() == CFGSTAT_READY)
+		ret = mbcompose_send(PM, PM_ENABLE, DSPREG_ICR_DMA);
+
+	return ret;
+}
+
+static void intmem_disable(void) {
+	if (dsp_cfgstat_get_stat() == CFGSTAT_READY)
+		mbcompose_send(PM, PM_DISABLE, DSPREG_ICR_DMA);
+}
+#else
+static int intmem_enable(void) { return 0; }
+static void intmem_disable(void) { }
+static int dsp_mmu_itack(void) { return 0; }
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2
+static inline void dsp_mem_ipi_init(void)
+{
+	int i, dspmem_pg_count;
+	dspmem_pg_count = dspmem_size >> 12;
+	for (i = 0; i < dspmem_pg_count; i++) {
+		writel(i, DSP_IPI_INDEX);
+		writel(DSP_IPI_ENTRY_ELMSIZEVALUE_16, DSP_IPI_ENTRY);
+	}
+	writel(1, DSP_IPI_ENABLE);
+	writel(IOMAP_VAL, DSP_IPI_IOMAP);
+}
+#else
+static inline void dsp_mem_ipi_init(void) { }
+#endif
+
+#endif /* __PLAT_OMAP_DSP_MMU_H */
diff --git a/drivers/dsp/dspgateway/omap1_dsp.h b/drivers/dsp/dspgateway/omap1_dsp.h
new file mode 100644
index 0000000..f4ec73e
--- /dev/null
+++ b/drivers/dsp/dspgateway/omap1_dsp.h
@@ -0,0 +1,114 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __OMAP_DSP_OMAP1_DSP_H
+#define __OMAP_DSP_OMAP1_DSP_H
+
+#ifdef CONFIG_ARCH_OMAP15XX
+#define OMAP1510_DARAM_BASE	(OMAP1510_DSP_BASE + 0x0)
+#define OMAP1510_DARAM_SIZE	0x10000
+#define OMAP1510_SARAM_BASE	(OMAP1510_DSP_BASE + 0x10000)
+#define OMAP1510_SARAM_SIZE	0x18000
+#endif
+
+#ifdef CONFIG_ARCH_OMAP16XX
+#define OMAP16XX_DARAM_BASE	(OMAP16XX_DSP_BASE + 0x0)
+#define OMAP16XX_DARAM_SIZE	0x10000
+#define OMAP16XX_SARAM_BASE	(OMAP16XX_DSP_BASE + 0x10000)
+#define OMAP16XX_SARAM_SIZE	0x18000
+#endif
+
+/*
+ * Reset Control
+ */
+#define ARM_RSTCT1_SW_RST		0x0008
+#define ARM_RSTCT1_DSP_RST		0x0004
+#define ARM_RSTCT1_DSP_EN		0x0002
+#define ARM_RSTCT1_ARM_RST		0x0001
+
+/*
+ * MPUI
+ */
+#define MPUI_CTRL_WORDSWAP_MASK		0x00600000
+#define MPUI_CTRL_WORDSWAP_ALL		0x00000000
+#define MPUI_CTRL_WORDSWAP_NONAPI	0x00200000
+#define MPUI_CTRL_WORDSWAP_API		0x00400000
+#define MPUI_CTRL_WORDSWAP_NONE		0x00600000
+#define MPUI_CTRL_AP_MASK		0x001c0000
+#define MPUI_CTRL_AP_MDH		0x00000000
+#define MPUI_CTRL_AP_MHD		0x00040000
+#define MPUI_CTRL_AP_DMH		0x00080000
+#define MPUI_CTRL_AP_HMD		0x000c0000
+#define MPUI_CTRL_AP_DHM		0x00100000
+#define MPUI_CTRL_AP_HDM		0x00140000
+#define MPUI_CTRL_BYTESWAP_MASK		0x00030000
+#define MPUI_CTRL_BYTESWAP_NONE		0x00000000
+#define MPUI_CTRL_BYTESWAP_NONAPI	0x00010000
+#define MPUI_CTRL_BYTESWAP_ALL		0x00020000
+#define MPUI_CTRL_BYTESWAP_API		0x00030000
+#define MPUI_CTRL_TIMEOUT_MASK		0x0000ff00
+#define MPUI_CTRL_APIF_HNSTB_DIV_MASK	0x000000f0
+#define MPUI_CTRL_S_NABORT_GL		0x00000008
+#define MPUI_CTRL_S_NABORT_32BIT	0x00000004
+#define MPUI_CTRL_EN_TIMEOUT		0x00000002
+#define MPUI_CTRL_HF_MCUCLK		0x00000001
+#define DSP_BOOT_CONFIG_DIRECT		0x00000000
+#define DSP_BOOT_CONFIG_PSD_DIRECT	0x00000001
+#define DSP_BOOT_CONFIG_IDLE		0x00000002
+#define DSP_BOOT_CONFIG_DL16		0x00000003
+#define DSP_BOOT_CONFIG_DL32		0x00000004
+#define DSP_BOOT_CONFIG_MPUI		0x00000005
+#define DSP_BOOT_CONFIG_INTERNAL	0x00000006
+
+/*
+ * DSP boot mode
+ *   direct:        0xffff00
+ *   pseudo direct: 0x080000
+ *   MPUI:          branch 0x010000
+ *   internel:      branch 0x024000
+ */
+#define DSP_BOOT_ADR_DIRECT		0xffff00
+#define DSP_BOOT_ADR_PSD_DIRECT		0x080000
+#define DSP_BOOT_ADR_MPUI		0x010000
+#define DSP_BOOT_ADR_INTERNAL		0x024000
+
+/*
+ * TC
+ */
+#define TC_ENDIANISM_SWAP		0x00000002
+#define TC_ENDIANISM_SWAP_WORD		0x00000002
+#define TC_ENDIANISM_SWAP_BYTE		0x00000000
+#define TC_ENDIANISM_EN			0x00000001
+
+/*
+ * DSP ICR
+ */
+#define DSPREG_ICR_RESERVED_BITS	0xffc0
+#define DSPREG_ICR_EMIF			0x0020
+#define DSPREG_ICR_DPLL			0x0010
+#define DSPREG_ICR_PER			0x0008
+#define DSPREG_ICR_CACHE		0x0004
+#define DSPREG_ICR_DMA			0x0002
+#define DSPREG_ICR_CPU			0x0001
+
+#endif /* __OMAP_DSP_OMAP1_DSP_H */
diff --git a/drivers/dsp/dspgateway/omap2_dsp.h b/drivers/dsp/dspgateway/omap2_dsp.h
new file mode 100644
index 0000000..0dc43f0
--- /dev/null
+++ b/drivers/dsp/dspgateway/omap2_dsp.h
@@ -0,0 +1,95 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __OMAP_DSP_OMAP2_DSP_H
+#define __OMAP_DSP_OMAP2_DSP_H
+
+#ifdef CONFIG_ARCH_OMAP24XX
+#define OMAP24XX_DARAM_BASE	(DSP_MEM_24XX_VIRT + 0x0)
+#define OMAP24XX_DARAM_SIZE	0x10000
+#define OMAP24XX_SARAM_BASE	(DSP_MEM_24XX_VIRT + 0x10000)
+#define OMAP24XX_SARAM_SIZE	0x18000
+#endif
+
+#include <asm/arch/hardware.h>
+
+/*
+ * DSP IPI registers: mapped to 0xe1000000 -- use readX(), writeX()
+ */
+#ifdef CONFIG_ARCH_OMAP24XX
+#define DSP_IPI_BASE			DSP_IPI_24XX_VIRT
+#endif
+
+#ifdef CONFIG_ARCH_OMAP34XX
+#define DSP_IPI_BASE			DSP_IPI_34XX_VIRT
+#endif
+
+#define DSP_IPI_REVISION		(DSP_IPI_BASE + 0x00)
+#define DSP_IPI_SYSCONFIG		(DSP_IPI_BASE + 0x10)
+#define DSP_IPI_INDEX			(DSP_IPI_BASE + 0x40)
+#define DSP_IPI_ENTRY			(DSP_IPI_BASE + 0x44)
+#define DSP_IPI_ENABLE			(DSP_IPI_BASE + 0x48)
+#define DSP_IPI_IOMAP			(DSP_IPI_BASE + 0x4c)
+#define DSP_IPI_DSPBOOTCONFIG		(DSP_IPI_BASE + 0x50)
+
+#define DSP_IPI_ENTRY_ELMSIZEVALUE_MASK	0x00000003
+#define DSP_IPI_ENTRY_ELMSIZEVALUE_8	0x00000000
+#define DSP_IPI_ENTRY_ELMSIZEVALUE_16	0x00000001
+#define DSP_IPI_ENTRY_ELMSIZEVALUE_32	0x00000002
+
+#define DSP_BOOT_CONFIG_DIRECT		0x00000000
+#define DSP_BOOT_CONFIG_PSD_DIRECT	0x00000001
+#define DSP_BOOT_CONFIG_IDLE		0x00000002
+#define DSP_BOOT_CONFIG_DL16		0x00000003
+#define DSP_BOOT_CONFIG_DL32		0x00000004
+#define DSP_BOOT_CONFIG_API		0x00000005
+#define DSP_BOOT_CONFIG_INTERNAL	0x00000006
+
+/*
+ * DSP boot mode
+ *   direct:        0xffff00
+ *   pseudo direct: 0x080000
+ *   API:           branch 0x010000
+ *   internel:      branch 0x024000
+ */
+#define DSP_BOOT_ADR_DIRECT		0xffff00
+#define DSP_BOOT_ADR_PSD_DIRECT		0x080000
+#define DSP_BOOT_ADR_API		0x010000
+#define DSP_BOOT_ADR_INTERNAL		0x024000
+
+/*
+ * DSP ICR
+ */
+#define DSPREG_ICR_RESERVED_BITS	0xfc00
+#define DSPREG_ICR_HWA			0x0200
+#define DSPREG_ICR_IPORT		0x0100
+#define DSPREG_ICR_MPORT		0x0080
+#define DSPREG_ICR_XPORT		0x0040
+#define DSPREG_ICR_DPORT		0x0020
+#define DSPREG_ICR_DPLL			0x0010
+#define DSPREG_ICR_PER			0x0008
+#define DSPREG_ICR_CACHE		0x0004
+#define DSPREG_ICR_DMA			0x0002
+#define DSPREG_ICR_CPU			0x0001
+
+#endif /* __OMAP_DSP_OMAP2_DSP_H */
diff --git a/drivers/dsp/dspgateway/proclist.h b/drivers/dsp/dspgateway/proclist.h
new file mode 100644
index 0000000..666ca4d
--- /dev/null
+++ b/drivers/dsp/dspgateway/proclist.h
@@ -0,0 +1,87 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2004-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __PLAT_OMAP_DSP_PROCLIST_H
+#define __PLAT_OMAP_DSP_PROCLIST_H
+
+struct proc_list {
+	struct list_head list_head;
+	pid_t pid;
+	struct file *file;
+};
+
+static inline int proc_list_add(spinlock_t *lock, struct list_head *list,
+				     struct task_struct *tsk, struct file *file)
+{
+	struct proc_list *new;
+
+	new = kmalloc(sizeof(struct proc_list), GFP_KERNEL);
+	if (new == NULL)
+		return -ENOMEM;
+	new->pid = tsk->pid;
+	new->file = file;
+	spin_lock(lock);
+	list_add_tail(&new->list_head, list);
+	spin_unlock(lock);
+
+	return 0;
+}
+
+static inline void proc_list_del(spinlock_t *lock, struct list_head *list,
+				     struct task_struct *tsk, struct file *file)
+{
+	struct proc_list *pl;
+
+	spin_lock(lock);
+	list_for_each_entry(pl, list, list_head) {
+		if (pl->file == file) {
+			list_del(&pl->list_head);
+			kfree(pl);
+			spin_unlock(lock);
+			return;
+		}
+	}
+
+	/* correspinding file struct isn't found in the list ???  */
+	printk(KERN_ERR "proc_list_del(): proc_list is inconsistent!\n"
+			"struct file (%p) not found\n", file);
+	printk(KERN_ERR "listing proc_list...\n");
+	list_for_each_entry(pl, list, list_head)
+		printk(KERN_ERR "  pid:%d file:%p\n", pl->pid, pl->file);
+	spin_unlock(lock);
+}
+
+static inline void proc_list_flush(spinlock_t *lock, struct list_head *list)
+{
+	struct proc_list *pl;
+
+	spin_lock(lock);
+	while (!list_empty(list)) {
+		pl = list_entry(list->next, struct proc_list, list_head);
+		list_del(&pl->list_head);
+		kfree(pl);
+	}
+	spin_unlock(lock);
+}
+
+#endif /* __PLAT_OMAP_DSP_PROCLIST_H */
diff --git a/drivers/dsp/dspgateway/task.c b/drivers/dsp/dspgateway/task.c
new file mode 100644
index 0000000..e5ee8e0
--- /dev/null
+++ b/drivers/dsp/dspgateway/task.c
@@ -0,0 +1,3042 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/major.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/kfifo.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/arch/mailbox.h>
+#include <asm/arch/dsp.h>
+#include "uaccess_dsp.h"
+#include "dsp_mbcmd.h"
+#include "dsp.h"
+#include "ipbuf.h"
+#include "proclist.h"
+
+/*
+ * devstate: task device state machine
+ * NOTASK:	task is not attached.
+ * ATTACHED:	task is attached.
+ * GARBAGE:	task is detached. waiting for all processes to close this device.
+ * ADDREQ:	requesting for tadd
+ * DELREQ:	requesting for tdel. no process is opening this device.
+ * FREEZED:	task is attached, but reserved to be killed.
+ * ADDFAIL:	tadd failed.
+ * ADDING:	tadd in process.
+ * DELING:	tdel in process.
+ * KILLING:	tkill in process.
+ */
+#define TASKDEV_ST_NOTASK	0x00000001
+#define TASKDEV_ST_ATTACHED	0x00000002
+#define TASKDEV_ST_GARBAGE	0x00000004
+#define TASKDEV_ST_INVALID	0x00000008
+#define TASKDEV_ST_ADDREQ	0x00000100
+#define TASKDEV_ST_DELREQ	0x00000200
+#define TASKDEV_ST_FREEZED	0x00000400
+#define TASKDEV_ST_ADDFAIL	0x00001000
+#define TASKDEV_ST_ADDING	0x00010000
+#define TASKDEV_ST_DELING	0x00020000
+#define TASKDEV_ST_KILLING	0x00040000
+#define TASKDEV_ST_STATE_MASK	0x7fffffff
+#define TASKDEV_ST_STALE	0x80000000
+
+static struct {
+	long state;
+	char *name;
+} devstate_desc[] = {
+	{ TASKDEV_ST_NOTASK,   "notask" },
+	{ TASKDEV_ST_ATTACHED, "attached" },
+	{ TASKDEV_ST_GARBAGE,  "garbage" },
+	{ TASKDEV_ST_INVALID,  "invalid" },
+	{ TASKDEV_ST_ADDREQ,   "addreq" },
+	{ TASKDEV_ST_DELREQ,   "delreq" },
+	{ TASKDEV_ST_FREEZED,  "freezed" },
+	{ TASKDEV_ST_ADDFAIL,  "addfail" },
+	{ TASKDEV_ST_ADDING,   "adding" },
+	{ TASKDEV_ST_DELING,   "deling" },
+	{ TASKDEV_ST_KILLING,  "killing" },
+};
+
+static char *devstate_name(long state)
+{
+	int i;
+	int max = ARRAY_SIZE(devstate_desc);
+
+	for (i = 0; i < max; i++) {
+		if (state & devstate_desc[i].state)
+			return devstate_desc[i].name;
+	}
+	return "unknown";
+}
+
+struct rcvdt_bk_struct {
+	struct ipblink link;
+	unsigned int rp;
+};
+
+struct taskdev {
+	struct bus_type *bus;
+	struct device dev;	/* Generic device interface */
+
+	long state;
+	struct rw_semaphore state_sem;
+	wait_queue_head_t state_wait_q;
+	struct mutex usecount_lock;
+	unsigned int usecount;
+	char name[TNM_LEN];
+	struct file_operations fops;
+	spinlock_t proc_list_lock;
+	struct list_head proc_list;
+	struct dsptask *task;
+
+	/* read stuff */
+	wait_queue_head_t read_wait_q;
+	struct mutex read_mutex;
+	spinlock_t read_lock;
+	union {
+		struct kfifo *fifo;	/* for active word */
+		struct rcvdt_bk_struct bk;
+	} rcvdt;
+
+	/* write stuff */
+	wait_queue_head_t write_wait_q;
+	struct mutex write_mutex;
+	spinlock_t wsz_lock;
+	size_t wsz;
+
+	/* tctl stuff */
+	wait_queue_head_t tctl_wait_q;
+	struct mutex tctl_mutex;
+	int tctl_stat;
+	int tctl_ret;	/* return value for tctl_show() */
+
+	/* device lock */
+	struct mutex lock;
+	pid_t lock_pid;
+};
+
+#define to_taskdev(n) container_of(n, struct taskdev, dev)
+
+struct dsptask {
+	enum {
+		TASK_ST_ERR = 0,
+		TASK_ST_READY,
+		TASK_ST_CFGREQ
+	} state;
+	u8 tid;
+	char name[TNM_LEN];
+	u16 ttyp;
+	struct taskdev *dev;
+
+	/* read stuff */
+	struct ipbuf_p *ipbuf_pvt_r;
+
+	/* write stuff */
+	struct ipbuf_p *ipbuf_pvt_w;
+
+	/* mmap stuff */
+	void *map_base;
+	size_t map_length;
+};
+
+#define sndtyp_acv(ttyp)	((ttyp) & TTYP_ASND)
+#define sndtyp_psv(ttyp)	(!((ttyp) & TTYP_ASND))
+#define sndtyp_bk(ttyp)		((ttyp) & TTYP_BKDM)
+#define sndtyp_wd(ttyp)		(!((ttyp) & TTYP_BKDM))
+#define sndtyp_pvt(ttyp)	((ttyp) & TTYP_PVDM)
+#define sndtyp_gbl(ttyp)	(!((ttyp) & TTYP_PVDM))
+#define rcvtyp_acv(ttyp)	((ttyp) & TTYP_ARCV)
+#define rcvtyp_psv(ttyp)	(!((ttyp) & TTYP_ARCV))
+#define rcvtyp_bk(ttyp)		((ttyp) & TTYP_BKMD)
+#define rcvtyp_wd(ttyp)		(!((ttyp) & TTYP_BKMD))
+#define rcvtyp_pvt(ttyp)	((ttyp) & TTYP_PVMD)
+#define rcvtyp_gbl(ttyp)	(!((ttyp) & TTYP_PVMD))
+
+static inline int has_taskdev_lock(struct taskdev *dev);
+static int dsp_rmdev_minor(unsigned char minor);
+static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor);
+static void taskdev_delete(unsigned char minor);
+static int taskdev_attach_task(struct taskdev *dev, struct dsptask *task);
+static int dsp_tdel_bh(struct taskdev *dev, u16 type);
+
+static struct bus_type dsptask_bus = {
+	.name = "dsptask",
+};
+
+static struct class *dsp_task_class;
+static DEFINE_MUTEX(devmgr_lock);
+static struct taskdev *taskdev[TASKDEV_MAX];
+static struct dsptask *dsptask[TASKDEV_MAX];
+static DEFINE_MUTEX(cfg_lock);
+static u16 cfg_cmd;
+static u8 cfg_tid;
+static DECLARE_WAIT_QUEUE_HEAD(cfg_wait_q);
+static u8 n_task;	/* static task count */
+static void *heap;
+
+#define is_dynamic_task(tid)	((tid) >= n_task)
+
+#define devstate_read_lock(dev, devstate) \
+		devstate_read_lock_timeout(dev, devstate, 0)
+#define devstate_read_unlock(dev)	up_read(&(dev)->state_sem)
+#define devstate_write_lock(dev, devstate) \
+		devstate_write_lock_timeout(dev, devstate, 0)
+#define devstate_write_unlock(dev)	up_write(&(dev)->state_sem)
+
+static ssize_t devname_show(struct device *d, struct device_attribute *attr,
+			    char *buf);
+static ssize_t devstate_show(struct device *d, struct device_attribute *attr,
+			     char *buf);
+static ssize_t proc_list_show(struct device *d, struct device_attribute *attr,
+			      char *buf);
+static ssize_t taskname_show(struct device *d, struct device_attribute *attr,
+			     char *buf);
+static ssize_t ttyp_show(struct device *d, struct device_attribute *attr,
+			 char *buf);
+static ssize_t fifosz_show(struct device *d, struct device_attribute *attr,
+			   char *buf);
+static int fifosz_store(struct device *d, struct device_attribute *attr,
+			const char *buf, size_t count);
+static ssize_t fifocnt_show(struct device *d, struct device_attribute *attr,
+			    char *buf);
+static ssize_t ipblink_show(struct device *d, struct device_attribute *attr,
+			    char *buf);
+static ssize_t wsz_show(struct device *d, struct device_attribute *attr,
+			char *buf);
+static ssize_t mmap_show(struct device *d, struct device_attribute *attr,
+			 char *buf);
+
+#define __ATTR_RW(_name,_mode) { \
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
+	.show	= _name##_show,					\
+	.store	= _name##_store,					\
+}
+
+static struct device_attribute dev_attr_devname   = __ATTR_RO(devname);
+static struct device_attribute dev_attr_devstate  = __ATTR_RO(devstate);
+static struct device_attribute dev_attr_proc_list = __ATTR_RO(proc_list);
+static struct device_attribute dev_attr_taskname  = __ATTR_RO(taskname);
+static struct device_attribute dev_attr_ttyp      = __ATTR_RO(ttyp);
+static struct device_attribute dev_attr_fifosz    = __ATTR_RW(fifosz, 0666);
+static struct device_attribute dev_attr_fifocnt   = __ATTR_RO(fifocnt);
+static struct device_attribute dev_attr_ipblink   = __ATTR_RO(ipblink);
+static struct device_attribute dev_attr_wsz       = __ATTR_RO(wsz);
+static struct device_attribute dev_attr_mmap      = __ATTR_RO(mmap);
+
+static inline void set_taskdev_state(struct taskdev *dev, int state)
+{
+	pr_debug("omapdsp: devstate: CHANGE %s[%d]:\"%s\"->\"%s\"\n",
+		 dev->name,
+		 (dev->task ? dev->task->tid : -1),
+		 devstate_name(dev->state),
+		 devstate_name(state));
+	dev->state = state;
+}
+
+/*
+ * devstate_read_lock_timeout()
+ * devstate_write_lock_timeout():
+ * timeout != 0: dev->state can be diffeent from what you want.
+ * timeout == 0: no timeout
+ */
+#define BUILD_DEVSTATE_LOCK_TIMEOUT(rw)						\
+static int devstate_##rw##_lock_timeout(struct taskdev *dev, long devstate,     \
+				      int timeout)				\
+{										\
+	DEFINE_WAIT(wait);							\
+	down_##rw(&dev->state_sem);						\
+	while (!(dev->state & devstate)) {					\
+		up_##rw(&dev->state_sem);					\
+		prepare_to_wait(&dev->state_wait_q, &wait, TASK_INTERRUPTIBLE);	\
+		if (!timeout)							\
+			timeout = MAX_SCHEDULE_TIMEOUT;				\
+		timeout = schedule_timeout(timeout);				\
+		finish_wait(&dev->state_wait_q, &wait);				\
+		if (timeout == 0)						\
+			return -ETIME;						\
+		if (signal_pending(current))					\
+			return -EINTR;						\
+		down_##rw(&dev->state_sem);					\
+	}									\
+	return 0;                                                               \
+}
+BUILD_DEVSTATE_LOCK_TIMEOUT(read)
+BUILD_DEVSTATE_LOCK_TIMEOUT(write)
+
+#define BUILD_DEVSTATE_LOCK_AND_TEST(rw)					\
+static int devstate_##rw##_lock_and_test(struct taskdev *dev, long devstate)	\
+{										\
+	down_##rw(&dev->state_sem);						\
+	if (dev->state & devstate)						\
+		return 1;	/* success */					\
+	/* failure */								\
+	up_##rw(&dev->state_sem);						\
+	return 0;								\
+}
+BUILD_DEVSTATE_LOCK_AND_TEST(read)
+BUILD_DEVSTATE_LOCK_AND_TEST(write)
+
+static int taskdev_lock_interruptible(struct taskdev *dev,
+				      struct mutex *lock)
+{
+	int ret;
+
+	if (has_taskdev_lock(dev))
+		ret = mutex_lock_interruptible(lock);
+	else {
+		if ((ret = mutex_lock_interruptible(&dev->lock)) != 0)
+			return ret;
+		ret = mutex_lock_interruptible(lock);
+		mutex_unlock(&dev->lock);
+	}
+
+	return ret;
+}
+
+static int taskdev_lock_and_statelock_attached(struct taskdev *dev,
+					       struct mutex *lock)
+{
+	int ret;
+
+	if (!devstate_read_lock_and_test(dev, TASKDEV_ST_ATTACHED))
+		return -ENODEV;
+
+	if ((ret = taskdev_lock_interruptible(dev, lock)) != 0)
+		devstate_read_unlock(dev);
+
+	return ret;
+}
+
+static inline void taskdev_unlock_and_stateunlock(struct taskdev *dev,
+						      struct mutex *lock)
+{
+	mutex_unlock(lock);
+	devstate_read_unlock(dev);
+}
+
+/*
+ * taskdev_flush_buf()
+ * must be called under state_lock(ATTACHED) and dev->read_mutex.
+ */
+static int taskdev_flush_buf(struct taskdev *dev)
+{
+	u16 ttyp = dev->task->ttyp;
+
+	if (sndtyp_wd(ttyp)) {
+		/* word receiving */
+		kfifo_reset(dev->rcvdt.fifo);
+	} else {
+		/* block receiving */
+		struct rcvdt_bk_struct *rcvdt = &dev->rcvdt.bk;
+
+		if (sndtyp_gbl(ttyp))
+			ipblink_flush(&rcvdt->link);
+		else {
+			ipblink_flush_pvt(&rcvdt->link);
+			release_ipbuf_pvt(dev->task->ipbuf_pvt_r);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * taskdev_set_fifosz()
+ * must be called under dev->read_mutex.
+ */
+static int taskdev_set_fifosz(struct taskdev *dev, unsigned long sz)
+{
+	u16 ttyp = dev->task->ttyp;
+
+	if (!(sndtyp_wd(ttyp) && sndtyp_acv(ttyp))) {
+		printk(KERN_ERR
+		       "omapdsp: buffer size can be changed only for "
+		       "active word sending task.\n");
+		return -EINVAL;
+	}
+	if ((sz == 0) || (sz & 1)) {
+		printk(KERN_ERR "omapdsp: illegal buffer size! (%ld)\n"
+				"it must be even and non-zero value.\n", sz);
+		return -EINVAL;
+	}
+
+	if (kfifo_len(dev->rcvdt.fifo)) {
+		printk(KERN_ERR "omapdsp: buffer is not empty!\n");
+		return -EIO;
+	}
+
+	kfifo_free(dev->rcvdt.fifo);
+	dev->rcvdt.fifo = kfifo_alloc(sz, GFP_KERNEL, &dev->read_lock);
+	if (IS_ERR(dev->rcvdt.fifo)) {
+		printk(KERN_ERR
+		       "omapdsp: unable to change receive buffer size. "
+		       "(%ld bytes for %s)\n", sz, dev->name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static inline int has_taskdev_lock(struct taskdev *dev)
+{
+	return (dev->lock_pid == current->pid);
+}
+
+static int taskdev_lock(struct taskdev *dev)
+{
+	if (mutex_lock_interruptible(&dev->lock))
+		return -EINTR;
+	dev->lock_pid = current->pid;
+	return 0;
+}
+
+static int taskdev_unlock(struct taskdev *dev)
+{
+	if (!has_taskdev_lock(dev)) {
+		printk(KERN_ERR
+		       "omapdsp: an illegal process attempted to "
+		       "unlock the dsptask lock!\n");
+		return -EINVAL;
+	}
+	dev->lock_pid = 0;
+	mutex_unlock(&dev->lock);
+	return 0;
+}
+
+static int dsp_task_config(struct dsptask *task, u8 tid)
+{
+	u16 ttyp;
+	int ret;
+
+	task->tid = tid;
+	dsptask[tid] = task;
+
+	/* TCFG request */
+	task->state = TASK_ST_CFGREQ;
+	if (mutex_lock_interruptible(&cfg_lock)) {
+		ret = -EINTR;
+		goto fail_out;
+	}
+	cfg_cmd = MBOX_CMD_DSP_TCFG;
+	mbcompose_send_and_wait(TCFG, tid, 0, &cfg_wait_q);
+	cfg_cmd = 0;
+	mutex_unlock(&cfg_lock);
+
+	if (task->state != TASK_ST_READY) {
+		printk(KERN_ERR "omapdsp: task %d configuration error!\n", tid);
+		ret = -EINVAL;
+		goto fail_out;
+	}
+
+	if (strlen(task->name) <= 1)
+		sprintf(task->name, "%d", tid);
+	pr_info("omapdsp: task %d: name %s\n", tid, task->name);
+
+	ttyp = task->ttyp;
+
+	/*
+	 * task info sanity check
+	 */
+
+	/* task type check */
+	if (rcvtyp_psv(ttyp) && rcvtyp_pvt(ttyp)) {
+		printk(KERN_ERR "omapdsp: illegal task type(0x%04x), tid=%d\n",
+		       tid, ttyp);
+		ret = -EINVAL;
+		goto fail_out;
+	}
+
+	/* private buffer address check */
+	if (sndtyp_pvt(ttyp) &&
+	    (ipbuf_p_validate(task->ipbuf_pvt_r, DIR_D2A) < 0)) {
+		ret = -EINVAL;
+		goto fail_out;
+	}
+	if (rcvtyp_pvt(ttyp) &&
+	    (ipbuf_p_validate(task->ipbuf_pvt_w, DIR_A2D) < 0)) {
+		ret = -EINVAL;
+		goto fail_out;
+	}
+
+	/* mmap buffer configuration check */
+	if ((task->map_length > 0) &&
+	    ((!ALIGN((unsigned long)task->map_base, PAGE_SIZE)) ||
+	     (!ALIGN(task->map_length, PAGE_SIZE)) ||
+	     (dsp_mem_type(task->map_base, task->map_length) != MEM_TYPE_EXTERN))) {
+		printk(KERN_ERR
+		       "omapdsp: illegal mmap buffer address(0x%p) or "
+		       "length(0x%x).\n"
+		       "  It needs to be page-aligned and located at "
+		       "external memory.\n",
+		       task->map_base, task->map_length);
+		ret = -EINVAL;
+		goto fail_out;
+	}
+
+	return 0;
+
+fail_out:
+	dsptask[tid] = NULL;
+	return ret;
+}
+
+static void dsp_task_init(struct dsptask *task)
+{
+	mbcompose_send(TCTL, task->tid, TCTL_TINIT);
+}
+
+int dsp_task_config_all(u8 n)
+{
+	int i, ret;
+	struct taskdev *devheap;
+	struct dsptask *taskheap;
+	size_t devheapsz, taskheapsz;
+
+	pr_info("omapdsp: found %d task(s)\n", n);
+	if (n == 0)
+		return 0;
+
+	/*
+	 * reducing kmalloc!
+	 */
+	devheapsz  = sizeof(struct taskdev) * n;
+	taskheapsz = sizeof(struct dsptask) * n;
+	heap = kzalloc(devheapsz + taskheapsz, GFP_KERNEL);
+	if (heap == NULL)
+		return -ENOMEM;
+	devheap  = heap;
+	taskheap = heap + devheapsz;
+
+	n_task = n;
+	for (i = 0; i < n; i++) {
+		struct taskdev *dev  = &devheap[i];
+		struct dsptask *task = &taskheap[i];
+
+		if ((ret = dsp_task_config(task, i)) < 0)
+			return ret;
+		if ((ret = taskdev_init(dev, task->name, i)) < 0)
+			return ret;
+		if ((ret = taskdev_attach_task(dev, task)) < 0)
+			return ret;
+		dsp_task_init(task);
+		pr_info("omapdsp: taskdev %s enabled.\n", dev->name);
+	}
+
+	return 0;
+}
+
+static void dsp_task_unconfig(struct dsptask *task)
+{
+	dsptask[task->tid] = NULL;
+}
+
+void dsp_task_unconfig_all(void)
+{
+	unsigned char minor;
+	u8 tid;
+	struct dsptask *task;
+
+	for (minor = 0; minor < n_task; minor++) {
+		/*
+		 * taskdev[minor] can be NULL in case of
+		 * configuration failure
+		 */
+		if (taskdev[minor])
+			taskdev_delete(minor);
+	}
+	for (; minor < TASKDEV_MAX; minor++) {
+		if (taskdev[minor])
+			dsp_rmdev_minor(minor);
+	}
+
+	for (tid = 0; tid < n_task; tid++) {
+		/*
+		 * dsptask[tid] can be NULL in case of
+		 * configuration failure
+		 */
+		task = dsptask[tid];
+		if (task)
+			dsp_task_unconfig(task);
+	}
+	for (; tid < TASKDEV_MAX; tid++) {
+		task = dsptask[tid];
+		if (task) {
+			/*
+			 * on-demand tasks should be deleted in
+			 * rmdev_minor(), but just in case.
+			 */
+			dsp_task_unconfig(task);
+			kfree(task);
+		}
+	}
+
+	if (heap) {
+		kfree(heap);
+		heap = NULL;
+	}
+
+	n_task = 0;
+}
+
+static struct device_driver dsptask_driver = {
+	.name	= "dsptask",
+	.bus	= &dsptask_bus,
+};
+
+u8 dsp_task_count(void)
+{
+	return n_task;
+}
+
+int dsp_taskmod_busy(void)
+{
+	struct taskdev *dev;
+	unsigned char minor;
+	unsigned int usecount;
+
+	for (minor = 0; minor < TASKDEV_MAX; minor++) {
+		dev = taskdev[minor];
+		if (dev == NULL)
+			continue;
+		if ((usecount = dev->usecount) > 0) {
+			printk("dsp_taskmod_busy(): %s: usecount=%d\n",
+			       dev->name, usecount);
+			return 1;
+		}
+/*
+		if ((dev->state & (TASKDEV_ST_ADDREQ |
+				   TASKDEV_ST_DELREQ)) {
+*/
+		if (dev->state & TASKDEV_ST_ADDREQ) {
+			printk("dsp_taskmod_busy(): %s is in %s\n",
+			       dev->name, devstate_name(dev->state));
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/*
+ * DSP task device file operations
+ */
+static ssize_t dsp_task_read_wd_acv(struct file *file, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	struct taskdev *dev = taskdev[minor];
+	int ret = 0;
+	DEFINE_WAIT(wait);
+
+	if (count == 0) {
+		return 0;
+	} else if (count & 0x1) {
+		printk(KERN_ERR
+		       "omapdsp: odd count is illegal for DSP task device.\n");
+		return -EINVAL;
+	}
+
+	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
+		return -ENODEV;
+
+
+	prepare_to_wait(&dev->read_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (kfifo_len(dev->rcvdt.fifo) == 0)
+		schedule();
+	finish_wait(&dev->read_wait_q, &wait);
+	if (kfifo_len(dev->rcvdt.fifo) == 0) {
+		/* failure */
+		if (signal_pending(current))
+			ret = -EINTR;
+		goto up_out;
+	}
+
+
+	ret = kfifo_get_to_user(dev->rcvdt.fifo, buf, count);
+
+ up_out:
+	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
+	return ret;
+}
+
+static ssize_t dsp_task_read_bk_acv(struct file *file, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	struct taskdev *dev = taskdev[minor];
+	struct rcvdt_bk_struct *rcvdt = &dev->rcvdt.bk;
+	ssize_t ret = 0;
+	DEFINE_WAIT(wait);
+
+	if (count == 0) {
+		return 0;
+	} else if (count & 0x1) {
+		printk(KERN_ERR
+		       "omapdsp: odd count is illegal for DSP task device.\n");
+		return -EINVAL;
+	} else if ((int)buf & 0x1) {
+		printk(KERN_ERR
+		       "omapdsp: buf should be word aligned for "
+		       "dsp_task_read().\n");
+		return -EINVAL;
+	}
+
+	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
+		return -ENODEV;
+
+	prepare_to_wait(&dev->read_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (ipblink_empty(&rcvdt->link))
+		schedule();
+	finish_wait(&dev->read_wait_q, &wait);
+	if (ipblink_empty(&rcvdt->link)) {
+		/* failure */
+		if (signal_pending(current))
+			ret = -EINTR;
+		goto up_out;
+	}
+
+	/* copy from delayed IPBUF */
+	if (sndtyp_pvt(dev->task->ttyp)) {
+		/* private */
+		if (!ipblink_empty(&rcvdt->link)) {
+			struct ipbuf_p *ipbp = dev->task->ipbuf_pvt_r;
+			unsigned char *base, *src;
+			size_t bkcnt;
+
+			if (dsp_mem_enable(ipbp) < 0) {
+				ret = -EBUSY;
+				goto up_out;
+			}
+			base = MKVIRT(ipbp->ah, ipbp->al);
+			bkcnt = ((unsigned long)ipbp->c) * 2 - rcvdt->rp;
+			if (dsp_address_validate(base, bkcnt,
+						 "task %s read buffer",
+						 dev->task->name) < 0) {
+				ret = -EINVAL;
+				goto pv_out1;
+			}
+			if (dsp_mem_enable(base) < 0) {
+				ret = -EBUSY;
+				goto pv_out1;
+			}
+			src = base + rcvdt->rp;
+			if (bkcnt > count) {
+				if (copy_to_user_dsp(buf, src, count)) {
+					ret = -EFAULT;
+					goto pv_out2;
+				}
+				ret = count;
+				rcvdt->rp += count;
+			} else {
+				if (copy_to_user_dsp(buf, src, bkcnt)) {
+					ret = -EFAULT;
+					goto pv_out2;
+				}
+				ret = bkcnt;
+				ipblink_del_pvt(&rcvdt->link);
+				release_ipbuf_pvt(ipbp);
+				rcvdt->rp = 0;
+			}
+		pv_out2:
+			dsp_mem_disable(src);
+		pv_out1:
+			dsp_mem_disable(ipbp);
+		}
+	} else {
+		/* global */
+		if (dsp_mem_enable_ipbuf() < 0) {
+			ret = -EBUSY;
+			goto up_out;
+		}
+		while (!ipblink_empty(&rcvdt->link)) {
+			unsigned char *src;
+			size_t bkcnt;
+			struct ipbuf_head *ipb_h = bid_to_ipbuf(rcvdt->link.top);
+
+			src = ipb_h->p->d + rcvdt->rp;
+			bkcnt = ((unsigned long)ipb_h->p->c) * 2 - rcvdt->rp;
+			if (bkcnt > count) {
+				if (copy_to_user_dsp(buf, src, count)) {
+					ret = -EFAULT;
+					goto gb_out;
+				}
+				ret += count;
+				rcvdt->rp += count;
+				break;
+			} else {
+				if (copy_to_user_dsp(buf, src, bkcnt)) {
+					ret = -EFAULT;
+					goto gb_out;
+				}
+				ret += bkcnt;
+				buf += bkcnt;
+				count -= bkcnt;
+				ipblink_del_top(&rcvdt->link);
+				unuse_ipbuf(ipb_h);
+				rcvdt->rp = 0;
+			}
+		}
+	gb_out:
+		dsp_mem_disable_ipbuf();
+	}
+
+ up_out:
+	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
+	return ret;
+}
+
+static ssize_t dsp_task_read_wd_psv(struct file *file, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	struct taskdev *dev = taskdev[minor];
+	int ret = 0;
+
+	if (count == 0) {
+		return 0;
+	} else if (count & 0x1) {
+		printk(KERN_ERR
+		       "omapdsp: odd count is illegal for DSP task device.\n");
+		return -EINVAL;
+	} else {
+		/* force! */
+		count = 2;
+	}
+
+	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
+		return -ENODEV;
+
+	mbcompose_send_and_wait(WDREQ, dev->task->tid, 0, &dev->read_wait_q);
+
+	if (kfifo_len(dev->rcvdt.fifo) == 0) {
+		/* failure */
+		if (signal_pending(current))
+			ret = -EINTR;
+		goto up_out;
+	}
+
+	ret = kfifo_get_to_user(dev->rcvdt.fifo, buf, count);
+
+up_out:
+	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
+	return ret;
+}
+
+static ssize_t dsp_task_read_bk_psv(struct file *file, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	struct taskdev *dev = taskdev[minor];
+	struct rcvdt_bk_struct *rcvdt = &dev->rcvdt.bk;
+	int ret = 0;
+
+	if (count == 0) {
+		return 0;
+	} else if (count & 0x1) {
+		printk(KERN_ERR
+		       "omapdsp: odd count is illegal for DSP task device.\n");
+		return -EINVAL;
+	} else if ((int)buf & 0x1) {
+		printk(KERN_ERR
+		       "omapdsp: buf should be word aligned for "
+		       "dsp_task_read().\n");
+		return -EINVAL;
+	}
+
+	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
+		return -ENODEV;
+
+	mbcompose_send_and_wait(BKREQ, dev->task->tid, count/2,
+				&dev->read_wait_q);
+
+	if (ipblink_empty(&rcvdt->link)) {
+		/* failure */
+		if (signal_pending(current))
+			ret = -EINTR;
+		goto up_out;
+	}
+
+	/*
+	 * We will not receive more than requested count.
+	 */
+	if (sndtyp_pvt(dev->task->ttyp)) {
+		/* private */
+		struct ipbuf_p *ipbp = dev->task->ipbuf_pvt_r;
+		size_t rcvcnt;
+		void *src;
+
+		if (dsp_mem_enable(ipbp) < 0) {
+			ret = -EBUSY;
+			goto up_out;
+		}
+		src = MKVIRT(ipbp->ah, ipbp->al);
+		rcvcnt = ((unsigned long)ipbp->c) * 2;
+		if (dsp_address_validate(src, rcvcnt, "task %s read buffer",
+					 dev->task->name) < 0) {
+			ret = -EINVAL;
+			goto pv_out1;
+		}
+		if (dsp_mem_enable(src) < 0) {
+			ret = -EBUSY;
+			goto pv_out1;
+		}
+		if (count > rcvcnt)
+			count = rcvcnt;
+		if (copy_to_user_dsp(buf, src, count)) {
+			ret = -EFAULT;
+			goto pv_out2;
+		}
+		ipblink_del_pvt(&rcvdt->link);
+		release_ipbuf_pvt(ipbp);
+		ret = count;
+pv_out2:
+		dsp_mem_disable(src);
+pv_out1:
+		dsp_mem_disable(ipbp);
+	} else {
+		/* global */
+		struct ipbuf_head *ipb_h = bid_to_ipbuf(rcvdt->link.top);
+		size_t rcvcnt;
+
+		if (dsp_mem_enable_ipbuf() < 0) {
+			ret = -EBUSY;
+			goto up_out;
+		}
+		rcvcnt = ((unsigned long)ipb_h->p->c) * 2;
+		if (count > rcvcnt)
+			count = rcvcnt;
+		if (copy_to_user_dsp(buf, ipb_h->p->d, count)) {
+			ret = -EFAULT;
+			goto gb_out;
+		}
+		ipblink_del_top(&rcvdt->link);
+		unuse_ipbuf(ipb_h);
+		ret = count;
+gb_out:
+		dsp_mem_disable_ipbuf();
+	}
+
+up_out:
+	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
+	return ret;
+}
+
+static ssize_t dsp_task_write_wd(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	struct taskdev *dev = taskdev[minor];
+	u16 wd;
+	int ret = 0;
+	DEFINE_WAIT(wait);
+
+	if (count == 0) {
+		return 0;
+	} else if (count & 0x1) {
+		printk(KERN_ERR
+		       "omapdsp: odd count is illegal for DSP task device.\n");
+		return -EINVAL;
+	} else {
+		/* force! */
+		count = 2;
+	}
+
+	if (taskdev_lock_and_statelock_attached(dev, &dev->write_mutex))
+		return -ENODEV;
+
+	prepare_to_wait(&dev->write_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (dev->wsz == 0)
+		schedule();
+	finish_wait(&dev->write_wait_q, &wait);
+	if (dev->wsz == 0) {
+		/* failure */
+		if (signal_pending(current))
+			ret = -EINTR;
+		goto up_out;
+	}
+
+	if (copy_from_user(&wd, buf, count)) {
+		ret = -EFAULT;
+		goto up_out;
+	}
+
+	spin_lock(&dev->wsz_lock);
+	if (mbcompose_send(WDSND, dev->task->tid, wd) < 0) {
+		spin_unlock(&dev->wsz_lock);
+		goto up_out;
+	}
+	ret = count;
+	if (rcvtyp_acv(dev->task->ttyp))
+		dev->wsz = 0;
+	spin_unlock(&dev->wsz_lock);
+
+ up_out:
+	taskdev_unlock_and_stateunlock(dev, &dev->write_mutex);
+	return ret;
+}
+
+static ssize_t dsp_task_write_bk(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	struct taskdev *dev = taskdev[minor];
+	int ret = 0;
+	DEFINE_WAIT(wait);
+
+	if (count == 0) {
+		return 0;
+	} else if (count & 0x1) {
+		printk(KERN_ERR
+		       "omapdsp: odd count is illegal for DSP task device.\n");
+		return -EINVAL;
+	} else if ((int)buf & 0x1) {
+		printk(KERN_ERR
+		       "omapdsp: buf should be word aligned for "
+		       "dsp_task_write().\n");
+		return -EINVAL;
+	}
+
+	if (taskdev_lock_and_statelock_attached(dev, &dev->write_mutex))
+		return -ENODEV;
+
+	prepare_to_wait(&dev->write_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (dev->wsz == 0)
+		schedule();
+	finish_wait(&dev->write_wait_q, &wait);
+	if (dev->wsz == 0) {
+		/* failure */
+		if (signal_pending(current))
+			ret = -EINTR;
+		goto up_out;
+	}
+
+	if (count > dev->wsz)
+		count = dev->wsz;
+
+	if (rcvtyp_pvt(dev->task->ttyp)) {
+		/* private */
+		struct ipbuf_p *ipbp = dev->task->ipbuf_pvt_w;
+		unsigned char *dst;
+
+		if (dsp_mem_enable(ipbp) < 0) {
+			ret = -EBUSY;
+			goto up_out;
+		}
+		dst = MKVIRT(ipbp->ah, ipbp->al);
+		if (dsp_address_validate(dst, count, "task %s write buffer",
+					 dev->task->name) < 0) {
+			ret = -EINVAL;
+			goto pv_out1;
+		}
+		if (dsp_mem_enable(dst) < 0) {
+			ret = -EBUSY;
+			goto pv_out1;
+		}
+		if (copy_from_user_dsp(dst, buf, count)) {
+			ret = -EFAULT;
+			goto pv_out2;
+		}
+		ipbp->c = count/2;
+		ipbp->s = dev->task->tid;
+		spin_lock(&dev->wsz_lock);
+		if (mbcompose_send(BKSNDP, dev->task->tid, 0) == 0) {
+			if (rcvtyp_acv(dev->task->ttyp))
+				dev->wsz = 0;
+			ret = count;
+		}
+		spin_unlock(&dev->wsz_lock);
+	pv_out2:
+		dsp_mem_disable(dst);
+	pv_out1:
+		dsp_mem_disable(ipbp);
+	} else {
+		/* global */
+		struct ipbuf_head *ipb_h;
+
+		if (dsp_mem_enable_ipbuf() < 0) {
+			ret = -EBUSY;
+			goto up_out;
+		}
+		if ((ipb_h = get_free_ipbuf(dev->task->tid)) == NULL)
+			goto gb_out;
+		if (copy_from_user_dsp(ipb_h->p->d, buf, count)) {
+			release_ipbuf(ipb_h);
+			ret = -EFAULT;
+			goto gb_out;
+		}
+		ipb_h->p->c  = count/2;
+		ipb_h->p->sa = dev->task->tid;
+		spin_lock(&dev->wsz_lock);
+		if (mbcompose_send(BKSND, dev->task->tid, ipb_h->bid) == 0) {
+			if (rcvtyp_acv(dev->task->ttyp))
+				dev->wsz = 0;
+			ret = count;
+			ipb_bsycnt_inc(&ipbcfg);
+		} else
+			release_ipbuf(ipb_h);
+		spin_unlock(&dev->wsz_lock);
+	gb_out:
+		dsp_mem_disable_ipbuf();
+	}
+
+ up_out:
+	taskdev_unlock_and_stateunlock(dev, &dev->write_mutex);
+	return ret;
+}
+
+static unsigned int dsp_task_poll(struct file * file, poll_table * wait)
+{
+	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	struct taskdev *dev = taskdev[minor];
+	struct dsptask *task = dev->task;
+	unsigned int mask = 0;
+
+	if (!devstate_read_lock_and_test(dev, TASKDEV_ST_ATTACHED))
+		return 0;
+	poll_wait(file, &dev->read_wait_q, wait);
+	poll_wait(file, &dev->write_wait_q, wait);
+	if (sndtyp_psv(task->ttyp) ||
+	    (sndtyp_wd(task->ttyp) && kfifo_len(dev->rcvdt.fifo)) ||
+	    (sndtyp_bk(task->ttyp) && !ipblink_empty(&dev->rcvdt.bk.link)))
+		mask |= POLLIN | POLLRDNORM;
+	if (dev->wsz)
+		mask |= POLLOUT | POLLWRNORM;
+	devstate_read_unlock(dev);
+
+	return mask;
+}
+
+static int dsp_tctl_issue(struct taskdev *dev, u16 cmd, int argc, u16 argv[])
+{
+	int tctl_argc;
+	struct mb_exarg mbarg, *mbargp;
+	int interactive;
+	u8 tid;
+	int ret = 0;
+
+	if (cmd < 0x8000) {
+		/*
+		 * 0x0000 - 0x7fff
+		 * system reserved TCTL commands
+		 */
+		switch (cmd) {
+		case TCTL_TEN:
+		case TCTL_TDIS:
+			tctl_argc = 0;
+			interactive = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	/*
+	 * 0x8000 - 0xffff
+	 * user-defined TCTL commands
+	 */
+	else if (cmd < 0x8100) {
+		/* 0x8000-0x80ff: no arg, non-interactive */
+		tctl_argc = 0;
+		interactive = 0;
+	} else if (cmd < 0x8200) {
+		/* 0x8100-0x81ff: 1 arg, non-interactive */
+		tctl_argc = 1;
+		interactive = 0;
+	} else if (cmd < 0x9000) {
+		/* 0x8200-0x8fff: reserved */
+		return -EINVAL;
+	} else if (cmd < 0x9100) {
+		/* 0x9000-0x90ff: no arg, interactive */
+		tctl_argc = 0;
+		interactive = 1;
+	} else if (cmd < 0x9200) {
+		/* 0x9100-0x91ff: 1 arg, interactive */
+		tctl_argc = 1;
+		interactive = 1;
+	} else {
+		/* 0x9200-0xffff: reserved */
+		return -EINVAL;
+	}
+
+	/*
+	 * if argc < 0, use tctl_argc as is.
+	 * if argc >= 0, check arg count.
+	 */
+	if ((argc >= 0) && (argc != tctl_argc))
+		return -EINVAL;
+
+	/*
+	 * issue TCTL
+	 */
+	if (taskdev_lock_interruptible(dev, &dev->tctl_mutex))
+		return -EINTR;
+
+	tid = dev->task->tid;
+	if (tctl_argc > 0) {
+		mbarg.argc = tctl_argc;
+		mbarg.tid  = tid;
+		mbarg.argv = argv;
+		mbargp = &mbarg;
+	} else
+		mbargp = NULL;
+
+	if (interactive) {
+		dev->tctl_stat = -EINVAL;
+
+		mbcompose_send_and_wait_exarg(TCTL, tid, cmd, mbargp,
+					      &dev->tctl_wait_q);
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			goto up_out;
+		}
+		if ((ret = dev->tctl_stat) < 0) {
+			printk(KERN_ERR "omapdsp: TCTL not responding.\n");
+			goto up_out;
+		}
+	} else
+		mbcompose_send_exarg(TCTL, tid, cmd, mbargp);
+
+up_out:
+	mutex_unlock(&dev->tctl_mutex);
+	return ret;
+}
+
+static int dsp_task_ioctl(struct inode *inode, struct file *file,
+			  unsigned int cmd, unsigned long arg)
+{
+	unsigned int minor = MINOR(inode->i_rdev);
+	struct taskdev *dev = taskdev[minor];
+	int ret;
+
+	if (cmd < 0x10000) {
+		/* issue TCTL */
+		u16 mbargv[1];
+
+		mbargv[0] = arg & 0xffff;
+		return dsp_tctl_issue(dev, cmd, -1, mbargv);
+	}
+
+	/* non TCTL ioctls */
+	switch (cmd) {
+
+	case TASK_IOCTL_LOCK:
+		ret = taskdev_lock(dev);
+		break;
+
+	case TASK_IOCTL_UNLOCK:
+		ret = taskdev_unlock(dev);
+		break;
+
+	case TASK_IOCTL_BFLSH:
+		if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
+			return -ENODEV;
+		ret = taskdev_flush_buf(dev);
+		taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
+		break;
+
+	case TASK_IOCTL_SETBSZ:
+		if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
+			return -ENODEV;
+		ret = taskdev_set_fifosz(dev, arg);
+		taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
+		break;
+
+	case TASK_IOCTL_GETNAME:
+		ret = 0;
+		if (copy_to_user((void __user *)arg, dev->name,
+				 strlen(dev->name) + 1))
+			ret = -EFAULT;
+		break;
+
+	default:
+		ret = -ENOIOCTLCMD;
+
+	}
+
+	return ret;
+}
+
+static void dsp_task_mmap_open(struct vm_area_struct *vma)
+{
+	struct taskdev *dev = (struct taskdev *)vma->vm_private_data;
+	struct dsptask *task;
+	size_t len = vma->vm_end - vma->vm_start;
+
+	BUG_ON(!(dev->state & TASKDEV_ST_ATTACHED));
+	task = dev->task;
+	omap_mmu_exmap_use(&dsp_mmu, task->map_base, len);
+}
+
+static void dsp_task_mmap_close(struct vm_area_struct *vma)
+{
+	struct taskdev *dev = (struct taskdev *)vma->vm_private_data;
+	struct dsptask *task;
+	size_t len = vma->vm_end - vma->vm_start;
+
+	BUG_ON(!(dev->state & TASKDEV_ST_ATTACHED));
+	task = dev->task;
+	omap_mmu_exmap_unuse(&dsp_mmu, task->map_base, len);
+}
+
+/**
+ * On demand page allocation is not allowed. The mapping area is defined by
+ * corresponding DSP tasks.
+ */
+static struct page *dsp_task_mmap_nopage(struct vm_area_struct *vma,
+					 unsigned long address, int *type)
+{
+	return NOPAGE_SIGBUS;
+}
+
+static struct vm_operations_struct dsp_task_vm_ops = {
+	.open = dsp_task_mmap_open,
+	.close = dsp_task_mmap_close,
+	.nopage = dsp_task_mmap_nopage,
+};
+
+static int dsp_task_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	void *tmp_vadr;
+	unsigned long tmp_padr, tmp_vmadr, off;
+	size_t req_len, tmp_len;
+	unsigned int minor = MINOR(filp->f_dentry->d_inode->i_rdev);
+	struct taskdev *dev = taskdev[minor];
+	struct dsptask *task;
+	int ret = 0;
+
+	if (!devstate_read_lock_and_test(dev, TASKDEV_ST_ATTACHED))
+		return -ENODEV;
+	task = dev->task;
+
+	/*
+	 * Don't swap this area out
+	 * Don't dump this area to a core file
+	 */
+	vma->vm_flags |= VM_RESERVED | VM_IO;
+
+	/* Do not cache this area */
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	req_len = vma->vm_end - vma->vm_start;
+	off = vma->vm_pgoff << PAGE_SHIFT;
+	tmp_vmadr = vma->vm_start;
+	tmp_vadr = task->map_base + off;
+	do {
+		tmp_padr = omap_mmu_virt_to_phys(&dsp_mmu, tmp_vadr, &tmp_len);
+		if (tmp_padr == 0) {
+			printk(KERN_ERR
+			       "omapdsp: task %s: illegal address "
+			       "for mmap: %p", task->name, tmp_vadr);
+			/* partial mapping will be cleared in upper layer */
+			ret = -EINVAL;
+			goto unlock_out;
+		}
+		if (tmp_len > req_len)
+			tmp_len = req_len;
+
+		pr_debug("omapdsp: mmap info: "
+			 "vmadr = %08lx, padr = %08lx, len = %x\n",
+			 tmp_vmadr, tmp_padr, tmp_len);
+		if (remap_pfn_range(vma, tmp_vmadr, tmp_padr >> PAGE_SHIFT,
+				    tmp_len, vma->vm_page_prot) != 0) {
+			printk(KERN_ERR
+			       "omapdsp: task %s: remap_page_range() failed.\n",
+			       task->name);
+			/* partial mapping will be cleared in upper layer */
+			ret = -EINVAL;
+			goto unlock_out;
+		}
+
+		req_len   -= tmp_len;
+		tmp_vmadr += tmp_len;
+		tmp_vadr  += tmp_len;
+	} while (req_len);
+
+	vma->vm_ops = &dsp_task_vm_ops;
+	vma->vm_private_data = dev;
+	omap_mmu_exmap_use(&dsp_mmu, task->map_base, vma->vm_end - vma->vm_start);
+
+unlock_out:
+	devstate_read_unlock(dev);
+	return ret;
+}
+
+static int dsp_task_open(struct inode *inode, struct file *file)
+{
+	unsigned int minor = MINOR(inode->i_rdev);
+	struct taskdev *dev;
+	int ret = 0;
+
+	if ((minor >= TASKDEV_MAX) || ((dev = taskdev[minor]) == NULL))
+		return -ENODEV;
+
+ restart:
+	mutex_lock(&dev->usecount_lock);
+	down_write(&dev->state_sem);
+
+	/* state can be NOTASK, ATTACHED/FREEZED, KILLING, GARBAGE or INVALID here. */
+	switch (dev->state & TASKDEV_ST_STATE_MASK) {
+	case TASKDEV_ST_NOTASK:
+		break;
+	case TASKDEV_ST_ATTACHED:
+		goto attached;
+
+	case TASKDEV_ST_INVALID:
+		up_write(&dev->state_sem);
+		mutex_unlock(&dev->usecount_lock);
+		return -ENODEV;
+
+	case TASKDEV_ST_FREEZED:
+	case TASKDEV_ST_KILLING:
+	case TASKDEV_ST_GARBAGE:
+	case TASKDEV_ST_DELREQ:
+		/* on the kill process. wait until it becomes NOTASK. */
+		up_write(&dev->state_sem);
+		mutex_unlock(&dev->usecount_lock);
+		if (devstate_write_lock(dev, TASKDEV_ST_NOTASK) < 0)
+			return -EINTR;
+		devstate_write_unlock(dev);
+		goto restart;
+	}
+
+	/* NOTASK */
+	set_taskdev_state(dev, TASKDEV_ST_ADDREQ);
+	/* wake up twch daemon for tadd */
+	dsp_twch_touch();
+	up_write(&dev->state_sem);
+	if (devstate_write_lock(dev, TASKDEV_ST_ATTACHED |
+				TASKDEV_ST_ADDFAIL) < 0) {
+		/* cancelled */
+		if (!devstate_write_lock_and_test(dev, TASKDEV_ST_ADDREQ)) {
+			mutex_unlock(&dev->usecount_lock);
+			/* out of control ??? */
+			return -EINTR;
+		}
+		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
+		ret = -EINTR;
+		goto change_out;
+	}
+	if (dev->state & TASKDEV_ST_ADDFAIL) {
+		printk(KERN_ERR "omapdsp: task attach failed for %s!\n",
+		       dev->name);
+		ret = -EBUSY;
+		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
+		goto change_out;
+	}
+
+ attached:
+	ret = proc_list_add(&dev->proc_list_lock,
+			    &dev->proc_list, current, file);
+	if (ret)
+		goto out;
+
+	dev->usecount++;
+	file->f_op = &dev->fops;
+	up_write(&dev->state_sem);
+	mutex_unlock(&dev->usecount_lock);
+
+#ifdef DSP_PTE_FREE	/* not used currently. */
+	dsp_map_update(current);
+	dsp_cur_users_add(current);
+#endif /* DSP_PTE_FREE */
+	return 0;
+
+ change_out:
+	wake_up_interruptible_all(&dev->state_wait_q);
+ out:
+	up_write(&dev->state_sem);
+	mutex_unlock(&dev->usecount_lock);
+	return ret;
+}
+
+static int dsp_task_release(struct inode *inode, struct file *file)
+{
+	unsigned int minor = MINOR(inode->i_rdev);
+	struct taskdev *dev = taskdev[minor];
+
+#ifdef DSP_PTE_FREE	/* not used currently. */
+	dsp_cur_users_del(current);
+#endif /* DSP_PTE_FREE */
+
+	if (has_taskdev_lock(dev))
+		taskdev_unlock(dev);
+
+	proc_list_del(&dev->proc_list_lock, &dev->proc_list, current, file);
+	mutex_lock(&dev->usecount_lock);
+	if (--dev->usecount > 0) {
+		/* other processes are using this device. no state change. */
+		mutex_unlock(&dev->usecount_lock);
+		return 0;
+	}
+
+	/* usecount == 0 */
+	down_write(&dev->state_sem);
+
+	/* state can be ATTACHED/FREEZED, KILLING or GARBAGE here. */
+	switch (dev->state & TASKDEV_ST_STATE_MASK) {
+
+	case TASKDEV_ST_KILLING:
+		break;
+
+	case TASKDEV_ST_GARBAGE:
+		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
+		wake_up_interruptible_all(&dev->state_wait_q);
+		break;
+
+	case TASKDEV_ST_ATTACHED:
+	case TASKDEV_ST_FREEZED:
+		if (is_dynamic_task(minor)) {
+			set_taskdev_state(dev, TASKDEV_ST_DELREQ);
+			/* wake up twch daemon for tdel */
+			dsp_twch_touch();
+		}
+		break;
+
+	}
+
+	up_write(&dev->state_sem);
+	mutex_unlock(&dev->usecount_lock);
+	return 0;
+}
+
+/*
+ * mkdev / rmdev
+ */
+int dsp_mkdev(char *name)
+{
+	struct taskdev *dev;
+	int status;
+	unsigned char minor;
+	int ret;
+
+	if (dsp_cfgstat_get_stat() != CFGSTAT_READY) {
+		printk(KERN_ERR "omapdsp: dsp has not been configured.\n");
+		return -EINVAL;
+	}
+
+	if (mutex_lock_interruptible(&devmgr_lock))
+		return -EINTR;
+
+	/* naming check */
+	for (minor = 0; minor < TASKDEV_MAX; minor++) {
+		if (taskdev[minor] && !strcmp(taskdev[minor]->name, name)) {
+			printk(KERN_ERR
+			       "omapdsp: task device name %s is already "
+			       "in use.\n", name);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	/* find free minor number */
+	for (minor = n_task; minor < TASKDEV_MAX; minor++) {
+		if (taskdev[minor] == NULL)
+			goto do_make;
+	}
+	printk(KERN_ERR "omapdsp: Too many task devices.\n");
+	ret = -EBUSY;
+	goto out;
+
+do_make:
+	if ((dev = kzalloc(sizeof(struct taskdev), GFP_KERNEL)) == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	if ((status = taskdev_init(dev, name, minor)) < 0) {
+		kfree(dev);
+		ret = status;
+		goto out;
+	}
+	ret = minor;
+
+out:
+	mutex_unlock(&devmgr_lock);
+	return ret;
+}
+
+int dsp_rmdev(char *name)
+{
+	unsigned char minor;
+	int status;
+	int ret;
+
+	if (dsp_cfgstat_get_stat() != CFGSTAT_READY) {
+		printk(KERN_ERR "omapdsp: dsp has not been configured.\n");
+		return -EINVAL;
+	}
+
+	if (mutex_lock_interruptible(&devmgr_lock))
+		return -EINTR;
+
+	/* find in dynamic devices */
+	for (minor = n_task; minor < TASKDEV_MAX; minor++) {
+		if (taskdev[minor] && !strcmp(taskdev[minor]->name, name))
+			goto do_remove;
+	}
+
+	/* find in static devices */
+	for (minor = 0; minor < n_task; minor++) {
+		if (taskdev[minor] && !strcmp(taskdev[minor]->name, name)) {
+			printk(KERN_ERR
+			       "omapdsp: task device %s is static.\n", name);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	printk(KERN_ERR "omapdsp: task device %s not found.\n", name);
+	return -EINVAL;
+
+do_remove:
+	ret = minor;
+	if ((status = dsp_rmdev_minor(minor)) < 0)
+		ret = status;
+out:
+	mutex_unlock(&devmgr_lock);
+	return ret;
+}
+
+static int dsp_rmdev_minor(unsigned char minor)
+{
+	struct taskdev *dev = taskdev[minor];
+
+	while (!down_write_trylock(&dev->state_sem)) {
+		down_read(&dev->state_sem);
+		if (dev->state & (TASKDEV_ST_ATTACHED |
+				  TASKDEV_ST_FREEZED)) {
+			/*
+			 * task is working. kill it.
+			 * ATTACHED -> FREEZED can be changed under
+			 * down_read of state_sem..
+			 */
+			set_taskdev_state(dev, TASKDEV_ST_FREEZED);
+			wake_up_interruptible_all(&dev->read_wait_q);
+			wake_up_interruptible_all(&dev->write_wait_q);
+			wake_up_interruptible_all(&dev->tctl_wait_q);
+		}
+		up_read(&dev->state_sem);
+		schedule();
+	}
+
+	switch (dev->state & TASKDEV_ST_STATE_MASK) {
+
+	case TASKDEV_ST_NOTASK:
+	case TASKDEV_ST_INVALID:
+		/* fine */
+		goto notask;
+
+	case TASKDEV_ST_ATTACHED:
+	case TASKDEV_ST_FREEZED:
+		/* task is working. kill it. */
+		set_taskdev_state(dev, TASKDEV_ST_KILLING);
+		up_write(&dev->state_sem);
+		dsp_tdel_bh(dev, TDEL_KILL);
+		goto invalidate;
+
+	case TASKDEV_ST_ADDREQ:
+		/* open() is waiting. drain it. */
+		set_taskdev_state(dev, TASKDEV_ST_ADDFAIL);
+		wake_up_interruptible_all(&dev->state_wait_q);
+		break;
+
+	case TASKDEV_ST_DELREQ:
+		/* nobody is waiting. */
+		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
+		wake_up_interruptible_all(&dev->state_wait_q);
+		break;
+
+	case TASKDEV_ST_ADDING:
+	case TASKDEV_ST_DELING:
+	case TASKDEV_ST_KILLING:
+	case TASKDEV_ST_GARBAGE:
+	case TASKDEV_ST_ADDFAIL:
+		/* transient state. wait for a moment. */
+		break;
+
+	}
+
+	up_write(&dev->state_sem);
+
+invalidate:
+	/* wait for some time and hope the state is settled */
+	devstate_read_lock_timeout(dev, TASKDEV_ST_NOTASK, 5 * HZ);
+	if (!(dev->state & TASKDEV_ST_NOTASK)) {
+		printk(KERN_WARNING
+		       "omapdsp: illegal device state (%s) on rmdev %s.\n",
+		       devstate_name(dev->state), dev->name);
+	}
+notask:
+	set_taskdev_state(dev, TASKDEV_ST_INVALID);
+	devstate_read_unlock(dev);
+
+	taskdev_delete(minor);
+	kfree(dev);
+
+	return 0;
+}
+
+static struct file_operations dsp_task_fops = {
+	.owner   = THIS_MODULE,
+	.poll    = dsp_task_poll,
+	.ioctl   = dsp_task_ioctl,
+	.open    = dsp_task_open,
+	.release = dsp_task_release,
+};
+
+static void dsptask_dev_release(struct device *dev)
+{
+}
+
+static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor)
+{
+	int ret;
+	struct device *task_dev;
+
+	taskdev[minor] = dev;
+
+	spin_lock_init(&dev->proc_list_lock);
+	INIT_LIST_HEAD(&dev->proc_list);
+	init_waitqueue_head(&dev->read_wait_q);
+	init_waitqueue_head(&dev->write_wait_q);
+	init_waitqueue_head(&dev->tctl_wait_q);
+	mutex_init(&dev->read_mutex);
+	mutex_init(&dev->write_mutex);
+	mutex_init(&dev->tctl_mutex);
+	mutex_init(&dev->lock);
+	spin_lock_init(&dev->wsz_lock);
+	dev->tctl_ret = -EINVAL;
+	dev->lock_pid = 0;
+
+	strncpy(dev->name, name, TNM_LEN);
+	dev->name[TNM_LEN-1] = '\0';
+	set_taskdev_state(dev, (minor < n_task) ? TASKDEV_ST_ATTACHED : TASKDEV_ST_NOTASK);
+	dev->usecount = 0;
+	mutex_init(&dev->usecount_lock);
+	memcpy(&dev->fops, &dsp_task_fops, sizeof(struct file_operations));
+
+	dev->dev.parent = omap_dsp->dev;
+	dev->dev.bus = &dsptask_bus;
+	sprintf(dev->dev.bus_id, "dsptask%d", minor);
+	dev->dev.release = dsptask_dev_release;
+	ret = device_register(&dev->dev);
+	if (ret) {
+		printk(KERN_ERR "device_register failed: %d\n", ret);
+		return ret;
+	}
+	ret = device_create_file(&dev->dev, &dev_attr_devname);
+	if (ret)
+		goto fail_create_devname;
+	ret = device_create_file(&dev->dev, &dev_attr_devstate);
+	if (ret)
+		goto fail_create_devstate;
+	ret = device_create_file(&dev->dev, &dev_attr_proc_list);
+	if (ret)
+		goto fail_create_proclist;
+
+	task_dev = device_create(dsp_task_class, NULL,
+				 MKDEV(OMAP_DSP_TASK_MAJOR, minor),
+				 "dsptask%d", (int)minor);
+
+	if (unlikely(IS_ERR(task_dev))) {
+		ret = -EINVAL;
+		goto fail_create_taskclass;
+	}
+
+	init_waitqueue_head(&dev->state_wait_q);
+	init_rwsem(&dev->state_sem);
+
+	return 0;
+
+ fail_create_taskclass:
+	device_remove_file(&dev->dev, &dev_attr_proc_list);
+ fail_create_proclist:
+	device_remove_file(&dev->dev, &dev_attr_devstate);
+ fail_create_devstate:
+	device_remove_file(&dev->dev, &dev_attr_devname);
+ fail_create_devname:
+	device_unregister(&dev->dev);
+	return ret;
+}
+
+static void taskdev_delete(unsigned char minor)
+{
+	struct taskdev *dev = taskdev[minor];
+
+	if (!dev)
+		return;
+	device_remove_file(&dev->dev, &dev_attr_devname);
+	device_remove_file(&dev->dev, &dev_attr_devstate);
+	device_remove_file(&dev->dev, &dev_attr_proc_list);
+	device_destroy(dsp_task_class, MKDEV(OMAP_DSP_TASK_MAJOR, minor));
+	device_unregister(&dev->dev);
+	proc_list_flush(&dev->proc_list_lock, &dev->proc_list);
+	taskdev[minor] = NULL;
+}
+
+static int taskdev_attach_task(struct taskdev *dev, struct dsptask *task)
+{
+	u16 ttyp = task->ttyp;
+	int ret;
+
+	dev->fops.read =
+		sndtyp_acv(ttyp) ?
+		sndtyp_wd(ttyp) ? dsp_task_read_wd_acv:
+		/* sndtyp_bk */   dsp_task_read_bk_acv:
+		/* sndtyp_psv */
+		sndtyp_wd(ttyp) ? dsp_task_read_wd_psv:
+		/* sndtyp_bk */   dsp_task_read_bk_psv;
+	if (sndtyp_wd(ttyp)) {
+		/* word */
+		size_t fifosz = sndtyp_psv(ttyp) ? 2:32; /* passive:active */
+
+		dev->rcvdt.fifo = kfifo_alloc(fifosz, GFP_KERNEL,
+					      &dev->read_lock);
+		if (IS_ERR(dev->rcvdt.fifo)) {
+			printk(KERN_ERR
+			       "omapdsp: unable to allocate receive buffer. "
+			       "(%d bytes for %s)\n", fifosz, dev->name);
+			return -ENOMEM;
+		}
+	} else {
+		/* block */
+		INIT_IPBLINK(&dev->rcvdt.bk.link);
+		dev->rcvdt.bk.rp = 0;
+	}
+
+	dev->fops.write =
+		rcvtyp_wd(ttyp) ? dsp_task_write_wd:
+		/* rcvbyp_bk */	  dsp_task_write_bk;
+	dev->wsz = rcvtyp_acv(ttyp) ? 0 :		/* active */
+		rcvtyp_wd(ttyp)  ? 2 :		/* passive word */
+		ipbcfg.lsz*2;	/* passive block */
+
+	if (task->map_length)
+		dev->fops.mmap = dsp_task_mmap;
+
+	ret = device_create_file(&dev->dev, &dev_attr_taskname);
+	if (unlikely(ret))
+		goto fail_create_taskname;
+	ret = device_create_file(&dev->dev, &dev_attr_ttyp);
+	if (unlikely(ret))
+		goto fail_create_ttyp;
+	ret = device_create_file(&dev->dev, &dev_attr_wsz);
+	if (unlikely(ret))
+		goto fail_create_wsz;
+	if (task->map_length) {
+		ret = device_create_file(&dev->dev, &dev_attr_mmap);
+		if (unlikely(ret))
+			goto fail_create_mmap;
+	}
+	if (sndtyp_wd(ttyp)) {
+		ret = device_create_file(&dev->dev, &dev_attr_fifosz);
+		if (unlikely(ret))
+			goto fail_create_fifosz;
+		ret = device_create_file(&dev->dev, &dev_attr_fifocnt);
+		if (unlikely(ret))
+			goto fail_create_fifocnt;
+	} else {
+		ret = device_create_file(&dev->dev, &dev_attr_ipblink);
+		if (unlikely(ret))
+			goto fail_create_ipblink;
+	}
+
+	dev->task = task;
+	task->dev = dev;
+
+	return 0;
+
+ fail_create_fifocnt:
+	device_remove_file(&dev->dev, &dev_attr_fifosz);
+ fail_create_ipblink:
+ fail_create_fifosz:
+	if (task->map_length)
+		device_remove_file(&dev->dev, &dev_attr_mmap);
+ fail_create_mmap:
+	device_remove_file(&dev->dev, &dev_attr_wsz);
+ fail_create_wsz:
+	device_remove_file(&dev->dev, &dev_attr_ttyp);
+ fail_create_ttyp:
+	device_remove_file(&dev->dev, &dev_attr_taskname);
+ fail_create_taskname:
+	if (task->map_length)
+		dev->fops.mmap = NULL;
+
+	dev->fops.write = NULL;
+	dev->wsz = 0;
+
+	dev->fops.read = NULL;
+	taskdev_flush_buf(dev);
+
+	if (sndtyp_wd(ttyp))
+		kfifo_free(dev->rcvdt.fifo);
+
+	dev->task = NULL;
+
+	return ret;
+}
+
+static void taskdev_detach_task(struct taskdev *dev)
+{
+	u16 ttyp = dev->task->ttyp;
+
+	device_remove_file(&dev->dev, &dev_attr_taskname);
+	device_remove_file(&dev->dev, &dev_attr_ttyp);
+	if (sndtyp_wd(ttyp)) {
+		device_remove_file(&dev->dev, &dev_attr_fifosz);
+		device_remove_file(&dev->dev, &dev_attr_fifocnt);
+	} else
+		device_remove_file(&dev->dev, &dev_attr_ipblink);
+	device_remove_file(&dev->dev, &dev_attr_wsz);
+	if (dev->task->map_length) {
+		device_remove_file(&dev->dev, &dev_attr_mmap);
+		dev->fops.mmap = NULL;
+	}
+
+	dev->fops.read = NULL;
+	taskdev_flush_buf(dev);
+	if (sndtyp_wd(ttyp))
+		kfifo_free(dev->rcvdt.fifo);
+
+	dev->fops.write = NULL;
+	dev->wsz = 0;
+
+	pr_info("omapdsp: taskdev %s disabled.\n", dev->name);
+	dev->task = NULL;
+}
+
+/*
+ * tadd / tdel / tkill
+ */
+static int dsp_tadd(struct taskdev *dev, dsp_long_t adr)
+{
+	struct dsptask *task;
+	struct mb_exarg arg;
+	u8 tid, tid_response;
+	u16 argv[2];
+	int ret = 0;
+
+	if (!devstate_write_lock_and_test(dev, TASKDEV_ST_ADDREQ)) {
+		printk(KERN_ERR
+		       "omapdsp: taskdev %s is not requesting for tadd. "
+		       "(state is %s)\n", dev->name, devstate_name(dev->state));
+		return -EINVAL;
+	}
+	set_taskdev_state(dev, TASKDEV_ST_ADDING);
+	devstate_write_unlock(dev);
+
+	if (adr == TADD_ABORTADR) {
+		/* aborting tadd intentionally */
+		pr_info("omapdsp: tadd address is ABORTADR.\n");
+		goto fail_out;
+	}
+	if (adr >= DSPSPACE_SIZE) {
+		printk(KERN_ERR
+		       "omapdsp: illegal address 0x%08x for tadd\n", adr);
+		ret = -EINVAL;
+		goto fail_out;
+	}
+
+	adr >>= 1;	/* word address */
+	argv[0] = adr >> 16;	/* addrh */
+	argv[1] = adr & 0xffff;	/* addrl */
+
+	if (mutex_lock_interruptible(&cfg_lock)) {
+		ret = -EINTR;
+		goto fail_out;
+	}
+	cfg_tid = TID_ANON;
+	cfg_cmd = MBOX_CMD_DSP_TADD;
+	arg.tid  = TID_ANON;
+	arg.argc = 2;
+	arg.argv = argv;
+
+	if (dsp_mem_sync_inc() < 0) {
+		printk(KERN_ERR "omapdsp: memory sync failed!\n");
+		ret = -EBUSY;
+		goto fail_out;
+	}
+	mbcompose_send_and_wait_exarg(TADD, 0, 0, &arg, &cfg_wait_q);
+
+	tid = cfg_tid;
+	cfg_tid = TID_ANON;
+	cfg_cmd = 0;
+	mutex_unlock(&cfg_lock);
+
+	if (tid == TID_ANON) {
+		printk(KERN_ERR "omapdsp: tadd failed!\n");
+		ret = -EINVAL;
+		goto fail_out;
+	}
+	if ((tid < n_task) || dsptask[tid]) {
+		printk(KERN_ERR "omapdsp: illegal tid (%d)!\n", tid);
+		ret = -EINVAL;
+		goto fail_out;
+	}
+	if ((task = kzalloc(sizeof(struct dsptask), GFP_KERNEL)) == NULL) {
+		ret = -ENOMEM;
+		goto del_out;
+	}
+
+	if ((ret = dsp_task_config(task, tid)) < 0)
+		goto free_out;
+
+	if (strcmp(dev->name, task->name)) {
+		printk(KERN_ERR
+		       "omapdsp: task name (%s) doesn't match with "
+		       "device name (%s).\n", task->name, dev->name);
+		ret = -EINVAL;
+		goto free_out;
+	}
+
+	if ((ret = taskdev_attach_task(dev, task)) < 0)
+		goto free_out;
+
+	dsp_task_init(task);
+	pr_info("omapdsp: taskdev %s enabled.\n", dev->name);
+	set_taskdev_state(dev, TASKDEV_ST_ATTACHED);
+	wake_up_interruptible_all(&dev->state_wait_q);
+	return 0;
+
+free_out:
+	kfree(task);
+
+del_out:
+	printk(KERN_ERR "omapdsp: deleting the task...\n");
+
+	set_taskdev_state(dev, TASKDEV_ST_DELING);
+
+	if (mutex_lock_interruptible(&cfg_lock)) {
+		printk(KERN_ERR "omapdsp: aborting tdel process. "
+				"DSP side could be corrupted.\n");
+		goto fail_out;
+	}
+	cfg_tid = TID_ANON;
+	cfg_cmd = MBOX_CMD_DSP_TDEL;
+	mbcompose_send_and_wait(TDEL, tid, TDEL_KILL, &cfg_wait_q);
+	tid_response = cfg_tid;
+	cfg_tid = TID_ANON;
+	cfg_cmd = 0;
+	mutex_unlock(&cfg_lock);
+
+	if (tid_response != tid)
+		printk(KERN_ERR "omapdsp: tdel failed. "
+				"DSP side could be corrupted.\n");
+
+fail_out:
+	set_taskdev_state(dev, TASKDEV_ST_ADDFAIL);
+	wake_up_interruptible_all(&dev->state_wait_q);
+	return ret;
+}
+
+int dsp_tadd_minor(unsigned char minor, dsp_long_t adr)
+{
+	struct taskdev *dev;
+	int status;
+	int ret;
+
+	if (mutex_lock_interruptible(&devmgr_lock))
+		return -EINTR;
+
+	if ((minor >= TASKDEV_MAX) || ((dev = taskdev[minor]) == NULL)) {
+		printk(KERN_ERR
+		       "omapdsp: no task device with minor %d\n", minor);
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = minor;
+	if ((status = dsp_tadd(dev, adr)) < 0)
+		ret = status;
+
+out:
+	mutex_unlock(&devmgr_lock);
+	return ret;
+}
+
+static int dsp_tdel(struct taskdev *dev)
+{
+	if (!devstate_write_lock_and_test(dev, TASKDEV_ST_DELREQ)) {
+		printk(KERN_ERR
+		       "omapdsp: taskdev %s is not requesting for tdel. "
+		       "(state is %s)\n", dev->name, devstate_name(dev->state));
+		return -EINVAL;
+	}
+	set_taskdev_state(dev, TASKDEV_ST_DELING);
+	devstate_write_unlock(dev);
+
+	return dsp_tdel_bh(dev, TDEL_SAFE);
+}
+
+int dsp_tdel_minor(unsigned char minor)
+{
+	struct taskdev *dev;
+	int status;
+	int ret;
+
+	if (mutex_lock_interruptible(&devmgr_lock))
+		return -EINTR;
+
+	if ((minor >= TASKDEV_MAX) || ((dev = taskdev[minor]) == NULL)) {
+		printk(KERN_ERR
+		       "omapdsp: no task device with minor %d\n", minor);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = minor;
+	if ((status = dsp_tdel(dev)) < 0)
+		ret = status;
+
+out:
+	mutex_unlock(&devmgr_lock);
+	return ret;
+}
+
+static int dsp_tkill(struct taskdev *dev)
+{
+	while (!down_write_trylock(&dev->state_sem)) {
+		if (!devstate_read_lock_and_test(dev, (TASKDEV_ST_ATTACHED |
+						       TASKDEV_ST_FREEZED))) {
+			printk(KERN_ERR
+			       "omapdsp: task has not been attached for "
+			       "taskdev %s\n", dev->name);
+			return -EINVAL;
+		}
+		/* ATTACHED -> FREEZED can be changed under read semaphore. */
+		set_taskdev_state(dev, TASKDEV_ST_FREEZED);
+		wake_up_interruptible_all(&dev->read_wait_q);
+		wake_up_interruptible_all(&dev->write_wait_q);
+		wake_up_interruptible_all(&dev->tctl_wait_q);
+		devstate_read_unlock(dev);
+		schedule();
+	}
+
+	if (!(dev->state & (TASKDEV_ST_ATTACHED |
+			    TASKDEV_ST_FREEZED))) {
+		printk(KERN_ERR
+		       "omapdsp: task has not been attached for taskdev %s\n",
+		       dev->name);
+		devstate_write_unlock(dev);
+		return -EINVAL;
+	}
+	if (!is_dynamic_task(dev->task->tid)) {
+		printk(KERN_ERR "omapdsp: task %s is not a dynamic task.\n",
+		       dev->name);
+		devstate_write_unlock(dev);
+		return -EINVAL;
+	}
+	set_taskdev_state(dev, TASKDEV_ST_KILLING);
+	devstate_write_unlock(dev);
+
+	return dsp_tdel_bh(dev, TDEL_KILL);
+}
+
+int dsp_tkill_minor(unsigned char minor)
+{
+	struct taskdev *dev;
+	int status;
+	int ret;
+
+	if (mutex_lock_interruptible(&devmgr_lock))
+		return -EINTR;
+
+	if ((minor >= TASKDEV_MAX) || ((dev = taskdev[minor]) == NULL)) {
+		printk(KERN_ERR
+		       "omapdsp: no task device with minor %d\n", minor);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = minor;
+	if ((status = dsp_tkill(dev)) < 0)
+		ret = status;
+
+out:
+	mutex_unlock(&devmgr_lock);
+	return ret;
+}
+
+static int dsp_tdel_bh(struct taskdev *dev, u16 type)
+{
+	struct dsptask *task;
+	u8 tid, tid_response;
+	int ret = 0;
+
+	task = dev->task;
+	tid = task->tid;
+	if (mutex_lock_interruptible(&cfg_lock)) {
+		if (type == TDEL_SAFE) {
+			set_taskdev_state(dev, TASKDEV_ST_DELREQ);
+			return -EINTR;
+		} else {
+			tid_response = TID_ANON;
+			ret = -EINTR;
+			goto detach_out;
+		}
+	}
+	cfg_tid = TID_ANON;
+	cfg_cmd = MBOX_CMD_DSP_TDEL;
+	mbcompose_send_and_wait(TDEL, tid, type, &cfg_wait_q);
+	tid_response = cfg_tid;
+	cfg_tid = TID_ANON;
+	cfg_cmd = 0;
+	mutex_unlock(&cfg_lock);
+
+detach_out:
+	taskdev_detach_task(dev);
+	dsp_task_unconfig(task);
+	kfree(task);
+
+	if (tid_response != tid) {
+		printk(KERN_ERR "omapdsp: %s failed!\n",
+		       (type == TDEL_SAFE) ? "tdel" : "tkill");
+		ret = -EINVAL;
+	}
+	down_write(&dev->state_sem);
+	set_taskdev_state(dev, (dev->usecount > 0) ? TASKDEV_ST_GARBAGE :
+					   TASKDEV_ST_NOTASK);
+	wake_up_interruptible_all(&dev->state_wait_q);
+	up_write(&dev->state_sem);
+
+	return ret;
+}
+
+/*
+ * state inquiry
+ */
+long taskdev_state_stale(unsigned char minor)
+{
+	if (taskdev[minor]) {
+		long state = taskdev[minor]->state;
+		taskdev[minor]->state |= TASKDEV_ST_STALE;
+		return state;
+	} else
+		return TASKDEV_ST_NOTASK;
+}
+
+/*
+ * functions called from mailbox interrupt routine
+ */
+void mbox_wdsnd(struct mbcmd *mb)
+{
+	unsigned int n;
+	u8 tid = mb->cmd_l;
+	u16 data = mb->data;
+	struct dsptask *task = dsptask[tid];
+
+	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
+		printk(KERN_ERR "mbox: WDSND with illegal tid! %d\n", tid);
+		return;
+	}
+	if (sndtyp_bk(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: WDSND from block sending task! (task%d)\n", tid);
+		return;
+	}
+	if (sndtyp_psv(task->ttyp) &&
+	    !waitqueue_active(&task->dev->read_wait_q)) {
+		printk(KERN_WARNING
+		       "mbox: WDSND from passive sending task (task%d) "
+		       "without request!\n", tid);
+		return;
+	}
+
+	n = kfifo_put(task->dev->rcvdt.fifo, (unsigned char *)&data,
+		      sizeof(data));
+	if (n != sizeof(data))
+		printk(KERN_WARNING "Receive FIFO(%d) is full\n", tid);
+
+	wake_up_interruptible(&task->dev->read_wait_q);
+}
+
+void mbox_wdreq(struct mbcmd *mb)
+{
+	u8 tid = mb->cmd_l;
+	struct dsptask *task = dsptask[tid];
+	struct taskdev *dev;
+
+	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
+		printk(KERN_ERR "mbox: WDREQ with illegal tid! %d\n", tid);
+		return;
+	}
+	if (rcvtyp_psv(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: WDREQ from passive receiving task! (task%d)\n",
+		       tid);
+		return;
+	}
+
+	dev = task->dev;
+	spin_lock(&dev->wsz_lock);
+	dev->wsz = 2;
+	spin_unlock(&dev->wsz_lock);
+	wake_up_interruptible(&dev->write_wait_q);
+}
+
+void mbox_bksnd(struct mbcmd *mb)
+{
+	u8 tid = mb->cmd_l;
+	u16 bid = mb->data;
+	struct dsptask *task = dsptask[tid];
+	struct ipbuf_head *ipb_h;
+	u16 cnt;
+
+	if (bid >= ipbcfg.ln) {
+		printk(KERN_ERR "mbox: BKSND with illegal bid! %d\n", bid);
+		return;
+	}
+	ipb_h = bid_to_ipbuf(bid);
+	ipb_bsycnt_dec(&ipbcfg);
+	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
+		printk(KERN_ERR "mbox: BKSND with illegal tid! %d\n", tid);
+		goto unuse_ipbuf_out;
+	}
+	if (sndtyp_wd(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: BKSND from word sending task! (task%d)\n", tid);
+		goto unuse_ipbuf_out;
+	}
+	if (sndtyp_pvt(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: BKSND from private sending task! (task%d)\n", tid);
+		goto unuse_ipbuf_out;
+	}
+	if (sync_with_dsp(&ipb_h->p->sd, tid, 10) < 0) {
+		printk(KERN_ERR "mbox: BKSND - IPBUF sync failed!\n");
+		return;
+	}
+
+	/* should be done in DSP, but just in case. */
+	ipb_h->p->next = BID_NULL;
+
+	cnt = ipb_h->p->c;
+	if (cnt > ipbcfg.lsz) {
+		printk(KERN_ERR "mbox: BKSND cnt(%d) > ipbuf line size(%d)!\n",
+		       cnt, ipbcfg.lsz);
+		goto unuse_ipbuf_out;
+	}
+
+	if (cnt == 0) {
+		/* 0-byte send from DSP */
+		unuse_ipbuf_nowait(ipb_h);
+		goto done;
+	}
+	ipblink_add_tail(&task->dev->rcvdt.bk.link, bid);
+	/* we keep coming bid and return alternative line to DSP. */
+	balance_ipbuf();
+
+done:
+	wake_up_interruptible(&task->dev->read_wait_q);
+	return;
+
+unuse_ipbuf_out:
+	unuse_ipbuf_nowait(ipb_h);
+	return;
+}
+
+void mbox_bkreq(struct mbcmd *mb)
+{
+	u8 tid = mb->cmd_l;
+	u16 cnt = mb->data;
+	struct dsptask *task = dsptask[tid];
+	struct taskdev *dev;
+
+	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
+		printk(KERN_ERR "mbox: BKREQ with illegal tid! %d\n", tid);
+		return;
+	}
+	if (rcvtyp_wd(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: BKREQ from word receiving task! (task%d)\n", tid);
+		return;
+	}
+	if (rcvtyp_pvt(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: BKREQ from private receiving task! (task%d)\n",
+		       tid);
+		return;
+	}
+	if (rcvtyp_psv(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: BKREQ from passive receiving task! (task%d)\n",
+		       tid);
+		return;
+	}
+
+	dev = task->dev;
+	spin_lock(&dev->wsz_lock);
+	dev->wsz = cnt*2;
+	spin_unlock(&dev->wsz_lock);
+	wake_up_interruptible(&dev->write_wait_q);
+}
+
+void mbox_bkyld(struct mbcmd *mb)
+{
+	u16 bid = mb->data;
+	struct ipbuf_head *ipb_h;
+
+	if (bid >= ipbcfg.ln) {
+		printk(KERN_ERR "mbox: BKYLD with illegal bid! %d\n", bid);
+		return;
+	}
+	ipb_h = bid_to_ipbuf(bid);
+
+	/* should be done in DSP, but just in case. */
+	ipb_h->p->next = BID_NULL;
+
+	/* we don't need to sync with DSP */
+	ipb_bsycnt_dec(&ipbcfg);
+	release_ipbuf(ipb_h);
+}
+
+void mbox_bksndp(struct mbcmd *mb)
+{
+	u8 tid = mb->cmd_l;
+	struct dsptask *task = dsptask[tid];
+	struct ipbuf_p *ipbp;
+
+	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
+		printk(KERN_ERR "mbox: BKSNDP with illegal tid! %d\n", tid);
+		return;
+	}
+	if (sndtyp_wd(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: BKSNDP from word sending task! (task%d)\n", tid);
+		return;
+	}
+	if (sndtyp_gbl(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: BKSNDP from non-private sending task! (task%d)\n",
+		       tid);
+		return;
+	}
+
+	/*
+	 * we should not have delayed block at this point
+	 * because read() routine releases the lock of the buffer and
+	 * until then DSP can't send next data.
+	 */
+
+	ipbp = task->ipbuf_pvt_r;
+	if (sync_with_dsp(&ipbp->s, tid, 10) < 0) {
+		printk(KERN_ERR "mbox: BKSNDP - IPBUF sync failed!\n");
+		return;
+	}
+	pr_debug("mbox: ipbuf_pvt_r->a = 0x%08lx\n",
+	       MKLONG(ipbp->ah, ipbp->al));
+	ipblink_add_pvt(&task->dev->rcvdt.bk.link);
+	wake_up_interruptible(&task->dev->read_wait_q);
+}
+
+void mbox_bkreqp(struct mbcmd *mb)
+{
+	u8 tid = mb->cmd_l;
+	struct dsptask *task = dsptask[tid];
+	struct taskdev *dev;
+	struct ipbuf_p *ipbp;
+
+	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
+		printk(KERN_ERR "mbox: BKREQP with illegal tid! %d\n", tid);
+		return;
+	}
+	if (rcvtyp_wd(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: BKREQP from word receiving task! (task%d)\n", tid);
+		return;
+	}
+	if (rcvtyp_gbl(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: BKREQP from non-private receiving task! (task%d)\n", tid);
+		return;
+	}
+	if (rcvtyp_psv(task->ttyp)) {
+		printk(KERN_ERR
+		       "mbox: BKREQP from passive receiving task! (task%d)\n", tid);
+		return;
+	}
+
+	ipbp = task->ipbuf_pvt_w;
+	if (sync_with_dsp(&ipbp->s, TID_FREE, 10) < 0) {
+		printk(KERN_ERR "mbox: BKREQP - IPBUF sync failed!\n");
+		return;
+	}
+	pr_debug("mbox: ipbuf_pvt_w->a = 0x%08lx\n",
+	       MKLONG(ipbp->ah, ipbp->al));
+	dev = task->dev;
+	spin_lock(&dev->wsz_lock);
+	dev->wsz = ipbp->c*2;
+	spin_unlock(&dev->wsz_lock);
+	wake_up_interruptible(&dev->write_wait_q);
+}
+
+void mbox_tctl(struct mbcmd *mb)
+{
+	u8 tid = mb->cmd_l;
+	struct dsptask *task = dsptask[tid];
+
+	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
+		printk(KERN_ERR "mbox: TCTL with illegal tid! %d\n", tid);
+		return;
+	}
+
+	if (!waitqueue_active(&task->dev->tctl_wait_q)) {
+		printk(KERN_WARNING "mbox: unexpected TCTL from DSP!\n");
+		return;
+	}
+
+	task->dev->tctl_stat = mb->data;
+	wake_up_interruptible(&task->dev->tctl_wait_q);
+}
+
+void mbox_tcfg(struct mbcmd *mb)
+{
+	u8 tid = mb->cmd_l;
+	struct dsptask *task = dsptask[tid];
+	u16 *tnm;
+	volatile u16 *buf;
+	int i;
+
+	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
+		printk(KERN_ERR "mbox: TCFG with illegal tid! %d\n", tid);
+		return;
+	}
+	if ((task->state != TASK_ST_CFGREQ) || (cfg_cmd != MBOX_CMD_DSP_TCFG)) {
+		printk(KERN_WARNING "mbox: unexpected TCFG from DSP!\n");
+		return;
+	}
+
+	if (dsp_mem_enable(ipbuf_sys_da) < 0) {
+		printk(KERN_ERR "mbox: TCFG - ipbuf_sys_da read failed!\n");
+		dsp_mem_disable(ipbuf_sys_da);
+		goto out;
+	}
+	if (sync_with_dsp(&ipbuf_sys_da->s, tid, 10) < 0) {
+		printk(KERN_ERR "mbox: TCFG - IPBUF sync failed!\n");
+		dsp_mem_disable(ipbuf_sys_da);
+		goto out;
+	}
+
+	/*
+	 * read configuration data on system IPBUF
+	 */
+	buf = ipbuf_sys_da->d;
+	task->ttyp        = buf[0];
+	task->ipbuf_pvt_r = MKVIRT(buf[1], buf[2]);
+	task->ipbuf_pvt_w = MKVIRT(buf[3], buf[4]);
+	task->map_base    = MKVIRT(buf[5], buf[6]);
+	task->map_length  = MKLONG(buf[7], buf[8]) << 1;	/* word -> byte */
+	tnm               = MKVIRT(buf[9], buf[10]);
+	release_ipbuf_pvt(ipbuf_sys_da);
+	dsp_mem_disable(ipbuf_sys_da);
+
+	/*
+	 * copy task name string
+	 */
+	if (dsp_address_validate(tnm, TNM_LEN, "task name buffer") < 0) {
+		task->name[0] = '\0';
+		goto out;
+	}
+
+	for (i = 0; i < TNM_LEN-1; i++) {
+		/* avoiding byte access */
+		u16 tmp = tnm[i];
+		task->name[i] = tmp & 0x00ff;
+		if (!tmp)
+			break;
+	}
+	task->name[TNM_LEN-1] = '\0';
+
+	task->state = TASK_ST_READY;
+out:
+	wake_up_interruptible(&cfg_wait_q);
+}
+
+void mbox_tadd(struct mbcmd *mb)
+{
+	u8 tid = mb->cmd_l;
+
+	if ((!waitqueue_active(&cfg_wait_q)) || (cfg_cmd != MBOX_CMD_DSP_TADD)) {
+		printk(KERN_WARNING "mbox: unexpected TADD from DSP!\n");
+		return;
+	}
+	cfg_tid = tid;
+	wake_up_interruptible(&cfg_wait_q);
+}
+
+void mbox_tdel(struct mbcmd *mb)
+{
+	u8 tid = mb->cmd_l;
+
+	if ((!waitqueue_active(&cfg_wait_q)) || (cfg_cmd != MBOX_CMD_DSP_TDEL)) {
+		printk(KERN_WARNING "mbox: unexpected TDEL from DSP!\n");
+		return;
+	}
+	cfg_tid = tid;
+	wake_up_interruptible(&cfg_wait_q);
+}
+
+void mbox_err_fatal(u8 tid)
+{
+	struct dsptask *task = dsptask[tid];
+	struct taskdev *dev;
+
+	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
+		printk(KERN_ERR "mbox: FATAL ERR with illegal tid! %d\n", tid);
+		return;
+	}
+
+	/* wake up waiting processes */
+	dev = task->dev;
+	wake_up_interruptible_all(&dev->read_wait_q);
+	wake_up_interruptible_all(&dev->write_wait_q);
+	wake_up_interruptible_all(&dev->tctl_wait_q);
+}
+
+static u16 *dbg_buf;
+static u16 dbg_buf_sz, dbg_line_sz;
+static int dbg_rp;
+
+int dsp_dbg_config(u16 *buf, u16 sz, u16 lsz)
+{
+#ifdef OLD_BINARY_SUPPORT
+	if ((mbox_revision == MBREV_3_0) || (mbox_revision == MBREV_3_2)) {
+		dbg_buf = NULL;
+		dbg_buf_sz = 0;
+		dbg_line_sz = 0;
+		dbg_rp = 0;
+		return 0;
+	}
+#endif
+
+	if (dsp_address_validate(buf, sz, "debug buffer") < 0)
+		return -1;
+
+	if (lsz > sz) {
+		printk(KERN_ERR
+		       "omapdsp: dbg_buf lsz (%d) is greater than its "
+		       "buffer size (%d)\n", lsz, sz);
+		return -1;
+	}
+
+	dbg_buf = buf;
+	dbg_buf_sz = sz;
+	dbg_line_sz = lsz;
+	dbg_rp = 0;
+
+	return 0;
+}
+
+void dsp_dbg_stop(void)
+{
+	dbg_buf = NULL;
+}
+
+#ifdef OLD_BINARY_SUPPORT
+static void mbox_dbg_old(struct mbcmd *mb);
+#endif
+
+void mbox_dbg(struct mbcmd *mb)
+{
+	u8 tid = mb->cmd_l;
+	int cnt = mb->data;
+	char s[80], *s_end = &s[79], *p;
+	u16 *src;
+	int i;
+
+#ifdef OLD_BINARY_SUPPORT
+	if ((mbox_revision == MBREV_3_0) || (mbox_revision == MBREV_3_2)) {
+		mbox_dbg_old(mb);
+		return;
+	}
+#endif
+
+	if (((tid >= TASKDEV_MAX) || (dsptask[tid] == NULL)) &&
+	    (tid != TID_ANON)) {
+		printk(KERN_ERR "mbox: DBG with illegal tid! %d\n", tid);
+		return;
+	}
+	if (dbg_buf == NULL) {
+		printk(KERN_ERR "mbox: DBG command received, but "
+		       "dbg_buf has not been configured yet.\n");
+		return;
+	}
+
+	if (dsp_mem_enable(dbg_buf) < 0)
+		return;
+
+	src = &dbg_buf[dbg_rp];
+	p = s;
+	for (i = 0; i < cnt; i++) {
+		u16 tmp;
+		/*
+		 * Be carefull that dbg_buf should not be read with
+		 * 1-byte access since it might be placed in DARAM/SARAM
+		 * and it can cause unexpected byteswap.
+		 * For example,
+		 *   *(p++) = *(src++) & 0xff;
+		 * causes 1-byte access!
+		 */
+		tmp = *src++;
+		*(p++) = tmp & 0xff;
+		if (*(p-1) == '\n') {
+			*p = '\0';
+			pr_info("%s", s);
+			p = s;
+			continue;
+		}
+		if (p == s_end) {
+			*p = '\0';
+			pr_info("%s\n", s);
+			p = s;
+			continue;
+		}
+	}
+	if (p > s) {
+		*p = '\0';
+		pr_info("%s\n", s);
+	}
+	if ((dbg_rp += cnt + 1) > dbg_buf_sz - dbg_line_sz)
+		dbg_rp = 0;
+
+	dsp_mem_disable(dbg_buf);
+}
+
+#ifdef OLD_BINARY_SUPPORT
+static void mbox_dbg_old(struct mbcmd *mb)
+{
+	u8 tid = mb->cmd_l;
+	char s[80], *s_end = &s[79], *p;
+	u16 *src;
+	volatile u16 *buf;
+	int cnt;
+	int i;
+
+	if (((tid >= TASKDEV_MAX) || (dsptask[tid] == NULL)) &&
+	    (tid != TID_ANON)) {
+		printk(KERN_ERR "mbox: DBG with illegal tid! %d\n", tid);
+		return;
+	}
+	if (dsp_mem_enable(ipbuf_sys_da) < 0) {
+		printk(KERN_ERR "mbox: DBG - ipbuf_sys_da read failed!\n");
+		return;
+	}
+	if (sync_with_dsp(&ipbuf_sys_da->s, tid, 10) < 0) {
+		printk(KERN_ERR "mbox: DBG - IPBUF sync failed!\n");
+		goto out1;
+	}
+	buf = ipbuf_sys_da->d;
+	cnt = buf[0];
+	src = MKVIRT(buf[1], buf[2]);
+	if (dsp_address_validate(src, cnt, "dbg buffer") < 0)
+		goto out2;
+
+	if (dsp_mem_enable(src) < 0)
+		goto out2;
+
+	p = s;
+	for (i = 0; i < cnt; i++) {
+		u16 tmp;
+		/*
+		 * Be carefull that ipbuf should not be read with
+		 * 1-byte access since it might be placed in DARAM/SARAM
+		 * and it can cause unexpected byteswap.
+		 * For example,
+		 *   *(p++) = *(src++) & 0xff;
+		 * causes 1-byte access!
+		 */
+		tmp = *src++;
+		*(p++) = tmp & 0xff;
+		if (*(p-1) == '\n') {
+			*p = '\0';
+			pr_info("%s", s);
+			p = s;
+			continue;
+		}
+		if (p == s_end) {
+			*p = '\0';
+			pr_info("%s\n", s);
+			p = s;
+			continue;
+		}
+	}
+	if (p > s) {
+		*p = '\0';
+		pr_info("%s\n", s);
+	}
+
+	dsp_mem_disable(src);
+out2:
+	release_ipbuf_pvt(ipbuf_sys_da);
+out1:
+	dsp_mem_disable(ipbuf_sys_da);
+}
+#endif /* OLD_BINARY_SUPPORT */
+
+/*
+ * sysfs files: for each device
+ */
+
+/* devname */
+static ssize_t devname_show(struct device *d, struct device_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "%s\n", to_taskdev(d)->name);
+}
+
+/* devstate */
+static ssize_t devstate_show(struct device *d, struct device_attribute *attr,
+			     char *buf)
+{
+	return sprintf(buf, "%s\n", devstate_name(to_taskdev(d)->state));
+}
+
+/* proc_list */
+static ssize_t proc_list_show(struct device *d, struct device_attribute *attr,
+			      char *buf)
+{
+	struct taskdev *dev;
+	struct proc_list *pl;
+	int len = 0;
+
+	dev = to_taskdev(d);
+	spin_lock(&dev->proc_list_lock);
+	list_for_each_entry(pl, &dev->proc_list, list_head) {
+		/* need to lock tasklist_lock before calling
+		 * find_task_by_pid_type. */
+		if (find_task_by_pid(pl->pid) != NULL)
+			len += sprintf(buf + len, "%d\n", pl->pid);
+		read_unlock(&tasklist_lock);
+	}
+	spin_unlock(&dev->proc_list_lock);
+
+	return len;
+}
+
+/* taskname */
+static ssize_t taskname_show(struct device *d, struct device_attribute *attr,
+			     char *buf)
+{
+	struct taskdev *dev = to_taskdev(d);
+	int len;
+
+	if (!devstate_read_lock_and_test(dev, TASKDEV_ST_ATTACHED))
+		return -ENODEV;
+
+	len = sprintf(buf, "%s\n", dev->task->name);
+
+	devstate_read_unlock(dev);
+	return len;
+}
+
+/* ttyp */
+static ssize_t ttyp_show(struct device *d, struct device_attribute *attr,
+			 char *buf)
+{
+	struct taskdev *dev = to_taskdev(d);
+	u16 ttyp;
+	int len = 0;
+
+	if (!devstate_read_lock_and_test(dev, TASKDEV_ST_ATTACHED))
+		return -ENODEV;
+
+	ttyp = dev->task->ttyp;
+	len += sprintf(buf + len, "0x%04x\n", ttyp);
+	len += sprintf(buf + len, "%s %s send\n",
+			(sndtyp_acv(ttyp)) ? "active" :
+					     "passive",
+			(sndtyp_wd(ttyp))  ? "word" :
+			(sndtyp_pvt(ttyp)) ? "private block" :
+					     "global block");
+	len += sprintf(buf + len, "%s %s receive\n",
+			(rcvtyp_acv(ttyp)) ? "active" :
+					     "passive",
+			(rcvtyp_wd(ttyp))  ? "word" :
+			(rcvtyp_pvt(ttyp)) ? "private block" :
+					     "global block");
+
+	devstate_read_unlock(dev);
+	return len;
+}
+
+/* fifosz */
+static ssize_t fifosz_show(struct device *d, struct device_attribute *attr,
+			   char *buf)
+{
+	struct kfifo *fifo = to_taskdev(d)->rcvdt.fifo;
+	return sprintf(buf, "%d\n", fifo->size);
+}
+
+static int fifosz_store(struct device *d, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct taskdev *dev = to_taskdev(d);
+	unsigned long fifosz;
+	int ret;
+
+	fifosz = simple_strtol(buf, NULL, 10);
+	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
+		return -ENODEV;
+	ret = taskdev_set_fifosz(dev, fifosz);
+	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
+
+	return (ret < 0) ? ret : strlen(buf);
+}
+
+/* fifocnt */
+static ssize_t fifocnt_show(struct device *d, struct device_attribute *attr,
+			    char *buf)
+{
+	struct kfifo *fifo = to_taskdev(d)->rcvdt.fifo;
+	return sprintf(buf, "%d\n", fifo->size);
+}
+
+/* ipblink */
+static inline char *bid_name(u16 bid)
+{
+	static char s[6];
+
+	switch (bid) {
+	case BID_NULL:
+		return "NULL";
+	case BID_PVT:
+		return "PRIVATE";
+	default:
+		sprintf(s, "%d", bid);
+		return s;
+	}
+}
+
+static ssize_t ipblink_show(struct device *d, struct device_attribute *attr,
+			    char *buf)
+{
+	struct rcvdt_bk_struct *rcvdt = &to_taskdev(d)->rcvdt.bk;
+	int len;
+
+	spin_lock(&rcvdt->link.lock);
+	len = sprintf(buf, "top  %s\ntail %s\n",
+		      bid_name(rcvdt->link.top), bid_name(rcvdt->link.tail));
+	spin_unlock(&rcvdt->link.lock);
+
+	return len;
+}
+
+/* wsz */
+static ssize_t wsz_show(struct device *d, struct device_attribute *attr,
+			char *buf)
+{
+	return sprintf(buf, "%d\n", to_taskdev(d)->wsz);
+}
+
+/* mmap */
+static ssize_t mmap_show(struct device *d, struct device_attribute *attr,
+			 char *buf)
+{
+	struct dsptask *task = to_taskdev(d)->task;
+	return sprintf(buf, "0x%p 0x%x\n", task->map_base, task->map_length);
+}
+
+/*
+ * called from ipbuf_show()
+ */
+int ipbuf_is_held(u8 tid, u16 bid)
+{
+	struct dsptask *task = dsptask[tid];
+	struct ipblink *link;
+	u16 b;
+	int ret = 0;
+
+	if (task == NULL)
+		return 0;
+
+	link = &task->dev->rcvdt.bk.link;
+	spin_lock(&link->lock);
+	ipblink_for_each(b, link) {
+		if (b == bid) {	/* found */
+			ret = 1;
+			break;
+		}
+	}
+	spin_unlock(&link->lock);
+
+	return ret;
+}
+
+int __init dsp_taskmod_init(void)
+{
+	int retval;
+
+	memset(taskdev, 0, sizeof(void *) * TASKDEV_MAX);
+	memset(dsptask, 0, sizeof(void *) * TASKDEV_MAX);
+
+	retval = register_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask",
+				 &dsp_task_fops);
+	if (retval < 0) {
+		printk(KERN_ERR
+		       "omapdsp: failed to register task device: %d\n", retval);
+		return retval;
+	}
+
+	retval = bus_register(&dsptask_bus);
+	if (retval) {
+		printk(KERN_ERR
+		       "omapdsp: failed to register DSP task bus: %d\n",
+		       retval);
+		unregister_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask");
+		return -EINVAL;
+	}
+	retval = driver_register(&dsptask_driver);
+	if (retval) {
+		printk(KERN_ERR
+		       "omapdsp: failed to register DSP task driver: %d\n",
+		       retval);
+		bus_unregister(&dsptask_bus);
+		unregister_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask");
+		return -EINVAL;
+	}
+	dsp_task_class = class_create(THIS_MODULE, "dsptask");
+	if (IS_ERR(dsp_task_class)) {
+		printk(KERN_ERR "omapdsp: failed to create DSP task class\n");
+		driver_unregister(&dsptask_driver);
+		bus_unregister(&dsptask_bus);
+		unregister_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void dsp_taskmod_exit(void)
+{
+	class_destroy(dsp_task_class);
+	driver_unregister(&dsptask_driver);
+	bus_unregister(&dsptask_bus);
+	unregister_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask");
+}
diff --git a/drivers/dsp/dspgateway/taskwatch.c b/drivers/dsp/dspgateway/taskwatch.c
new file mode 100644
index 0000000..4297b51
--- /dev/null
+++ b/drivers/dsp/dspgateway/taskwatch.c
@@ -0,0 +1,163 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/sched.h>
+#include <asm/uaccess.h>
+#include <asm/arch/dsp.h>
+#include "dsp_mbcmd.h"
+#include "dsp.h"
+
+static DECLARE_WAIT_QUEUE_HEAD(read_wait_q);
+static unsigned int change_cnt;
+
+void dsp_twch_touch(void)
+{
+	change_cnt++;
+	wake_up_interruptible(&read_wait_q);
+}
+
+/*
+ * @count: represents the device counts of the user's interst
+ */
+static ssize_t dsp_twch_read(struct file *file, char __user *buf, size_t count,
+			     loff_t *ppos)
+{
+	long taskstat[TASKDEV_MAX];
+	int devcount = count / sizeof(long);
+	int i;
+	DEFINE_WAIT(wait);
+
+	if (dsp_cfgstat_get_stat() != CFGSTAT_READY) {
+		printk(KERN_ERR "omapdsp: dsp has not been configured.\n");
+		return -EINVAL;
+	}
+
+	prepare_to_wait(&read_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (change_cnt == 0)	/* last check */
+		schedule();
+	finish_wait(&read_wait_q, &wait);
+
+	/* unconfigured while waiting ;-( */
+	if ((change_cnt == 0) && (dsp_cfgstat_get_stat() != CFGSTAT_READY))
+		return -EINVAL;
+
+	if (devcount > TASKDEV_MAX)
+		devcount = TASKDEV_MAX;
+
+	count = devcount * sizeof(long);
+	change_cnt = 0;
+	for (i = 0; i < devcount; i++) {
+		/*
+		 * once the device state is read, the 'STALE' bit will be set
+		 * so that the Dynamic Loader can distinguish the new request
+		 * from the old one.
+		 */
+		taskstat[i] = taskdev_state_stale(i);
+	}
+
+	if (copy_to_user(buf, taskstat, count))
+		return -EFAULT;
+
+	return count;
+}
+
+static unsigned int dsp_twch_poll(struct file *file, poll_table *wait)
+{
+	unsigned int mask = 0;
+
+	poll_wait(file, &read_wait_q, wait);
+	if (change_cnt)
+		mask |= POLLIN | POLLRDNORM;
+
+	return mask;
+}
+
+static int dsp_twch_ioctl(struct inode *inode, struct file *file,
+			  unsigned int cmd, unsigned long arg)
+{
+	int ret;
+
+	switch (cmd) {
+	case TWCH_IOCTL_MKDEV:
+		{
+			char name[TNM_LEN];
+			if (copy_from_user(name, (void __user *)arg, TNM_LEN))
+				return -EFAULT;
+			name[TNM_LEN-1] = '\0';
+			ret = dsp_mkdev(name);
+			break;
+		}
+
+	case TWCH_IOCTL_RMDEV:
+		{
+			char name[TNM_LEN];
+			if (copy_from_user(name, (void __user *)arg, TNM_LEN))
+				return -EFAULT;
+			name[TNM_LEN-1] = '\0';
+			ret = dsp_rmdev(name);
+			break;
+		}
+
+	case TWCH_IOCTL_TADD:
+		{
+			struct omap_dsp_taddinfo ti;
+			if (copy_from_user(&ti, (void __user *)arg, sizeof(ti)))
+				return -EFAULT;
+			ret = dsp_tadd_minor(ti.minor, ti.taskadr);
+			break;
+		}
+
+	case TWCH_IOCTL_TDEL:
+		ret = dsp_tdel_minor(arg);
+		break;
+
+	case TWCH_IOCTL_TKILL:
+		ret = dsp_tkill_minor(arg);
+		break;
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return ret;
+}
+
+struct file_operations dsp_twch_fops = {
+	.owner = THIS_MODULE,
+	.read  = dsp_twch_read,
+	.poll  = dsp_twch_poll,
+	.ioctl = dsp_twch_ioctl,
+};
+
+void dsp_twch_start(void)
+{
+	change_cnt = 1;		/* first read will not wait */
+}
+
+void dsp_twch_stop(void)
+{
+	wake_up_interruptible(&read_wait_q);
+}
diff --git a/drivers/dsp/dspgateway/uaccess_dsp.S b/drivers/dsp/dspgateway/uaccess_dsp.S
new file mode 100644
index 0000000..bcf4a54
--- /dev/null
+++ b/drivers/dsp/dspgateway/uaccess_dsp.S
@@ -0,0 +1,77 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2004-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+		.text
+
+/* Prototype: int __copy_to_user_dsp_2b(void *to, const char *from)
+ * Purpose  : copy 2 bytes to user memory from kernel(DSP) memory
+ *            escaping from unexpected byte swap using __copy_to_user()
+ *            in OMAP architecture.
+ * Params   : to   - user memory
+ *          : from - kernel(DSP) memory
+ * Returns  : success = 0, failure = 2
+ */
+
+ENTRY(__copy_to_user_dsp_2b)
+		stmfd	sp!, {r4, lr}
+		ldrb	r3, [r1], #1
+		ldrb	r4, [r1], #1
+USER(		strbt	r4, [r0], #1)			@ May fault
+USER(		strbt	r3, [r0], #1)			@ May fault
+		mov	r0, #0
+		ldmfd	sp!, {r4, pc}
+
+		.section .fixup,"ax"
+		.align	0
+9001:		mov	r0, #2
+		ldmfd	sp!, {r4, pc}
+		.previous
+
+/* Prototype: unsigned long __copy_from_user_dsp_2b(void *to, const void *from);
+ * Purpose  : copy 2 bytes from user memory to kernel(DSP) memory
+ *            escaping from unexpected byte swap using __copy_to_user()
+ *            in OMAP architecture.
+ * Params   : to   - kernel (DSP) memory
+ *          : from - user memory
+ * Returns  : success = 0, failure = 2
+ */
+
+ENTRY(__copy_from_user_dsp_2b)
+		stmfd	sp!, {r4, lr}
+USER(		ldrbt	r3, [r1], #1)			@ May fault
+USER(		ldrbt	r4, [r1], #1)			@ May fault
+		strb	r4, [r0], #1
+		strb	r3, [r0], #1
+		mov	r0, #0
+		ldmfd	sp!, {r4, pc}
+
+		.section .fixup,"ax"
+		.align	0
+9001:		mov	r3, #0
+		strh	r3, [r0], #2
+		mov	r0, #2
+		ldmfd	sp!, {r4, pc}
+		.previous
diff --git a/drivers/dsp/dspgateway/uaccess_dsp.h b/drivers/dsp/dspgateway/uaccess_dsp.h
new file mode 100644
index 0000000..028814f
--- /dev/null
+++ b/drivers/dsp/dspgateway/uaccess_dsp.h
@@ -0,0 +1,176 @@
+/*
+ * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef _OMAP_DSP_UACCESS_DSP_H
+#define _OMAP_DSP_UACCESS_DSP_H
+
+#include <asm/uaccess.h>
+#include <asm/arch/dsp_common.h>
+#include "dsp.h"
+
+#define HAVE_ASM_COPY_FROM_USER_DSP_2B
+
+#ifdef HAVE_ASM_COPY_FROM_USER_DSP_2B
+extern unsigned long __copy_from_user_dsp_2b(void *to,
+						  const void __user *from);
+extern unsigned long __copy_to_user_dsp_2b(void __user *to,
+						const void *from);
+#endif
+
+#ifndef HAVE_ASM_COPY_FROM_USER_DSP_2B
+static inline unsigned long copy_from_user_dsp_2b(void *to,
+						      const void *from)
+{
+	unsigned short tmp;
+
+	if (__copy_from_user(&tmp, from, 2))
+		return 2;
+	/* expecting compiler to generate "strh" instruction */
+	*((unsigned short *)to) = tmp;
+	return 0;
+}
+#endif
+
+/*
+ * @n must be multiple of 2
+ */
+static inline unsigned long copy_from_user_dsp(void *to, const void *from,
+						   unsigned long n)
+{
+	if (access_ok(VERIFY_READ, from, n)) {
+		if ((is_dsp_internal_mem(to)) &&
+		    (((unsigned long)to & 2) || (n & 2))) {
+			/*
+			 * DARAM/SARAM with odd word alignment
+			 */
+			unsigned long n4;
+			unsigned long last_n;
+
+			/* dest not aligned -- copy 2 bytes */
+			if (((unsigned long)to & 2) && (n >= 2)) {
+#ifdef HAVE_ASM_COPY_FROM_USER_DSP_2B
+				if (__copy_from_user_dsp_2b(to, from))
+#else
+				if (copy_from_user_dsp_2b(to, from))
+#endif
+					return n;
+				to += 2;
+				from += 2;
+				n -= 2;
+			}
+			/* middle 4*n bytes */
+			last_n = n & 2;
+			n4 = n - last_n;
+			if ((n = __copy_from_user(to, from, n4)) != 0)
+				return n + last_n;
+			/* last 2 bytes */
+			if (last_n) {
+				to += n4;
+				from += n4;
+#ifdef HAVE_ASM_COPY_FROM_USER_DSP_2B
+				if (__copy_from_user_dsp_2b(to, from))
+#else
+				if (copy_from_user_dsp_2b(to, from))
+#endif
+					return 2;
+				n = 0;
+			}
+		} else {
+			/*
+			 * DARAM/SARAM with 4-byte alignment or
+			 * external memory
+			 */
+			n = __copy_from_user(to, from, n);
+		}
+	}
+	else	/* security hole - plug it */
+		memzero(to, n);
+	return n;
+}
+
+#ifndef HAVE_ASM_COPY_FROM_USER_DSP_2B
+static inline unsigned long copy_to_user_dsp_2b(void *to, const void *from)
+{
+	/* expecting compiler to generate "strh" instruction */
+	unsigned short tmp = *(unsigned short *)from;
+
+	return __copy_to_user(to, &tmp, 2);
+}
+#endif
+
+/*
+ * @n must be multiple of 2
+ */
+static inline unsigned long copy_to_user_dsp(void *to, const void *from,
+						 unsigned long n)
+{
+	if (access_ok(VERIFY_WRITE, to, n)) {
+		if ((is_dsp_internal_mem(from)) &&
+		    (((unsigned long)to & 2) || (n & 2))) {
+			/*
+			 * DARAM/SARAM with odd word alignment
+			 */
+			unsigned long n4;
+			unsigned long last_n;
+
+			/* dest not aligned -- copy 2 bytes */
+			if (((unsigned long)to & 2) && (n >= 2)) {
+#ifdef HAVE_ASM_COPY_FROM_USER_DSP_2B
+				if (__copy_to_user_dsp_2b(to, from))
+#else
+				if (copy_to_user_dsp_2b(to, from))
+#endif
+					return n;
+				to += 2;
+				from += 2;
+				n -= 2;
+			}
+			/* middle 4*n bytes */
+			last_n = n & 2;
+			n4 = n - last_n;
+			if ((n = __copy_to_user(to, from, n4)) != 0)
+				return n + last_n;
+			/* last 2 bytes */
+			if (last_n) {
+				to += n4;
+				from += n4;
+#ifdef HAVE_ASM_COPY_FROM_USER_DSP_2B
+				if (__copy_to_user_dsp_2b(to, from))
+#else
+				if (copy_to_user_dsp_2b(to, from))
+#endif
+					return 2;
+				n = 0;
+			}
+		} else {
+			/*
+			 * DARAM/SARAM with 4-byte alignment or
+			 * external memory
+			 */
+			n = __copy_to_user(to, from, n);
+		}
+	}
+	return n;
+}
+
+#endif /* _OMAP_DSP_UACCESS_DSP_H */
diff --git a/include/asm-arm/arch-omap/mmu.h b/include/asm-arm/arch-omap/mmu.h
index 6c5869c..714ee1d 100644
--- a/include/asm-arm/arch-omap/mmu.h
+++ b/include/asm-arm/arch-omap/mmu.h
@@ -59,6 +59,16 @@ struct omap_mmu_tlb_lock {
 struct omap_mmu;
 struct omap_mmu_tlb_entry;
 
+#ifdef CONFIG_ARCH_OMAP1
+extern struct omap_mmu_ops omap1_mmu_ops;
+extern void omap_mmu_itack(struct omap_mmu *mmu);
+#elif defined(CONFIG_ARCH_OMAP2)
+extern struct omap_mmu_ops omap2_mmu_ops;
+static inline void omap_mmu_itack(struct omap_mmu *mmu)
+{
+}
+#endif
+
 struct omap_mmu_ops {
 	int (*startup)(struct omap_mmu *mmu);
 	void (*shutdown)(struct omap_mmu *mmu);
-- 
1.5.3.6.GIT


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--aVD9QWMuhilNxW9f--
