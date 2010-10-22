From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH 3/4] staging: tidspbridge: remove gb bitmap implementation
Date: Fri, 22 Oct 2010 15:57:30 +0300
Message-ID: <1287752251-5847-4-git-send-email-ionut.nicu@mindbit.ro>
References: <1287752251-5847-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38988 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556Ab0JVNDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 09:03:52 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so493616bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 06:03:51 -0700 (PDT)
In-Reply-To: <1287752251-5847-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Replace the tidspbridge generic bitmap operations
with the linux generic bitmap implementation.

Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
---
 drivers/staging/tidspbridge/Makefile               |    2 +-
 drivers/staging/tidspbridge/gen/gb.c               |  165 ------
 drivers/staging/tidspbridge/include/dspbridge/gb.h |   79 ---
 drivers/staging/tidspbridge/rmgr/node.c            |  599 +++++++++-----------
 4 files changed, 274 insertions(+), 571 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/gen/gb.c
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/gb.h

diff --git a/drivers/staging/tidspbridge/Makefile b/drivers/staging/tidspbridge/Makefile
index aaf397f..6080e7e 100644
--- a/drivers/staging/tidspbridge/Makefile
+++ b/drivers/staging/tidspbridge/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_TIDSPBRIDGE)	+= bridgedriver.o
 
-libgen = gen/gb.o gen/gh.o gen/uuidutil.o
+libgen = gen/gh.o gen/uuidutil.o
 libcore = core/chnl_sm.o core/msg_sm.o core/io_sm.o core/tiomap3430.o \
 		core/tiomap3430_pwr.o core/tiomap_io.o core/dsp-mmu.o \
 		core/ue_deh.o core/wdt.o core/dsp-clock.o core/sync.o
diff --git a/drivers/staging/tidspbridge/gen/gb.c b/drivers/staging/tidspbridge/gen/gb.c
deleted file mode 100644
index 3c0e04c..0000000
--- a/drivers/staging/tidspbridge/gen/gb.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * gb.c
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Generic bitmap operations.
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
-#include <linux/types.h>
-/*  ----------------------------------- This */
-#include <dspbridge/gb.h>
-
-struct gb_t_map {
-	u32 len;
-	u32 wcnt;
-	u32 *words;
-};
-
-/*
- *  ======== gb_clear ========
- *  purpose:
- *      Clears a bit in the bit map.
- */
-
-void gb_clear(struct gb_t_map *map, u32 bitn)
-{
-	u32 mask;
-
-	mask = 1L << (bitn % BITS_PER_LONG);
-	map->words[bitn / BITS_PER_LONG] &= ~mask;
-}
-
-/*
- *  ======== gb_create ========
- *  purpose:
- *      Creates a bit map.
- */
-
-struct gb_t_map *gb_create(u32 len)
-{
-	struct gb_t_map *map;
-	u32 i;
-	map = kzalloc(sizeof(struct gb_t_map), GFP_KERNEL);
-	if (map != NULL) {
-		map->len = len;
-		map->wcnt = len / BITS_PER_LONG + 1;
-		map->words = kzalloc(map->wcnt * sizeof(u32), GFP_KERNEL);
-		if (map->words != NULL) {
-			for (i = 0; i < map->wcnt; i++)
-				map->words[i] = 0L;
-
-		} else {
-			kfree(map);
-			map = NULL;
-		}
-	}
-
-	return map;
-}
-
-/*
- *  ======== gb_delete ========
- *  purpose:
- *      Frees a bit map.
- */
-
-void gb_delete(struct gb_t_map *map)
-{
-	kfree(map->words);
-	kfree(map);
-}
-
-/*
- *  ======== gb_findandset ========
- *  purpose:
- *      Finds a free bit and sets it.
- */
-u32 gb_findandset(struct gb_t_map *map)
-{
-	u32 bitn;
-
-	bitn = gb_minclear(map);
-
-	if (bitn != GB_NOBITS)
-		gb_set(map, bitn);
-
-	return bitn;
-}
-
-/*
- *  ======== gb_minclear ========
- *  purpose:
- *      returns the location of the first unset bit in the bit map.
- */
-u32 gb_minclear(struct gb_t_map *map)
-{
-	u32 bit_location = 0;
-	u32 bit_acc = 0;
-	u32 i;
-	u32 bit;
-	u32 *word;
-
-	for (word = map->words, i = 0; i < map->wcnt; word++, i++) {
-		if (~*word) {
-			for (bit = 0; bit < BITS_PER_LONG; bit++, bit_acc++) {
-				if (bit_acc == map->len)
-					return GB_NOBITS;
-
-				if (~*word & (1L << bit)) {
-					bit_location = i * BITS_PER_LONG + bit;
-					return bit_location;
-				}
-
-			}
-		} else {
-			bit_acc += BITS_PER_LONG;
-		}
-	}
-
-	return GB_NOBITS;
-}
-
-/*
- *  ======== gb_set ========
- *  purpose:
- *      Sets a bit in the bit map.
- */
-
-void gb_set(struct gb_t_map *map, u32 bitn)
-{
-	u32 mask;
-
-	mask = 1L << (bitn % BITS_PER_LONG);
-	map->words[bitn / BITS_PER_LONG] |= mask;
-}
-
-/*
- *  ======== gb_test ========
- *  purpose:
- *      Returns true if the bit is set in the specified location.
- */
-
-bool gb_test(struct gb_t_map *map, u32 bitn)
-{
-	bool state;
-	u32 mask;
-	u32 word;
-
-	mask = 1L << (bitn % BITS_PER_LONG);
-	word = map->words[bitn / BITS_PER_LONG];
-	state = word & mask ? true : false;
-
-	return state;
-}
diff --git a/drivers/staging/tidspbridge/include/dspbridge/gb.h b/drivers/staging/tidspbridge/include/dspbridge/gb.h
deleted file mode 100644
index fda783a..0000000
--- a/drivers/staging/tidspbridge/include/dspbridge/gb.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * gb.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Generic bitmap manager.
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
-#ifndef GB_
-#define GB_
-
-#define GB_NOBITS (~0)
-#include <dspbridge/host_os.h>
-
-struct gb_t_map;
-
-/*
- *  ======== gb_clear ========
- *  Clear the bit in position bitn in the bitmap map.  Bit positions are
- *  zero based.
- */
-
-extern void gb_clear(struct gb_t_map *map, u32 bitn);
-
-/*
- *  ======== gb_create ========
- *  Create a bit map with len bits.  Initially all bits are cleared.
- */
-
-extern struct gb_t_map *gb_create(u32 len);
-
-/*
- *  ======== gb_delete ========
- *  Delete previously created bit map
- */
-
-extern void gb_delete(struct gb_t_map *map);
-
-/*
- *  ======== gb_findandset ========
- *  Finds a clear bit, sets it, and returns the position
- */
-
-extern u32 gb_findandset(struct gb_t_map *map);
-
-/*
- *  ======== gb_minclear ========
- *  gb_minclear returns the minimum clear bit position.  If no bit is
- *  clear, gb_minclear returns -1.
- */
-extern u32 gb_minclear(struct gb_t_map *map);
-
-/*
- *  ======== gb_set ========
- *  Set the bit in position bitn in the bitmap map.  Bit positions are
- *  zero based.
- */
-
-extern void gb_set(struct gb_t_map *map, u32 bitn);
-
-/*
- *  ======== gb_test ========
- *  Returns TRUE if the bit in position bitn is set in map; otherwise
- *  gb_test returns FALSE.  Bit positions are zero based.
- */
-
-extern bool gb_test(struct gb_t_map *map, u32 bitn);
-
-#endif /*GB_ */
diff --git a/drivers/staging/tidspbridge/rmgr/node.c b/drivers/staging/tidspbridge/rmgr/node.c
index a660247..9fa35de 100644
--- a/drivers/staging/tidspbridge/rmgr/node.c
+++ b/drivers/staging/tidspbridge/rmgr/node.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/bitmap.h>
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
 
@@ -50,7 +51,6 @@
 #include <dspbridge/dspioctl.h>
 
 /*  ----------------------------------- Others */
-#include <dspbridge/gb.h>
 #include <dspbridge/uuidutil.h>
 
 /*  ----------------------------------- This */
@@ -131,11 +131,14 @@ struct node_mgr {
 	struct lst_list *node_list;	/* List of all allocated nodes */
 	u32 num_nodes;		/* Number of nodes in node_list */
 	u32 num_created;	/* Number of nodes *created* on DSP */
-	struct gb_t_map *pipe_map;	/* Pipe connection bit map */
-	struct gb_t_map *pipe_done_map;	/* Pipes that are half free */
-	struct gb_t_map *chnl_map;	/* Channel allocation bit map */
-	struct gb_t_map *dma_chnl_map;	/* DMA Channel allocation bit map */
-	struct gb_t_map *zc_chnl_map;	/* Zero-Copy Channel alloc bit map */
+	DECLARE_BITMAP(pipe_map, MAXPIPES); /* Pipe connection bitmap */
+	DECLARE_BITMAP(pipe_done_map, MAXPIPES); /* Pipes that are half free */
+	/* Channel allocation bitmap */
+	DECLARE_BITMAP(chnl_map, CHNL_MAXCHANNELS);
+	/* DMA Channel allocation bitmap */
+	DECLARE_BITMAP(dma_chnl_map, CHNL_MAXCHANNELS);
+	/* Zero-Copy Channel alloc bitmap */
+	DECLARE_BITMAP(zc_chnl_map, CHNL_MAXCHANNELS);
 	struct ntfy_object *ntfy_obj;	/* Manages registered notifications */
 	struct mutex node_mgr_lock;	/* For critical sections */
 	u32 ul_fxn_addrs[NUMRMSFXNS];	/* RMS function addresses */
@@ -814,73 +817,64 @@ int node_connect(struct node_object *node1, u32 stream1,
 	char *pstr_dev_name = NULL;
 	enum node_type node1_type = NODE_TASK;
 	enum node_type node2_type = NODE_TASK;
+	enum dsp_strmmode strm_mode;
 	struct node_strmdef *pstrm_def;
 	struct node_strmdef *input = NULL;
 	struct node_strmdef *output = NULL;
 	struct node_object *dev_node_obj;
 	struct node_object *hnode;
 	struct stream_chnl *pstream;
-	u32 pipe_id = GB_NOBITS;
-	u32 chnl_id = GB_NOBITS;
+	u32 pipe_id;
+	u32 chnl_id;
 	s8 chnl_mode;
 	u32 dw_length;
 	int status = 0;
 	DBC_REQUIRE(refs > 0);
 
-	if ((node1 != (struct node_object *)DSP_HGPPNODE && !node1) ||
-	    (node2 != (struct node_object *)DSP_HGPPNODE && !node2))
-		status = -EFAULT;
+	if (!node1 || !node2)
+		return -EFAULT;
 
-	if (!status) {
-		/* The two nodes must be on the same processor */
-		if (node1 != (struct node_object *)DSP_HGPPNODE &&
-		    node2 != (struct node_object *)DSP_HGPPNODE &&
-		    node1->hnode_mgr != node2->hnode_mgr)
-			status = -EPERM;
-		/* Cannot connect a node to itself */
-		if (node1 == node2)
-			status = -EPERM;
+	/* The two nodes must be on the same processor */
+	if (node1 != (struct node_object *)DSP_HGPPNODE &&
+			node2 != (struct node_object *)DSP_HGPPNODE &&
+			node1->hnode_mgr != node2->hnode_mgr)
+		return -EPERM;
+
+	/* Cannot connect a node to itself */
+	if (node1 == node2)
+		return -EPERM;
+
+	/* node_get_type() will return NODE_GPP if hnode =
+	 * DSP_HGPPNODE. */
+	node1_type = node_get_type(node1);
+	node2_type = node_get_type(node2);
+	/* Check stream indices ranges */
+	if ((node1_type != NODE_GPP && node1_type != NODE_DEVICE &&
+				stream1 >= MAX_OUTPUTS(node1)) ||
+			(node2_type != NODE_GPP && node2_type != NODE_DEVICE &&
+			 stream2 >= MAX_INPUTS(node2)))
+		return -EINVAL;
 
-	}
-	if (!status) {
-		/* node_get_type() will return NODE_GPP if hnode =
-		 * DSP_HGPPNODE. */
-		node1_type = node_get_type(node1);
-		node2_type = node_get_type(node2);
-		/* Check stream indices ranges */
-		if ((node1_type != NODE_GPP && node1_type != NODE_DEVICE &&
-		     stream1 >= MAX_OUTPUTS(node1)) || (node2_type != NODE_GPP
-							  && node2_type !=
-							  NODE_DEVICE
-							  && stream2 >=
-							  MAX_INPUTS(node2)))
-			status = -EINVAL;
-	}
-	if (!status) {
-		/*
-		 *  Only the following types of connections are allowed:
-		 *      task/dais socket < == > task/dais socket
-		 *      task/dais socket < == > device
-		 *      task/dais socket < == > GPP
-		 *
-		 *  ie, no message nodes, and at least one task or dais
-		 *  socket node.
-		 */
-		if (node1_type == NODE_MESSAGE || node2_type == NODE_MESSAGE ||
-		    (node1_type != NODE_TASK && node1_type != NODE_DAISSOCKET &&
-		     node2_type != NODE_TASK && node2_type != NODE_DAISSOCKET))
-			status = -EPERM;
-	}
+	/*
+	 *  Only the following types of connections are allowed:
+	 *      task/dais socket < == > task/dais socket
+	 *      task/dais socket < == > device
+	 *      task/dais socket < == > GPP
+	 *
+	 *  ie, no message nodes, and at least one task or dais
+	 *  socket node.
+	 */
+	if (node1_type == NODE_MESSAGE || node2_type == NODE_MESSAGE ||
+			(node1_type != NODE_TASK &&
+			 node1_type != NODE_DAISSOCKET &&
+			 node2_type != NODE_TASK &&
+			 node2_type != NODE_DAISSOCKET))
+		return -EPERM;
 	/*
 	 * Check stream mode. Default is STRMMODE_PROCCOPY.
 	 */
-	if (!status && pattrs) {
-		if (pattrs->strm_mode != STRMMODE_PROCCOPY)
-			status = -EPERM;	/* illegal stream mode */
-
-	}
-	if (status)
-		goto func_end;
+	if (pattrs && pattrs->strm_mode != STRMMODE_PROCCOPY)
+		return -EPERM;	/* illegal stream mode */
 
 	if (node1_type != NODE_GPP) {
 		hnode_mgr = node1->hnode_mgr;
@@ -888,155 +882,143 @@ int node_connect(struct node_object *node1, u32 stream1,
 		DBC_ASSERT(node2 != (struct node_object *)DSP_HGPPNODE);
 		hnode_mgr = node2->hnode_mgr;
 	}
+
 	/* Enter critical section */
 	mutex_lock(&hnode_mgr->node_mgr_lock);
 
 	/* Nodes must be in the allocated state */
-	if (node1_type != NODE_GPP && node_get_state(node1) != NODE_ALLOCATED)
+	if (node1_type != NODE_GPP &&
+			node_get_state(node1) != NODE_ALLOCATED) {
 		status = -EBADR;
+		goto out_unlock;
+	}
 
-	if (node2_type != NODE_GPP && node_get_state(node2) != NODE_ALLOCATED)
+	if (node2_type != NODE_GPP &&
+			node_get_state(node2) != NODE_ALLOCATED) {
 		status = -EBADR;
+		goto out_unlock;
+	}
 
-	if (!status) {
-		/*  Check that stream indices for task and dais socket nodes
-		 *  are not already be used. (Device nodes checked later) */
-		if (node1_type == NODE_TASK || node1_type == NODE_DAISSOCKET) {
-			output =
-			    &(node1->create_args.asa.
-			      task_arg_obj.strm_out_def[stream1]);
-			if (output->sz_device != NULL)
-				status = -EISCONN;
-
+	/*  Check that stream indices for task and dais socket nodes
+	 *  are not already be used. (Device nodes checked later) */
+	if (node1_type == NODE_TASK || node1_type == NODE_DAISSOCKET) {
+		output = &(node1->create_args.asa.
+				task_arg_obj.strm_out_def[stream1]);
+		if (output->sz_device != NULL) {
+			status = -EISCONN;
+			goto out_unlock;
 		}
-		if (node2_type == NODE_TASK || node2_type == NODE_DAISSOCKET) {
-			input =
-			    &(node2->create_args.asa.
-			      task_arg_obj.strm_in_def[stream2]);
-			if (input->sz_device != NULL)
-				status = -EISCONN;
 
+	}
+	if (node2_type == NODE_TASK || node2_type == NODE_DAISSOCKET) {
+		input = &(node2->create_args.asa.
+				task_arg_obj.strm_in_def[stream2]);
+		if (input->sz_device != NULL) {
+			status = -EISCONN;
+			goto out_unlock;
 		}
+
 	}
 	/* Connecting two task nodes? */
-	if (!status && ((node1_type == NODE_TASK ||
-				       node1_type == NODE_DAISSOCKET)
-				      && (node2_type == NODE_TASK
-					  || node2_type == NODE_DAISSOCKET))) {
+	if (((node1_type == NODE_TASK || node1_type == NODE_DAISSOCKET) &&
+				(node2_type == NODE_TASK ||
+				 node2_type == NODE_DAISSOCKET))) {
 		/* Find available pipe */
-		pipe_id = gb_findandset(hnode_mgr->pipe_map);
-		if (pipe_id == GB_NOBITS) {
+		pipe_id = find_first_zero_bit(hnode_mgr->pipe_map, MAXPIPES);
+		if (pipe_id == MAXPIPES) {
 			status = -ECONNREFUSED;
-		} else {
-			node1->outputs[stream1].type = NODECONNECT;
-			node2->inputs[stream2].type = NODECONNECT;
-			node1->outputs[stream1].dev_id = pipe_id;
-			node2->inputs[stream2].dev_id = pipe_id;
-			output->sz_device = kzalloc(PIPENAMELEN + 1,
-							GFP_KERNEL);
-			input->sz_device = kzalloc(PIPENAMELEN + 1, GFP_KERNEL);
-			if (output->sz_device == NULL ||
-			    input->sz_device == NULL) {
-				/* Undo the connection */
-				kfree(output->sz_device);
-
-				kfree(input->sz_device);
-
-				output->sz_device = NULL;
-				input->sz_device = NULL;
-				gb_clear(hnode_mgr->pipe_map, pipe_id);
-				status = -ENOMEM;
-			} else {
-				/* Copy "/dbpipe<pipId>" name to device names */
-				sprintf(output->sz_device, "%s%d",
-					PIPEPREFIX, pipe_id);
-				strcpy(input->sz_device, output->sz_device);
-			}
+			goto out_unlock;
+		}
+		set_bit(pipe_id, hnode_mgr->pipe_map);
+		node1->outputs[stream1].type = NODECONNECT;
+		node2->inputs[stream2].type = NODECONNECT;
+		node1->outputs[stream1].dev_id = pipe_id;
+		node2->inputs[stream2].dev_id = pipe_id;
+		output->sz_device = kzalloc(PIPENAMELEN + 1, GFP_KERNEL);
+		input->sz_device = kzalloc(PIPENAMELEN + 1, GFP_KERNEL);
+		if (output->sz_device == NULL || input->sz_device == NULL) {
+			/* Undo the connection */
+			kfree(output->sz_device);
+			kfree(input->sz_device);
+			output->sz_device = NULL;
+			input->sz_device = NULL;
+			clear_bit(pipe_id, hnode_mgr->pipe_map);
+			status = -ENOMEM;
+			goto out_unlock;
 		}
+		/* Copy "/dbpipe<pipId>" name to device names */
+		sprintf(output->sz_device, "%s%d", PIPEPREFIX, pipe_id);
+		strcpy(input->sz_device, output->sz_device);
 	}
 	/* Connecting task node to host? */
-	if (!status && (node1_type == NODE_GPP ||
-				      node2_type == NODE_GPP)) {
-		if (node1_type == NODE_GPP) {
-			chnl_mode = CHNL_MODETODSP;
-		} else {
-			DBC_ASSERT(node2_type == NODE_GPP);
-			chnl_mode = CHNL_MODEFROMDSP;
+	if ((node1_type == NODE_GPP || node2_type == NODE_GPP)) {
+		pstr_dev_name = kzalloc(HOSTNAMELEN + 1, GFP_KERNEL);
+		if (!pstr_dev_name) {
+			status = -ENOMEM;
+			goto out_unlock;
 		}
+
+		DBC_ASSERT((node1_type == NODE_GPP) ||
+				(node2_type == NODE_GPP));
+
+		chnl_mode = (node1_type == NODE_GPP) ?
+			CHNL_MODETODSP : CHNL_MODEFROMDSP;
+
 		/*  Reserve a channel id. We need to put the name "/host<id>"
 		 *  in the node's create_args, but the host
 		 *  side channel will not be opened until DSPStream_Open is
 		 *  called for this node. */
-		if (pattrs) {
-			if (pattrs->strm_mode == STRMMODE_RDMA) {
-				chnl_id =
-				    gb_findandset(hnode_mgr->dma_chnl_map);
+		strm_mode = pattrs ? pattrs->strm_mode : STRMMODE_PROCCOPY;
+		switch (strm_mode) {
+		case STRMMODE_RDMA:
+			chnl_id = find_first_zero_bit(hnode_mgr->dma_chnl_map,
+					CHNL_MAXCHANNELS);
+			if (chnl_id < CHNL_MAXCHANNELS) {
+				set_bit(chnl_id, hnode_mgr->dma_chnl_map);
 				/* dma chans are 2nd transport chnl set
 				 * ids(e.g. 16-31) */
-				(chnl_id != GB_NOBITS) ?
-				    (chnl_id =
-				     chnl_id +
-				     hnode_mgr->ul_num_chnls) : chnl_id;
-			} else if (pattrs->strm_mode == STRMMODE_ZEROCOPY) {
-				chnl_id = gb_findandset(hnode_mgr->zc_chnl_map);
+				chnl_id = chnl_id + hnode_mgr->ul_num_chnls;
+			}
+			break;
+		case STRMMODE_ZEROCOPY:
+			chnl_id = find_first_zero_bit(hnode_mgr->zc_chnl_map,
+					CHNL_MAXCHANNELS);
+			if (chnl_id < CHNL_MAXCHANNELS) {
+				set_bit(chnl_id, hnode_mgr->zc_chnl_map);
 				/* zero-copy chans are 3nd transport set
 				 * (e.g. 32-47) */
-				(chnl_id != GB_NOBITS) ? (chnl_id = chnl_id +
-							  (2 *
-							   hnode_mgr->
-							   ul_num_chnls))
-				    : chnl_id;
-			} else {	/* must be PROCCOPY */
-				DBC_ASSERT(pattrs->strm_mode ==
-					   STRMMODE_PROCCOPY);
-				chnl_id = gb_findandset(hnode_mgr->chnl_map);
-				/* e.g. 0-15 */
+				chnl_id = chnl_id +
+					(2 * hnode_mgr->ul_num_chnls);
 			}
-		} else {
-			/* default to PROCCOPY */
-			chnl_id = gb_findandset(hnode_mgr->chnl_map);
+			break;
+		case STRMMODE_PROCCOPY:
+			chnl_id = find_first_zero_bit(hnode_mgr->chnl_map,
+					CHNL_MAXCHANNELS);
+			if (chnl_id < CHNL_MAXCHANNELS)
+				set_bit(chnl_id, hnode_mgr->chnl_map);
+			break;
+		default:
+			status = -EINVAL;
+			goto out_unlock;
 		}
-		if (chnl_id == GB_NOBITS) {
+		if (chnl_id == CHNL_MAXCHANNELS) {
 			status = -ECONNREFUSED;
-			goto func_cont2;
+			goto out_unlock;
 		}
-		pstr_dev_name = kzalloc(HOSTNAMELEN + 1, GFP_KERNEL);
-		if (pstr_dev_name != NULL)
-			goto func_cont2;
-
-		if (pattrs) {
-			if (pattrs->strm_mode == STRMMODE_RDMA) {
-				gb_clear(hnode_mgr->dma_chnl_map, chnl_id -
-					 hnode_mgr->ul_num_chnls);
-			} else if (pattrs->strm_mode == STRMMODE_ZEROCOPY) {
-				gb_clear(hnode_mgr->zc_chnl_map, chnl_id -
-					 (2 * hnode_mgr->ul_num_chnls));
-			} else {
-				DBC_ASSERT(pattrs->strm_mode ==
-					   STRMMODE_PROCCOPY);
-				gb_clear(hnode_mgr->chnl_map, chnl_id);
-			}
+
+		if (node1 == (struct node_object *)DSP_HGPPNODE) {
+			node2->inputs[stream2].type = HOSTCONNECT;
+			node2->inputs[stream2].dev_id = chnl_id;
+			input->sz_device = pstr_dev_name;
 		} else {
-			gb_clear(hnode_mgr->chnl_map, chnl_id);
-		}
-		status = -ENOMEM;
-func_cont2:
-		if (!status) {
-			if (node1 == (struct node_object *)DSP_HGPPNODE) {
-				node2->inputs[stream2].type = HOSTCONNECT;
-				node2->inputs[stream2].dev_id = chnl_id;
-				input->sz_device = pstr_dev_name;
-			} else {
-				node1->outputs[stream1].type = HOSTCONNECT;
-				node1->outputs[stream1].dev_id = chnl_id;
-				output->sz_device = pstr_dev_name;
-			}
-			sprintf(pstr_dev_name, "%s%d", HOSTPREFIX, chnl_id);
+			node1->outputs[stream1].type = HOSTCONNECT;
+			node1->outputs[stream1].dev_id = chnl_id;
+			output->sz_device = pstr_dev_name;
 		}
+		sprintf(pstr_dev_name, "%s%d", HOSTPREFIX, chnl_id);
 	}
 	/* Connecting task node to device node? */
-	if (!status && ((node1_type == NODE_DEVICE) ||
-				      (node2_type == NODE_DEVICE))) {
+	if (((node1_type == NODE_DEVICE) || (node2_type == NODE_DEVICE))) {
 		if (node2_type == NODE_DEVICE) {
 			/* node1 == > device */
 			dev_node_obj = node2;
@@ -1053,60 +1035,57 @@ func_cont2:
 		/* Set up create args */
 		pstream->type = DEVICECONNECT;
 		dw_length = strlen(dev_node_obj->pstr_dev_name);
-		if (conn_param != NULL) {
+		if (conn_param != NULL)
 			pstrm_def->sz_device = kzalloc(dw_length + 1 +
-							conn_param->cb_data,
-							GFP_KERNEL);
-		} else {
+					conn_param->cb_data,
+					GFP_KERNEL);
 			pstrm_def->sz_device = kzalloc(dw_length + 1,
-							GFP_KERNEL);
-		}
-		if (pstrm_def->sz_device == NULL) {
+					GFP_KERNEL);
+		if (!pstrm_def->sz_device) {
 			status = -ENOMEM;
-		} else {
-			/* Copy device name */
-			strncpy(pstrm_def->sz_device,
+			goto out_unlock;
+		}
+		/* Copy device name */
+		strncpy(pstrm_def->sz_device,
 				dev_node_obj->pstr_dev_name, dw_length);
-			if (conn_param != NULL) {
-				strncat(pstrm_def->sz_device,
+		if (conn_param != NULL)
+			strncat(pstrm_def->sz_device,
 					(char *)conn_param->node_data,
 					(u32) conn_param->cb_data);
-			}
-			dev_node_obj->device_owner = hnode;
-		}
+		dev_node_obj->device_owner = hnode;
 	}
-	if (!status) {
-		/* Fill in create args */
-		if (node1_type == NODE_TASK || node1_type == NODE_DAISSOCKET) {
-			node1->create_args.asa.task_arg_obj.num_outputs++;
-			fill_stream_def(node1, output, pattrs);
-		}
-		if (node2_type == NODE_TASK || node2_type == NODE_DAISSOCKET) {
-			node2->create_args.asa.task_arg_obj.num_inputs++;
-			fill_stream_def(node2, input, pattrs);
-		}
-		/* Update node1 and node2 stream_connect */
-		if (node1_type != NODE_GPP && node1_type != NODE_DEVICE) {
-			node1->num_outputs++;
-			if (stream1 > node1->max_output_index)
-				node1->max_output_index = stream1;
+	/* Fill in create args */
+	if (node1_type == NODE_TASK || node1_type == NODE_DAISSOCKET) {
+		node1->create_args.asa.task_arg_obj.num_outputs++;
+		fill_stream_def(node1, output, pattrs);
+	}
+	if (node2_type == NODE_TASK || node2_type == NODE_DAISSOCKET) {
+		node2->create_args.asa.task_arg_obj.num_inputs++;
+		fill_stream_def(node2, input, pattrs);
+	}
+	/* Update node1 and node2 stream_connect */
+	if (node1_type != NODE_GPP && node1_type != NODE_DEVICE) {
+		node1->num_outputs++;
+		if (stream1 > node1->max_output_index)
+			node1->max_output_index = stream1;
 
-		}
-		if (node2_type != NODE_GPP && node2_type != NODE_DEVICE) {
-			node2->num_inputs++;
-			if (stream2 > node2->max_input_index)
-				node2->max_input_index = stream2;
+	}
+	if (node2_type != NODE_GPP && node2_type != NODE_DEVICE) {
+		node2->num_inputs++;
+		if (stream2 > node2->max_input_index)
+			node2->max_input_index = stream2;
 
-		}
-		fill_stream_connect(node1, node2, stream1, stream2);
 	}
+	fill_stream_connect(node1, node2, stream1, stream2);
 	/* end of sync_enter_cs */
 	/* Exit critical section */
+out_unlock:
+	if (status && pstr_dev_name)
+		kfree(pstr_dev_name);
 	mutex_unlock(&hnode_mgr->node_mgr_lock);
-func_end:
 	dev_dbg(bridge, "%s: node1: %p stream1: %d node2: %p stream2: %d"
-		"pattrs: %p status: 0x%x\n", __func__, node1,
-		stream1, node2, stream2, pattrs, status);
+			"pattrs: %p status: 0x%x\n", __func__, node1,
+			stream1, node2, stream2, pattrs, status);
 	return status;
 }
 
@@ -1284,6 +1263,7 @@ int node_create_mgr(struct node_mgr **node_man,
 	struct nldr_attrs nldr_attrs_obj;
 	int status = 0;
 	u8 dev_type;
+
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(node_man != NULL);
 	DBC_REQUIRE(hdev_obj != NULL);
@@ -1291,113 +1271,95 @@ int node_create_mgr(struct node_mgr **node_man,
 	*node_man = NULL;
 	/* Allocate Node manager object */
 	node_mgr_obj = kzalloc(sizeof(struct node_mgr), GFP_KERNEL);
-	if (node_mgr_obj) {
-		node_mgr_obj->hdev_obj = hdev_obj;
-		node_mgr_obj->node_list = kzalloc(sizeof(struct lst_list),
-							GFP_KERNEL);
-		node_mgr_obj->pipe_map = gb_create(MAXPIPES);
-		node_mgr_obj->pipe_done_map = gb_create(MAXPIPES);
-		if (node_mgr_obj->node_list == NULL
-		    || node_mgr_obj->pipe_map == NULL
-		    || node_mgr_obj->pipe_done_map == NULL) {
-			status = -ENOMEM;
-		} else {
-			INIT_LIST_HEAD(&node_mgr_obj->node_list->head);
-			node_mgr_obj->ntfy_obj = kmalloc(
-				sizeof(struct ntfy_object), GFP_KERNEL);
-			if (node_mgr_obj->ntfy_obj)
-				ntfy_init(node_mgr_obj->ntfy_obj);
-			else
-				status = -ENOMEM;
-		}
-		node_mgr_obj->num_created = 0;
-	} else {
+	if (unlikely(node_mgr_obj == NULL))
+		return -ENOMEM;
+
+	node_mgr_obj->hdev_obj = hdev_obj;
+	node_mgr_obj->node_list = kzalloc(sizeof(struct lst_list), GFP_KERNEL);
+	if (unlikely(node_mgr_obj->node_list == NULL)) {
 		status = -ENOMEM;
+		goto out_err;
 	}
-	/* get devNodeType */
-	if (!status)
-		status = dev_get_dev_type(hdev_obj, &dev_type);
+
+	node_mgr_obj->ntfy_obj = kmalloc(sizeof(struct ntfy_object),
+			GFP_KERNEL);
+	if (unlikely(node_mgr_obj->ntfy_obj == NULL)) {
+		status = -ENOMEM;
+		goto out_err;
+	}
+	ntfy_init(node_mgr_obj->ntfy_obj);
+
+	INIT_LIST_HEAD(&node_mgr_obj->node_list->head);
+
+	dev_get_dev_type(hdev_obj, &dev_type);
 
 	/* Create the DCD Manager */
-	if (!status) {
-		status =
-		    dcd_create_manager(sz_zl_file, &node_mgr_obj->hdcd_mgr);
-		if (!status)
-			status = get_proc_props(node_mgr_obj, hdev_obj);
+	status = dcd_create_manager(sz_zl_file, &node_mgr_obj->hdcd_mgr);
+	if (unlikely(status != 0))
+		goto out_err;
+
+	status = get_proc_props(node_mgr_obj, hdev_obj);
+	if (unlikely(status != 0))
+		goto out_err;
 
-	}
 	/* Create NODE Dispatcher */
-	if (!status) {
-		disp_attr_obj.ul_chnl_offset = node_mgr_obj->ul_chnl_offset;
-		disp_attr_obj.ul_chnl_buf_size = node_mgr_obj->ul_chnl_buf_size;
-		disp_attr_obj.proc_family = node_mgr_obj->proc_family;
-		disp_attr_obj.proc_type = node_mgr_obj->proc_type;
-		status =
-		    disp_create(&node_mgr_obj->disp_obj, hdev_obj,
-				&disp_attr_obj);
-	}
+	disp_attr_obj.ul_chnl_offset = node_mgr_obj->ul_chnl_offset;
+	disp_attr_obj.ul_chnl_buf_size = node_mgr_obj->ul_chnl_buf_size;
+	disp_attr_obj.proc_family = node_mgr_obj->proc_family;
+	disp_attr_obj.proc_type = node_mgr_obj->proc_type;
+
+	status = disp_create(&node_mgr_obj->disp_obj, hdev_obj, &disp_attr_obj);
+	if (unlikely(status != 0))
+		goto out_err;
+
 	/* Create a STRM Manager */
-	if (!status)
-		status = strm_create(&node_mgr_obj->strm_mgr_obj, hdev_obj);
+	status = strm_create(&node_mgr_obj->strm_mgr_obj, hdev_obj);
+	if (unlikely(status != 0))
+		goto out_err;
 
-	if (!status) {
-		dev_get_intf_fxns(hdev_obj, &node_mgr_obj->intf_fxns);
-		/* Get msg_ctrl queue manager */
-		dev_get_msg_mgr(hdev_obj, &node_mgr_obj->msg_mgr_obj);
-		mutex_init(&node_mgr_obj->node_mgr_lock);
-		node_mgr_obj->chnl_map = gb_create(node_mgr_obj->ul_num_chnls);
-		/* dma chnl map. ul_num_chnls is # per transport */
-		node_mgr_obj->dma_chnl_map =
-		    gb_create(node_mgr_obj->ul_num_chnls);
-		node_mgr_obj->zc_chnl_map =
-		    gb_create(node_mgr_obj->ul_num_chnls);
-		if ((node_mgr_obj->chnl_map == NULL)
-		    || (node_mgr_obj->dma_chnl_map == NULL)
-		    || (node_mgr_obj->zc_chnl_map == NULL)) {
-			status = -ENOMEM;
-		} else {
-			/* Block out reserved channels */
-			for (i = 0; i < node_mgr_obj->ul_chnl_offset; i++)
-				gb_set(node_mgr_obj->chnl_map, i);
-
-			/* Block out channels reserved for RMS */
-			gb_set(node_mgr_obj->chnl_map,
-			       node_mgr_obj->ul_chnl_offset);
-			gb_set(node_mgr_obj->chnl_map,
-			       node_mgr_obj->ul_chnl_offset + 1);
-		}
-	}
-	if (!status) {
-		/* NO RM Server on the IVA */
-		if (dev_type != IVA_UNIT) {
-			/* Get addresses of any RMS functions loaded */
-			status = get_rms_fxns(node_mgr_obj);
-		}
+	dev_get_intf_fxns(hdev_obj, &node_mgr_obj->intf_fxns);
+	/* Get msg_ctrl queue manager */
+	dev_get_msg_mgr(hdev_obj, &node_mgr_obj->msg_mgr_obj);
+	mutex_init(&node_mgr_obj->node_mgr_lock);
+
+	/* Block out reserved channels */
+	for (i = 0; i < node_mgr_obj->ul_chnl_offset; i++)
+		set_bit(i, node_mgr_obj->chnl_map);
+
+	/* Block out channels reserved for RMS */
+	set_bit(node_mgr_obj->ul_chnl_offset, node_mgr_obj->chnl_map);
+	set_bit(node_mgr_obj->ul_chnl_offset + 1, node_mgr_obj->chnl_map);
+
+	/* NO RM Server on the IVA */
+	if (dev_type != IVA_UNIT) {
+		/* Get addresses of any RMS functions loaded */
+		status = get_rms_fxns(node_mgr_obj);
 	}
+	if (unlikely(status != 0))
+		goto out_err;
 
 	/* Get loader functions and create loader */
-	if (!status)
-		node_mgr_obj->nldr_fxns = nldr_fxns;	/* Dyn loader funcs */
+	node_mgr_obj->nldr_fxns = nldr_fxns;	/* Dyn loader funcs */
 
-	if (!status) {
-		nldr_attrs_obj.pfn_ovly = ovly;
-		nldr_attrs_obj.pfn_write = mem_write;
-		nldr_attrs_obj.us_dsp_word_size = node_mgr_obj->udsp_word_size;
-		nldr_attrs_obj.us_dsp_mau_size = node_mgr_obj->udsp_mau_size;
-		node_mgr_obj->loader_init = node_mgr_obj->nldr_fxns.pfn_init();
-		status =
-		    node_mgr_obj->nldr_fxns.pfn_create(&node_mgr_obj->nldr_obj,
-						       hdev_obj,
-						       &nldr_attrs_obj);
-	}
-	if (!status)
-		*node_man = node_mgr_obj;
-	else
-		delete_node_mgr(node_mgr_obj);
+	nldr_attrs_obj.pfn_ovly = ovly;
+	nldr_attrs_obj.pfn_write = mem_write;
+	nldr_attrs_obj.us_dsp_word_size = node_mgr_obj->udsp_word_size;
+	nldr_attrs_obj.us_dsp_mau_size = node_mgr_obj->udsp_mau_size;
+	node_mgr_obj->loader_init = node_mgr_obj->nldr_fxns.pfn_init();
+	status = node_mgr_obj->nldr_fxns.pfn_create(&node_mgr_obj->nldr_obj,
+			hdev_obj,
+			&nldr_attrs_obj);
+	if (unlikely(status != 0))
+		goto out_err;
+
+	*node_man = node_mgr_obj;
 
 	DBC_ENSURE((status && *node_man == NULL) || (!status && *node_man));
 
 	return status;
+out_err:
+	delete_node_mgr(node_mgr_obj);
+	return status;
 }
 
 /*
@@ -2613,21 +2575,6 @@ static void delete_node_mgr(struct node_mgr *hnode_mgr)
 			kfree(hnode_mgr->ntfy_obj);
 		}
 
-		if (hnode_mgr->pipe_map)
-			gb_delete(hnode_mgr->pipe_map);
-
-		if (hnode_mgr->pipe_done_map)
-			gb_delete(hnode_mgr->pipe_done_map);
-
-		if (hnode_mgr->chnl_map)
-			gb_delete(hnode_mgr->chnl_map);
-
-		if (hnode_mgr->dma_chnl_map)
-			gb_delete(hnode_mgr->dma_chnl_map);
-
-		if (hnode_mgr->zc_chnl_map)
-			gb_delete(hnode_mgr->zc_chnl_map);
-
 		if (hnode_mgr->disp_obj)
 			disp_delete(hnode_mgr->disp_obj);
 
@@ -2742,25 +2689,25 @@ static void free_stream(struct node_mgr *hnode_mgr, struct stream_chnl stream)
 {
 	/* Free up the pipe id unless other node has not yet been deleted. */
 	if (stream.type == NODECONNECT) {
-		if (gb_test(hnode_mgr->pipe_done_map, stream.dev_id)) {
+		if (test_bit(stream.dev_id, hnode_mgr->pipe_done_map)) {
 			/* The other node has already been deleted */
-			gb_clear(hnode_mgr->pipe_done_map, stream.dev_id);
-			gb_clear(hnode_mgr->pipe_map, stream.dev_id);
+			clear_bit(stream.dev_id, hnode_mgr->pipe_done_map);
+			clear_bit(stream.dev_id, hnode_mgr->pipe_map);
 		} else {
 			/* The other node has not been deleted yet */
-			gb_set(hnode_mgr->pipe_done_map, stream.dev_id);
+			set_bit(stream.dev_id, hnode_mgr->pipe_done_map);
 		}
 	} else if (stream.type == HOSTCONNECT) {
 		if (stream.dev_id < hnode_mgr->ul_num_chnls) {
-			gb_clear(hnode_mgr->chnl_map, stream.dev_id);
+			clear_bit(stream.dev_id, hnode_mgr->chnl_map);
 		} else if (stream.dev_id < (2 * hnode_mgr->ul_num_chnls)) {
 			/* dsp-dma */
-			gb_clear(hnode_mgr->dma_chnl_map, stream.dev_id -
-				 (1 * hnode_mgr->ul_num_chnls));
+			clear_bit(stream.dev_id - (1 * hnode_mgr->ul_num_chnls),
+					hnode_mgr->dma_chnl_map);
 		} else if (stream.dev_id < (3 * hnode_mgr->ul_num_chnls)) {
 			/* zero-copy */
-			gb_clear(hnode_mgr->zc_chnl_map, stream.dev_id -
-				 (2 * hnode_mgr->ul_num_chnls));
+			clear_bit(stream.dev_id - (2 * hnode_mgr->ul_num_chnls),
+					hnode_mgr->zc_chnl_map);
 		}
 	}
 }
-- 
1.7.2.3

