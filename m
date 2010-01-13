From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2] OMAP3: hwmod: support to specify the offset position
 of various SYSCONFIG register bits.
Date: Wed, 13 Jan 2010 11:44:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001131139170.20437@utopia.booyaka.com>
References: <1263294013-9140-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40620 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab0AMSoy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 13:44:54 -0500
In-Reply-To: <1263294013-9140-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hello Thara,

two more minor changes to make:

On Tue, 12 Jan 2010, Thara Gopinath wrote:

> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
> @@ -0,0 +1,51 @@
> +/*
> + * omap_hwmod common data structures
> + *
> + * Copyright (C) 2010 Nokia Corporation
> + * Paul Walmsley
> + *

Please remove the above copyright, etc., since you created it, your 
code.

> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Thara Gopinath <thara@ti.com>
> + *
> + * Created in collaboration with (alphabetical order): Benoit Cousson,
> + * Kevin Hilman, Tony Lindgren, Rajendra Nayak, Vikram Pandita, Sakari
> + * Poussa, Anand Sawant, Santosh Shilimkar, Richard Woodruff
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This data/structures are to be used while defining OMAP on-chip module
> + * data and their integration with other OMAP modules and Linux.
> + */
> +
> +#include <linux/list.h>
> +
> +#include <plat/omap_hwmod.h>
> +
> +/**
> + * struct omap_hwmod_sysc_legacy - OMAP3 legacy scheme for old IPs
> + *
> + * To be used by hwmod structure to specify the sysconfig offsets
> + * if the device ip follows the Legacy scheme.
> + */
> +struct omap_hwmod_sysc_fields omap_hwmod_sysc_legacy = {
> +	.midle_shift        = SYSC_LGCY_MIDLEMODE_SHIFT,
> +	.clkact_shift       = SYSC_LGCY_CLOCKACTIVITY_SHIFT,
> +	.sidle_shift        = SYSC_LGCY_SIDLEMODE_SHIFT,
> +	.enwkup_shift       = SYSC_LGCY_ENAWAKEUP_SHIFT,
> +	.srst_shift         = SYSC_LGCY_SOFTRESET_SHIFT,
> +	.autoidle_shift     = SYSC_LGCY_AUTOIDLE_SHIFT,
> +};
> +
> +/**
> + * struct omap_hwmod_sysc_fields - OMAP4 new scheme for Highlander compliant IPs
> + *
> + * To be used by hwmod structure to specify the sysconfig offsets if the
> + * device ip follows the highlander scheme
> + */
> +struct omap_hwmod_sysc_fields omap_hwmod_sysc_highlander = {
> +	.midle_shift        = SYSC_HIGH_MIDLEMODE_SHIFT,
> +	.sidle_shift        = SYSC_HIGH_SIDLEMODE_SHIFT,
> +	.srst_shift         = SYSC_HIGH_SOFTRESET_SHIFT,
> +};

All of these assignment lines have whitespace problems.  The whitespace
between the field names and the equal signs should be implemented with 
tabs, not spaces.

Once these two issues are fixed, I'll queue the patch.

- Paul
