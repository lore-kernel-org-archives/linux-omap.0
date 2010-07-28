From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
 implementation
Date: Wed, 28 Jul 2010 11:23:07 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044ED63921@dbde02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
 <1279927348-21750-2-git-send-email-davidsin@ti.com>
 <1279927348-21750-3-git-send-email-davidsin@ti.com>
 <1279927348-21750-4-git-send-email-davidsin@ti.com>
 <1279927348-21750-5-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39296 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab0G1Fx0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 01:53:26 -0400
In-Reply-To: <1279927348-21750-5-git-send-email-davidsin@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sin, David" <davidsin@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Molnar, Lajos" <molnar@ti.com>

> -----Original Message-----
> From: Sin, David
> Sent: Saturday, July 24, 2010 4:52 AM
> To: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org;
> Tony Lindgren; Russell King
> Cc: Kanigeri, Hari; Ohad Ben-Cohen; Hiremath, Vaibhav; Shilimkar, Santosh;
> Molnar, Lajos; Sin, David
> Subject: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
> implementation
> 
> From: Lajos Molnar <molnar@ti.com>
> 
> This patch defines the TILER Memory Manager (TMM) interface and
> provides implementation for a PAT-supporting TMM.
> 
> Signed-off-by: Lajos Molnar <molnar@ti.com>
> Signed-off-by: David Sin <davidsin@ti.com>
> ---
>  drivers/media/video/tiler/tmm-pat.c |  274
> +++++++++++++++++++++++++++++++++++
>  drivers/media/video/tiler/tmm.h     |  109 ++++++++++++++
>  2 files changed, 383 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/video/tiler/tmm-pat.c
>  create mode 100644 drivers/media/video/tiler/tmm.h
> 
> diff --git a/drivers/media/video/tiler/tmm-pat.c
> b/drivers/media/video/tiler/tmm-pat.c
> new file mode 100644
> index 0000000..ccd32b4
> --- /dev/null
> +++ b/drivers/media/video/tiler/tmm-pat.c
> @@ -0,0 +1,274 @@
> +/*
> + * tmm-pat.c
> + *
> + * DMM driver support functions for TI TILER hardware block.
> + *
> + * Authors: Lajos Molnar <molnar@ti.com>
> + *          David Sin <davidsin@ti.com>
> + *
> + * Copyright (C) 2009-2010 Texas Instruments, Inc.
> + *
> + * This package is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> + */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/mmzone.h>
> +#include <asm/cacheflush.h>
> +#include <linux/mutex.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +
> +#include "tmm.h"
> +
> +/* Page size granularity can be 4k, 16k, or 64k */
> +#define DMM_PAGE 0x1000
> +
[Hiremath, Vaibhav] You can use SZ_4K, SZ_16K macros here.

> +/* Memory limit to cache free pages. TILER will eventually use this much */
> +static u32 cache_limit = CONFIG_TILER_CACHE_LIMIT << 20;
> +module_param_named(cache, cache_limit, uint, 0644);
> +MODULE_PARM_DESC(cache, "Cache free pages if total memory is under this
> limit");
> +
> +/* global state - statically initialized */
> +static LIST_HEAD(free_list);	/* page cache: list of free pages */
> +static u32 total_mem;		/* total memory allocated (free & used) */
> +static u32 refs;		/* number of tmm_pat instances */
> +static DEFINE_MUTEX(mtx);	/* global mutex */
> +
> +/* The page struct pointer and physical address of each page.*/
> +struct mem {
> +	struct list_head list;
> +	struct page *pg;	/* page struct */
> +	u32 pa;			/* physical address */
> +};
> +
> +/* Used to keep track of mem per tmm_pat_get_pages call */
> +struct fast {
[Hiremath, Vaibhav] Can you think of some better naming convention here, "fast" is bit confusing here?
Does following convention make sense to you here,

struct mem	=> struct tmm_page
struct fast	=> struct tmm_pages


> +	struct list_head list;
> +	struct mem **mem;	/* array of page info */
> +	u32 *pa;		/* array of physical addresses */
> +	u32 num;		/* number of pages */
> +};
> +
> +/* TMM PAT private structure */
> +struct dmm_mem {
> +	struct list_head fast_list;
> +	struct dmm *dmm;
> +};
> +
> +/**
> + *  Frees pages in a fast structure.  Moves pages to the free list if there
> + *  are	less pages used	than max_to_keep.  Otherwise, it frees the
> pages
> + */
> +static void free_fast(struct fast *f)
[Hiremath, Vaibhav] Same here, free_pages. Applicable to all places.

> +{
> +	s32 i = 0;
> +
> +	/* mutex is locked */
> +	for (i = 0; i < f->num; i++) {
> +		if (total_mem < cache_limit) {
> +			/* cache free page if under the limit */
> +			list_add(&f->mem[i]->list, &free_list);
> +		} else {
> +			/* otherwise, free */
> +			total_mem -= PAGE_SIZE;
[Hiremath, Vaibhav] I have one Q here,

What if DMM/Tiler page size is different than Linux PAGE_SIZE? Does this driver will still work? Have you tested it?

Thanks,
Vaibhav

> +			__free_page(f->mem[i]->pg);
> +		}
> +	}
> +	kfree(f->pa);
> +	kfree(f->mem);
> +	/* remove only if element was added */
> +	if (f->list.next)
> +		list_del(&f->list);
> +	kfree(f);
> +}
> +
> +/* allocate and flush a page */
> +static struct mem *alloc_mem(void)
> +{
> +	struct mem *m = kzalloc(sizeof(*m), GFP_KERNEL);
> +	if (!m)
> +		return NULL;
> +
> +	m->pg = alloc_page(GFP_KERNEL | GFP_DMA);
> +	if (!m->pg) {
> +		kfree(m);
> +		return NULL;
> +	}
> +
> +	m->pa = page_to_phys(m->pg);
> +
> +	/* flush the cache entry for each page we allocate. */
> +	dmac_flush_range(page_address(m->pg),
> +				page_address(m->pg) + PAGE_SIZE);
> +	outer_flush_range(m->pa, m->pa + PAGE_SIZE);
> +
> +	return m;
> +}
> +
> +static void free_page_cache(void)
> +{
> +	struct mem *m, *m_;
> +
> +	/* mutex is locked */
> +	list_for_each_entry_safe(m, m_, &free_list, list) {
> +		__free_page(m->pg);
> +		total_mem -= PAGE_SIZE;
> +		list_del(&m->list);
> +		kfree(m);
> +	}
> +}
> +
> +static void tmm_pat_deinit(struct tmm *tmm)
> +{
> +	struct fast *f, *f_;
> +	struct dmm_mem *pvt = (struct dmm_mem *) tmm->pvt;
> +
> +	mutex_lock(&mtx);
> +
> +	/* free all outstanding used memory */
> +	list_for_each_entry_safe(f, f_, &pvt->fast_list, list)
> +		free_fast(f);
> +
> +	/* if this is the last tmm_pat, free all memory */
> +	if (--refs == 0)
> +		free_page_cache();
> +
> +	mutex_unlock(&mtx);
> +}
> +
> +static u32 *tmm_pat_get_pages(struct tmm *tmm, u32 n)
> +{
> +	struct mem *m;
> +	struct fast *f;
> +	struct dmm_mem *pvt = (struct dmm_mem *) tmm->pvt;
> +
> +	f = kzalloc(sizeof(*f), GFP_KERNEL);
> +	if (!f)
> +		return NULL;
> +
> +	/* array of mem struct pointers */
> +	f->mem = kzalloc(n * sizeof(*f->mem), GFP_KERNEL);
> +
> +	/* array of physical addresses */
> +	f->pa = kzalloc(n * sizeof(*f->pa), GFP_KERNEL);
> +
> +	/* no pages have been allocated yet (needed for cleanup) */
> +	f->num = 0;
> +
> +	if (!f->mem || !f->pa)
> +		goto cleanup;
> +
> +	/* fill out fast struct mem array with free pages */
> +	mutex_lock(&mtx);
> +	while (f->num < n) {
> +		/* if there is a free cached page use it */
> +		if (!list_empty(&free_list)) {
> +			/* unbind first element from list */
> +			m = list_first_entry(&free_list, typeof(*m), list);
> +			list_del(&m->list);
> +		} else {
> +			mutex_unlock(&mtx);
> +
> +			/**
> +			 * Unlock mutex during allocation and cache flushing.
> +			 */
> +			m = alloc_mem();
> +			if (!m)
> +				goto cleanup;
> +
> +			mutex_lock(&mtx);
> +			total_mem += PAGE_SIZE;
> +		}
> +
> +		f->mem[f->num] = m;
> +		f->pa[f->num++] = m->pa;
> +	}
> +
> +	list_add(&f->list, &pvt->fast_list);
> +	mutex_unlock(&mtx);
> +	return f->pa;
> +
> +cleanup:
> +	free_fast(f);
> +	return NULL;
> +}
> +
> +static void tmm_pat_free_pages(struct tmm *tmm, u32 *page_list)
> +{
> +	struct dmm_mem *pvt = (struct dmm_mem *) tmm->pvt;
> +	struct fast *f, *f_;
> +
> +	mutex_lock(&mtx);
> +	/* find fast struct based on 1st page */
> +	list_for_each_entry_safe(f, f_, &pvt->fast_list, list) {
> +		if (f->pa[0] == page_list[0]) {
> +			free_fast(f);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&mtx);
> +}
> +
> +static s32 tmm_pat_map(struct tmm *tmm, struct pat_area area, u32 page_pa)
> +{
> +	struct dmm_mem *pvt = (struct dmm_mem *) tmm->pvt;
> +	struct pat pat_desc = {0};
> +
> +	/* send pat descriptor to dmm driver */
> +	pat_desc.ctrl.dir = 0;
> +	pat_desc.ctrl.ini = 0;
> +	pat_desc.ctrl.lut_id = 0;
> +	pat_desc.ctrl.start = 1;
> +	pat_desc.ctrl.sync = 0;
> +	pat_desc.area = area;
> +	pat_desc.next = NULL;
> +
> +	/* must be a 16-byte aligned physical address */
> +	pat_desc.data = page_pa;
> +	return dmm_pat_refill(pvt->dmm, &pat_desc, MANUAL);
> +}
> +
> +struct tmm *tmm_pat_init(u32 pat_id)
> +{
> +	struct tmm *tmm = NULL;
> +	struct dmm_mem *pvt = NULL;
> +
> +	struct dmm *dmm = dmm_pat_init(pat_id);
> +	if (dmm)
> +		tmm = kzalloc(sizeof(*tmm), GFP_KERNEL);
> +	if (tmm)
> +		pvt = kzalloc(sizeof(*pvt), GFP_KERNEL);
> +	if (pvt) {
> +		/* private data */
> +		pvt->dmm = dmm;
> +		INIT_LIST_HEAD(&pvt->fast_list);
> +
> +		/* increate tmm_pat references */
> +		mutex_lock(&mtx);
> +		refs++;
> +		mutex_unlock(&mtx);
> +
> +		/* public data */
> +		tmm->pvt = pvt;
> +		tmm->deinit = tmm_pat_deinit;
> +		tmm->get = tmm_pat_get_pages;
> +		tmm->free = tmm_pat_free_pages;
> +		tmm->map = tmm_pat_map;
> +		tmm->clear = NULL;   /* not yet supported */
> +
> +		return tmm;
> +	}
> +
> +	kfree(pvt);
> +	kfree(tmm);
> +	dmm_pat_release(dmm);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(tmm_pat_init);
> diff --git a/drivers/media/video/tiler/tmm.h
> b/drivers/media/video/tiler/tmm.h
> new file mode 100644
> index 0000000..fbdc1e2
> --- /dev/null
> +++ b/drivers/media/video/tiler/tmm.h
> @@ -0,0 +1,109 @@
> +/*
> + * tmm.h
> + *
> + * TMM interface definition for TI TILER driver.
> + *
> + * Author: Lajos Molnar <molnar@ti.com>
> + *
> + * Copyright (C) 2009-2010 Texas Instruments, Inc.
> + *
> + * This package is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> + */
> +#ifndef TMM_H
> +#define TMM_H
> +
> +#include <mach/dmm.h>
> +/**
> + * TMM interface
> + */
> +struct tmm {
> +	void *pvt;
> +
> +	/* function table */
> +	u32 *(*get)	(struct tmm *tmm, u32 num_pages);
> +	void (*free)	(struct tmm *tmm, u32 *pages);
> +	s32  (*map)	(struct tmm *tmm, struct pat_area area, u32 page_pa);
> +	void (*clear)	(struct tmm *tmm, struct pat_area area);
> +	void (*deinit)	(struct tmm *tmm);
> +};
> +
> +/**
> + * Request a set of pages from the DMM free page stack.
> + * @return a pointer to a list of physical page addresses.
> + */
> +static inline
> +u32 *tmm_get(struct tmm *tmm, u32 num_pages)
> +{
> +	if (tmm && tmm->pvt)
> +		return tmm->get(tmm, num_pages);
> +	return NULL;
> +}
> +
> +/**
> + * Return a set of used pages to the DMM free page stack.
> + * @param list a pointer to a list of physical page addresses.
> + */
> +static inline
> +void tmm_free(struct tmm *tmm, u32 *pages)
> +{
> +	if (tmm && tmm->pvt)
> +		tmm->free(tmm, pages);
> +}
> +
> +/**
> + * Program the physical address translator.
> + * @param area PAT area
> + * @param list of pages
> + */
> +static inline
> +s32 tmm_map(struct tmm *tmm, struct pat_area area, u32 page_pa)
> +{
> +	if (tmm && tmm->map && tmm->pvt)
> +		return tmm->map(tmm, area, page_pa);
> +	return -ENODEV;
> +}
> +
> +/**
> + * Clears the physical address translator.
> + * @param area PAT area
> + */
> +static inline
> +void tmm_clear(struct tmm *tmm, struct pat_area area)
> +{
> +	if (tmm && tmm->clear && tmm->pvt)
> +		tmm->clear(tmm, area);
> +}
> +
> +/**
> + * Checks whether tiler memory manager supports mapping
> + */
> +static inline
> +bool tmm_can_map(struct tmm *tmm)
> +{
> +	return tmm && tmm->map;
> +}
> +
> +/**
> + * Deinitialize tiler memory manager
> + */
> +static inline
> +void tmm_deinit(struct tmm *tmm)
> +{
> +	if (tmm && tmm->pvt)
> +		tmm->deinit(tmm);
> +}
> +
> +/**
> + * TMM implementation for PAT support.
> + *
> + * Initialize TMM for PAT with given id.
> + */
> +struct tmm *tmm_pat_init(u32 pat_id);
> +
> +#endif
> --
> 1.6.3.3

