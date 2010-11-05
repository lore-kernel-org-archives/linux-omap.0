From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH v2 04/12] staging: tidspbridge: remove gb bitmap implementation
Date: Fri,  5 Nov 2010 17:13:08 +0200
Message-ID: <1288969996-22103-5-git-send-email-ionut.nicu@mindbit.ro>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33152 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab0KEPOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 11:14:08 -0400
Received: by gwj21 with SMTP id 21so2210883gwj.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 08:14:07 -0700 (PDT)
In-Reply-To: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sapiens Rene <rene.sapiens@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Now that all users of gb have been converted to the
standard linux bitmap API, we can remove it from the
gen library.

Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
---
 drivers/staging/tidspbridge/Makefile               |    2 +-
 drivers/staging/tidspbridge/gen/gb.c               |  165 --------------------
 drivers/staging/tidspbridge/include/dspbridge/gb.h |   79 ----------
 3 files changed, 1 insertions(+), 245 deletions(-)
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
-- 
1.7.2.3

