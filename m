From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC 1/3] clk: omap: introduce clock driver
Date: Tue, 4 Jun 2013 07:52:52 -0700
Message-ID: <20130604145252.GJ3331@atomide.com>
References: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
 <1370327958-19776-2-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37604 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab3FDOw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jun 2013 10:52:57 -0400
Content-Disposition: inline
In-Reply-To: <1370327958-19776-2-git-send-email-mturquette@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Tero Kristo <t-kristo@ti.com>, Rajendra <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Joel A Fernandes <joelagnel@ti.com>, Paul Walmsley <paul@pwsan.com>

* Mike Turquette <mturquette@linaro.org> [130603 23:45]:
> Parses OMAP clock data from DT and registers those clocks with the clock
> framework.  dt_omap_clk_init must be called early during boot for timer
> initialization so it is exported and called from the existing clock code
> instead of probing like a real driver.

Thanks for doing this, makes sense to me. I have queued up patches to
make omap4 DT only, so this is the way to go.

> --- /dev/null
> +++ b/include/linux/clk/omap.h
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (C) 2010 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __LINUX_CLK_OMAP_H_
> +#define __LINUX_CLK_OMAP_H_
> +
> +int __init dt_omap_clk_init(void);
> +
> +#endif

Maybe leave out the Broadcom copyright from this header? :)

Regards,

Tony
