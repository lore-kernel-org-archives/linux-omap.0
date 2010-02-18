From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 10/12] DSPBRIDGE: Remove custom debugging implementation
Date: Thu, 18 Feb 2010 15:38:01 -0600
Message-ID: <1266529083-2358-11-git-send-email-omar.ramirez@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46722 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756070Ab0BRVZ3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 16:25:29 -0500
In-Reply-To: <1266529083-2358-10-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Replace custom debug implementation with a friendly set
of pr_err, pr_info and dev_dbg messages.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbg.h |   65 ------
 arch/arm/plat-omap/include/dspbridge/gt.h  |  271 ----------------------
 drivers/dsp/bridge/Makefile                |    4 +-
 drivers/dsp/bridge/gen/_gt_para.c          |   95 --------
 drivers/dsp/bridge/gen/gt.c                |  336 ----------------------------
 drivers/dsp/bridge/rmgr/drv_interface.c    |   16 --
 drivers/dsp/bridge/services/dbg.c          |   81 -------
 drivers/dsp/bridge/services/services.c     |   13 +-
 8 files changed, 4 insertions(+), 877 deletions(-)
 delete mode 100644 drivers/dsp/bridge/gen/_gt_para.c
 delete mode 100644 drivers/dsp/bridge/gen/gt.c
 delete mode 100644 drivers/dsp/bridge/services/dbg.c

diff --git a/arch/arm/plat-omap/include/dspbridge/dbg.h b/arch/arm/plat-omap/include/dspbridge/dbg.h
index 4d01eca..828fd71 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbg.h
@@ -21,69 +21,4 @@
 #include <dspbridge/host_os.h>
 #include <linux/types.h>
 
-/* Levels of trace debug messages: */
-#define DBG_ENTER   (u8)(0x01)	/* Function entry point. */
-#define DBG_LEVEL1  (u8)(0x02)	/* Display debugging state/varibles */
-#define DBG_LEVEL2  (u8)(0x04)	/* Display debugging state/varibles */
-#define DBG_LEVEL3  (u8)(0x08)	/* Display debugging state/varibles */
-#define DBG_LEVEL4  (u8)(0x10)	/* Display debugging state/varibles */
-#define DBG_LEVEL5  (u8)(0x20)	/* Module Init, Exit */
-#define DBG_LEVEL6  (u8)(0x40)	/* Warn SERVICES Failures */
-#define DBG_LEVEL7  (u8)(0x80)	/* Warn Critical Errors */
-
-#if (defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
-
-/*
- *  ======== DBG_Exit ========
- *  Purpose:
- *      Discontinue usage of module; free resources when reference count
- *      reaches 0.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      DBG initialized.
- *  Ensures:
- *      Resources used by module are freed when cRef reaches zero.
- */
-	extern void DBG_Exit(void);
-
-/*
- *  ======== DBG_Init ========
- *  Purpose:
- *      Initializes private state of DBG module.
- *  Parameters:
- *  Returns:
- *      TRUE if initialized; FALSE if error occured.
- *  Requires:
- *  Ensures:
- */
-	extern bool DBG_Init(void);
-
-/*
- *  ======== DBG_Trace ========
- *  Purpose:
- *      Output a trace message to the debugger, if the given trace level
- *      is unmasked.
- *  Parameters:
- *      bLevel:         Trace level.
- *      pstrFormat:     sprintf-style format string.
- *      ...:            Arguments for format string.
- *  Returns:
- *      DSP_SOK:        Success, or trace level masked.
- *      DSP_EFAIL:      On Error.
- *  Requires:
- *      DBG initialized.
- *  Ensures:
- *      Debug message is printed to debugger output window, if trace level
- *      is unmasked.
- */
-	extern DSP_STATUS DBG_Trace(IN u8 bLevel, IN char *pstrFormat, ...);
-#else
-
-#define DBG_Exit(void) do {} while (0)
-#define DBG_Init(void) true
-#define DBG_Trace(bLevel, pstrFormat, args...) do {} while (0)
-
-#endif	/* (CONFIG_BRIDGE_DEBUG || DDSP_DEBUG_PRODUCT) && GT_TRACE */
-
 #endif				/* DBG_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/gt.h b/arch/arm/plat-omap/include/dspbridge/gt.h
index 9097910..116bb6f 100644
--- a/arch/arm/plat-omap/include/dspbridge/gt.h
+++ b/arch/arm/plat-omap/include/dspbridge/gt.h
@@ -34,275 +34,4 @@
 
 #include <dspbridge/host_os.h>
 
-#if !defined(GT_ASSERT) || GT_TRACE
-#define GT_ASSERT 1
-#endif
-
-struct GT_Config {
-	Fxn PRINTFXN;
-	Fxn PIDFXN;
-	Fxn TIDFXN;
-	Fxn ERRORFXN;
-};
-
-extern struct GT_Config *GT;
-
-struct GT_Mask {
-	char *modName;
-	u8 *flags;
-} ;
-
-/*
- *  New GT Class defenitions.
- *
- *  The following are the explanations and how it could be used in the code
- *
- *  -   GT_ENTER    On Entry to Functions
- *
- *  -   GT_1CLASS   Display level of debugging status- Object/Automatic
- *                  variables
- *  -   GT_2CLASS   ---- do ----
- *
- *  -   GT_3CLASS   ---- do ---- + It can be used(recommended) for debug
- *		    status in the ISR, IST
- *  -   GT_4CLASS   ---- do ----
- *
- *  -   GT_5CLASS   Display entry for module init/exit functions
- *
- *  -   GT_6CLASS   Warn whenever SERVICES function fails
- *
- *  -   GT_7CLASS   Warn failure of Critical failures
- *
- */
-
-#define GT_ENTER	((u8)0x01)
-#define GT_1CLASS	((u8)0x02)
-#define GT_2CLASS	((u8)0x04)
-#define GT_3CLASS	((u8)0x08)
-#define GT_4CLASS	((u8)0x10)
-#define GT_5CLASS	((u8)0x20)
-#define GT_6CLASS	((u8)0x40)
-#define GT_7CLASS	((u8)0x80)
-
-#ifdef _LINT_
-
-/* LINTLIBRARY */
-
-/*
- *  ======== GT_assert ========
- */
-/* ARGSUSED */
-void GT_assert(struct GT_Mask mask, s32 expr)
-{
-}
-
-/*
- *  ======== GT_config ========
- */
-/* ARGSUSED */
-void GT_config(struct GT_Config config)
-{
-}
-
-/*
- *  ======== GT_create ========
- */
-/* ARGSUSED */
-void GT_create(struct GT_Mask *mask, char *modName)
-{
-}
-
-/*
- *  ======== GT_curLine ========
- *  Purpose:
- *      Returns the current source code line number. Is useful for performing
- *      branch testing using trace.  For example,
- *
- *      GT_1trace(curTrace, GT_1CLASS,
- *          "in module XX_mod, executing line %u\n", GT_curLine());
- */
-/* ARGSUSED */
-u16 GT_curLine(void)
-{
-	return (u16)NULL;
-}
-
-/*
- *  ======== GT_exit ========
- */
-/* ARGSUSED */
-void GT_exit(void)
-{
-}
-
-/*
- *  ======== GT_init ========
- */
-/* ARGSUSED */
-void GT_init(void)
-{
-}
-
-/*
- *  ======== GT_query ========
- */
-/* ARGSUSED */
-bool GT_query(struct GT_Mask mask, u8 class)
-{
-	return false;
-}
-
-/*
- *  ======== GT_set ========
- *  sets trace mask according to settings
- */
-
-/* ARGSUSED */
-void GT_set(char *settings)
-{
-}
-
-/*
- *  ======== GT_setprintf ========
- *  sets printf function
- */
-
-/* ARGSUSED */
-void GT_setprintf(Fxn fxn)
-{
-}
-
-/* ARGSUSED */
-void GT_0trace(struct GT_Mask mask, u8 class, char *format)
-{
-}
-
-/* ARGSUSED */
-void GT_1trace(struct GT_Mask mask, u8 class, char *format, ...)
-{
-}
-
-/* ARGSUSED */
-void GT_2trace(struct GT_Mask mask, u8 class, char *format, ...)
-{
-}
-
-/* ARGSUSED */
-void GT_3trace(struct GT_Mask mask, u8 class, char *format, ...)
-{
-}
-
-/* ARGSUSED */
-void GT_4trace(struct GT_Mask mask, u8 class, char *format, ...)
-{
-}
-
-/* ARGSUSED */
-void GT_5trace(struct GT_Mask mask, u8 class, char *format, ...)
-{
-}
-
-/* ARGSUSED */
-void GT_6trace(struct GT_Mask mask, u8 class, char *format, ...)
-{
-}
-
-#else
-
-#define	GT_BOUND    26		/* 26 letters in alphabet */
-
-extern void _GT_create(struct GT_Mask *mask, char *modName);
-
-#define GT_exit()
-
-extern void GT_init(void);
-extern void _GT_set(char *str);
-extern s32 _GT_trace(struct GT_Mask *mask, char *format, ...);
-
-#if GT_ASSERT == 0
-
-#define GT_assert(mask, expr)
-#define GT_config(config)
-#define GT_configInit(config)
-#define GT_seterror(fxn)
-
-#else
-
-extern struct GT_Config _GT_params;
-
-#define GT_assert(mask, expr) \
-	(!(expr) ? \
-	    pr_err("assertion violation: %s, line %d\n", \
-			    __FILE__, __LINE__), NULL : NULL)
-
-#define GT_config(config)     (_GT_params = *(config))
-#define GT_configInit(config) (*(config) = _GT_params)
-#define GT_seterror(fxn)      (_GT_params.ERRORFXN = (Fxn)(fxn))
-
-#endif
-
-#if GT_TRACE == 0
-
-#define GT_curLine()                ((u16)__LINE__)
-#define GT_create(mask, modName)
-#define GT_exit()
-#define GT_init()
-#define GT_set(settings)
-#define GT_setprintf(fxn)
-
-#define GT_query(mask, class)     false
-
-#define GT_0trace(mask, class, format) do {} while (0)
-#define GT_1trace(mask, class, format, arg1) do {} while (0)
-#define GT_2trace(mask, class, format, arg1, arg2) do {} while (0)
-#define GT_3trace(mask, class, format, arg1, arg2, arg3) do {} while (0)
-#define GT_4trace(mask, class, format, arg1, arg2, arg3, arg4) do {} while (0)
-#define GT_5trace(mask, class, format, arg1, arg2, arg3, arg4, arg5) \
-	do {} while (0)
-#define GT_6trace(mask, class, format, arg1, arg2, arg3, arg4, arg5, arg6) \
-	do {} while (0)
-
-#else				/* GT_TRACE == 1 */
-
-
-#define GT_create(mask, modName)    _GT_create((mask), (modName))
-#define GT_curLine()                ((u16)__LINE__)
-#define GT_set(settings)          _GT_set(settings)
-#define GT_setprintf(fxn)         (_GT_params.PRINTFXN = (Fxn)(fxn))
-
-#define GT_query(mask, class) ((*(mask).flags & (class)))
-
-#define GT_0trace(mask, class, format) \
-    ((*(mask).flags & (class)) ? \
-    _GT_trace(&(mask), (format)) : 0)
-
-#define GT_1trace(mask, class, format, arg1) \
-    ((*(mask).flags & (class)) ? \
-    _GT_trace(&(mask), (format), (arg1)) : 0)
-
-#define GT_2trace(mask, class, format, arg1, arg2) \
-    ((*(mask).flags & (class)) ? \
-    _GT_trace(&(mask), (format), (arg1), (arg2)) : 0)
-
-#define GT_3trace(mask, class, format, arg1, arg2, arg3) \
-    ((*(mask).flags & (class)) ? \
-    _GT_trace(&(mask), (format), (arg1), (arg2), (arg3)) : 0)
-
-#define GT_4trace(mask, class, format, arg1, arg2, arg3, arg4) \
-    ((*(mask).flags & (class)) ? \
-    _GT_trace(&(mask), (format), (arg1), (arg2), (arg3), (arg4)) : 0)
-
-#define GT_5trace(mask, class, format, arg1, arg2, arg3, arg4, arg5) \
-    ((*(mask).flags & (class)) ? \
-    _GT_trace(&(mask), (format), (arg1), (arg2), (arg3), (arg4), (arg5)) : 0)
-
-#define GT_6trace(mask, class, format, arg1, arg2, arg3, arg4, arg5, arg6) \
-    ((*(mask).flags & (class)) ? \
-    _GT_trace(&(mask), (format), (arg1), (arg2), (arg3), (arg4), (arg5), \
-	(arg6)) : 0)
-
-#endif				/* GT_TRACE */
-
-#endif				/* _LINT_ */
-
 #endif				/* GTCE_ */
diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index 8aeb6a5..11d92cd 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -1,10 +1,10 @@
 obj-$(CONFIG_MPU_BRIDGE)	+= bridgedriver.o
 
-libgen = gen/gb.o gen/gt.o gen/gs.o gen/gh.o gen/_gt_para.o gen/uuidutil.o
+libgen = gen/gb.o gen/gs.o gen/gh.o gen/uuidutil.o
 libservices = services/mem.o services/sync.o \
 		services/clk.o services/cfg.o services/reg.o \
                services/regsup.o services/ntfy.o \
-		services/dbg.o services/services.o
+		services/services.o
 libwmd = wmd/chnl_sm.o wmd/msg_sm.o wmd/io_sm.o wmd/tiomap3430.o \
 		wmd/tiomap3430_pwr.o wmd/tiomap_sm.o wmd/tiomap_io.o \
 		wmd/mmu_fault.o wmd/ue_deh.o
diff --git a/drivers/dsp/bridge/gen/_gt_para.c b/drivers/dsp/bridge/gen/_gt_para.c
deleted file mode 100644
index 1bb82b1..0000000
--- a/drivers/dsp/bridge/gen/_gt_para.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- * _gt_para.c
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
-/*
- * Configuration parameters for GT.  This file is separated from
- * gt.c so that GT_assert() can reference the error function without
- * forcing the linker to include all the code for GT_set(), GT_init(),
- * etc. into a fully bound image.  Thus, GT_assert() can be retained in
- * a program for which GT_?trace() has been compiled out.
- */
-
-/*  ----------------------------------- Host OS */
-#include <dspbridge/host_os.h>
-
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dspbridge/std.h>
-
-/*  ----------------------------------- Trace & Debug */
-#include <dspbridge/gt.h>
-
-/*  ----------------------------------- Function Prototypes */
-static void error(char *msg, ...);
-static s32 GT_nop(void);
-
-/*  ----------------------------------- Defines, Data Structures, Typedefs */
-
-struct GT_Config _GT_params = {
-	(Fxn) printk,		/* printf */
-	(Fxn) NULL,		/* procid */
-	(Fxn) GT_nop,		/* taskid */
-	(Fxn) error,		/* error */
-};
-
-/*  ----------------------------------- Globals */
-struct GT_Config *GT = &_GT_params;
-
-/*
- *  ======== GT_nop ========
- */
-static s32 GT_nop(void)
-{
-	return 0;
-}
-
-/*
- * ======== error ========
- *  purpose:
- *      Prints error onto the standard output.
- */
-static void error(char *fmt, ...)
-{
-	s32 arg1, arg2, arg3, arg4, arg5, arg6;
-
-	va_list va;
-
-	va_start(va, fmt);
-
-	arg1 = va_arg(va, s32);
-	arg2 = va_arg(va, s32);
-	arg3 = va_arg(va, s32);
-	arg4 = va_arg(va, s32);
-	arg5 = va_arg(va, s32);
-	arg6 = va_arg(va, s32);
-
-	va_end(va);
-
-	pr_err("ERROR: ");
-	printk(fmt, arg1, arg2, arg3, arg4, arg5, arg6);
-
-#if defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)
-	if (in_interrupt()) {
-		printk(KERN_INFO "Not stopping after error since ISR/DPC "
-			"are disabled\n");
-	} else {
-		set_current_state(TASK_INTERRUPTIBLE);
-		flush_signals(current);
-		schedule();
-		flush_signals(current);
-		printk(KERN_INFO "Signaled in error function\n");
-	}
-#endif
-}
diff --git a/drivers/dsp/bridge/gen/gt.c b/drivers/dsp/bridge/gen/gt.c
deleted file mode 100644
index 40bed53..0000000
--- a/drivers/dsp/bridge/gen/gt.c
+++ /dev/null
@@ -1,336 +0,0 @@
-/*
- * gt.c
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * This module implements the trace mechanism for bridge.
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
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dspbridge/std.h>
-
-/*  ----------------------------------- This */
-#include <dspbridge/gt.h>
-
-#define GT_WILD	'*'
-
-#define GT_CLEAR	'='
-#define GT_ON		'+'
-#define GT_OFF		'-'
-
-enum GT_State {
-	GT_SEP,
-	GT_FIRST,
-	GT_SECOND,
-	GT_OP,
-	GT_DIGITS
-} ;
-
-#ifdef CONFIG_BRIDGE_DEBUG
-static char *GT_1format = "%s - %d: ";
-static char *GT_2format = "%s - %d(%d): ";
-#endif /* CONFIG_BRIDGE_DEBUG */
-
-static unsigned char *GT_tMask[GT_BOUND];
-
-static bool curInit;
-static char *separator;
-static unsigned char tabMem[GT_BOUND][sizeof(unsigned char) * GT_BOUND];
-
-static void error(char *string);
-static void setMask(s16 index1, s16 index2, char op, unsigned char mask);
-
-/*
- *  ======== _GT_create ========
- *  purpose:
- *      Creates GT mask.
- */
-void _GT_create(struct GT_Mask *mask, char *modName)
-{
-	mask->modName = modName;
-	mask->flags = &(GT_tMask[modName[0] - 'A'][modName[1] - 'A']);
-}
-
-/*
- *  ======== GT_init ========
- *  purpose:
- *      Initializes GT module.
- */
-#ifdef GT_init
-#undef GT_init
-#endif
-void GT_init(void)
-{
-	register unsigned char index1;
-	register unsigned char index2;
-
-	if (!curInit) {
-		curInit = true;
-
-		separator = " ,;/";
-
-		for (index1 = 0; index1 < GT_BOUND; index1++) {
-			GT_tMask[index1] = tabMem[index1];
-			for (index2 = 0; index2 < GT_BOUND; index2++) {
-				/* no tracing */
-				GT_tMask[index1][index2] = 0x00;
-			}
-		}
-	}
-}
-
-/*
- *  ======== _GT_set ========
- *  purpose:
- *      Sets the trace string format.
- */
-
-void _GT_set(char *str)
-{
-	enum GT_State state;
-	char *sep;
-	s16 index1 = GT_BOUND;	/* indicates all values */
-	s16 index2 = GT_BOUND;	/* indicates all values */
-	char op = GT_CLEAR;
-	bool maskValid;
-	s16 digit;
-	register unsigned char mask = 0x0;	/* no tracing */
-
-	if (str == NULL)
-		return;
-
-	maskValid = false;
-	state = GT_SEP;
-	while (*str != '\0') {
-		switch ((s32) state) {
-		case (s32) GT_SEP:
-			maskValid = false;
-			sep = separator;
-			while (*sep != '\0') {
-				if (*str == *sep) {
-					str++;
-					break;
-				} else {
-					sep++;
-				}
-			}
-			if (*sep == '\0')
-				state = GT_FIRST;
-
-			break;
-		case (s32) GT_FIRST:
-			if (*str == GT_WILD) {
-				/* indicates all values */
-				index1 = GT_BOUND;
-				/* indicates all values */
-				index2 = GT_BOUND;
-				state = GT_OP;
-			} else {
-				if (*str >= 'a')
-					index1 = (s16) (*str - 'a');
-				else
-					index1 = (s16) (*str - 'A');
-				if ((index1 >= 0) && (index1 < GT_BOUND))
-					state = GT_SECOND;
-				else
-					state = GT_SEP;
-			}
-			str++;
-			break;
-		case (s32) GT_SECOND:
-			if (*str == GT_WILD) {
-				index2 = GT_BOUND;   /* indicates all values */
-				state = GT_OP;
-				str++;
-			} else {
-				if (*str >= 'a')
-					index2 = (s16) (*str - 'a');
-				else
-					index2 = (s16) (*str - 'A');
-				if ((index2 >= 0) && (index2 < GT_BOUND)) {
-					state = GT_OP;
-					str++;
-				} else {
-					state = GT_SEP;
-				}
-			}
-			break;
-		case (s32) GT_OP:
-			op = *str;
-			mask = 0x0;	/* no tracing */
-			switch (op) {
-			case (s32) GT_CLEAR:
-				maskValid = true;
-			case (s32) GT_ON:
-			case (s32) GT_OFF:
-				state = GT_DIGITS;
-				str++;
-				break;
-			default:
-				state = GT_SEP;
-				break;
-			}
-			break;
-		case (s32) GT_DIGITS:
-			digit = (s16) (*str - '0');
-			if ((digit >= 0) && (digit <= 7)) {
-				mask |= (0x01 << digit);
-				maskValid = true;
-				str++;
-			} else {
-				if (maskValid == true) {
-					setMask(index1, index2, op, mask);
-					maskValid = false;
-				}
-				state = GT_SEP;
-			}
-			break;
-		default:
-			error("illegal trace mask");
-			break;
-		}
-	}
-
-	if (maskValid)
-		setMask(index1, index2, op, mask);
-}
-
-/*
- *  ======== _GT_trace ========
- *  purpose:
- *      Prints the input string onto standard output
- */
-
-s32 _GT_trace(struct GT_Mask *mask, char *format, ...)
-{
-	s32 arg1, arg2, arg3, arg4, arg5, arg6;
-	va_list va;
-
-	va_start(va, format);
-
-	arg1 = va_arg(va, s32);
-	arg2 = va_arg(va, s32);
-	arg3 = va_arg(va, s32);
-	arg4 = va_arg(va, s32);
-	arg5 = va_arg(va, s32);
-	arg6 = va_arg(va, s32);
-
-	va_end(va);
-#ifdef CONFIG_BRIDGE_DEBUG
-	if (GT->PIDFXN == NULL) {
-		printk(GT_1format, mask->modName, GT->TIDFXN ?
-		(*GT->TIDFXN)() : 0);
-	} else {
-		printk(GT_2format, mask->modName, (*GT->PIDFXN)(),
-		GT->TIDFXN ? (*GT->TIDFXN)() : 0);
-	}
-#endif
-	printk(format, arg1, arg2, arg3, arg4, arg5, arg6);
-
-	return 0;
-}
-
-/*
- *  ======== error ========
- *  purpose:
- *      Prints errors onto the standard output.
- */
-static void error(char *string)
-{
-	printk("GT: %s", string);
-}
-
-/*
- *  ======== setmask ========
- *  purpose:
- *      Sets mask for the GT module.
- */
-
-static void setMask(s16 index1, s16 index2, char op, u8 mask)
-{
-	register s16 index;
-
-	if (index1 < GT_BOUND) {
-		if (index2 < GT_BOUND) {
-			switch (op) {
-			case (s32) GT_CLEAR:
-				GT_tMask[index1][index2] = mask;
-				break;
-			case (s32) GT_ON:
-				GT_tMask[index1][index2] |= mask;
-				break;
-			case (s32) GT_OFF:
-				GT_tMask[index1][index2] &= ~mask;
-				break;
-			default:
-				error("illegal trace mask");
-				break;
-			}
-		} else {
-			for (index2--; index2 >= 0; index2--) {
-				switch (op) {
-				case (s32) GT_CLEAR:
-					GT_tMask[index1][index2] = mask;
-					break;
-				case (s32) GT_ON:
-					GT_tMask[index1][index2] |= mask;
-					break;
-				case (s32) GT_OFF:
-					GT_tMask[index1][index2] &= ~mask;
-					break;
-				default:
-					error("illegal trace mask");
-					break;
-				}
-			}
-		}
-	} else {
-		for (index1--; index1 >= 0; index1--) {
-			if (index2 < GT_BOUND) {
-				switch (op) {
-				case (s32) GT_CLEAR:
-					GT_tMask[index1][index2] = mask;
-					break;
-				case (s32) GT_ON:
-					GT_tMask[index1][index2] |= mask;
-					break;
-				case (s32) GT_OFF:
-					GT_tMask[index1][index2] &= ~mask;
-					break;
-				default:
-					error("illegal trace mask");
-					break;
-				}
-			} else {
-				index = GT_BOUND;
-				for (index--; index >= 0; index--) {
-					switch (op) {
-					case (s32) GT_CLEAR:
-						GT_tMask[index1][index] = mask;
-						break;
-					case (s32) GT_ON:
-						GT_tMask[index1][index] |= mask;
-						break;
-					case (s32) GT_OFF:
-						GT_tMask[index1][index] &=
-						    ~mask;
-						break;
-					default:
-						error("illegal trace mask");
-						break;
-					}
-				}
-			}
-		}
-	}
-}
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 24246d5..1d09bb5 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -85,9 +85,6 @@ static struct cdev bridge_cdev;
 static struct class *bridge_class;
 
 static u32 driverContext;
-#ifdef CONFIG_BRIDGE_DEBUG
-static char *GT_str;
-#endif /* CONFIG_BRIDGE_DEBUG */
 static s32 driver_major;
 static char *base_img;
 char *iva_img;
@@ -117,9 +114,6 @@ static int omap34xxbridge_suspend_lockout(
 #endif
 
 #ifdef CONFIG_BRIDGE_DEBUG
-module_param(GT_str, charp, 0);
-MODULE_PARM_DESC(GT_str, "GT string, default = NULL");
-
 module_param(dsp_debug, int, 0);
 MODULE_PARM_DESC(dsp_debug, "Wait after loading DSP image. default = false");
 #endif
@@ -256,15 +250,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	device_create(bridge_class, NULL, MKDEV(driver_major, 0),
 			NULL, "DspBridge");
 
-	GT_init();
-
-#ifdef CONFIG_BRIDGE_DEBUG
-	if (GT_str)
-		GT_set(GT_str);
-#elif defined(DDSP_DEBUG_PRODUCT) && GT_TRACE
-	GT_set("**=67");
-#endif
-
 #ifdef CONFIG_PM
 	/* Initialize the wait queue */
 	if (!status) {
@@ -385,7 +370,6 @@ func_cont:
 	MEM_ExtPhysPoolRelease();
 
 	SERVICES_Exit();
-	GT_exit();
 
 	devno = MKDEV(driver_major, 0);
 	cdev_del(&bridge_cdev);
diff --git a/drivers/dsp/bridge/services/dbg.c b/drivers/dsp/bridge/services/dbg.c
deleted file mode 100644
index 86c4628..0000000
--- a/drivers/dsp/bridge/services/dbg.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * dbg.c
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Provide debugging services for DSP/BIOS Bridge Mini Driver.
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
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dspbridge/std.h>
-#include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
-
-/*  ----------------------------------- Trace & Debug */
-#include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
-
-/*  ----------------------------------- This */
-#include <dspbridge/dbg.h>
-
-#if (defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
-
-/*
- *  ======== DBG_Init ========
- *  Purpose:
- *      Ensures trace capability is set up for link drivers.
- */
-bool DBG_Init(void)
-{
-	return true;
-}
-
-/*
- *  ======== DBG_Trace ========
- *  Purpose:
- *      Output a trace message to the debugger, if the given trace level
- *      is unmasked.
- */
-DSP_STATUS DBG_Trace(u8 bLevel, char *pstrFormat, ...)
-{
-	s32 arg1, arg2, arg3, arg4, arg5, arg6;
-	va_list va;
-
-	va_start(va, pstrFormat);
-
-	arg1 = va_arg(va, s32);
-	arg2 = va_arg(va, s32);
-	arg3 = va_arg(va, s32);
-	arg4 = va_arg(va, s32);
-	arg5 = va_arg(va, s32);
-	arg6 = va_arg(va, s32);
-
-	va_end(va);
-
-	if (bLevel)
-		printk(pstrFormat, arg1, arg2, arg3, arg4, arg5, arg6);
-
-	return DSP_SOK;
-}
-
-/*
- *  ======== DBG_Exit ========
- *  Purpose:
- *      Discontinue usage of the DBG module.
- */
-void DBG_Exit(void)
-{
-	/* Do nothing */
-}
-
-#endif	/* (CONFIG_BRIDGE_DEBUG || DDSP_DEBUG_PRODUCT) && GT_TRACE */
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index 87bb76b..f1a8fa8 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -51,11 +51,8 @@ void SERVICES_Exit(void)
 	SYNC_Exit();
 	CLK_Exit();
 	REG_Exit();
-	DBG_Exit();
 	CFG_Exit();
 	MEM_Exit();
-
-	GT_exit();
 }
 
 /*
@@ -66,21 +63,18 @@ void SERVICES_Exit(void)
 bool SERVICES_Init(void)
 {
 	bool fInit = true;
-	bool fCFG, fDBG, fMEM;
+	bool fCFG, fMEM;
 	bool fREG, fSYNC, fCLK, fNTFY;
 
-	GT_init();
-
 	/* Perform required initialization of SERVICES modules. */
 	fMEM = MEM_Init();
 	fREG = REG_Init();
 	fCFG = CFG_Init();
-	fDBG = DBG_Init();
 	fSYNC = SYNC_Init();
 	fCLK  = CLK_Init();
 	fNTFY = NTFY_Init();
 
-	fInit = fCFG && fDBG && fMEM && fREG && fSYNC && fCLK;
+	fInit = fCFG && fMEM && fREG && fSYNC && fCLK;
 
 	if (!fInit) {
 		if (fNTFY)
@@ -95,9 +89,6 @@ bool SERVICES_Init(void)
 		if (fREG)
 			REG_Exit();
 
-		if (fDBG)
-			DBG_Exit();
-
 		if (fCFG)
 			CFG_Exit();
 
-- 
1.6.2.4

