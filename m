From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 05/07][GIT 3/4+] Removing bridge compilation flags
Date: Mon, 4 Aug 2008 09:55:53 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530804B516@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:42501 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753821AbYHDO4A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 10:56:00 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m74EtsYH017185
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 09:55:59 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m74EtsLY025499
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 09:55:54 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Remove the compilation flags to make Dynamic loader optimizations default in the code. Modified Kbuild so these flags are not defined anymore.

---
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dbtype.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/dbtype.h       2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dbtype.h    2008-07-30 00:46:32.000000000 -0500
@@ -101,10 +101,6 @@

 #define CDECL

-#define WINAPI
-
-#define STDCALL
-
 #define DLLIMPORT
 #define DLLEXPORT

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dynamic_loader.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/dynamic_loader.h       2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dynamic_loader.h    2008-07-30 00:46:32.000000000 -0500
@@ -19,11 +19,7 @@
 #ifndef _DYNAMIC_LOADER_H_
 #define _DYNAMIC_LOADER_H_
 #include <stdarg.h>
-#ifndef __KERNEL__
-#include <stdint.h>
-#else
 #include <linux/types.h>
-#endif

 /*
  * Dynamic Loader
@@ -100,7 +96,7 @@
                                       /* the returned module handle*/
                                       DLOAD_mhandle *mhandle
            );
-#ifdef OPT_ELIMINATE_EXTRA_DLOAD
+
 /*****************************************************************************
  * Procedure Dynamic_Open_Module
  *
@@ -137,7 +133,6 @@
                                      /* the returned module handle */
                                      DLOAD_mhandle *mhandle
        );
-#endif

 /*****************************************************************************
  * Procedure Dynamic_Unload_Module
@@ -341,29 +336,15 @@
                LDR_ADDR load_addr;     /* load address of the section */
                LDR_ADDR size;  /* size of the section in addressable units */
 #ifndef _BIG_ENDIAN
-#ifdef __KERNEL__
                u16 page;       /* memory page or view */
                u16 type;       /* one of the section types below */
 #else
-               uint16_t page;  /* memory page or view */
-               uint16_t type;  /* one of the section types below */
-#endif
-#else
-#ifdef __KERNEL__
                u16 type;       /* one of the section types below */
                u16 page;       /* memory page or view */
-#else
-               uint16_t type;  /* one of the section types below */
-               uint16_t page;  /* memory page or view */
-#endif
 #endif
                /* a context field for use by Dynamic_Loader_Allocate;
                 *   ignored but maintained by the dynamic loader */
-#ifdef __KERNEL__
                u32 context;
-#else
-               uintptr_t context;
-#endif
        } ;

 /* use this macro to extract type of section from LDR_SECTION_INFO.type field */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/host_os.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/host_os.h      2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/host_os.h   2008-07-30 00:46:32.000000000 -0500
@@ -27,8 +27,6 @@
 #ifndef _HOST_OS_H_
 #define _HOST_OS_H_

-#ifdef __KERNEL__
-
 #include <linux/autoconf.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -55,9 +53,9 @@
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
+#include <dbtype.h>
 /* #include <asm/arch/bus.h> */

-
 #if defined(OMAP_2430) || defined(OMAP_3430)
 #include <asm/arch/clock.h>
 #ifdef OMAP_3430
@@ -76,28 +74,10 @@
 #define SEEK_CUR        1      /* Seek from current position.  */
 #define SEEK_END        2      /* Seek from end of file.  */

-
 /* TODO -- Remove, once BP defines them */
 #ifdef OMAP_3430
 #define INT_MAIL_MPU_IRQ        26
 #define INT_DSP_MMU_IRQ        28
 #endif

-
-#else
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <semaphore.h>
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/ioctl.h>
-#include <sys/mman.h>
-#endif
-
-#include <dbtype.h>
-
 #endif
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/mem.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/mem.h  2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/mem.h       2008-07-30 00:46:32.000000000 -0500
@@ -89,11 +89,7 @@
  *      The returned pointer, if not NULL, points to a valid memory block of
  *      the size requested.
  */
-#ifdef __KERNEL__
        extern void *MEM_Alloc(IN u32 cBytes, IN enum MEM_POOLATTRS type);
-#else
-#define MEM_Alloc(size, type) malloc(size)
-#endif

 /*
  *  ======== MEM_AllocObject ========
@@ -203,11 +199,7 @@
  *  Ensures:
  *      pMemBuf is no longer a valid pointer to memory.
  */
-#ifdef __KERNEL__
        extern void MEM_Free(IN void *pMemBuf);
-#else
-#define MEM_Free(ptr) free(ptr)
-#endif

 /*
  *  ======== MEM_FreePhysMem ========
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/Kbuild
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/Kbuild 2008-07-30 00:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/Kbuild      2008-07-30 00:46:32.000000000 -0500
@@ -37,8 +37,6 @@
 endif

 ccflags-y += -Wno-strict-prototypes -fomit-frame-pointer
-ccflags-y += -DOPT_ELIMINATE_EXTRA_DLOAD -DOPT_REDUCE_SYMBOL_LOOKUPS \
-               -DOPT_USE_MEMSET

 #Machine dependent
 ccflags-y += -D_TI_ -D_DB_TIOMAP -DOMAP_3430 -D__KERNEL__ -DTMS32060 \
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/cload.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/cload.c        2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/cload.c     2008-07-30 00:46:32.000000000 -0500
@@ -212,7 +212,6 @@
        return dl_state.dload_errcount;
 }                              /* DLOAD_File */

-#ifdef OPT_ELIMINATE_EXTRA_DLOAD
 /*************************************************************************
  * Procedure Dynamic_Open_Module
  *
@@ -317,7 +316,6 @@

        return dl_state.dload_errcount;
 }                             /* DLOAD_File */
-#endif


 /*************************************************************************
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/dload_internal.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/dload_internal.h       2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/dload_internal.h    2008-07-30 00:46:32.000000000 -0500
@@ -18,11 +18,9 @@

 #ifndef __DLOAD_INTERNAL__
 #define __DLOAD_INTERNAL__
-#ifndef __KERNEL__
-#include <stdint.h>
-#else
+
 #include <linux/types.h>
-#endif
+
 /*
  * Internal state definitions for the dynamic loader
  */
@@ -33,17 +31,10 @@


 /* type used for relocation intermediate results */
-#ifdef __KERNEL__
 typedef s32 RVALUE;
-#else
-typedef int_least32_t RVALUE;
-#endif
+
 /* unsigned version of same; must have at least as many bits */
-#ifdef __KERNEL__
 typedef u32 URVALUE;
-#else
-typedef uint_least32_t URVALUE;
-#endif

 /*
  * Dynamic loader configuration constants
@@ -93,42 +84,18 @@
  */
 struct dbg_mirror_root {
        /* must be same as dbg_mirror_list; __DLModules address on target */
-#ifdef __KERNEL__
        u32 dbthis;
-#else
-    uint32_t dbthis;
-#endif
        struct my_handle *hnext;        /* must be same as dbg_mirror_list */
-#ifdef __KERNEL__
        u16 changes;    /* change counter */
-#else
-       uint16_t changes;
-#endif
-#ifdef __KERNEL__
        u16 refcount;   /* number of modules referencing this root */
-#else
-       uint16_t changes;
-#endif
 } ;

 struct dbg_mirror_list {
-#ifdef __KERNEL__
        u32 dbthis;
-#else
-       uint32_t dbthis;
-#endif
        struct my_handle *hnext, *hprev;
        struct dbg_mirror_root *hroot;
-#ifdef __KERNEL__
        u16 dbsiz;
-#else
-       uint16_t dbsiz;
-#endif
-#ifdef __KERNEL__
        u32 context;    /* Save context for .dllview memory allocation */
-#else
-       uint32_t context;
-#endif
 } ;

 #define VARIABLE_SIZE 1
@@ -149,17 +116,10 @@
  * reduced symbol structure used for symbols during relocation
  */
 struct Local_Symbol {
-#ifdef __KERNEL__
        s32 value;      /* Relocated symbol value */
        s32 delta;      /* Original value in input file */
        s16 secnn;              /* section number */
        s16 sclass;             /* symbol class */
-#else
-       int_least32_t value;    /* Relocated symbol value */
-       int_least32_t delta;    /* Original value in input file */
-       int16_t secnn;          /* section number */
-       int16_t sclass;         /* symbol class */
-#endif
 } ;

 /*
@@ -213,11 +173,7 @@
        enum cinit_mode cinit_state;    /* current state of cload_cinit() */
        int cinit_count;        /* the current count */
        LDR_ADDR cinit_addr;    /* the current address */
-#ifdef __KERNEL__
        s16 cinit_page; /* the current page */
-#else
-       uint16_t cinit_page;
-#endif
        /* Handle to be returned by Dynamic_Load_Module */
        struct my_handle *myhandle;
        unsigned dload_errcount;        /* Total # of errors reported so far */
@@ -227,11 +183,7 @@
        boolean big_e_target;   /* Target data in big-endian format */
 #endif
        /* map for reordering bytes, 0 if not needed */
-#ifdef __KERNEL__
        u32 reorder_map;
-#else
-       uint_least32_t reorder_map;
-#endif
        struct doff_filehdr_t dfile_hdr;        /* DOFF file header structure */
        struct doff_verify_rec_t verify;        /* Verify record */

@@ -256,13 +208,9 @@
 extern void dload_headers(struct dload_state *dlthis);
 extern void dload_strings(struct dload_state *dlthis, boolean sec_names_only);
 extern void dload_sections(struct dload_state *dlthis);
-#ifndef __KERNEL__
-extern void dload_reorder(void *data, int dsiz, uint_least32_t map);
-extern uint32_t dload_checksum(void *data, unsigned siz);
-#else
 extern void dload_reorder(void *data, int dsiz, u32 map);
 extern u32 dload_checksum(void *data, unsigned siz);
-#endif
+
 #if HOST_ENDIANNESS
 extern uint32_t dload_reverse_checksum(void *data, unsigned siz);
 #if (TARGET_AU_BITS > 8) && (TARGET_AU_BITS < 32)
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/doff.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/doff.h 2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/doff.h      2008-07-30 00:46:32.000000000 -0500
@@ -28,89 +28,15 @@
 #define _DOFF_H

 #ifndef UINT32_C
-#ifndef __KERNEL__
-#define UINT32_C(zzz) ((uint32_t)zzz)
-#else
 #define UINT32_C(zzz) ((u32)zzz)
 #endif
-#endif

 #define BYTE_RESHUFFLE_VALUE UINT32_C(0x00010203)

 /* DOFF file header containing fields categorizing the remainder of the file */
 struct doff_filehdr_t {

-#ifndef __KERNEL__
-       /* string table size, including filename, in bytes              */
-       uint32_t df_strtab_size;
-
-       /* entry point if one exists */
-       uint32_t df_entrypt;
-
-       /* identifies byte ordering of file;
-        * always set to BYTE_RESHUFFLE_VALUE  */
-       uint32_t df_byte_reshuffle;
-
-       /* Size of the string table up to and including the last section name */
-       /* Size includes the name of the COFF file also              */
-       uint32_t df_scn_name_size;
-
-#ifndef _BIG_ENDIAN
-       /* number of symbols */
-       uint16_t df_no_syms;
-
-       /* length in bytes of the longest string, including terminating NULL */
-       /* excludes the name of the file                                  */
-       uint16_t df_max_str_len;
-
-       /* total number of sections including no-load ones               */
-       uint16_t df_no_scns;
-
-       /* number of sections containing target code allocated or downloaded */
-       uint16_t df_target_scns;
-
-       /* unique id for dll file format & version      */
-       uint16_t df_doff_version;
-
-       /* identifies ISA */
-       uint16_t df_target_id;
-
-       /* useful file flags */
-       uint16_t df_flags;
-
-       /* section reference for entry point, N_UNDEF for none,    */
-       /* N_ABS for absolute address */
-       int16_t df_entry_secn;
-#else
-       /* length of the longest string, including terminating NULL   */
-       uint16_t df_max_str_len;
-
-       /* number of symbols */
-       uint16_t df_no_syms;
-
-       /* number of sections containing target code allocated or downloaded */
-       uint16_t df_target_scns;
-
-       /* total number of sections including no-load ones */
-       uint16_t df_no_scns;
-
-       /* identifies ISA */
-       uint16_t df_target_id;
-
-       /* unique id for dll file format & version */
-       uint16_t df_doff_version;
-
-       /* section reference for entry point, N_UNDEF for none,   */
-       /* N_ABS for absolute address */
-       int16_t df_entry_secn;
-
-       /* useful file flags */
-       uint16_t df_flags;
-#endif
-       /* checksum for file header record */
-       uint32_t df_checksum;
-#else
-               /* string table size, including filename, in bytes   */
+       /* string table size, including filename, in bytes   */
        u32 df_strtab_size;

        /* entry point if one exists */
@@ -178,7 +104,6 @@
 #endif
        /* checksum for file header record */
        u32 df_checksum;
-#endif

 } ;

@@ -201,22 +126,6 @@
 /* Verification record containing values used to test integrity of the bits */
 struct doff_verify_rec_t {

-#ifndef __KERNEL__
-       /* time and date stamp */
-       uint32_t dv_timdat;
-
-       /* checksum for all section records */
-       uint32_t dv_scn_rec_checksum;
-
-       /* checksum for string table */
-       uint32_t dv_str_tab_checksum;
-
-       /* checksum for symbol table */
-       uint32_t dv_sym_tab_checksum;
-
-       /* checksum for verification record */
-       uint32_t dv_verify_rec_checksum;
-#else
        /* time and date stamp */
        u32 dv_timdat;

@@ -231,7 +140,6 @@

        /* checksum for verification record */
        u32 dv_verify_rec_checksum;
-#endif

 } ;

@@ -250,24 +158,6 @@

 struct doff_scnhdr_t {

-#ifndef __KERNEL__
-       int32_t ds_offset;      /* offset into string table of name    */
-       int32_t ds_paddr;       /* RUN address, in target AU           */
-       int32_t ds_vaddr;       /* LOAD address, in target AU          */
-       int32_t ds_size;        /* section size, in target AU          */
-#ifndef _BIG_ENDIAN
-       uint16_t ds_page;       /* memory page id                      */
-       uint16_t ds_flags;      /* section flags                       */
-#else
-       uint16_t ds_flags;      /* section flags                       */
-       uint16_t ds_page;       /* memory page id                      */
-#endif
-       uint32_t ds_first_pkt_offset;
-       /* Absolute byte offset into the file  */
-       /* where the first image record resides */
-
-       int32_t ds_nipacks;     /* number of image packets             */
-#else
        s32 ds_offset;  /* offset into string table of name    */
        s32 ds_paddr;   /* RUN address, in target AU           */
        s32 ds_vaddr;   /* LOAD address, in target AU          */
@@ -284,23 +174,12 @@
        /* where the first image record resides */

        s32 ds_nipacks; /* number of image packets             */
-#endif
+
 };

 /* Symbol table entry */
 struct doff_syment_t {

-#ifndef __KERNEL__
-       int32_t dn_offset;      /* offset into string table of name    */
-       int32_t dn_value;       /* value of symbol                     */
-#ifndef _BIG_ENDIAN
-       int16_t dn_scnum;       /* section number                      */
-       int16_t dn_sclass;      /* storage class                       */
-#else
-       int16_t dn_sclass;      /* storage class                       */
-       int16_t dn_scnum;       /* section number, 1-based             */
-#endif
-#else
        s32 dn_offset;  /* offset into string table of name    */
        s32 dn_value;   /* value of symbol                     */
 #ifndef _BIG_ENDIAN
@@ -310,7 +189,7 @@
        s16 dn_sclass;  /* storage class                       */
        s16 dn_scnum;   /* section number, 1-based             */
 #endif
-#endif
+
 } ;

 /* special values for dn_scnum */
@@ -329,27 +208,6 @@
 /* information necessary for its processing.                          */
 struct image_packet_t {

-#ifndef __KERNEL__
-       int32_t i_num_relocs;   /* number of relocations for   */
-       /* this packet                 */
-
-       int32_t i_packet_size;  /* number of bytes in array    */
-       /* "bits" occupied  by         */
-       /* valid data.  Could be       */
-       /* < IMAGE_PACKET_SIZE to      */
-       /* prevent splitting a         */
-       /* relocation across packets.  */
-       /* Last packet of a section    */
-       /* will most likely contain    */
-       /* < IMAGE_PACKET_SIZE bytes   */
-       /* of valid data               */
-
-       int32_t i_checksum;     /* Checksum for image packet   */
-       /* and the corresponding       */
-       /* relocation records          */
-
-       uint_least8_t *i_bits;  /* Actual data in section      */
-#else
        s32 i_num_relocs;       /* number of relocations for   */
        /* this packet                 */

@@ -369,73 +227,19 @@
        /* relocation records          */

        u8 *i_bits;     /* Actual data in section      */
-#endif
+
 };

 /* The relocation structure definition matches the COFF version.  Offsets  */
 /* however are relative to the image packet base not the section base.     */
 struct reloc_record_t {
-#ifndef __KERNEL__
-       int32_t r_vaddr;        /* (virtual) address of reference   */
-#else
+
        s32 r_vaddr;
-#endif
+
        /* expressed in target AUs          */

        union {
                struct {
-#ifndef __KERNEL__
-#ifndef _BIG_ENDIAN
-                       uint8_t _offset;        /* bit offset of rel fld      */
-                       uint8_t _fieldsz;       /* size of rel fld            */
-                       uint8_t _wordsz;        /* # bytes containing rel fld */
-                       uint8_t _dum1;
-                       uint16_t _dum2;
-                       uint16_t _type;
-#else
-                       unsigned _dum1:8;
-                       unsigned _wordsz:8;     /* # bytes containing rel fld */
-                       unsigned _fieldsz:8;    /* size of rel fld            */
-                       unsigned _offset:8;     /* bit offset of rel fld      */
-                       uint16_t _type;
-                       uint16_t _dum2;
-#endif
-               } _r_field;
-
-               struct {
-                       uint32_t _spc;  /* image packet relative PC   */
-#ifndef _BIG_ENDIAN
-                       uint16_t _dum;
-                       uint16_t _type; /* relocation type            */
-#else
-                       uint16_t _type; /* relocation type            */
-                       uint16_t _dum;
-#endif
-               } _r_spc;
-
-               struct {
-                       uint32_t _uval; /* constant value             */
-#ifndef _BIG_ENDIAN
-                       uint16_t _dum;
-                       uint16_t _type; /* relocation type            */
-#else
-                       uint16_t _type; /* relocation type            */
-                       uint16_t _dum;
-#endif
-               } _r_uval;
-
-               struct {
-                       int32_t _symndx;        /* 32-bit sym tbl index       */
-#ifndef _BIG_ENDIAN
-                       uint16_t _disp; /* extra addr encode data     */
-                       uint16_t _type; /* relocation type            */
-#else
-                       uint16_t _type; /* relocation type            */
-                       uint16_t _disp; /* extra addr encode data     */
-#endif
-               } _r_sym;
-       } _u_reloc;
-#else
 #ifndef _BIG_ENDIAN
                        u8 _offset;     /* bit offset of rel fld      */
                        u8 _fieldsz;    /* size of rel fld            */
@@ -486,7 +290,6 @@
 #endif
                } _r_sym;
        } _u_reloc;
-#endif

 } ;

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/header.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/header.h       2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/header.h    2008-07-30 00:46:32.000000000 -0500
@@ -27,13 +27,10 @@

 /* maximum parenthesis nesting in relocation stack expressions */
 #define STATIC_EXPR_STK_SIZE 10
-#ifndef __KERNEL__
-#include <stdint.h>
-#else
+
 #include <linux/types.h>
 typedef unsigned int            uint_least32_t;
 typedef unsigned short int     uint_least16_t;
-#endif

 #include "doff.h"
 #include "dynamic_loader.h"
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/module_list.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/module_list.h  2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/module_list.h       2008-07-30 00:46:32.000000000 -0500
@@ -62,11 +62,7 @@
 #ifndef _MODULE_LIST_H_
 #define _MODULE_LIST_H_

-#ifndef __KERNEL__
-#include <stdint.h>
-#else
 #include <linux/types.h>
-#endif

 /* Global pointer to the modules_header structure*/
 #define MODULES_HEADER "_DLModules"
@@ -85,22 +81,7 @@
 /* the first entry in the list is the modules_header record;
  * its address is contained in the global _DLModules pointer */
 struct modules_header {
-#ifndef __KERNEL__
-       /* Address of the first dll_module record in the list or NULL.
-        * Note: for C55x this is a word address (C55x data is
-        * word-addressable)*/
-       uint32_t first_module;
-
-       /* Combined storage size (in target addressable units) of the
-        * dll_module record which follows this header record, or zero
-        * if the list is empty.  This size includes the module's string table.
-        * Note: for C55x the unit is a 16-bit word */
-       uint16_t first_module_size;

-       /* Counter is incremented whenever a module record is removed from
-        * the list */
-       uint16_t update_flag;
-#else
        /* Address of the first dll_module record in the list or NULL.
         Note: for C55x this is a word address (C55x data is word-addressable)*/
        u32 first_module;
@@ -114,7 +95,6 @@
        /* Counter is incremented whenever a module record is removed from
         * the list */
        u16 update_flag;
-#endif

 } ;

@@ -124,21 +104,7 @@

 /* information recorded about each section in a module */
 struct dll_sect {
-#ifndef __KERNEL__
-       /* Load-time address of the section.
-        * Note: for C55x this is a byte address for program sections, and
-        * a word address for data sections.  C55x program memory is
-        * byte-addressable, while data memory is word-addressable. */
-       uint32_t sect_load_adr;

-       /* Run-time address of the section.
-        * Note 1: for C55x this is a byte address for program sections, and
-        * a word address for data sections.
-        * Note 2: for C55x two most significant bits of this field indicate
-        * the section type: '00' for a code section, '11' for a data section
-        * (C55 addresses are really only 24-bits wide). */
-       uint32_t sect_run_adr;
-#else
        /* Load-time address of the section.
         * Note: for C55x this is a byte address for program sections, and
         * a word address for data sections.  C55x program memory is
@@ -152,38 +118,12 @@
         * the section type: '00' for a code section, '11' for a data section
         * (C55 addresses are really only 24-bits wide). */
        u32 sect_run_adr;
-#endif
+
 } ;

 /* the rest of the entries in the list are module records */
 struct dll_module {
-#ifndef __KERNEL__
-       /* Address of the next dll_module record in the list, or 0 if this is
-        * the last record in the list.
-        * Note: for C55x this is a word address (C55x data is
-        * word-addressable)                                                */
-       uint32_t next_module;
-
-       /* Combined storage size (in target addressable units) of the
-        * dll_module record which follows this one, or zero if this is the
-        * last record in the list.  This size includes the module's string
-        * table.
-        * Note: for C55x the unit is a 16-bit word. */
-       uint16_t next_module_size;

-       /* version number of the tooling; set to INIT_VERSION for Phase 1 */
-       uint16_t version;
-
-       /* the verification word; set to VERIFICATION */
-       uint16_t verification;
-
-       /* Number of sections in the sects array */
-       uint16_t num_sects;
-
-       /* Module's "unique" id; copy of the timestamp from the host
-        * COFF file */
-       uint32_t timestamp;
-#else
        /* Address of the next dll_module record in the list, or 0 if this is
         * the last record in the list.
         * Note: for C55x this is a word address (C55x data is
@@ -209,7 +149,7 @@
        /* Module's "unique" id; copy of the timestamp from the host
         * COFF file */
        u32 timestamp;
-#endif
+
        /* Array of num_sects elements of the module's section records */
        struct dll_sect sects[1];
 } ;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/params.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/params.h       2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/params.h    2008-07-30 00:46:32.000000000 -0500
@@ -214,24 +214,12 @@

 /* the unit in which we process target image data */
 #if TARGET_AU_BITS <= 8
-#ifndef __KERNEL__
-typedef uint_least8_t TgtAU_t;
-#else
 typedef u8 TgtAU_t;
-#endif
 #elif TARGET_AU_BITS <= 16
-#ifndef __KERNEL__
-typedef uint_least16_t TgtAU_t;
-#else
 typedef u16 TgtAU_t;
-#endif
-#else
-#ifndef __KERNEL__
-typedef uint_least32_t TgtAU_t;
 #else
 typedef u32 TgtAU_t;
 #endif
-#endif

 /* size of that unit */
 #if TARGET_AU_BITS < BITS_PER_AU
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc_table.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc_table.h  2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc_table.h       2008-07-30 00:46:32.000000000 -0500
@@ -21,11 +21,7 @@
 /*
  * Table of relocation operator properties
  */
-#ifndef __KERNEL__
-#include "stdint.h"
-#else
 #include <linux/types.h>
-#endif

 /* How does this relocation operation access the program image? */
 #define ROP_N  0               /* does not access image */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dbll.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dbll.c    2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dbll.c 2008-07-30 00:46:32.000000000 -0500
@@ -751,19 +751,11 @@
        } else {
                /* Do a fake load to get symbols - set write function to NoOp */
                zlLib->init.dlInit.writemem = NoOp;
-#ifdef OPT_ELIMINATE_EXTRA_DLOAD
                err = Dynamic_Open_Module(&zlLib->stream.dlStream,
                                        &zlLib->symbol.dlSymbol,
                                        &zlLib->allocate.dlAlloc,
                                        &zlLib->init.dlInit, 0,
                                        &zlLib->mHandle);
-#else
-               err = Dynamic_Load_Module(&zlLib->stream.dlStream,
-                                        &zlLib->symbol.dlSymbol,
-                                        &zlLib->allocate.dlAlloc,
-                                        &zlLib->init.dlInit, 0,
-                                        &zlLib->mHandle);
-#endif
                if (err != 0) {
                        GT_1trace(DBLL_debugMask, GT_6CLASS, "DBLL_open: "
                                 "Dynamic_Load_Module failed: 0x%lx\n", err);
@@ -1526,7 +1518,6 @@
                   unsigned val)
 {
        Bool retVal = TRUE;
-#ifdef OPT_USE_MEMSET
        char *pBuf;
        struct DBLL_LibraryObj *lib;
        struct DBLLInit *pInit = (struct DBLLInit *)this;
@@ -1542,23 +1533,6 @@
                writeMem(this, &pBuf, addr, info, 0);
        if (pBuf)
                memset(pBuf, val, nBytes);
-#else
-       DBC_Require(this != NULL);
-       ulRemainBytes = nBytes;
-       /* Zero out buffer */
-       memset(tempBuf, val, MAXEXPR);
-
-       while ((ulRemainBytes > 0) && retVal) {
-               ulBytes = ulRemainBytes > MAXEXPR ? MAXEXPR : ulRemainBytes;
-
-               /* Call a function to fill memory */
-               retVal = writeMem(this, tempBuf, addr, info, ulBytes);
-
-               ulRemainBytes -= ulBytes;
-               /* (u8 *) addr += ulBytes; */
-               addr = (LDR_ADDR)((u8 *)addr + ulBytes);
-       }
-#endif
        return retVal;
 }

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_io.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_io.c        2008-07-30 00:46:15.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_io.c     2008-07-30 00:46:32.000000000 -0500
@@ -427,9 +427,7 @@
                MEM_UnmapLinearAddress((void *) pDevContext->dwDspExtBaseAddr);
                pDevContext->dwDspExtBaseAddr = 0x0;
        }
-#ifdef OPT_REDUCE_SYMBOL_LOOKUPS
        bSymbolsReloaded = FALSE;
-#endif
        return retVal;
 }
 ---

Regards,

omar
