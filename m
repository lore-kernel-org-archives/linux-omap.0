From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 01/11] OMAP4: PRCM: add OMAP4-specific
 accessor/mutatorfunctions
Date: Wed, 8 Dec 2010 13:16:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012081315160.13430@utopia.booyaka.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <20101208061829.30541.99531.stgit@twilight.localdomain> <3407936b2b482d0f7f6b5bb273455377@mail.gmail.com> <alpine.DEB.2.00.1012081243270.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52132 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab0LHUQO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 15:16:14 -0500
In-Reply-To: <alpine.DEB.2.00.1012081243270.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Wed, 8 Dec 2010, Paul Walmsley wrote:

> On Wed, 8 Dec 2010, Rajendra Nayak wrote:
> 
> > > +#include "cminst44xx.h"
> > 
> > This header seems to be missed in the series.
> 
> Oops, sorry about that.  Fixed in the git branch on git.pwsan.com.
> 
> Attached below is the final mach-omap2/cminst44xx.h file.

Well, anyway, here it is.

- Paul

/*
 * OMAP4 Power/Reset Management (CM) function prototypes
 *
 * Copyright (C) 2010 Nokia Corporation
 * Paul Walmsley
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
#ifndef __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
#define __ARCH_ASM_MACH_OMAP2_CMINST44XX_H

extern bool omap4_cminst_is_clkdm_in_hwsup(u8 part, s16 inst, u16 cdoffs);
extern void omap4_cminst_clkdm_enable_hwsup(u8 part, s16 inst, u16 cdoffs);
extern void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs);
extern void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs);
extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);

/*
 * In an ideal world, we would not export these low-level functions,
 * but this will probably take some time to fix properly
 */
extern u32 omap4_cminst_read_inst_reg(u8 part, s16 inst, u16 idx);
extern void omap4_cminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx);
extern u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
					   s16 inst, s16 idx);

extern int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg);

#endif
