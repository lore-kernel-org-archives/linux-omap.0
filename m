From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] DSPBRIDGE: OSAL: Get rid of KFILE
Date: Thu, 17 Sep 2009 18:26:06 +0300
Message-ID: <1253201166-31850-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39108 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbZIQP0X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Sep 2009 11:26:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@nokia.com, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

* Remove KFILE_Init(), KFILE_Exit() and tracing stuff
* Simplify KFILE_Seek()
* Simplify error checker in KFILE_Open after filp_open() call
* Remove pid/tgid related code: it seems totally useless here
* Get rid of KFILE_FileObj, use regular struct file instead

* Remove kfile.c and kfile.h
* Redefine necessary file operations in cod.c in a bit optimal way
* Clean up errbase.h

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |   27 --
 arch/arm/plat-omap/include/dspbridge/kfile.h   |  216 ---------------
 drivers/dsp/bridge/Kbuild                      |    2 +-
 drivers/dsp/bridge/pmgr/cod.c                  |  108 +++++++-
 drivers/dsp/bridge/pmgr/dbl.c                  |   14 +-
 drivers/dsp/bridge/services/kfile.c            |  337 ------------------------
 drivers/dsp/bridge/services/services.c         |   10 +-
 7 files changed, 112 insertions(+), 602 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/kfile.h
 delete mode 100644 drivers/dsp/bridge/services/kfile.c

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 47b9a0b..271315a 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -464,31 +464,4 @@
 /* Insufficient space to hold data in registry value. */
 #define REG_E_MOREDATA              (REG_EBASE + 0x03)
 
-/* FAILURE Codes : KFILE */
-#define KFILE_EBASE                 (DSP_COMP_EBASE + 0x900)
-
-/* Invalid file handle. */
-#define E_KFILE_INVALIDHANDLE       (KFILE_EBASE + 0x01)
-
-/* Bad file name. */
-#define E_KFILE_BADFILENAME         (KFILE_EBASE + 0x02)
-
-/* Invalid file mode. */
-#define E_KFILE_INVALIDMODE         (KFILE_EBASE + 0x03)
-
-/* No resources available. */
-#define E_KFILE_NORESOURCES         (KFILE_EBASE + 0x04)
-
-/* Invalid file buffer        . */
-#define E_KFILE_INVALIDBUFFER       (KFILE_EBASE + 0x05)
-
-/* Bad origin argument. */
-#define E_KFILE_BADORIGINFLAG       (KFILE_EBASE + 0x06)
-
-/* Invalid file offset value. */
-#define E_KFILE_INVALIDOFFSET       (KFILE_EBASE + 0x07)
-
-/* General KFILE error condition */
-#define E_KFILE_ERROR               (KFILE_EBASE + 0x08)
-
 #endif				/* ERRBASE_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/kfile.h b/arch/arm/plat-omap/include/dspbridge/kfile.h
deleted file mode 100644
index 23c89b0..0000000
--- a/arch/arm/plat-omap/include/dspbridge/kfile.h
+++ /dev/null
@@ -1,216 +0,0 @@
-/*
- * kfile.h
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
- *  ======== kfile.h ========
- *  Purpose:
- *      Provide file I/O management capabilities.
- *
- *  Public Functions:
- *      KFILE_Close
- *      KFILE_Exit
- *      KFILE_Init
- *      KFILE_Open
- *      KFILE_Read
- *      KFILE_Seek
- *      KFILE_Tell
- *      KFILE_Write
- *
- *  Notes:
- *      The KFILE module is not like most of the other DSP/BIOS Bridge modules
- *      in that it doesn't return WSX_STATUS type values.  Rather, it's
- *      prototypes are meant to match the stdio file prototypes
- *      (ie, fopen, fclose, etc.).
- *
- *! Revision History
- *! ================
- *! 29-Oct-1999 kc:  Clean up for code review.
- *! 07-Jan-1998 cr:  Clean up for code review.
- *! 15-Aug-1997 cr:  Added E_KFILE_ERROR for general error condition.
- *! 04-Aug-1997 cr:  Added explicit CDECL descriptions.
- *! 11-Nov-1996 cr:  Implemented changes based on code review.
- *! 05-Nov-1996 cr:  Cleaned up for code review.
- *! 29-May-1996 gp:  Added requirement that size != 0 in _Write() and _Read().
- *! 28-May-1996 mg:  Changed return values for Read/Write.
- *! 14-Dec-1995 cr:  Created.
- */
-
-#ifndef KFILE_
-#define KFILE_
-
-/*
- *  Constants for KFILE_Seek.  Note that these MUST be the same definitions as
- *  those defined for fseek.
- */
-#define KFILE_SEEK_SET          0x00	/* seek from beginning of file */
-#define KFILE_SEEK_CUR          0x01	/* seek from current position */
-#define KFILE_SEEK_END          0x02	/* seek from end of file */
-
-	struct KFILE_FileObj;
-
-/*
- *  ======== KFILE_Close ========
- *  Purpose:
- *      This function closes a file's stream.
- *  Parameters:
- *      hFile:      Handle of the file stream returned by KFILE_Open.
- *  Returns:
- *      E_KFILE_INVALIDHANDLE:  bad handle.
- *      0:                      success.
- *      E_KFILE_ERROR:          unable to close specified handle.
- *  Requires:
- *      KFILE initialized.
- *  Ensures:
- */
-	extern s32 KFILE_Close(IN struct KFILE_FileObj *hFile);
-
-/*
- *  ======== KFILE_Exit ========
- *  Purpose:
- *      Discontinue usage of module; free resources when reference count
- *      reaches 0.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      KFILE initialized.
- *  Ensures:
- *      Resources used by module are freed when cRef reaches zero.
- */
-	extern void KFILE_Exit(void);
-
-/*
- *  ======== KFILE_Init ========
- *  Purpose:
- *      Initializes private state of KFILE module.
- *  Parameters:
- *  Returns:
- *      TRUE if success, else FALSE.
- *  Requires:
- *  Ensures:
- *      KFILE initialized.
- */
-	extern bool KFILE_Init(void);
-
-/*
- *  ======== KFILE_Open ========
- *  Purpose:
- *      Opens a file for use.
- *  Parameters:
- *      pszFileName:    Full path to name of the file to open.
- *      pszMode:        String containing open status.  Only the first
- *                      character of the string is examined, for either
- *                      "r" (read) or "w" (write) mode.
- *  Returns:
- *      A valid file handle if success, else NULL.
- *  Requires:
- *      - KFILE initialized.
- *      - pszMode != NULL.
- *      - pszFileName != NULL.
- *  Ensures:
- */
-	extern struct KFILE_FileObj *KFILE_Open(IN CONST char *filename,
-				       IN CONST char *mode);
-
-/*
- *  ======== KFILE_Read ========
- *  Purpose:
- *      This function reads a specified number of bytes into a buffer.
- *  Parameters:
- *      pBuffer:    Array to which the file data is copied.
- *      cSize:      Number of characters in each object.
- *      cCount:     Number of objects to read in.
- *      hFile:      Handle of the file stream returned by KFILE_Open.
- *  Returns:
- *      E_KFILE_INVALIDHANDLE:  bad file handle.
- *      E_KFILE_ERROR:          general failure.
- *      > 0:                    success; # of objects read from file.
- *  Requires:
- *      KFILE initialized.
- *      pBuffer is a valid pointer.
- *  Ensures:
- */
-	extern s32 KFILE_Read(OUT void __user*buffer,
-			      IN s32 size, IN s32 count,
-			      IN struct KFILE_FileObj *hFile);
-
-/*
- *  ======== KFILE_Seek ========
- *  Purpose:
- *      This function sets the file position indicator.  NOTE:  we don't
- *      support seeking beyond the boundaries of a file.
- *  Parameters:
- *      hFile:      Handle of the file stream returned by KFILE_Open.
- *      offset:     Number of bytes from the origin to move.
- *      origin:     File reference point, one of the following values:
- *                  KFILE_SEEK_SET:  Seek from beginning of file.
- *                  KFILE_SEEK_CUR:  Seek from current position.
- *                  KFILE_SEEK_END:  Seek from end of file.
- *  Returns:
- *      0: success.
- *      E_KFILE_INVALIDHANDLE:  bad handle.
- *      E_KFILE_BADORIGIN:      invalid origin paramater.
- *      E_KFILE_ERROR:          general failure.
- *  Requires:
- *      KFILE initialized.
- *  Ensures:
- */
-	extern s32 KFILE_Seek(IN struct KFILE_FileObj *hFile,
-			      IN s32 offset, IN s32 origin);
-
-/*
- *  ======== KFILE_Tell ========
- *  Purpose:
- *      This function reports the current value of the position indicator.
- *  Parameters:
- *      hFile:          Handle of the file stream returned by KFILE_Open.
- *  Return value:
- *      > 0: success; returns # of bytes the position indicator is from
- *           beginning of file.
- *      E_KFILE_ERROR:          general failure.
- *      E_KFILE_INVALIDHANDLE:  bad file handle.
- *  Requires:
- *      KFILE initialized.
- *  Ensures:
- */
-	extern s32 KFILE_Tell(IN struct KFILE_FileObj *hFile);
-
-/*
- *  ======== KFILE_Write ========
- *  Purpose:
- *      This function writes a number of objects to the stream.
- *  Parameters:
- *      pBuffer:    Array from which the file data is written.
- *      cSize:      Number of characters in each object.
- *      cCount:     Number of objects to write out.
- *      hFile:      Handle of the file stream returned by KFILE_Open.
- *  Returns:
- *      E_KFILE_INVALIDHANDLE:  bad file handle.
- *      E_KFILE_ERROR:          general failure.
- *      > 0:                    success; # of objects written to file.
- *  Requires:
- *      KFILE initialized.
- *      pBuffer != NULL.
- *  Postcondition:
- *      The file position indicator is advanced by the number of
- *      characters written.
- */
-	extern s32 KFILE_Write(OUT void *buffer,
-			       IN s32 size,
-			       IN s32 count,
-			       IN struct KFILE_FileObj *hFile);
-
-#endif				/* KFILE_ */
diff --git a/drivers/dsp/bridge/Kbuild b/drivers/dsp/bridge/Kbuild
index 838cc13..f0b1972 100644
--- a/drivers/dsp/bridge/Kbuild
+++ b/drivers/dsp/bridge/Kbuild
@@ -2,7 +2,7 @@ obj-$(CONFIG_MPU_BRIDGE)	+= bridgedriver.o
 
 libgen = gen/gb.o gen/gt.o gen/gs.o gen/gh.o gen/_gt_para.o gen/uuidutil.o
 libservices = services/mem.o services/dpc.o \
-               services/kfile.o services/sync.o \
+		services/sync.o \
 		services/clk.o services/cfg.o services/reg.o \
                services/regsup.o services/ntfy.o \
 		services/dbg.o services/services.o
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index e26d115..c3ee2a3 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -57,6 +57,8 @@
 
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
@@ -68,7 +70,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/kfile.h>
 #include <dspbridge/ldr.h>
 #include <dspbridge/mem.h>
 
@@ -136,6 +137,101 @@ static struct DBLL_Fxns dbllFxns = {
 static bool NoOp(void);
 
 /*
+ * File operations (originally were under kfile.c)
+ */
+static s32 COD_fClose(struct file *hFile)
+{
+	/* Check for valid handle */
+	if (!hFile)
+		return DSP_EHANDLE;
+
+	filp_close(hFile, NULL);
+
+	/* we can't use DSP_SOK here */
+	return 0;
+}
+
+static struct file *COD_fOpen(CONST char *pszFileName, CONST char *pszMode)
+{
+	mm_segment_t fs;
+	struct file *hFile;
+
+	fs = get_fs();
+	set_fs(get_ds());
+
+	/* ignore given mode and open file as read-only */
+	hFile = filp_open(pszFileName, O_RDONLY, 0);
+
+	if (IS_ERR(hFile))
+		hFile = NULL;
+
+	set_fs(fs);
+
+	return hFile;
+}
+
+static s32 COD_fRead(void __user *pBuffer, s32 cSize, s32 cCount,
+		     struct file *hFile)
+{
+	/* check for valid file handle */
+	if (!hFile)
+		return DSP_EHANDLE;
+
+	if ((cSize > 0) && (cCount > 0) && pBuffer) {
+		u32 dwBytesRead;
+		mm_segment_t fs;
+
+		/* read from file */
+		fs = get_fs();
+		set_fs(get_ds());
+		dwBytesRead = hFile->f_op->read(hFile, pBuffer, cSize * cCount,
+						&(hFile->f_pos));
+		set_fs(fs);
+
+		if (!dwBytesRead)
+			return DSP_EFREAD;
+
+		return dwBytesRead / cSize;
+	}
+
+	return DSP_EINVALIDARG;
+}
+
+static s32 COD_fSeek(struct file *hFile, s32 lOffset, s32 cOrigin)
+{
+	u32 dwCurPos;
+
+	/* check for valid file handle */
+	if (!hFile)
+		return DSP_EHANDLE;
+
+	/* based on the origin flag, move the internal pointer */
+	dwCurPos = hFile->f_op->llseek(hFile, lOffset, cOrigin);
+
+	if ((s32)dwCurPos < 0)
+		return DSP_EFAIL;
+
+	/* we can't use DSP_SOK here */
+	return 0;
+}
+
+static s32 COD_fTell(struct file *hFile)
+{
+	u32 dwCurPos;
+
+	if (!hFile)
+		return DSP_EHANDLE;
+
+	/* Get current position */
+	dwCurPos = hFile->f_op->llseek(hFile, 0, SEEK_CUR);
+
+	if ((s32)dwCurPos < 0)
+		return DSP_EFAIL;
+
+	return dwCurPos;
+}
+
+/*
  *  ======== COD_Close ========
  */
 void COD_Close(struct COD_LIBRARYOBJ *lib)
@@ -199,11 +295,11 @@ DSP_STATUS COD_Create(OUT struct COD_MANAGER **phMgr, char *pstrDummyFile,
 
 	zlAttrs.alloc = (DBLL_AllocFxn)NoOp;
 	zlAttrs.free = (DBLL_FreeFxn)NoOp;
-	zlAttrs.fread = (DBLL_ReadFxn)KFILE_Read;
-	zlAttrs.fseek = (DBLL_SeekFxn)KFILE_Seek;
-	zlAttrs.ftell = (DBLL_TellFxn)KFILE_Tell;
-	zlAttrs.fclose = (DBLL_FCloseFxn)KFILE_Close;
-	zlAttrs.fopen = (DBLL_FOpenFxn)KFILE_Open;
+	zlAttrs.fread = (DBLL_ReadFxn)COD_fRead;
+	zlAttrs.fseek = (DBLL_SeekFxn)COD_fSeek;
+	zlAttrs.ftell = (DBLL_TellFxn)COD_fTell;
+	zlAttrs.fclose = (DBLL_FCloseFxn)COD_fClose;
+	zlAttrs.fopen = (DBLL_FOpenFxn)COD_fOpen;
 	zlAttrs.symLookup = NULL;
 	zlAttrs.baseImage = true;
 	zlAttrs.logWrite = NULL;
diff --git a/drivers/dsp/bridge/pmgr/dbl.c b/drivers/dsp/bridge/pmgr/dbl.c
index af0b89b..19aac41 100644
--- a/drivers/dsp/bridge/pmgr/dbl.c
+++ b/drivers/dsp/bridge/pmgr/dbl.c
@@ -38,6 +38,7 @@
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
 #include <linux/kernel.h>
+#include <linux/fs.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
@@ -50,7 +51,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
-#include <dspbridge/kfile.h>
 
 /*  ----------------------------------- This */
 #include <dspbridge/dbof.h>
@@ -161,7 +161,7 @@ struct TargetInfo {
 struct DBL_LibraryObj {
 	u32 dwSignature; 	/* For object validation */
 	struct DBL_TargetObj *pTarget; 	/* Target for this library */
-	struct KFILE_FileObj *file; 	/* DBOF file handle */
+	struct file *file; 	/* DBOF file handle */
 	bool byteSwapped; 	/* Are bytes swapped? */
 	struct DBOF_FileHdr fileHdr; 	/* Header of DBOF file */
 	u16 nSymbols; 		/* Number of DSP/Bridge symbols */
@@ -1024,7 +1024,7 @@ static DSP_STATUS loadSect(struct DBL_TargetObj *dbl,
 {
 	struct DBOF_SectHdr sectHdr;
 	char *pBuf;
-	struct KFILE_FileObj *file;
+	struct file *file;
 	u32 space;
 	u32 addr;
 	u32 total;
@@ -1090,7 +1090,7 @@ static DSP_STATUS readDCDSects(struct DBL_TargetObj *dbl,
 {
 	struct DBOF_DCDSectHdr *pSectHdr;
 	struct DCDSect *pSect;
-	struct KFILE_FileObj *file;
+	struct file *file;
 	u16 nSects;
 	u16 i;
 	u16 mauSize;
@@ -1144,7 +1144,7 @@ static DSP_STATUS readDCDSects(struct DBL_TargetObj *dbl,
 static DSP_STATUS readHeader(struct DBL_TargetObj *dbl,
 			    struct DBL_LibraryObj *pdblLib)
 {
-	struct KFILE_FileObj *file;
+	struct file *file;
 	s32 i;
 	struct DBOF_FileHdr *pHdr;
 	u32 swapMagic;
@@ -1218,7 +1218,7 @@ static DSP_STATUS readOvlySects(struct DBL_TargetObj *dbl,
 	struct DBOF_OvlySectData *pData;
 	struct OvlyData *pOvlyData;
 	char *pName;
-	struct KFILE_FileObj *file;
+	struct file *file;
 	u16 i, j;
 	u16 nSects;
 	u16 n;
@@ -1333,7 +1333,7 @@ static DSP_STATUS readSymbols(struct DBL_TargetObj *dbl,
 			     struct DBL_LibraryObj *pdblLib)
 {
 	struct DBOF_SymbolHdr symHdr;
-	struct KFILE_FileObj *file;
+	struct file *file;
 	u16 i;
 	u16 nSymbols;
 	u16 len;
diff --git a/drivers/dsp/bridge/services/kfile.c b/drivers/dsp/bridge/services/kfile.c
deleted file mode 100644
index d1e262c..0000000
--- a/drivers/dsp/bridge/services/kfile.c
+++ /dev/null
@@ -1,337 +0,0 @@
-/*
- * kfile.c
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
- *  ======== kfilece.c ========
- *  Purpose:
- *      This module provides file i/o services.
- *
- *  Public Functions:
- *      KFILE_Close
- *      KFILE_Exit
- *      KFILE_Init
- *      KFILE_Open
- *      KFILE_Read
- *      KFILE_Seek
- *      KFILE_Tell
- *
- *! Revision History
- *! ================
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!		 GT Changes.
- *! 22-Nov-1999 kc: Added changes from code review.
- *! 12-Nov-1999 kc: Enabled CSL for UNICODE/ANSI string conversions.
- *! 30-Sep-1999 ag: Changed KFILE_Read() GT level from _ENTER to _4CLASS.
- *!                 Removed GT_set().
- *! 25-Aug-1999 ag: Changed MEM_Calloc allocation type to MEM_PAGED.
- *! 13-Jul-1999 a0216266(ww - TID): Stubbed from kfilent.c.
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
-#include <dspbridge/gt.h>
-
-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
-
-/*  ----------------------------------- This */
-#include <dspbridge/kfile.h>
-
-/*  ----------------------------------- Defines, Data Structures, Typedefs */
-#define SIGNATURE           0x4c49464b	/* hex code of KFIL (reversed) */
-#define MAXFILENAMELENGTH   256
-#define GENERAL_FAILURE     0xffffffff	/* SetFilePointer error */
-
-/* The KFILE_FileObj abstracts the true file handle from a KFILE handle. */
-struct KFILE_FileObj {
-    u32 dwSignature;
-    __kernel_pid_t owner_pid;	/* PID of process that opened this file */
-    char 	*fileName  ;
-    bool          isOpen    ;
-    u32        size      ;
-    u32        curPos    ;
-    long 	  hInternal;		/* internal handle of file */
-    struct file *fileDesc;
-
-};
-
-/*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask KFILE_debugMask = { NULL, NULL };	/* Debug mask */
-#endif
-
-/*
- *  ======== KFILE_Close ========
- *  Purpose:
- *      This function closes a file's stream.
- */
-s32 KFILE_Close(struct KFILE_FileObj *hFile)
-{
-	s32 cRetVal = 0;	/* 0 indicates success */
-	s32 fRetVal = 0;
-	__kernel_pid_t curr_pid;
-
-	GT_1trace(KFILE_debugMask, GT_ENTER, "KFILE_Close: hFile 0x%x\n",
-		  hFile);
-
-	/* Check for valid handle */
-	if (MEM_IsValidHandle(hFile, SIGNATURE)) {
-		/* Close file only if opened by the same process (id). Otherwise
-		 * Linux closes all open file handles when process exits.*/
-		/* Return TGID instead of process handle */
-		curr_pid = (__kernel_pid_t)current->tgid;
-		fRetVal = filp_close(hFile->fileDesc, NULL) ;
-		if (fRetVal) {
-			cRetVal = E_KFILE_ERROR;
-			GT_1trace(KFILE_debugMask, GT_6CLASS,
-				  "KFILE_Close: sys_close "
-				  "returned %d\n", fRetVal);
-		}
-		MEM_FreeObject(hFile);
-	} else {
-		cRetVal = E_KFILE_INVALIDHANDLE;
-		GT_0trace(KFILE_debugMask, GT_6CLASS, "KFILE_Close: "
-			  "invalid file handle\n");
-	}
-	return cRetVal;
-}
-
-/*
- *  ======== KFILE_Exit ========
- *  Purpose:
- *      Decrement reference count, and free resources when reference count
- *      is 0.
- */
-void KFILE_Exit(void)
-{
-	GT_0trace(KFILE_debugMask, GT_5CLASS, "KFILE_Exit\n");
-}
-
-/*
- *  ======== KFILE_Init ========
- */
-bool KFILE_Init(void)
-{
-	GT_create(&KFILE_debugMask, "KF");	/* "KF" for KFile */
-
-	GT_0trace(KFILE_debugMask, GT_5CLASS, "KFILE_Init\n");
-
-	return true;
-}
-
-/*
- *  ======== KFILE_Open ========
- *  Purpose:
- *      Open a file for reading ONLY
- */
-struct KFILE_FileObj *KFILE_Open(CONST char *pszFileName, CONST char *pszMode)
-{
-	struct KFILE_FileObj *hFile;	/* file handle */
-	DSP_STATUS status;
-	mm_segment_t fs;
-
-	struct file*fileDesc = NULL;
-	DBC_Require(pszMode != NULL);
-	DBC_Require(pszFileName != NULL);
-
-	GT_2trace(KFILE_debugMask, GT_ENTER,
-		  "KFILE_Open: pszFileName %s, pszMode "
-		  "%s\n", pszFileName, pszMode);
-
-	/* create a KFILE object */
-	MEM_AllocObject(hFile, struct KFILE_FileObj, SIGNATURE);
-
-	if (hFile) {
-		fs = get_fs();
-		set_fs(get_ds());
-	/* Third argument is mode (permissions). Ignored unless creating file */
-		fileDesc = filp_open(pszFileName, O_RDONLY, 0);
-		if ((IS_ERR(fileDesc)) || (fileDesc == NULL) ||
-		     (fileDesc->f_op == NULL) || (fileDesc->f_op->read == NULL)
-		     || (fileDesc->f_op->llseek == NULL)) {
-			status = DSP_EFILE;
-		} else {
-			hFile->fileDesc = fileDesc;
-			hFile->fileName = (char *)pszFileName;
-			hFile->isOpen	   = true;
-			hFile->curPos   = 0;
-			hFile->size = fileDesc->f_op->llseek(fileDesc, 0,
-							    SEEK_END);
-			fileDesc->f_op->llseek(fileDesc, 0, SEEK_SET);
-			/* Return TGID instead of process handle */
-			hFile->owner_pid = current->tgid;
-
-			status = DSP_SOK;
-		}
-		set_fs(fs);
-		if (DSP_FAILED(status)) {
-			/* free memory, and clear handle */
-			MEM_FreeObject(hFile);
-			hFile = NULL;
-		}
-	} else {
-			GT_0trace(KFILE_debugMask, GT_6CLASS,
-				  "KFILE_Open: MEM_AllocObject failed\n");
-			status = DSP_EMEMORY;
-	}
-	return hFile;
-}
-
-/*
- *  ======== KFILE_Read ========
- *  Purpose:
- *      Reads a specified number of bytes into a buffer.
- */
-s32
-KFILE_Read(void __user*pBuffer, s32 cSize, s32 cCount,
-			struct KFILE_FileObj *hFile)
-{
-	u32 dwBytesRead = 0;
-	s32 cRetVal = 0;
-	mm_segment_t fs;
-
-	DBC_Require(pBuffer != NULL);
-
-	GT_4trace(KFILE_debugMask, GT_4CLASS,
-		  "KFILE_Read: buffer 0x%x, cSize 0x%x,"
-		  "cCount 0x%x, hFile 0x%x\n", pBuffer, cSize, cCount, hFile);
-
-	/* check for valid file handle */
-	if (MEM_IsValidHandle(hFile, SIGNATURE)) {
-		if ((cSize > 0) && (cCount > 0) && pBuffer) {
-			/* read from file */
-			fs = get_fs();
-			set_fs(get_ds());
-			dwBytesRead = hFile->fileDesc->f_op->read(hFile->
-				      fileDesc, pBuffer, cSize *cCount,
-				      &(hFile->fileDesc->f_pos));
-			set_fs(fs);
-			if (dwBytesRead) {
-				cRetVal = dwBytesRead / cSize;
-				hFile->curPos += dwBytesRead;
-				DBC_Assert((dwBytesRead / cSize) <= \
-					  (u32)cCount);
-			} else {
-				cRetVal = E_KFILE_ERROR;
-				GT_0trace(KFILE_debugMask, GT_6CLASS,
-					  "KFILE_Read: sys_read() failed\n");
-			}
-		} else {
-			cRetVal = DSP_EINVALIDARG;
-			GT_0trace(KFILE_debugMask, GT_6CLASS,
-				  "KFILE_Read: Invalid argument(s)\n");
-		}
-	} else {
-		cRetVal = E_KFILE_INVALIDHANDLE;
-		GT_0trace(KFILE_debugMask, GT_6CLASS,
-			  "KFILE_Read: invalid file handle\n");
-	}
-
-	return cRetVal;
-}
-
-/*
- *  ======== KFILE_Seek ========
- *  Purpose:
- *      Sets the file position indicator. NOTE:  we don't support seeking
- *      beyond the boundaries of a file.
- */
-s32 KFILE_Seek(struct KFILE_FileObj *hFile, s32 lOffset, s32 cOrigin)
-{
-	s32 cRetVal = 0;	/* 0 for success */
-	u32 dwCurPos = 0;
-
-	struct file *fileDesc = NULL;
-
-	GT_3trace(KFILE_debugMask, GT_ENTER, "KFILE_Seek: hFile 0x%x, "
-		  "lOffset 0x%x, cOrigin 0x%x\n",
-		  hFile, lOffset, cOrigin);
-
-	/* check for valid file handle */
-	if (MEM_IsValidHandle(hFile, SIGNATURE)) {
-		/* based on the origin flag, move the internal pointer */
-
-	fileDesc = hFile->fileDesc;
-		switch (cOrigin) {
-		case KFILE_SEEK_SET:
-			dwCurPos = hFile->fileDesc->f_op->llseek(hFile->
-				   fileDesc, lOffset, SEEK_SET);
-			cRetVal = ((dwCurPos >= 0) ? 0 : E_KFILE_ERROR);
-			break;
-
-		case KFILE_SEEK_CUR:
-			dwCurPos = hFile->fileDesc->f_op->llseek(hFile->
-				   fileDesc, lOffset, SEEK_CUR);
-			cRetVal = ((dwCurPos >= 0) ? 0 : E_KFILE_ERROR);
-			break;
-		case KFILE_SEEK_END:
-			dwCurPos = hFile->fileDesc->f_op->llseek(hFile->
-				   fileDesc, lOffset, SEEK_END);
-			cRetVal = ((dwCurPos >= 0) ? 0 : E_KFILE_ERROR);
-			break;
-		default:
-			cRetVal = E_KFILE_BADORIGINFLAG;
-			GT_0trace(KFILE_debugMask, GT_6CLASS,
-				  "KFILE_Seek:bad origin flag\n");
-			break;
-		}
-	} else {
-		cRetVal = E_KFILE_INVALIDHANDLE;
-		GT_0trace(KFILE_debugMask, GT_6CLASS,
-			  "KFILE_Seek:invalid file handle\n");
-	}
-	return cRetVal;
-}
-
-/*
- *  ======== KFILE_Tell ========
- *  Purpose:
- *      Reports the current value of the position indicator. We did not
- *	    consider 64 bit long file size, which implies a 4GB file limit
- *      (2 to 32 power).
- */
-s32 KFILE_Tell(struct KFILE_FileObj *hFile)
-{
-	u32 dwCurPos = 0;
-	s32 lRetVal = E_KFILE_ERROR;
-
-	GT_1trace(KFILE_debugMask, GT_ENTER, "KFILE_Tell: hFile 0x%x\n", hFile);
-
-	if (MEM_IsValidHandle(hFile, SIGNATURE)) {
-
-		/* Get current position. */
-		dwCurPos = hFile->fileDesc->f_op->llseek(hFile->fileDesc, 0,
-			   SEEK_CUR);
-		if (dwCurPos >= 0)
-			lRetVal = dwCurPos;
-
-	} else {
-		lRetVal = E_KFILE_INVALIDHANDLE;
-		GT_0trace(KFILE_debugMask, GT_6CLASS,
-			  "KFILE_Seek:invalid file handle\n");
-	}
-	return lRetVal;
-}
-
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index 7df9920..639b7fb 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -46,7 +46,6 @@
 #include <dspbridge/cfg.h>
 #include <dspbridge/dbg.h>
 #include <dspbridge/dpc.h>
-#include <dspbridge/kfile.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/reg.h>
@@ -83,7 +82,6 @@ void SERVICES_Exit(void)
 		SYNC_Exit();
 		CLK_Exit();
 		REG_Exit();
-		KFILE_Exit();
 		DPC_Exit();
 		DBG_Exit();
 		CFG_Exit();
@@ -103,7 +101,7 @@ void SERVICES_Exit(void)
 bool SERVICES_Init(void)
 {
 	bool fInit = true;
-	bool fCFG, fDBG, fDPC, fKFILE, fMEM;
+	bool fCFG, fDBG, fDPC, fMEM;
 	bool fREG, fSYNC, fCLK, fNTFY;
 
 	DBC_Require(cRefs >= 0);
@@ -122,12 +120,11 @@ bool SERVICES_Init(void)
 		fCFG = CFG_Init();
 		fDBG = DBG_Init();
 		fDPC = DPC_Init();
-		fKFILE = KFILE_Init();
 		fSYNC = SYNC_Init();
 		fCLK  = CLK_Init();
 		fNTFY = NTFY_Init();
 
-		fInit = fCFG && fDBG && fDPC && fKFILE &&
+		fInit = fCFG && fDBG && fDPC &&
 			fMEM && fREG && fSYNC && fCLK;
 
 		if (!fInit) {
@@ -143,9 +140,6 @@ bool SERVICES_Init(void)
 			if (fREG)
 				REG_Exit();
 
-			if (fKFILE)
-				KFILE_Exit();
-
 			if (fDPC)
 				DPC_Exit();
 
-- 
1.5.6.5

