From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC 2/3] ARM: dts: omap4 clock data
Date: Tue, 4 Jun 2013 07:55:43 -0700
Message-ID: <20130604145543.GK3331@atomide.com>
References: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
 <1370327958-19776-3-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14343 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754008Ab3FDOzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jun 2013 10:55:48 -0400
Content-Disposition: inline
In-Reply-To: <1370327958-19776-3-git-send-email-mturquette@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Tero Kristo <t-kristo@ti.com>, Rajendra <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Joel A Fernandes <joelagnel@ti.com>, Paul Walmsley <paul@pwsan.com>

* Mike Turquette <mturquette@linaro.org> [130603 23:45]:
> This is a first pass at creating a unique node for each clock in the
> OMAP4 power, reset and & clock manager (PRCM).  So far I have only
> converted mux clocks & fixed-rate clocks, which coexist with the current
> clock data in the kernel.  The rest needs to be done but better to
> publish early and often to see what others think of this approach.

> +/* FIXME need to print the address directly */
> +/*
> +#include "../../mach-omap2/prm44xx.h"
> +#include "../../mach-omap2/cm2_44xx.h"
> +#include "../../mach-omap2/cm1_44xx.h"
> +*/

I don't think you're using the above includes any longer
in this file?

Regards,

Tony
