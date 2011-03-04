From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 08/17] omap4: pm: Add GIC save/restore support
Date: Fri, 4 Mar 2011 14:09:18 +0530
Message-ID: <20b497dc6e31dd5eb91b2a11002966c2@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-9-git-send-email-santosh.shilimkar@ti.com>
 <8739n55f75.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54620 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754878Ab1CDIjU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 03:39:20 -0500
Received: by mail-qy0-f171.google.com with SMTP id 19so579201qyj.9
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 00:39:19 -0800 (PST)
In-reply-to: <8739n55f75.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 4:00 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 08/17] omap4: pm: Add GIC save/restore support
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>

[...]

> > +	/*
> > +	 * Find out how many interrupts are supported.
> > +	 * OMAP4 supports max of 128 SPIs where as GIC can support
> > +	 * up to 1020 interrupt sources.
> > +	 */
> > +	max_spi_reg = __raw_readl(gic_dist_base_addr + GIC_DIST_CTR) &
> 0x1f;
> > +	max_spi_irq = max_spi_reg * 32;
>
> Based on the spec, this should also be max'd at 1020 so you never
> write the reserved values after 1020.
>

That's correct as per generic GIC specs. On OMAP4, the maximum IRQs
already fused in "DIST_CTR"  bit-fields and fixed. Hence we don't
need that additional comparison.

Regards
Santosh
