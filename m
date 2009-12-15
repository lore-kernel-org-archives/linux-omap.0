From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 02/17] DSPBRIDGE: Implemented Trampoline support for dynamic loader
Date: Tue, 15 Dec 2009 00:19:43 -0600
Message-ID: <1260857998-19349-3-git-send-email-omar.ramirez@ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55098 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbZLOGMx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 01:12:53 -0500
In-Reply-To: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

Implemented on dynamic loader automatic generation of
trampolines when near calls are made to outside of signed
21-bit offset available in the C64X+ DSP.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/Makefile                    |    3 +-
 drivers/dsp/bridge/dynload/cload.c             |  322 +++++---
 drivers/dsp/bridge/dynload/dload_internal.h    |  125 +++-
 drivers/dsp/bridge/dynload/reloc.c             |   81 ++-
 drivers/dsp/bridge/dynload/tramp.c             | 1110 ++++++++++++++++++++++++
 drivers/dsp/bridge/dynload/tramp_table_c6000.c |  164 ++++
 6 files changed, 1659 insertions(+), 146 deletions(-)
 create mode 100644 drivers/dsp/bridge/dynload/tramp.c
 create mode 100644 drivers/dsp/bridge/dynload/tramp_table_c6000.c

diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index e10a2da..cb6d1ce 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -14,7 +14,8 @@ libpmgr = pmgr/chnl.o pmgr/io.o pmgr/msg.o pmgr/cod.o pmgr/dev.o pmgr/wcd.o \
 librmgr = rmgr/dbdcd.o rmgr/disp.o rmgr/drv.o rmgr/mgr.o rmgr/node.o \
 		rmgr/proc.o rmgr/pwr.o rmgr/rmm.o rmgr/strm.o rmgr/dspdrv.o \
 		rmgr/nldr.o rmgr/drv_interface.o
-libdload = dynload/cload.o dynload/getsection.o dynload/reloc.o
+libdload = dynload/cload.o dynload/getsection.o dynload/reloc.o \
+		 dynload/tramp.o
 libhw = hw/hw_prcm.o hw/hw_dspssC64P.o hw/hw_mmu.o hw/hw_mbox.o
 
 bridgedriver-objs = $(libgen) $(libservices) $(libwmd) $(libpmgr) $(librmgr) \
diff --git a/drivers/dsp/bridge/dynload/cload.c b/drivers/dsp/bridge/dynload/cload.c
index 4fead55..7b9cd97 100644
--- a/drivers/dsp/bridge/dynload/cload.c
+++ b/drivers/dsp/bridge/dynload/cload.c
@@ -191,6 +191,8 @@ int Dynamic_Load_Module(struct Dynamic_Loader_Stream *module,
 		symbol_table_free(&dl_state);
 		section_table_free(&dl_state);
 		string_table_free(&dl_state);
+		dload_tramp_cleanup(&dl_state);
+
 
 		if (dl_state.dload_errcount) {
 			Dynamic_Unload_Module(dl_state.myhandle, syms, alloc,
@@ -489,10 +491,14 @@ static void allocate_sections(struct dload_state *dlthis)
 		DL_ERROR("Arg 3 (alloc) required but NULL", 0);
 		return;
 	}
-	/* allocate space for the module handle, which we will
-	 *	keep for unload purposes */
-	siz = dlthis->dfile_hdr.df_target_scns *
-	      sizeof(struct LDR_SECTION_INFO) + MY_HANDLE_SIZE;
+	/*
+	 * allocate space for the module handle, which we will keep for unload
+	 * purposes include an additional section store for an auto-generated
+	 * trampoline section in case we need it.
+	 */
+	siz = (dlthis->dfile_hdr.df_target_scns + 1) *
+		sizeof(struct LDR_SECTION_INFO) + MY_HANDLE_SIZE;
+
 	hndl = (struct my_handle *)dlthis->mysym->Allocate(dlthis->mysym, siz);
 	if (!hndl) {		/* not enough storage */
 		DL_ERROR(E_ALLOC, siz);
@@ -587,7 +593,7 @@ static void section_table_free(struct dload_state *dlthis)
  * big unsorted array.  We just read that array into memory in bulk.
  ************************************************************************/
 static const char S_STRINGTBL[] = { "string table" };
-void dload_strings(struct dload_state *dlthis, boolean sec_names_only)
+void dload_strings(struct dload_state *dlthis, bool sec_names_only)
 {
 	u32 ssiz;
 	char *strbuf;
@@ -707,11 +713,16 @@ static void dload_symbols(struct dload_state *dlthis)
 	if (s_count == 0)
 		return;
 
-	/* We keep a local symbol table for all of the symbols in the input.
+	/*
+	 * We keep a local symbol table for all of the symbols in the input.
 	 * This table contains only section & value info, as we do not have
 	 * to do any name processing for locals.  We reuse this storage
 	 * as a temporary for .dllview record construction.
-	 * Allocate storage for the whole table.*/
+	 * Allocate storage for the whole table.  Add 1 to the section count
+	 * in case a trampoline section is auto-generated as well as the
+	 * size of the trampoline section name so DLLView doens't get lost.
+	 */
+
 	siz = s_count * sizeof(struct Local_Symbol);
 	dsiz = DBG_HDR_SIZE +
 		(sizeof(struct dll_sect) * dlthis->allocated_secn_count) +
@@ -790,6 +801,12 @@ static void dload_symbols(struct dload_state *dlthis)
 					goto loop_cont;
 				}
 				val = delta = symp->value;
+#ifdef ENABLE_TRAMP_DEBUG
+				dload_syms_error(dlthis->mysym,
+						"===> ext sym [%s] at %x",
+						sname, val);
+#endif
+
 				goto loop_cont;
 			}
 			/* symbol defined by this module */
@@ -1045,9 +1062,11 @@ loopexit:
 #define MY_RELOC_BUF_SIZ 8
 /* careful! exists at the same time as the image buffer*/
 static int relocate_packet(struct dload_state *dlthis,
-			   struct image_packet_t *ipacket, u32 *checks)
+				struct image_packet_t *ipacket,
+				u32 *checks, bool *tramps_generated)
 {
 	u32 rnum;
+	*tramps_generated = false;
 
 	rnum = ipacket->i_num_relocs;
 	do {			/* all relocs */
@@ -1068,11 +1087,21 @@ static int relocate_packet(struct dload_state *dlthis,
 		*checks += dload_checksum(rp, siz);
 		do {
 			/* perform the relocation operation */
-			dload_relocate(dlthis, (TgtAU_t *) ipacket->i_bits, rp);
+			dload_relocate(dlthis, (TgtAU_t *) ipacket->i_bits, rp,
+					tramps_generated, false);
 			rp += 1;
 			rnum -= 1;
 		} while ((rinbuf -= 1) > 0);
 	} while (rnum > 0);	/* all relocs */
+	/* If trampoline(s) were generated, we need to do an update of the
+	 * trampoline copy of the packet since a 2nd phase relo will be done
+	 * later.  */
+	if (*tramps_generated == true) {
+		dload_tramp_pkt_udpate(dlthis,
+				(dlthis->image_secn - dlthis->ldr_sections),
+				dlthis->image_offset, ipacket);
+	}
+
 	return 1;
 }				/* dload_read_reloc */
 
@@ -1097,7 +1126,7 @@ static void dload_data(struct dload_state *dlthis)
 	struct doff_scnhdr_t *sptr = dlthis->sect_hdrs;
 	struct LDR_SECTION_INFO *lptr = dlthis->ldr_sections;
 #ifdef OPT_ZERO_COPY_LOADER
-	boolean bZeroCopy = false;
+	bool bZeroCopy = false;
 #endif
 	u8 *pDest;
 
@@ -1107,155 +1136,158 @@ static void dload_data(struct dload_state *dlthis)
 	} ibuf;
 
 	/* Indicates whether CINIT processing has occurred */
-	boolean cinit_processed = false;
+	bool cinit_processed = false;
 
 	/* Loop through the sections and load them one at a time.
 	 */
 	for (curr_sect = 0; curr_sect < dlthis->dfile_hdr.df_no_scns;
 	     curr_sect += 1) {
-		if (DS_NEEDS_DOWNLOAD(sptr)) {
-			s32 nip;
-			LDR_ADDR image_offset = 0;
-			/* set relocation info for this section */
-			if (curr_sect < dlthis->allocated_secn_count)
-				dlthis->delta_runaddr = sptr->ds_paddr;
-			else {
-				lptr = DOFFSEC_IS_LDRSEC(sptr);
-				dlthis->delta_runaddr = 0;
-			}
-			dlthis->image_secn = lptr;
+		if (!DS_NEEDS_DOWNLOAD(sptr))
+			goto loop_cont1;
+
+		s32 nip;
+		LDR_ADDR image_offset = 0;
+		/* set relocation info for this section */
+		if (curr_sect < dlthis->allocated_secn_count)
+			dlthis->delta_runaddr = sptr->ds_paddr;
+		else {
+			lptr = DOFFSEC_IS_LDRSEC(sptr);
+			dlthis->delta_runaddr = 0;
+		}
+		dlthis->image_secn = lptr;
 #if BITS_PER_AU > BITS_PER_BYTE
-			lptr->name = unpack_name(dlthis, sptr->ds_offset);
+		lptr->name = unpack_name(dlthis, sptr->ds_offset);
 #endif
-			nip = sptr->ds_nipacks;
-			while ((nip -= 1) >= 0) {	/* process packets */
-
-				s32 ipsize;
-				u32 checks;
-				/* get the fixed header bits */
-				if (dlthis->strm->read_buffer(dlthis->strm,
-				    &ibuf.ipacket, IPH_SIZE) != IPH_SIZE) {
-					DL_ERROR(E_READSTRM, IMAGEPAK);
-					return;
-				}
-				/* reorder the header if need be */
-				if (dlthis->reorder_map) {
-					dload_reorder(&ibuf.ipacket, IPH_SIZE,
-						      dlthis->reorder_map);
-				}
-				/* now read the rest of the packet */
-				ipsize =
-				    BYTE_TO_HOST(DOFF_ALIGN
-						(ibuf.ipacket.i_packet_size));
-				if (ipsize > BYTE_TO_HOST(IMAGE_PACKET_SIZE)) {
-					DL_ERROR("Bad image packet size %d",
-						ipsize);
-					return;
-				}
-				pDest = ibuf.bufr;
+		nip = sptr->ds_nipacks;
+		while ((nip -= 1) >= 0) {	/* process packets */
+			s32 ipsize;
+			u32 checks;
+			bool  tramp_generated = false;
+
+			/* get the fixed header bits */
+			if (dlthis->strm->read_buffer(dlthis->strm,
+			    &ibuf.ipacket, IPH_SIZE) != IPH_SIZE) {
+				DL_ERROR(E_READSTRM, IMAGEPAK);
+				return;
+			}
+			/* reorder the header if need be */
+			if (dlthis->reorder_map) {
+				dload_reorder(&ibuf.ipacket, IPH_SIZE,
+					      dlthis->reorder_map);
+			}
+			/* now read the rest of the packet */
+			ipsize = BYTE_TO_HOST(DOFF_ALIGN
+					(ibuf.ipacket.i_packet_size));
+			if (ipsize > BYTE_TO_HOST(IMAGE_PACKET_SIZE)) {
+				DL_ERROR("Bad image packet size %d", ipsize);
+				return;
+			}
+			pDest = ibuf.bufr;
 #ifdef OPT_ZERO_COPY_LOADER
-				bZeroCopy = false;
-				if (DLOAD_SECT_TYPE(sptr) != DLOAD_CINIT) {
-					dlthis->myio->writemem(dlthis->myio,
-						&pDest, lptr->load_addr +
-						image_offset, lptr, 0);
+			bZeroCopy = false;
+			if (DLOAD_SECT_TYPE(sptr) != DLOAD_CINIT) {
+				dlthis->myio->writemem(dlthis->myio, &pDest,
+					lptr->load_addr + image_offset,
+					lptr, 0);
 				bZeroCopy = (pDest != ibuf.bufr);
-				}
+			}
 #endif
-		/* End of determination */
+			/* End of determination */
 
-				if (dlthis->strm->read_buffer(dlthis->strm,
-				    ibuf.bufr, ipsize) != ipsize) {
-					DL_ERROR(E_READSTRM, IMAGEPAK);
-					return;
-				}
-				ibuf.ipacket.i_bits = pDest;
+			if (dlthis->strm->read_buffer(dlthis->strm,
+			    ibuf.bufr, ipsize) != ipsize) {
+				DL_ERROR(E_READSTRM, IMAGEPAK);
+				return;
+			}
+			ibuf.ipacket.i_bits = pDest;
 
-				/* reorder the bytes if need be */
+			/* reorder the bytes if need be */
 #if !defined(_BIG_ENDIAN) || (TARGET_AU_BITS > 16)
-				if (dlthis->reorder_map) {
-					dload_reorder(pDest, ipsize,
-						     dlthis->reorder_map);
-				}
-				checks = dload_checksum(pDest, ipsize);
+			if (dlthis->reorder_map) {
+				dload_reorder(pDest, ipsize,
+					     dlthis->reorder_map);
+			}
+			checks = dload_checksum(pDest, ipsize);
 #else
-				if (dlthis->dfile_hdr.df_byte_reshuffle !=
-				    TARGET_ORDER(REORDER_MAP
-				    (BYTE_RESHUFFLE_VALUE))) {
-					/* put image bytes in big-endian order,
-					 * not PC order */
-					dload_reorder(pDest, ipsize,
+			if (dlthis->dfile_hdr.df_byte_reshuffle !=
+			    TARGET_ORDER(REORDER_MAP(BYTE_RESHUFFLE_VALUE))) {
+				/* put image bytes in big-endian order,
+				 * not PC order */
+				dload_reorder(pDest, ipsize,
 					TARGET_ORDER
 					(dlthis->dfile_hdr.df_byte_reshuffle));
-				}
+			}
 #if TARGET_AU_BITS > 8
-				checks = dload_reverse_checksum_16(pDest,
-								   ipsize);
+			checks = dload_reverse_checksum_16(pDest, ipsize);
 #else
-				checks = dload_reverse_checksum(pDest,
-								ipsize);
+			checks = dload_reverse_checksum(pDest, ipsize);
 #endif
 #endif
-
-				checks += dload_checksum(&ibuf.ipacket,
-							IPH_SIZE);
-				/* relocate the image bits as needed */
-				if (ibuf.ipacket.i_num_relocs) {
-					dlthis->image_offset = image_offset;
-					if (!relocate_packet(dlthis,
-					    &ibuf.ipacket, &checks))
-						return;	/* serious error */
-				}
-				if (~checks)
-					DL_ERROR(E_CHECKSUM, IMAGEPAK);
-				/* stuff the result into target memory */
+			checks += dload_checksum(&ibuf.ipacket,	IPH_SIZE);
+			/* relocate the image bits as needed */
+			if (ibuf.ipacket.i_num_relocs) {
+				dlthis->image_offset = image_offset;
+				if (!relocate_packet(dlthis,
+				    &ibuf.ipacket, &checks,
+				    &tramp_generated))
+					return;	/* serious error */
+			}
+			if (~checks)
+				DL_ERROR(E_CHECKSUM, IMAGEPAK);
+			/* Only write the result to the target if no
+			 * trampoline was generated.  Otherwise it
+			 * will be done during trampoline finalize.  */
+
+			if (tramp_generated == false) {
+				/* stuff the result into target
+				 * memory */
 				if (DLOAD_SECT_TYPE(sptr) == DLOAD_CINIT) {
 					cload_cinit(dlthis, &ibuf.ipacket);
 					cinit_processed = true;
 				} else {
 #ifdef OPT_ZERO_COPY_LOADER
-				    if (!bZeroCopy) {
+					if (!bZeroCopy) {
 #endif
-
-					if (!dlthis->myio->writemem
-					   (dlthis->myio, ibuf.bufr,
-					   lptr->load_addr + image_offset, lptr,
-					   BYTE_TO_HOST
-					   (ibuf.ipacket.i_packet_size))) {
-						DL_ERROR(
-						"Write to " FMT_UI32 " failed",
-						lptr->load_addr + image_offset);
-					}
+						if (!dlthis->myio->writemem
+						(dlthis->myio, ibuf.bufr,
+						lptr->load_addr + image_offset,
+						lptr, BYTE_TO_HOST
+						(ibuf.ipacket.i_packet_size))) {
+							DL_ERROR(
+							"Write to " FMT_UI32
+							" failed",
+							lptr->load_addr +
+							image_offset);
+						}
 #ifdef OPT_ZERO_COPY_LOADER
-				}
+					}
 #endif
-
 				}
-				image_offset +=
+			}
+			image_offset +=
 				      BYTE_TO_TADDR(ibuf.ipacket.i_packet_size);
-			}	/* process packets */
-			/* if this is a BSS section, we may want to fill it */
-			if (DLOAD_SECT_TYPE(sptr) != DLOAD_BSS)
-				goto loop_cont;
+		}	/* process packets */
+		/* if this is a BSS section, we may want to fill it */
+		if (DLOAD_SECT_TYPE(sptr) != DLOAD_BSS)
+			goto loop_cont;
 
-			if (!(dlthis->myoptions & DLOAD_INITBSS))
-				goto loop_cont;
+		if (!(dlthis->myoptions & DLOAD_INITBSS))
+			goto loop_cont;
 
-			if (cinit_processed) {
-				/* Don't clear BSS after load-time
-				 * initialization */
-				DL_ERROR
-				  ("Zero-initialization at " FMT_UI32 " after "
+		if (cinit_processed) {
+			/* Don't clear BSS after load-time
+			 * initialization */
+			DL_ERROR("Zero-initialization at " FMT_UI32 " after "
 				  "load-time initialization!", lptr->load_addr);
-				goto loop_cont;
-			}
-			/* fill the .bss area */
-			dlthis->myio->fillmem(dlthis->myio,
-					      TADDR_TO_HOST(lptr->load_addr),
-					      lptr, TADDR_TO_HOST(lptr->size),
-					      dload_fill_bss);
 			goto loop_cont;
-		} /* if DS_DOWNLOAD_MASK */
+		}
+		/* fill the .bss area */
+		dlthis->myio->fillmem(dlthis->myio,
+					TADDR_TO_HOST(lptr->load_addr),
+					lptr, TADDR_TO_HOST(lptr->size),
+					dload_fill_bss);
+		goto loop_cont;
+loop_cont1:
 		/* If not loading, but BSS, zero initialize */
 		if (DLOAD_SECT_TYPE(sptr) != DLOAD_BSS)
 			goto loop_cont;
@@ -1281,6 +1313,12 @@ loop_cont:
 		sptr += 1;
 		lptr += 1;
 	}			/* load sections */
+
+	/*  Finalize any trampolines that were created during the load  */
+	if (dload_tramp_finalize(dlthis) == 0) {
+		DL_ERROR("Finalization of auto-trampolines (size = " FMT_UI32
+			") failed", dlthis->tramp.tramp_sect_next_addr);
+    }
 }				/* dload_data */
 
 /*************************************************************************
@@ -1526,6 +1564,16 @@ static void init_module_handle(struct dload_state *dlthis)
 	hndl = dlthis->myhandle;
 	if (!hndl)
 		return;		/* must be errors detected, so forget it */
+
+	/*  Store the section count  */
+	hndl->secn_count = dlthis->allocated_secn_count;
+
+	/*  If a trampoline section was created, add it in  */
+	if (dlthis->tramp.tramp_sect_next_addr != 0)
+		hndl->secn_count += 1;
+
+	hndl->secn_count = hndl->secn_count << 1;
+
 	hndl->secn_count = dlthis->allocated_secn_count << 1;
 #ifndef TARGET_ENDIANNESS
 	if (dlthis->big_e_target)
@@ -1603,10 +1651,30 @@ static void init_module_handle(struct dload_state *dlthis)
 		dbsec += 1;
 		asecs += 1;
 	}
+
+	/*  If a trampoline section was created go ahead and add its info  */
+	if (dlthis->tramp.tramp_sect_next_addr != 0) {
+		dbmod->num_sects++;
+		dbsec->sect_load_adr = asecs->load_addr;
+		dbsec->sect_run_adr = asecs->run_addr;
+		dbsec++;
+		asecs++;
+	}
+
 	/* now cram in the names */
 	cp = copy_tgt_strings(dbsec, dlthis->str_head,
 			      dlthis->debug_string_size);
 
+
+	/* If a trampoline section was created, add its name so DLLView
+	 * can show the user the section info.  */
+	if (dlthis->tramp.tramp_sect_next_addr != 0) {
+		cp = copy_tgt_strings(cp,
+			dlthis->tramp.final_string_table,
+			strlen(dlthis->tramp.final_string_table) + 1);
+	}
+
+
 	/* round off the size of the debug record, and remember same */
 	hndl->dm.dbsiz = HOST_TO_TDATA_ROUND(cp - (char *)dbmod);
 	*cp = 0;		/* strictly to make our test harness happy */
@@ -1713,7 +1781,9 @@ int Dynamic_Unload_Module(DLOAD_mhandle mhandle,
 	if (!syms)
 		return 1;
 	syms->Purge_Symbol_Table(syms, (unsigned) hndl);
-	 /* Deallocate target memory for sections */
+	 /* Deallocate target memory for sections
+	  * NOTE: The trampoline section, if created, gets deleted here, too */
+
 	asecs = hndl->secns;
 	if (alloc)
 		for (curr_sect = (hndl->secn_count >> 1); curr_sect > 0;
diff --git a/drivers/dsp/bridge/dynload/dload_internal.h b/drivers/dsp/bridge/dynload/dload_internal.h
index 78f5058..65d1f47 100644
--- a/drivers/dsp/bridge/dynload/dload_internal.h
+++ b/drivers/dsp/bridge/dynload/dload_internal.h
@@ -120,7 +120,103 @@ struct Local_Symbol {
 	s32 delta;	/* Original value in input file */
 	s16 secnn;		/* section number */
 	s16 sclass;		/* symbol class */
-} ;
+};
+
+
+/*
+ * Trampoline data structures
+ */
+#define TRAMP_NO_GEN_AVAIL              65535
+#define TRAMP_SYM_PREFIX                "__$dbTR__"
+#define TRAMP_SECT_NAME                 ".dbTR"
+#define TRAMP_SYM_PREFIX_LEN            9  /*  MUST MATCH THE LENGTH ABOVE!! */
+#define TRAMP_SYM_HEX_ASCII_LEN         9  /*  Includes NULL termination  */
+
+#define GET_CONTAINER(ptr, type, field) ((type *)((unsigned long)ptr -\
+				(unsigned long)(&((type *)0)->field)))
+#ifndef FIELD_OFFSET
+#define FIELD_OFFSET(type, field)       ((unsigned long)(&((type *)0)->field))
+#endif
+
+
+/*
+    The trampoline code for the target is located in a table called
+    "tramp_gen_info" with is indexed by looking up the index in the table
+    "tramp_map".  The tramp_map index is acquired using the target
+    HASH_FUNC on the relocation type that caused the trampoline.  Each
+    trampoline code table entry MUST follow this format:
+
+    |----------------------------------------------|
+    |  tramp_gen_code_hdr                          |
+    |----------------------------------------------|
+    |  Trampoline image code                       |
+    |  (the raw instruction code for the target)   |
+    |----------------------------------------------|
+    |  Relocation entries for the image code       |
+    |----------------------------------------------|
+
+    This is very similar to how image data is laid out in the DOFF file
+    itself.
+*/
+struct tramp_gen_code_hdr {
+	u32		tramp_code_size;    /*  in BYTES  */
+	u32		num_relos;
+	u32		relo_offset;   /*  in BYTES  */
+};
+
+struct tramp_img_pkt {
+	struct tramp_img_pkt	*next;    /*  MUST BE FIRST  */
+	u32		base;
+	struct tramp_gen_code_hdr	hdr;
+	u8		payload[VARIABLE_SIZE];
+};
+
+struct tramp_img_dup_relo {
+	struct tramp_img_dup_relo	*next;
+	struct reloc_record_t	relo;
+};
+
+struct tramp_img_dup_pkt {
+	struct tramp_img_dup_pkt  *next;    /*  MUST BE FIRST  */
+	s16		secnn;
+	u32		offset;
+	struct image_packet_t                img_pkt;
+	struct tramp_img_dup_relo            *relo_chain;
+
+	/*  PAYLOAD OF IMG PKT FOLLOWS  */
+};
+
+struct tramp_sym {
+	struct tramp_sym	*next;    /*  MUST BE FIRST  */
+	u32		index;
+	u32		str_index;
+	struct Local_Symbol sym_info;
+};
+
+struct tramp_string {
+	struct tramp_string	*next;    /*  MUST BE FIRST  */
+	u32	index;
+	char    str[VARIABLE_SIZE];    /*  NULL terminated  */
+};
+
+struct tramp_info {
+	u32		tramp_sect_next_addr;
+	struct LDR_SECTION_INFO	sect_info;
+
+	struct tramp_sym		*symbol_head;
+	struct tramp_sym		*symbol_tail;
+	u32		tramp_sym_next_index;
+	struct	Local_Symbol		*final_sym_table;
+
+	struct tramp_string                *string_head;
+	struct tramp_string                *string_tail;
+	u32		tramp_string_next_index;
+	u32		tramp_string_size;
+	char		*final_string_table;
+
+	struct tramp_img_pkt		*tramp_pkts;
+	struct tramp_img_dup_pkt	*dup_pkts;
+};
 
 /*
  * States of the .cinit state machine
@@ -187,6 +283,8 @@ struct dload_state {
 	struct doff_filehdr_t dfile_hdr;	/* DOFF file header structure */
 	struct doff_verify_rec_t verify;	/* Verify record */
 
+	struct tramp_info tramp;	/* Trampoline data, if needed  */
+
 	int relstkidx;		/* index into relocation value stack */
 	/* relocation value stack used in relexp.c */
 	RVALUE relstk[STATIC_EXPR_STK_SIZE];
@@ -206,7 +304,7 @@ extern void dload_error(struct dload_state *dlthis, const char *errtxt, ...);
 extern void dload_syms_error(struct Dynamic_Loader_Sym *syms,
 			     const char *errtxt, ...);
 extern void dload_headers(struct dload_state *dlthis);
-extern void dload_strings(struct dload_state *dlthis, boolean sec_names_only);
+extern void dload_strings(struct dload_state *dlthis, bool sec_names_only);
 extern void dload_sections(struct dload_state *dlthis);
 extern void dload_reorder(void *data, int dsiz, u32 map);
 extern u32 dload_checksum(void *data, unsigned siz);
@@ -226,7 +324,8 @@ extern uint32_t dload_reverse_checksum_16(void *data, unsigned siz);
  * exported by reloc.c
  */
 extern void dload_relocate(struct dload_state *dlthis, TgtAU_t *data,
-			   struct reloc_record_t *rp);
+			struct reloc_record_t *rp, bool *tramps_generated,
+			bool second_pass);
 
 extern RVALUE dload_unpack(struct dload_state *dlthis, TgtAU_t *data,
 			   int fieldsz, int offset, unsigned sgn);
@@ -234,4 +333,24 @@ extern RVALUE dload_unpack(struct dload_state *dlthis, TgtAU_t *data,
 extern int dload_repack(struct dload_state *dlthis, RVALUE val, TgtAU_t *data,
 			int fieldsz, int offset, unsigned sgn);
 
+
+/*
+ * exported by tramp.c
+ */
+extern bool dload_tramp_avail(struct dload_state *dlthis,
+			struct reloc_record_t *rp);
+
+int dload_tramp_generate(struct dload_state *dlthis, s16 secnn,
+			u32 image_offset, struct image_packet_t *ipacket,
+			struct reloc_record_t *rp);
+
+extern int dload_tramp_pkt_udpate(struct dload_state *dlthis,
+			s16 secnn, u32 image_offset,
+			struct image_packet_t *ipacket);
+
+extern int dload_tramp_finalize(struct dload_state *dlthis);
+
+extern void dload_tramp_cleanup(struct dload_state *dlthis);
+
+
 #endif				/* __DLOAD_INTERNAL__ */
diff --git a/drivers/dsp/bridge/dynload/reloc.c b/drivers/dsp/bridge/dynload/reloc.c
index 54e460e..d4457c5 100644
--- a/drivers/dsp/bridge/dynload/reloc.c
+++ b/drivers/dsp/bridge/dynload/reloc.c
@@ -163,10 +163,10 @@ static const u8 C60_Scale[SCALE_MASK+1] = {
  *	Performs the specified relocation operation
  **************************************************************************/
 void dload_relocate(struct dload_state *dlthis, TgtAU_t *data,
-		    struct reloc_record_t *rp)
+			struct reloc_record_t *rp, bool *tramps_genereted,
+			bool second_pass)
 {
-	RVALUE val = 0;
-	RVALUE reloc_amt = 0;
+	RVALUE val, reloc_amt, orig_val = 0;
 	unsigned int fieldsz = 0;
 	unsigned int offset = 0;
 	unsigned int reloc_info = 0;
@@ -178,6 +178,17 @@ void dload_relocate(struct dload_state *dlthis, TgtAU_t *data,
 #ifdef RFV_SCALE
 	unsigned int scale = 0;
 #endif
+	struct image_packet_t *img_pkt = NULL;
+
+	/* The image packet data struct is only used during first pass
+	  * relocation in the event that a trampoline is needed.  2nd pass
+	  * relocation doesn't guarantee that data is coming from an
+	  * image_packet_t structure. See cload.c, dload_data for how i_bits is
+	  * set. If that changes this needs to be updated!!!  */
+	if (second_pass == false)
+		img_pkt = (struct image_packet_t *)((u8 *)data -
+				sizeof(struct image_packet_t));
+
 
 	rx = HASH_FUNC(rp->r_type);
 	while (rop_map1[rx] != rp->r_type) {
@@ -211,16 +222,22 @@ void dload_relocate(struct dload_state *dlthis, TgtAU_t *data,
 	/* Compute the relocation amount for the referenced symbol, if any */
 	reloc_amt = rp->r_uval;
 	if (RFV_SYM(reloc_info)) {	/* relocation uses a symbol reference */
-		if ((u32)rp->r_symndx < dlthis->dfile_hdr.df_no_syms) {
-			/* real symbol reference */
-			svp = &dlthis->local_symtab[rp->r_symndx];
-			reloc_amt = (RFV_SYM(reloc_info) == ROP_SYMD) ?
-				    svp->delta : svp->value;
+		/* If this is first pass, use the module local symbol table,
+		  * else use the trampoline symbol table.  */
+	       if (second_pass == false) {
+			if ((u32)rp->r_symndx < dlthis->dfile_hdr.df_no_syms) {
+				/* real symbol reference */
+				svp = &dlthis->local_symtab[rp->r_symndx];
+				reloc_amt = (RFV_SYM(reloc_info) == ROP_SYMD) ?
+					    svp->delta : svp->value;
+			}
+			/* reloc references current section */
+			else if (rp->r_symndx == -1) {
+				reloc_amt = (RFV_SYM(reloc_info) == ROP_SYMD) ?
+				dlthis->delta_runaddr :
+				dlthis->image_secn->run_addr;
+			}
 		}
-		/* reloc references current section */
-		else if (rp->r_symndx == -1)
-			reloc_amt = (RFV_SYM(reloc_info) == ROP_SYMD) ?
-			  dlthis->delta_runaddr : dlthis->image_secn->run_addr;
 	}	/* relocation uses a symbol reference */
 	/* Handle stack adjustment */
 	val = 0;
@@ -277,6 +294,10 @@ void dload_relocate(struct dload_state *dlthis, TgtAU_t *data,
 	if (reloc_info & ROP_R) {    /* relocation reads current image value */
 		val = dload_unpack(dlthis, data, fieldsz, offset,
 		      RFV_SIGN(reloc_info));
+	/* Save off the original value in case the relo overflows and
+	  * we can trampoline it.  */
+	orig_val = val;
+
 #ifdef RFV_SCALE
 		val <<= scale;
 #endif
@@ -414,10 +435,38 @@ void dload_relocate(struct dload_state *dlthis, TgtAU_t *data,
 #endif
 		if (dload_repack(dlthis, val, data, fieldsz, offset,
 		   RFV_SIGN(reloc_info))) {
-			dload_error(dlthis, "Relocation value " FMT_UI32
-			    " overflows %d bits in %s offset " FMT_UI32, val,
-			    fieldsz, dlthis->image_secn->name,
-			    dlthis->image_offset + rp->r_vaddr);
+			/* Check to see if this relo can be trampolined,
+			  * but only in first phase relocation.  2nd phase
+			  * relocation cannot trampoline.  */
+			if ((second_pass == false) &&
+				(dload_tramp_avail(dlthis, rp) == true)) {
+
+				/* Before generating the trampoline, restore
+				  * the value to its original so the 2nd pass
+				  *  relo will work.  */
+				dload_repack(dlthis, orig_val, data, fieldsz,
+					offset, RFV_SIGN(reloc_info));
+				if (!dload_tramp_generate(dlthis,
+					(dlthis->image_secn - dlthis->
+					ldr_sections), dlthis->image_offset,
+					img_pkt, rp)) {
+					dload_error(dlthis, "Failed to "
+					     "generate trampoline for bit "
+					     "overflow");
+					dload_error(dlthis, "Relocation value "
+					   FMT_UI32 " overflows %d bits in %s "
+					   "offset " FMT_UI32, val, fieldsz,
+					   dlthis->image_secn->name,
+					   dlthis->image_offset + rp->r_vaddr);
+				} else
+					*tramps_genereted = true;
+			} else {
+				dload_error(dlthis, "Relocation value "
+					FMT_UI32 " overflows %d bits in %s"
+					" offset " FMT_UI32, val, fieldsz,
+					dlthis->image_secn->name,
+					dlthis->image_offset + rp->r_vaddr);
+			}
 		}
 	} else if (top)
 		*stackp = val;
diff --git a/drivers/dsp/bridge/dynload/tramp.c b/drivers/dsp/bridge/dynload/tramp.c
new file mode 100644
index 0000000..8c725c7
--- /dev/null
+++ b/drivers/dsp/bridge/dynload/tramp.c
@@ -0,0 +1,1110 @@
+/*
+ *  Copyright 2009 by Texas Instruments Incorporated.
+ *  All rights reserved. Property of Texas Instruments Incorporated.
+ *  Restricted rights to use, duplicate or disclose this code are
+ *  granted through contract.
+ *
+ *  @(#) DSP/BIOS Bridge
+ */
+#include "header.h"
+
+#if TMS32060
+#include "tramp_table_c6000.c"
+#endif
+
+#define MAX_RELOS_PER_PASS	4
+
+/*
+ * Function:	priv_tramp_sect_tgt_alloc
+ * Description: Allocate target memory for the trampoline section.  The
+ *	  target mem size is easily obtained as the next available address.
+ */
+static int priv_tramp_sect_tgt_alloc(struct dload_state *dlthis)
+{
+	int ret_val = 0;
+	struct LDR_SECTION_INFO	*sect_info;
+
+	/*  Populate the trampoline loader section and allocate it on the
+	 * target.  The section name is ALWAYS the first string in the final
+	 * string table for trampolines.  The trampoline section is always
+	 * 1 beyond the total number of allocated sections.  */
+	sect_info = &dlthis->ldr_sections[dlthis->allocated_secn_count];
+
+	sect_info->name = dlthis->tramp.final_string_table;
+	sect_info->size = dlthis->tramp.tramp_sect_next_addr;
+	sect_info->context = 0;
+	sect_info->type =
+		(4 << 8) | DLOAD_TEXT | DS_ALLOCATE_MASK | DS_DOWNLOAD_MASK;
+	sect_info->page = 0;
+	sect_info->run_addr = 0;
+	sect_info->load_addr = 0;
+	ret_val = dlthis->myalloc->Allocate(dlthis->myalloc,
+			sect_info, DS_ALIGNMENT(sect_info->type));
+
+	if (ret_val == 0)
+		dload_error(dlthis, "Failed to allocate target memory for"
+							" trampoline");
+
+	return ret_val;
+}
+
+/*
+ * Function:	priv_h2a
+ * Description: Helper function to convert a hex value to its ASCII
+ *	  representation.  Used for trampoline symbol name generation.
+ */
+static u8 priv_h2a(u8 value)
+{
+	if (value > 0xF)
+		return 0xFF;
+
+	if (value <= 9)
+		value += 0x30;
+	else
+		value += 0x37;
+
+	return value;
+}
+
+/*
+ * Function:	priv_tramp_sym_gen_name
+ * Description: Generate a trampoline symbol name (ASCII) using the value
+ *	  of the symbol.  This places the new name into the user buffer.
+ *	  The name is fixed in length and of the form: __$dbTR__xxxxxxxx
+ *	  (where "xxxxxxxx" is the hex value.
+ */
+static void priv_tramp_sym_gen_name(u32 value, char *dst)
+{
+	u32 i;
+	volatile char *prefix = TRAMP_SYM_PREFIX;
+	volatile char *dst_local = dst;
+	u8 tmp;
+
+	/*  Clear out the destination, including the ending NULL  */
+	for (i = 0; i < (TRAMP_SYM_PREFIX_LEN + TRAMP_SYM_HEX_ASCII_LEN); i++)
+		*(dst_local + i) = 0;
+
+	/*  Copy the prefix to start  */
+	for (i = 0; i < strlen(TRAMP_SYM_PREFIX); i++) {
+		*dst_local = *(prefix + i);
+		dst_local++;
+	}
+
+	/*  Now convert the value passed in to a string equiv of the hex  */
+	for (i = 0; i < sizeof(value); i++) {
+#ifndef _BIG_ENDIAN
+		tmp = *(((u8 *)&value) + (sizeof(value) - 1) - i);
+		*dst_local = priv_h2a((tmp & 0xF0) >> 4);
+		dst_local++;
+		*dst_local = priv_h2a(tmp & 0x0F);
+		dst_local++;
+#else
+		tmp = *(((u8 *)&value) + i);
+		*dst_local = priv_h2a((tmp & 0xF0) >> 4);
+		dst_local++;
+		*dst_local = priv_h2a(tmp & 0x0F);
+		dst_local++;
+#endif
+	}
+
+	/*  NULL terminate  */
+	*dst_local = 0;
+}
+
+/*
+ * Function:	priv_tramp_string_create
+ * Description: Create a new string specific to the trampoline loading and add
+ *	  it to the trampoline string list.  This list contains the
+ *	  trampoline section name and trampoline point symbols.
+ */
+static struct tramp_string *priv_tramp_string_create(struct dload_state *dlthis,
+	  u32 str_len, char *str)
+{
+	struct tramp_string *new_string = NULL;
+	u32 i;
+
+	/*  Create a new string object with the specified size.  */
+	new_string = (struct tramp_string *)dlthis->mysym->Allocate(
+		dlthis->mysym, (sizeof(struct tramp_string) + str_len + 1));
+	if (new_string != NULL) {
+		/*  Clear the string first.  This ensures the ending NULL is
+		 * present and the optimizer won't touch it.  */
+		for (i = 0; i < (sizeof(struct tramp_string) + str_len + 1);
+				i++)
+			*((u8 *)new_string + i) = 0;
+
+		/*  Add this string to our virtual table by assigning it the
+		 * next index and pushing it to the tail of the list.  */
+		new_string->index = dlthis->tramp.tramp_string_next_index;
+		dlthis->tramp.tramp_string_next_index++;
+		dlthis->tramp.tramp_string_size += str_len + 1;
+
+		new_string->next = NULL;
+		if (dlthis->tramp.string_head == NULL)
+			dlthis->tramp.string_head = new_string;
+		else
+			dlthis->tramp.string_tail->next = new_string;
+
+		dlthis->tramp.string_tail = new_string;
+
+		/*  Copy the string over to the new object  */
+		for (i = 0; i < str_len; i++)
+			new_string->str[i] = str[i];
+	}
+
+	return new_string;
+}
+
+/*
+ * Function:	priv_tramp_string_find
+ * Description: Walk the trampoline string list and find a match for the
+ *	  provided string.  If not match is found, NULL is returned.
+ */
+static struct tramp_string *priv_tramp_string_find(struct dload_state *dlthis,
+								char *str)
+{
+	struct tramp_string *cur_str = NULL;
+	struct tramp_string *ret_val = NULL;
+	u32 i;
+	u32 str_len = strlen(str);
+
+	for (cur_str = dlthis->tramp.string_head;
+		 (ret_val == NULL) && (cur_str != NULL);
+		 cur_str = cur_str->next) {
+		/*  If the string lengths aren't equal, don't bother
+		 * comparing  */
+		if (str_len != strlen(cur_str->str))
+			continue;
+
+		/*  Walk the strings until one of them ends  */
+		for (i = 0; i < str_len; i++) {
+			/*  If they don't match in the current position then
+			 * break out now, no sense in continuing to look at
+			 * this string.  */
+			if (str[i] != cur_str->str[i])
+				break;
+		}
+
+		if (i == str_len)
+			ret_val = cur_str;
+	}
+
+	return ret_val;
+}
+
+/*
+ * Function:	priv_string_tbl_finalize
+ * Description: Flatten the trampoline string list into a table of NULL
+ *	  terminated strings.  This is the same format of string table
+ *	  as used by the COFF/DOFF file.
+ */
+static int priv_string_tbl_finalize(struct dload_state *dlthis)
+{
+	int ret_val = 0;
+	struct tramp_string *cur_string;
+	char *cur_loc;
+	char *tmp;
+
+	/*  Allocate enough space for all strings that have been created.  The
+	 * table is simply all strings concatenated together will NULL
+	 * endings.  */
+	dlthis->tramp.final_string_table =
+		(char *)dlthis->mysym->Allocate(dlthis->mysym,
+					dlthis->tramp.tramp_string_size);
+	if (dlthis->tramp.final_string_table != NULL) {
+		/*  We got our buffer, walk the list and release the nodes as*
+		 * we go  */
+		cur_loc = dlthis->tramp.final_string_table;
+		cur_string = dlthis->tramp.string_head;
+		while (cur_string != NULL) {
+			/*  Move the head/tail pointers  */
+			dlthis->tramp.string_head = cur_string->next;
+			if (dlthis->tramp.string_tail == cur_string)
+				dlthis->tramp.string_tail = NULL;
+
+			/*  Copy the string contents  */
+			for (tmp = cur_string->str;
+				 *tmp != '\0';
+				 tmp++, cur_loc++)
+				*cur_loc = *tmp;
+
+			/*  Pick up the NULL termination since it was missed by
+			 * breaking using it to end the above loop.  */
+			*cur_loc = '\0';
+			cur_loc++;
+
+			/*  Free the string node, we don't need it any more. */
+			dlthis->mysym->Deallocate(dlthis->mysym, cur_string);
+
+			/*  Move our pointer to the next one  */
+			cur_string = dlthis->tramp.string_head;
+		}
+
+		/*  Update our return value to success  */
+		ret_val = 1;
+	} else
+		dload_error(dlthis, "Failed to allocate trampoline "
+						"string table");
+
+	return ret_val;
+}
+
+/*
+ * Function:	priv_tramp_sect_alloc
+ * Description: Virtually allocate space from the trampoline section.  This
+ *	  function returns the next offset within the trampoline section
+ *	  that is available and moved the next available offset by the
+ *	  requested size.  NO TARGET ALLOCATION IS DONE AT THIS TIME.
+ */
+static u32 priv_tramp_sect_alloc(struct dload_state *dlthis, u32 tramp_size)
+{
+	u32 ret_val;
+
+	/*  If the next available address is 0, this is our first allocation.
+	 * Create a section name string to go into the string table .  */
+	if (dlthis->tramp.tramp_sect_next_addr == 0) {
+		dload_syms_error(dlthis->mysym, "*** WARNING ***  created "
+			"dynamic TRAMPOLINE section for module %s",
+			dlthis->str_head);
+	}
+
+	/*  Reserve space for the new trampoline  */
+	ret_val = dlthis->tramp.tramp_sect_next_addr;
+	dlthis->tramp.tramp_sect_next_addr += tramp_size;
+	return ret_val;
+}
+
+/*
+ * Function:	priv_tramp_sym_create
+ * Description: Allocate and create a new trampoline specific symbol and add
+ *	  it to the trampoline symbol list.  These symbols will include
+ *	  trampoline points as well as the external symbols they
+ *	  reference.
+ */
+static struct tramp_sym *priv_tramp_sym_create(struct dload_state *dlthis,
+			u32 str_index, struct Local_Symbol *tmp_sym)
+{
+	struct tramp_sym	*new_sym = NULL;
+	u32 i;
+
+	/*  Allocate new space for the symbol in the symbol table.  */
+	new_sym = (struct tramp_sym *)dlthis->mysym->Allocate(dlthis->mysym,
+						   sizeof(struct tramp_sym));
+	if (new_sym != NULL) {
+		for (i = 0; i != sizeof(struct tramp_sym); i++)
+			*((char *)new_sym + i) = 0;
+
+		/*  Assign this symbol the next symbol index for easier
+		 * reference later during relocation.  */
+		new_sym->index = dlthis->tramp.tramp_sym_next_index;
+		dlthis->tramp.tramp_sym_next_index++;
+
+		/*  Populate the symbol information.  At this point any
+		 * trampoline symbols will be the offset location, not the
+		 * final.  Copy over the symbol info to start, then be sure to
+		 * get the string index from the trampoline string table.  */
+		new_sym->sym_info = *tmp_sym;
+		new_sym->str_index = str_index;
+
+		/*  Push the new symbol to the tail of the symbol table list  */
+		new_sym->next = NULL;
+		if (dlthis->tramp.symbol_head == NULL)
+			dlthis->tramp.symbol_head = new_sym;
+		else
+			dlthis->tramp.symbol_tail->next = new_sym;
+
+		dlthis->tramp.symbol_tail = new_sym;
+	}
+
+	return new_sym;
+}
+
+/*
+ * Function:	priv_tramp_sym_get
+ * Description: Search for the symbol with the matching string index (from
+ *	  the trampoline string table) and return the trampoline
+ *	  symbol object, if found.  Otherwise return NULL.
+ */
+static struct tramp_sym *priv_tramp_sym_get(struct dload_state *dlthis,
+						 u32 string_index)
+{
+	struct tramp_sym *sym_found = NULL;
+
+	/*  Walk the symbol table list and search vs. the string index  */
+	for (sym_found = dlthis->tramp.symbol_head;
+		 sym_found != NULL;
+		 sym_found = sym_found->next) {
+		if (sym_found->str_index == string_index)
+			break;
+	}
+
+	return sym_found;
+}
+
+/*
+ * Function:	priv_tramp_sym_find
+ * Description: Search for a trampoline symbol based on the string name of
+ *	  the symbol.  Return the symbol object, if found, otherwise
+ *	  return NULL.
+ */
+static struct tramp_sym *priv_tramp_sym_find(struct dload_state *dlthis,
+							char *string)
+{
+	struct tramp_sym *sym_found = NULL;
+	struct tramp_string *str_found = NULL;
+
+	/*  First, search for the string, then search for the sym based on the
+		string index.  */
+	str_found = priv_tramp_string_find(dlthis, string);
+	if (str_found != NULL)
+		sym_found = priv_tramp_sym_get(dlthis, str_found->index);
+
+	return sym_found;
+}
+
+/*
+ * Function:	priv_tramp_sym_finalize
+ * Description: Allocate a flat symbol table for the trampoline section,
+ *	  put each trampoline symbol into the table, adjust the
+ *	  symbol value based on the section address on the target and
+ *	  free the trampoline symbol list nodes.
+ */
+static int priv_tramp_sym_finalize(struct dload_state *dlthis)
+{
+	int ret_val = 0;
+	struct tramp_sym *cur_sym;
+	struct LDR_SECTION_INFO *tramp_sect =
+		&dlthis->ldr_sections[dlthis->allocated_secn_count];
+	struct Local_Symbol *new_sym;
+
+	/*  Allocate a table to hold a flattened version of all symbols
+	 * created.  */
+	dlthis->tramp.final_sym_table =
+		(struct Local_Symbol *)dlthis->mysym->Allocate(
+			dlthis->mysym, (sizeof(struct Local_Symbol) *
+			dlthis->tramp.tramp_sym_next_index));
+	if (dlthis->tramp.final_sym_table != NULL) {
+		/*  Walk the list of all symbols, copy it over to the flattened
+		 * table. After it has been copied, the node can be freed as
+		 * it is no longer needed.  */
+		new_sym = dlthis->tramp.final_sym_table;
+		cur_sym = dlthis->tramp.symbol_head;
+		while (cur_sym != NULL) {
+			/*  Pop it off the list  */
+			dlthis->tramp.symbol_head = cur_sym->next;
+			if (cur_sym == dlthis->tramp.symbol_tail)
+				dlthis->tramp.symbol_tail = NULL;
+
+			/*  Copy the symbol contents into the flat table  */
+			*new_sym = cur_sym->sym_info;
+
+			/*  Now finaize the symbol.  If it is in the tramp
+			 * section, we need to adjust for the section start.
+			 * If it is external then we don't need to adjust at
+			 * all.
+			 * NOTE: THIS CODE ASSUMES THAT THE TRAMPOLINE IS
+			 * REFERENCED LIKE A CALL TO AN EXTERNAL SO VALUE AND
+			 * DELTA ARE THE SAME.  SEE THE FUNCTION dload_symbols
+			 * WHERE DN_UNDEF IS HANDLED FOR MORE REFERENCE.  */
+			if (new_sym->secnn < 0) {
+				new_sym->value += tramp_sect->load_addr;
+				new_sym->delta = new_sym->value;
+			}
+
+			/*  Let go of the symbol node  */
+			dlthis->mysym->Deallocate(dlthis->mysym, cur_sym);
+
+			/*  Move to the next node  */
+			cur_sym = dlthis->tramp.symbol_head;
+			new_sym++;
+		}
+
+		ret_val = 1;
+	} else
+		dload_error(dlthis, "Failed to alloc trampoline sym table");
+
+	return ret_val;
+}
+
+/*
+ * Function:	priv_tgt_img_gen
+ * Description: Allocate storage for and copy the target specific image data
+ *	and fix up its relocations for the new external symbol.  If
+ *	a trampoline image packet was successfully created it is added
+ *	to the trampoline list.
+ */
+static int priv_tgt_img_gen(struct dload_state *dlthis, u32 base,
+		u32 gen_index, struct tramp_sym *new_ext_sym)
+{
+	struct tramp_img_pkt *new_img_pkt = NULL;
+	u32 i;
+	u32 pkt_size = tramp_img_pkt_size_get();
+	u8 *gen_tbl_entry;
+	u8 *pkt_data;
+	struct reloc_record_t *cur_relo;
+	int ret_val = 0;
+
+	/*  Allocate a new image packet and set it up.  */
+	new_img_pkt =
+		(struct tramp_img_pkt *)dlthis->mysym->Allocate(dlthis->mysym,
+								 pkt_size);
+	if (new_img_pkt != NULL) {
+		/*  Save the base, this is where it goes in the section  */
+		new_img_pkt->base = base;
+
+		/*  Copy over the image data and relos from the target table */
+		pkt_data = (u8 *)&new_img_pkt->hdr;
+		gen_tbl_entry = (u8 *)&tramp_gen_info[gen_index];
+		for (i = 0; i < pkt_size; i++) {
+			*pkt_data = *gen_tbl_entry;
+			pkt_data++;
+			gen_tbl_entry++;
+		}
+
+		/*  Update the relocations to point to the external symbol  */
+		cur_relo =
+			(struct reloc_record_t *)((u8 *)&new_img_pkt->hdr +
+					   new_img_pkt->hdr.relo_offset);
+		for (i = 0; i < new_img_pkt->hdr.num_relos; i++)
+			cur_relo[i].r_symndx = new_ext_sym->index;
+
+		/*  Add it to the trampoline list.  */
+		new_img_pkt->next = dlthis->tramp.tramp_pkts;
+		dlthis->tramp.tramp_pkts = new_img_pkt;
+
+		ret_val = 1;
+	}
+
+	return ret_val;
+}
+
+/*
+ * Function:	priv_pkt_relo
+ * Description: Take the provided image data and the collection of relocations
+ *	  for it and perform the relocations.  Note that all relocations
+ *	  at this stage are considered SECOND PASS since the original
+ *	  image has already been processed in the first pass.  This means
+ *	  TRAMPOLINES ARE TREATED AS 2ND PASS even though this is really
+ *	  the first (and only) relocation that will be performed on them.
+ */
+static int priv_pkt_relo(struct dload_state *dlthis, TgtAU_t *data,
+			 struct reloc_record_t *rp[], u32 relo_count)
+{
+	int ret_val = 1;
+	u32 i;
+	bool tmp;
+
+	/*  Walk through all of the relos and process them.  This function is
+	 * the equivalent of relocate_packet() from cload.c, but specialized
+	 * for trampolines and 2nd phase relocations.  */
+	for (i = 0; i < relo_count; i++)
+		dload_relocate(dlthis, data, rp[i], &tmp, true);
+
+	return ret_val;
+}
+
+/*
+ * Function:	priv_tramp_pkt_finalize
+ * Description: Walk the list of all trampoline packets and finalize them.
+ *	  Each trampoline image packet will be relocated now that the
+ *	  trampoline section has been allocated on the target.  Once
+ *	  all of the relocations are done the trampoline image data
+ *	  is written into target memory and the trampoline packet
+ *	  is freed: it is no longer needed after this point.
+ */
+static int priv_tramp_pkt_finalize(struct dload_state *dlthis)
+{
+	int ret_val = 1;
+	struct tramp_img_pkt *cur_pkt = NULL;
+	struct reloc_record_t *relos[MAX_RELOS_PER_PASS];
+	u32 relos_done;
+	u32 i;
+	struct reloc_record_t *cur_relo;
+	struct LDR_SECTION_INFO *sect_info =
+		&dlthis->ldr_sections[dlthis->allocated_secn_count];
+
+	/*  Walk the list of trampoline packets and relocate each packet.  This
+	 * function is the trampoline equivalent of dload_data() from
+	 * cload.c.  */
+	cur_pkt = dlthis->tramp.tramp_pkts;
+	while ((ret_val != 0) && (cur_pkt != NULL)) {
+		/*  Remove the pkt from the list  */
+		dlthis->tramp.tramp_pkts = cur_pkt->next;
+
+		/*  Setup section and image offset information for the relo  */
+		dlthis->image_secn = sect_info;
+		dlthis->image_offset = cur_pkt->base;
+		dlthis->delta_runaddr = sect_info->run_addr;
+
+		/*  Walk through all relos for the packet  */
+		relos_done = 0;
+		cur_relo = (struct reloc_record_t *)((u8 *)&cur_pkt->hdr +
+						  cur_pkt->hdr.relo_offset);
+		while (relos_done < cur_pkt->hdr.num_relos) {
+#ifdef ENABLE_TRAMP_DEBUG
+			dload_syms_error(dlthis->mysym,
+				 "===> Trampoline %x branches to %x",
+				 sect_info->run_addr + dlthis->image_offset,
+				 dlthis->tramp.
+				 final_sym_table[cur_relo->r_symndx].value);
+#endif
+
+			for (i = 0;
+				 ((i < MAX_RELOS_PER_PASS) &&
+				  ((i + relos_done) < cur_pkt->hdr.num_relos));
+				 i++)
+				relos[i] = cur_relo + i;
+
+			/*  Do the actual relo  */
+			ret_val = priv_pkt_relo(dlthis,
+						(TgtAU_t *)&cur_pkt->payload,
+						relos, i);
+			if (ret_val == 0) {
+				dload_error(dlthis,
+				"Relocation of trampoline pkt at %x failed",
+				cur_pkt->base + sect_info->run_addr);
+				break;
+			}
+
+			relos_done += i;
+			cur_relo += i;
+		}
+
+		/*  Make sure we didn't hit a problem  */
+		if (ret_val != 0) {
+			/*  Relos are done for the packet, write it to the
+			 * target  */
+			ret_val = dlthis->myio->writemem(dlthis->myio,
+					   &cur_pkt->payload,
+					   sect_info->load_addr + cur_pkt->base
+					   , sect_info, BYTE_TO_HOST(
+					   cur_pkt->hdr.tramp_code_size));
+			if (ret_val == 0) {
+				dload_error(dlthis,
+					"Write to " FMT_UI32 " failed",
+					sect_info->load_addr + cur_pkt->base);
+			}
+
+			/*  Done with the pkt, let it go  */
+			dlthis->mysym->Deallocate(dlthis->mysym, cur_pkt);
+
+			/*  Get the next packet to process  */
+			cur_pkt = dlthis->tramp.tramp_pkts;
+		}
+	}
+
+	return ret_val;
+}
+
+/*
+ * Function:	priv_dup_pkt_finalize
+ * Description: Walk the list of duplicate image packets and finalize them.
+ *	  Each duplicate packet will be relocated again for the
+ *	  relocations that previously failed and have been adjusted
+ *	  to point at a trampoline.  Once all relocations for a packet
+ *	  have been done, write the packet into target memory.  The
+ *	  duplicate packet and its relocation chain are all freed
+ *	  after use here as they are no longer needed after this.
+ */
+static int priv_dup_pkt_finalize(struct dload_state *dlthis)
+{
+	int ret_val = 1;
+	struct tramp_img_dup_pkt *cur_pkt;
+	struct tramp_img_dup_relo *cur_relo;
+	struct reloc_record_t *relos[MAX_RELOS_PER_PASS];
+	struct doff_scnhdr_t *sect_hdr = NULL;
+	s32 i;
+
+	/* Similar to the trampoline pkt finalize, this function walks each dup
+	 * pkt that was generated and performs all relocations that were
+	 * deferred to a 2nd pass.  This is the equivalent of dload_data() from
+	 * cload.c, but does not need the additional reorder and checksum
+	 * processing as it has already been done.  */
+	cur_pkt = dlthis->tramp.dup_pkts;
+	while ((ret_val != 0) && (cur_pkt != NULL)) {
+		/*  Remove the node from the list, we'll be freeing it
+		 * shortly  */
+		dlthis->tramp.dup_pkts = cur_pkt->next;
+
+		/*  Setup the section and image offset for relocation  */
+		dlthis->image_secn = &dlthis->ldr_sections[cur_pkt->secnn];
+		dlthis->image_offset = cur_pkt->offset;
+
+		/*  In order to get the delta run address, we need to reference
+		 * the original section header.  It's a bit ugly, but needed
+		 * for relo.  */
+		i = (s32)(dlthis->image_secn - dlthis->ldr_sections);
+		sect_hdr = dlthis->sect_hdrs + i;
+		dlthis->delta_runaddr = sect_hdr->ds_paddr;
+
+		/*  Walk all relos in the chain and process each.  */
+		cur_relo = cur_pkt->relo_chain;
+		while (cur_relo != NULL) {
+			/*  Process them a chunk at a time to be efficient  */
+			for (i = 0; (i < MAX_RELOS_PER_PASS)
+				 && (cur_relo != NULL);
+				 i++, cur_relo = cur_relo->next) {
+				relos[i] = &cur_relo->relo;
+				cur_pkt->relo_chain = cur_relo->next;
+			}
+
+			/*  Do the actual relo  */
+			ret_val = priv_pkt_relo(dlthis,
+				cur_pkt->img_pkt.i_bits,
+				relos, i);
+			if (ret_val == 0) {
+				dload_error(dlthis,
+					"Relocation of dup pkt at %x failed",
+					cur_pkt->offset + dlthis->image_secn->
+					run_addr);
+				break;
+			}
+
+			/*  Release all of these relos, we're done with them */
+			while (i > 0) {
+				dlthis->mysym->Deallocate(dlthis->mysym,
+					  GET_CONTAINER(relos[i - 1],
+					struct tramp_img_dup_relo, relo));
+				i--;
+			}
+
+			/*  DO NOT ADVANCE cur_relo, IT IS ALREADY READY TO
+			 * GO!  */
+		}
+
+		/* Done with all relos.  Make sure we didn't have a problem and
+		 * write it out to the target  */
+		if (ret_val != 0) {
+			ret_val = dlthis->myio->writemem(dlthis->myio,
+				   cur_pkt->img_pkt.i_bits,
+				   dlthis->image_secn->load_addr +
+				   cur_pkt->offset, dlthis->image_secn,
+				   BYTE_TO_HOST(cur_pkt->
+				   img_pkt.i_packet_size));
+			if (ret_val == 0) {
+				dload_error(dlthis,
+					"Write to " FMT_UI32 " failed",
+					dlthis->image_secn->load_addr +
+					cur_pkt->offset);
+			}
+
+			dlthis->mysym->Deallocate(dlthis->mysym, cur_pkt);
+
+			/*  Advance to the next packet  */
+			cur_pkt = dlthis->tramp.dup_pkts;
+		}
+	}
+
+	return ret_val;
+}
+
+/*
+ * Function:	priv_dup_find
+ * Description: Walk the list of existing duplicate packets and find a
+ *	  match based on the section number and image offset.  Return
+ *	  the duplicate packet if found, otherwise NULL.
+ */
+static struct tramp_img_dup_pkt *priv_dup_find(struct dload_state *dlthis,
+					s16 secnn, u32 image_offset)
+{
+	struct tramp_img_dup_pkt *cur_pkt = NULL;
+
+	for (cur_pkt = dlthis->tramp.dup_pkts;
+		 cur_pkt != NULL;
+		 cur_pkt = cur_pkt->next) {
+		if ((cur_pkt->secnn == secnn) &&
+			(cur_pkt->offset == image_offset)) {
+			/*  Found a match, break out  */
+			break;
+		}
+	}
+
+	return cur_pkt;
+}
+
+/*
+ * Function:	priv_img_pkt_dup
+ * Description: Duplicate the original image packet.  If this is the first
+ *	  time this image packet has been seen (based on section number
+ *	  and image offset), create a new duplicate packet and add it
+ *	  to the dup packet list.  If not, just get the existing one and
+ *	  update it with the current packet contents (since relocation
+ *	  on the packet is still ongoing in first pass.)  Create a
+ *	  duplicate of the provided relocation, but update it to point
+ *	  to the new trampoline symbol.  Add the new relocation dup to
+ *	  the dup packet's relo chain for 2nd pass relocation later.
+ */
+static int priv_img_pkt_dup(struct dload_state *dlthis,
+	s16 secnn, u32 image_offset, struct image_packet_t *ipacket,
+	struct reloc_record_t *rp, struct tramp_sym *new_tramp_sym)
+{
+	struct tramp_img_dup_pkt *dup_pkt = NULL;
+	u32 new_dup_size;
+	s32 i;
+	int ret_val = 0;
+	struct tramp_img_dup_relo *dup_relo = NULL;
+
+	/*  Determinne if this image packet is already being tracked in the
+		dup list for other trampolines.  */
+	dup_pkt = priv_dup_find(dlthis, secnn, image_offset);
+
+	if (dup_pkt == NULL) {
+		/*  This image packet does not exist in our tracking, so create
+		 * a new one and add it to the head of the list.  */
+		new_dup_size = sizeof(struct tramp_img_dup_pkt) +
+						ipacket->i_packet_size;
+
+		dup_pkt = (struct tramp_img_dup_pkt *)
+			dlthis->mysym->Allocate(dlthis->mysym, new_dup_size);
+		if (dup_pkt != NULL) {
+			/*  Save off the section and offset information  */
+			dup_pkt->secnn = secnn;
+			dup_pkt->offset = image_offset;
+			dup_pkt->relo_chain = NULL;
+
+			/*  Copy the original packet content  */
+			dup_pkt->img_pkt = *ipacket;
+			dup_pkt->img_pkt.i_bits = (u8 *)(dup_pkt + 1);
+			for (i = 0; i < ipacket->i_packet_size; i++)
+				*(dup_pkt->img_pkt.i_bits + i) =
+					*(ipacket->i_bits + i);
+
+			/*  Add the packet to the dup list  */
+			dup_pkt->next = dlthis->tramp.dup_pkts;
+			dlthis->tramp.dup_pkts = dup_pkt;
+		} else
+			dload_error(dlthis, "Failed to create dup packet!");
+	} else {
+		/*  The image packet contents could have changed since
+		 * trampoline detection happens during relocation of the image
+		 * packets.  So, we need to update the image packet contents
+		 * before adding relo information.  */
+		for (i = 0; i < dup_pkt->img_pkt.i_packet_size; i++)
+			*(dup_pkt->img_pkt.i_bits + i) =
+				*(ipacket->i_bits + i);
+	}
+
+	/*  Since the previous code may have allocated a new dup packet for us,
+		double check that we actually have one.  */
+	if (dup_pkt != NULL) {
+		/*  Allocate a new node for the relo chain.  Each image packet
+		 * can potentially have multiple relocations that cause a
+		 * trampoline to be generated.  So, we keep them in a chain,
+		 * order is not important.  */
+		dup_relo = dlthis->mysym->Allocate(dlthis->mysym,
+					   sizeof(struct tramp_img_dup_relo));
+		if (dup_relo != NULL) {
+			/*  Copy the relo contents, adjust for the new
+			 * trampoline and add it to the list.  */
+			dup_relo->relo = *rp;
+			dup_relo->relo.r_symndx = new_tramp_sym->index;
+
+			dup_relo->next = dup_pkt->relo_chain;
+			dup_pkt->relo_chain = dup_relo;
+
+			/*  That's it, we're done.  Make sure we update our
+			 * return value to be success since everything finished
+			 * ok  */
+			ret_val = 1;
+		} else
+			dload_error(dlthis, "Unable to alloc dup relo");
+	}
+
+	return ret_val;
+}
+
+/*
+ * Function:	dload_tramp_avail
+ * Description: Check to see if the target supports a trampoline for this type
+ *	  of relocation.  Return true if it does, otherwise false.
+ */
+bool dload_tramp_avail(struct dload_state *dlthis, struct reloc_record_t *rp)
+{
+	bool ret_val = false;
+	u16 map_index;
+	u16 gen_index;
+
+	/*  Check type hash vs. target tramp table  */
+	map_index = HASH_FUNC(rp->r_type);
+	gen_index = tramp_map[map_index];
+	if (gen_index != TRAMP_NO_GEN_AVAIL)
+		ret_val = true;
+
+	return ret_val;
+}
+
+/*
+ * Function:	dload_tramp_generate
+ * Description: Create a new trampoline for the provided image packet and
+ *	  relocation causing problems.  This will create the trampoline
+ *	  as well as duplicate/update the image packet and relocation
+ *	  causing the problem, which will be relo'd again during
+ *	  finalization.
+ */
+int dload_tramp_generate(struct dload_state *dlthis, s16 secnn,
+	u32 image_offset, struct image_packet_t *ipacket,
+	struct reloc_record_t *rp)
+{
+	u16 map_index;
+	u16 gen_index;
+	int ret_val = 1;
+	char tramp_sym_str[TRAMP_SYM_PREFIX_LEN + TRAMP_SYM_HEX_ASCII_LEN];
+	struct Local_Symbol *ref_sym;
+	struct tramp_sym	*new_tramp_sym;
+	struct tramp_sym	*new_ext_sym;
+	struct tramp_string *new_tramp_str;
+	u32 new_tramp_base;
+	struct Local_Symbol tmp_sym;
+	struct Local_Symbol ext_tmp_sym;
+
+	/*  Hash the relo type to get our generator information  */
+	map_index = HASH_FUNC(rp->r_type);
+	gen_index = tramp_map[map_index];
+	if (gen_index != TRAMP_NO_GEN_AVAIL) {
+		/*  If this is the first trampoline, create the section name in
+		 * our string table for debug help later.  */
+		if (dlthis->tramp.string_head == NULL) {
+			priv_tramp_string_create(dlthis,
+				 strlen(TRAMP_SECT_NAME), TRAMP_SECT_NAME);
+		}
+
+#ifdef ENABLE_TRAMP_DEBUG
+		dload_syms_error(dlthis->mysym,
+			 "Trampoline at img loc %x, references %x",
+			 dlthis->ldr_sections[secnn].run_addr + image_offset +
+			 rp->r_vaddr,
+			 dlthis->local_symtab[rp->r_symndx].value);
+#endif
+
+		/*  Generate the trampoline string, check if already defined.
+		 * If the relo symbol index is -1, it means we need the section
+		 * info for relo later.  To do this we'll dummy up a symbol
+		 * with the section delta and run addresses.  */
+		if (rp->r_symndx == -1) {
+			ext_tmp_sym.value =
+				dlthis->ldr_sections[secnn].run_addr;
+			ext_tmp_sym.delta = dlthis->sect_hdrs[secnn].ds_paddr;
+			ref_sym = &ext_tmp_sym;
+		} else
+			ref_sym = &(dlthis->local_symtab[rp->r_symndx]);
+
+		priv_tramp_sym_gen_name(ref_sym->value, tramp_sym_str);
+		new_tramp_sym = priv_tramp_sym_find(dlthis, tramp_sym_str);
+		if (new_tramp_sym == NULL) {
+			/*  If tramp string not defined, create it and a new
+			 * string, and symbol for it as well as the original
+			 * symbol which caused the trampoline.  */
+			new_tramp_str = priv_tramp_string_create(dlthis,
+				 strlen(tramp_sym_str), tramp_sym_str);
+			if (new_tramp_str == NULL) {
+				dload_error(dlthis, "Failed to create new "
+					"trampoline string\n");
+				ret_val = 0;
+			} else {
+				/*  Allocate tramp section space for the new
+				 * tramp from the target  */
+				new_tramp_base = priv_tramp_sect_alloc(dlthis,
+							   tramp_size_get());
+
+				/*  We have a string, create the new symbol and
+				 * duplicate the external.  */
+				tmp_sym.value = new_tramp_base;
+				tmp_sym.delta = 0;
+				tmp_sym.secnn = -1;
+				tmp_sym.sclass = 0;
+				new_tramp_sym = priv_tramp_sym_create(dlthis,
+					  new_tramp_str->index, &tmp_sym);
+
+				new_ext_sym = priv_tramp_sym_create(dlthis,
+								-1, ref_sym);
+
+				if ((new_tramp_sym != NULL) &&
+					(new_ext_sym != NULL)) {
+					/*  Call the image generator to get the
+					 * new image data and fix up its
+					 * relocations for the external
+					 * symbol.  */
+					ret_val = priv_tgt_img_gen(dlthis,
+					   new_tramp_base, gen_index,
+					   new_ext_sym);
+
+					/*  Add generated image data to tramp
+					 * image list  */
+					if (ret_val != 1) {
+						dload_error(dlthis, "Failed to"
+						   " create image packet for "
+						   "trampoline\n");
+					}
+				} else {
+					dload_error(dlthis, "Failed to create "
+					   "new tramp syms (%8.8X, %8.8X)\n",
+					   new_tramp_sym, new_ext_sym);
+					ret_val = 0;
+				}
+			}
+		}
+
+		/*  Duplicate the image data and relo record that caused the
+		 * tramp, including update the relo data to point to the tramp
+		 * symbol.  */
+		if (ret_val == 1) {
+			ret_val = priv_img_pkt_dup(dlthis, secnn, image_offset,
+				   ipacket, rp, new_tramp_sym);
+			if (ret_val != 1) {
+				dload_error(dlthis, "Failed to create dup of "
+					"original img pkt\n");
+			}
+		}
+	}
+
+	return ret_val;
+}
+
+/*
+ * Function:	dload_tramp_pkt_update
+ * Description: Update the duplicate copy of this image packet, which the
+ *	  trampoline layer is already tracking.  This is call is critical
+ *	  to make if trampolines were generated anywhere within the
+ *	  packet and first pass relo continued on the remainder.  The
+ *	  trampoline layer needs the updates image data so when 2nd
+ *	  pass relo is done during finalize the image packet can be
+ *	  written to the target since all relo is done.
+ */
+int dload_tramp_pkt_udpate(struct dload_state *dlthis, s16 secnn,
+	   u32 image_offset, struct image_packet_t *ipacket)
+{
+	struct tramp_img_dup_pkt *dup_pkt = NULL;
+	s32 i;
+	int ret_val = 0;
+
+	/*  Find the image packet in question, the caller needs us to update it
+		since a trampoline was previously generated.  */
+	dup_pkt = priv_dup_find(dlthis, secnn, image_offset);
+	if (dup_pkt != NULL) {
+		for (i = 0; i < dup_pkt->img_pkt.i_packet_size; i++)
+			*(dup_pkt->img_pkt.i_bits + i) = *(ipacket->i_bits + i);
+
+		ret_val = 1;
+	} else {
+		dload_error(dlthis,
+			"Unable to find existing DUP pkt for %x, offset %x",
+			secnn, image_offset);
+
+	}
+
+	return ret_val;
+}
+
+/*
+ * Function:	dload_tramp_finalize
+ * Description: If any trampolines were created, finalize everything on the
+ *	  target by allocating the trampoline section on the target,
+ *	  finalizing the trampoline symbols, finalizing the trampoline
+ *	  packets (write the new section to target memory) and finalize
+ *	  the duplicate packets by doing 2nd pass relo over them.
+ */
+int dload_tramp_finalize(struct dload_state *dlthis)
+{
+	int ret_val = 1;
+
+	if (dlthis->tramp.tramp_sect_next_addr != 0) {
+		/*  Finalize strings into a flat table.  This is needed so it
+		 * can be added to the debug string table later.  */
+		ret_val = priv_string_tbl_finalize(dlthis);
+
+		/*  Do target allocation for section BEFORE finalizing
+		 * symbols.  */
+		if (ret_val != 0)
+			ret_val = priv_tramp_sect_tgt_alloc(dlthis);
+
+		/*  Finalize symbols with their correct target information and
+		 * flatten  */
+		if (ret_val != 0)
+			ret_val = priv_tramp_sym_finalize(dlthis);
+
+		/*  Finalize all trampoline packets.  This performs the
+		 * relocation on the packets as well as writing them to target
+		 * memory.  */
+		if (ret_val != 0)
+			ret_val = priv_tramp_pkt_finalize(dlthis);
+
+		/*  Perform a 2nd pass relocation on the dup list.  */
+		if (ret_val != 0)
+			ret_val = priv_dup_pkt_finalize(dlthis);
+	}
+
+	return ret_val;
+}
+
+/*
+ * Function:	dload_tramp_cleanup
+ * Description: Release all temporary resources used in the trampoline layer.
+ *	  Note that the target memory which may have been allocated and
+ *	  written to store the trampolines is NOT RELEASED HERE since it
+ *	  is potentially still in use.  It is automatically released
+ *	  when the module is unloaded.
+ */
+void dload_tramp_cleanup(struct dload_state *dlthis)
+{
+	struct tramp_info *tramp = &dlthis->tramp;
+	struct tramp_sym *cur_sym;
+	struct tramp_string *cur_string;
+	struct tramp_img_pkt *cur_tramp_pkt;
+	struct tramp_img_dup_pkt *cur_dup_pkt;
+	struct tramp_img_dup_relo *cur_dup_relo;
+
+	/*  If there were no tramps generated, just return  */
+	if (tramp->tramp_sect_next_addr == 0)
+		return;
+
+	/*  Destroy all tramp information  */
+	for (cur_sym = tramp->symbol_head;
+		 cur_sym != NULL;
+		 cur_sym = tramp->symbol_head) {
+		tramp->symbol_head = cur_sym->next;
+		if (tramp->symbol_tail == cur_sym)
+			tramp->symbol_tail = NULL;
+
+		dlthis->mysym->Deallocate(dlthis->mysym, cur_sym);
+	}
+
+	if (tramp->final_sym_table != NULL)
+		dlthis->mysym->Deallocate(dlthis->mysym,
+			tramp->final_sym_table);
+
+	for (cur_string = tramp->string_head;
+		 cur_string != NULL;
+		 cur_string = tramp->string_head) {
+		tramp->string_head = cur_string->next;
+		if (tramp->string_tail == cur_string)
+			tramp->string_tail = NULL;
+
+		dlthis->mysym->Deallocate(dlthis->mysym, cur_string);
+	}
+
+	if (tramp->final_string_table != NULL)
+		dlthis->mysym->Deallocate(dlthis->mysym,
+			tramp->final_string_table);
+
+	for (cur_tramp_pkt = tramp->tramp_pkts;
+		 cur_tramp_pkt != NULL;
+		 cur_tramp_pkt = tramp->tramp_pkts) {
+		tramp->tramp_pkts = cur_tramp_pkt->next;
+		dlthis->mysym->Deallocate(dlthis->mysym, cur_tramp_pkt);
+	}
+
+	for (cur_dup_pkt = tramp->dup_pkts;
+		 cur_dup_pkt != NULL;
+		 cur_dup_pkt = tramp->dup_pkts) {
+		tramp->dup_pkts = cur_dup_pkt->next;
+
+		for (cur_dup_relo = cur_dup_pkt->relo_chain;
+			 cur_dup_relo != NULL;
+			 cur_dup_relo = cur_dup_pkt->relo_chain) {
+			cur_dup_pkt->relo_chain = cur_dup_relo->next;
+			dlthis->mysym->Deallocate(dlthis->mysym, cur_dup_relo);
+		}
+
+		dlthis->mysym->Deallocate(dlthis->mysym, cur_dup_pkt);
+	}
+}
diff --git a/drivers/dsp/bridge/dynload/tramp_table_c6000.c b/drivers/dsp/bridge/dynload/tramp_table_c6000.c
new file mode 100644
index 0000000..1a7d974
--- /dev/null
+++ b/drivers/dsp/bridge/dynload/tramp_table_c6000.c
@@ -0,0 +1,164 @@
+/*
+ *  Copyright 2009 by Texas Instruments Incorporated.
+ *  All rights reserved. Property of Texas Instruments Incorporated.
+ *  Restricted rights to use, duplicate or disclose this code are
+ *  granted through contract.
+ *
+ *  @(#) DSP/BIOS Bridge
+ */
+#include "dload_internal.h"
+
+/*  These are defined in coff.h, but may not be available on all platforms
+	so we'll go ahead and define them here.  */
+#ifndef R_C60LO16
+#define R_C60LO16	  0x54	   /* C60: MVK Low Half Register	  */
+#define R_C60HI16	  0x55	   /* C60: MVKH/MVKLH High Half Register  */
+#endif
+
+#define C6X_TRAMP_WORD_COUNT			8
+#define C6X_TRAMP_MAX_RELOS			 8
+
+/*  THIS HASH FUNCTION MUST MATCH THE ONE IN reloc_table_c6000.c  */
+#define HASH_FUNC(zz) (((((zz) + 1) * UINT32_C(1845)) >> 11) & 63)
+
+
+/*  THIS MUST MATCH reloc_record_t FOR A SYMBOL BASED RELO  */
+struct c6000_relo_record {
+	s32 r_vaddr;
+	s32 symndx;
+#ifndef _BIG_ENDIAN
+	u16 disp;
+	u16 type;
+#else
+	u16 type;
+	u16 disp;
+#endif
+};
+
+struct c6000_gen_code {
+	struct tramp_gen_code_hdr	hdr;
+	u32 tramp_instrs[C6X_TRAMP_WORD_COUNT];
+	struct c6000_relo_record relos[C6X_TRAMP_MAX_RELOS];
+};
+
+
+/*  Hash mapping for relos that can cause trampolines.  */
+static const u16 tramp_map[] =
+{
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	0,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535,
+	65535
+};
+
+
+static const struct c6000_gen_code   tramp_gen_info[] =
+{
+	/*  Tramp caused by R_C60PCR21  */
+	{
+		/*  Header - 8 instructions, 2 relos  */
+		{
+			sizeof(u32) * C6X_TRAMP_WORD_COUNT,
+			2,
+			FIELD_OFFSET(struct c6000_gen_code, relos)
+		},
+
+		/*  Trampoline instructions  */
+		{
+			0x053C54F7,	/*	 STW.D2T2  B10, *sp--[2]  */
+			0x0500002A,	/*  || MVK.S2	<blank>, B10   */
+			0x0500006A,	/*	 MVKH.S2   <blank>, B10   */
+			0x00280362,	/*	 B.S2	  B10		*/
+			0x053C52E6,	/*	 LDW.D2T2  *++sp[2], B10  */
+			0x00006000,	/*	 NOP	   4		*/
+			0x00000000,	/*	 NOP			*/
+			0x00000000	/*	 NOP			*/
+		},
+
+		/*  Relocations  */
+		{
+			{ 4, 0, 0, R_C60LO16 },
+			{ 8, 0, 0, R_C60HI16 },
+			{ 0, 0, 0, 0x0000 },
+			{ 0, 0, 0, 0x0000 },
+			{ 0, 0, 0, 0x0000 },
+			{ 0, 0, 0, 0x0000 },
+			{ 0, 0, 0, 0x0000 },
+			{ 0, 0, 0, 0x0000 }
+		}
+	}
+};
+
+
+
+/*  TARGET SPECIFIC FUNCTIONS THAT MUST BE DEFINED  */
+static u32 tramp_size_get(void)
+{
+	return sizeof(u32) * C6X_TRAMP_WORD_COUNT;
+}
+
+
+static u32 tramp_img_pkt_size_get(void)
+{
+	return sizeof(struct c6000_gen_code);
+}
-- 
1.6.2.4

