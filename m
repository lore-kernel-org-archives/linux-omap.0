From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC 2/8] TILER-DMM: Container manager interface and utility
 definitons
Date: Sat, 24 Jul 2010 12:26:47 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6255353@dbde02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
 <1279927348-21750-2-git-send-email-davidsin@ti.com>
 <1279927348-21750-3-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54484 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab0GXG5D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jul 2010 02:57:03 -0400
In-Reply-To: <1279927348-21750-3-git-send-email-davidsin@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sin, David" <davidsin@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Molnar, Lajos" <molnar@ti.com>, "Ramachandra, Ravikiran" <r.ramachandra@ti.com>

> -----Original Message-----
> From: Sin, David
> Sent: Saturday, July 24, 2010 4:52 AM
> To: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org;
> Tony Lindgren; Russell King
> Cc: Kanigeri, Hari; Ohad Ben-Cohen; Hiremath, Vaibhav; Shilimkar, Santosh;
> Molnar, Lajos; Sin, David; Ramachandra, Ravikiran
> Subject: [RFC 2/8] TILER-DMM: Container manager interface and utility
> definitons
> 
> From: Lajos Molnar <molnar@ti.com>
> 
> This patch defined the TILER Container Manager (TCM) interface and
> provides utility methods for implementing a TCM.
> 
> Signed-off-by: Lajos Molnar <molnar@ti.com>
> Signed-off-by: David Sin <davidsin@ti.com>
> Signed-off-by: Ravi Ramachandra <r.ramachandra@ti.com>
> ---
>  drivers/media/video/tiler/tcm.h           |  209
> +++++++++++++++++++++++++++++
>  drivers/media/video/tiler/tcm/tcm-utils.h |   54 ++++++++
>  2 files changed, 263 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/video/tiler/tcm.h
>  create mode 100644 drivers/media/video/tiler/tcm/tcm-utils.h
> 
> diff --git a/drivers/media/video/tiler/tcm.h
> b/drivers/media/video/tiler/tcm.h
> new file mode 100644
> index 0000000..52a022a
> --- /dev/null
> +++ b/drivers/media/video/tiler/tcm.h
> @@ -0,0 +1,209 @@
> +/*
> + * tcm.h
> + *
> + * TILER container manager specification and support functions for TI
> + * TILER driver.
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
> +
> +#ifndef TCM_H
> +#define TCM_H
> +
> +struct tcm;
> +
> +/* point */
> +struct tcm_pt {
> +	u16 x;
> +	u16 y;
> +};
> +
> +/* 2d area */
> +struct tcm_area {
> +	struct tcm    *tcm;	/* parent */
> +	struct tcm_pt  p0;
> +	struct tcm_pt  p1;
> +};
> +
> +struct tcm {
> +	u16 width, height;	/* container dimensions */
> +
> +	/* 'pvt' structure shall contain any tcm details (attr) along with
> +	linked list of allocated areas and mutex for mutually exclusive
> access
> +	to the list.  It may also contain copies of width and height to
> notice
> +	any changes to the publicly available width and height fields. */
Commenting style ...

> +	void *pvt;
> +
> +	/* function table */
> +	s32 (*reserve_2d)(struct tcm *tcm, u16 height, u16 width, u8 align,
> +			  struct tcm_area *area);
> +	s32 (*free)      (struct tcm *tcm, struct tcm_area *area);
> +	void (*deinit)   (struct tcm *tcm);
> +};
> +
> +/*=======================================================================
> ======
> +    BASIC TILER CONTAINER MANAGER INTERFACE
> +=========================================================================
> ====*/
Commenting style.
> +
> +/*
> + * NOTE:
> + *
> + * Since some basic parameter checking is done outside the TCM
> algorithms,
> + * TCM implementation do NOT have to check the following:
> + *
> + *   area pointer is NULL
> + *   width and height fits within container
> + *   number of pages is more than the size of the container
> + *
> + */
> +
> +/**
> + * Template for <ALGO_NAME>_tcm_init method.  Define as:
> + * TCM_INIT(<ALGO_NAME>_tcm_init)
> + *
> + * Allocates and initializes a tiler container manager.
> + *
> + * @param width		Width of container
> + * @param height	Height of container
> + * @param attr		Container manager specific configuration
> + *			arguments.  Please describe these in
> + *			your header file.
> + *
> + * @return Pointer to the allocated and initialized container
> + *	   manager.  NULL on failure.  DO NOT leak any memory on
> + *	   failure!
> + */
> +#define TCM_INIT(name, attr_t) \
> +struct tcm *name(u16 width, u16 height, typeof(attr_t) *attr);
> +
> +/**
> + * Deinitialize tiler container manager.
> + *
> + * @param tcm	Pointer to container manager.
> + *
> + * @return 0 on success, non-0 error value on error.  The call
> + *	   should free as much memory as possible and meaningful
> + *	   even on failure.  Some error codes: -ENODEV: invalid
> + *	   manager.
> + */
> +static inline void tcm_deinit(struct tcm *tcm)
> +{
> +	if (tcm)
> +		tcm->deinit(tcm);
> +}
> +
> +/**
> + * Reserves a 2D area in the container.
> + *
> + * @param tcm		Pointer to container manager.
> + * @param height	Height(in pages) of area to be reserved.
> + * @param width		Width(in pages) of area to be reserved.
> + * @param align		Alignment requirement for top-left corner of area.
> Not
> + *			all values may be supported by the container manager,
> + *			but it must support 0 (1), 32 and 64.
> + *			0 value is equivalent to 1.
> + * @param area		Pointer to where the reserved area should be
> stored.
> + *
> + * @return 0 on success.  Non-0 error code on failure.  Also,
> + *	   the tcm field of the area will be set to NULL on
> + *	   failure.  Some error codes: -ENODEV: invalid manager,
> + *	   -EINVAL: invalid area, -ENOMEM: not enough space for
> + *	    allocation.
> + */
> +static inline s32 tcm_reserve_2d(struct tcm *tcm, u16 width, u16 height,
> +				 u16 align, struct tcm_area *area)
> +{
> +	/* perform rudimentary error checking */
> +	s32 res = (tcm  == NULL ? -ENODEV :
> +		(area == NULL || width == 0 || height == 0 ||
> +		 /* align must be a 2 power */
> +		 align & (align - 1)) ? -EINVAL :
> +		(height > tcm->height || width > tcm->width) ? -ENOMEM :
> +		tcm->reserve_2d(tcm, height, width, align, area));
> +
> +	if (area)
> +		area->tcm = res ? NULL : tcm;
> +
> +	return res;
> +}
> +
> +/**
> + * Free a previously reserved area from the container.
> + *
> + * @param area	Pointer to area reserved by a prior call to
> tcm_reserve_2d call,
> + *		whether it was successful or not. (Note: all fields of
> + *		the structure must match.)
> + *
> + * @return 0 on success.  Non-0 error code on failure.  Also, the tcm
> + *	   field of the area is set to NULL on success to avoid subsequent
> + *	   freeing.  This call will succeed even if supplying
> + *	   the area from a failed reserved call.
> + */
> +static inline s32 tcm_free(struct tcm_area *area)
> +{
> +	s32 res = 0; /* free succeeds by default */
> +
> +	if (area && area->tcm) {
> +		res = area->tcm->free(area->tcm, area);
> +		if (res == 0)
> +			area->tcm = NULL;
> +	}
> +
> +	return res;
> +}
> +
> +/*=======================================================================
> ======
> +    HELPER FUNCTION FOR ANY TILER CONTAINER MANAGER
> +=========================================================================
> ====*/
> +
> +/* Verify if a tcm area is logically valid */
> +static inline bool tcm_area_is_valid(struct tcm_area *area)
> +{
> +	return area && area->tcm &&
> +		/* coordinate bounds */
> +		area->p1.x < area->tcm->width &&
> +		area->p1.y < area->tcm->height &&
> +		area->p0.y <= area->p1.y &&
> +		area->p0.x <= area->p1.x;
> +}
> +
> +/* see if a coordinate is within an area */
> +static inline bool __tcm_is_in(struct tcm_pt *p, struct tcm_area *a)
> +{
> +	return p->x >= a->p0.x && p->x <= a->p1.x &&
> +		p->y >= a->p0.y && p->y <= a->p1.y;
> +}
> +
> +/* calculate area width */
> +static inline u16 __tcm_area_width(struct tcm_area *area)
> +{
> +	return area->p1.x - area->p0.x + 1;
> +}
> +
> +/* calculate area height */
> +static inline u16 __tcm_area_height(struct tcm_area *area)
> +{
> +	return area->p1.y - area->p0.y + 1;
> +}
> +
> +/* calculate number of slots in an area */
> +static inline u16 __tcm_sizeof(struct tcm_area *area)
> +{
> +	return __tcm_area_width(area) * __tcm_area_height(area);
> +}
> +#define tcm_sizeof(area) __tcm_sizeof(&(area))
> +#define tcm_awidth(area) __tcm_area_width(&(area))
> +#define tcm_aheight(area) __tcm_area_height(&(area))
> +#define tcm_is_in(pt, area) __tcm_is_in(&(pt), &(area))
> +
> +#endif
> diff --git a/drivers/media/video/tiler/tcm/tcm-utils.h
> b/drivers/media/video/tiler/tcm/tcm-utils.h
> new file mode 100644
> index 0000000..0d1260a
> --- /dev/null
> +++ b/drivers/media/video/tiler/tcm/tcm-utils.h
> @@ -0,0 +1,54 @@
> +/*
> + * tcm_utils.h
> + *
> + * Utility functions for implementing TILER container managers.
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
> +
> +#ifndef TCM_UTILS_H
> +#define TCM_UTILS_H
> +
> +#include "../tcm.h"
Should avoid this type
> +
> +/* TCM_ALG_NAME must be defined to use the debug methods */
> +
> +#ifdef DEBUG
> +#define IFDEBUG(x) x
> +#else
> +/* compile-check debug statements even if not DEBUG */
> +#define IFDEBUG(x) do { if (0) x; } while (0)
> +#endif
> +
> +#define P(level, fmt, ...) \
> +	IFDEBUG(printk(level TCM_ALG_NAME ":%d:%s()" fmt "\n", \
> +			__LINE__, __func__, ##__VA_ARGS__))
> +
> +#define P1(fmt, ...) P(KERN_NOTICE, fmt, ##__VA_ARGS__)
> +#define P2(fmt, ...) P(KERN_INFO, fmt, ##__VA_ARGS__)
> +#define P3(fmt, ...) P(KERN_DEBUG, fmt, ##__VA_ARGS__)
Macro names can be bit more informative than p1 , P2 , P etc
> +
> +#define PA(level, msg, p_area) P##level(msg " (%03d %03d)-(%03d %03d)\n",
> \
> +	(p_area)->p0.x, (p_area)->p0.y, (p_area)->p1.x, (p_area)->p1.y)
> +
> +/* assign coordinates to area */
> +static inline
> +void assign(struct tcm_area *a, u16 x0, u16 y0, u16 x1, u16 y1)
> +{
> +	a->p0.x = x0;
> +	a->p0.y = y0;
> +	a->p1.x = x1;
> +	a->p1.y = y1;
> +}
> +
> +#endif
> --
> 1.6.3.3

