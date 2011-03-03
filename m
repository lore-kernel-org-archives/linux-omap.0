From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 02/17] omap4: pm: Add SAR RAM support
Date: Thu, 3 Mar 2011 21:38:12 +0530
Message-ID: <2a3493e9e5af3821f8b43c4c136c04db@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-3-git-send-email-santosh.shilimkar@ti.com>
 <87vd016vaa.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59207 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758196Ab1CCQIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 11:08:14 -0500
Received: by mail-qw0-f47.google.com with SMTP id 2so1067049qwi.34
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 08:08:13 -0800 (PST)
In-reply-to: <87vd016vaa.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 3:27 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 02/17] omap4: pm: Add SAR RAM support
>
[..]

> > +
> > +	/* Static mapping, never released */
> > +	sar_ram_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_8K);
> > +	BUG_ON(!sar_ram_base);
>
> Again, a BUG is not approprate here.
>
> Instead, other code needs to properly handle when sar_ram_base ==
> NULL
>
Fixed.

> > +	return 0;
> > +}
> > +early_initcall(omap4_sar_ram_init);
> > diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h
> b/arch/arm/mach-omap2/omap4-sar-layout.h
> > new file mode 100644
> > index 0000000..bb66816
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/omap4-sar-layout.h
> > @@ -0,0 +1,24 @@

[....]
> > +
> > +extern void __iomem *sar_ram_base;
>
> This patch creates this as global, but has no global users.
>
> Also, personally, I don't like these 'base address as global
> pointer'
> that are appearing throughout the OMAP4 code.  This one is
> continuing
> the pattern of some others (gic_dist_base_addr, gic_cpu_base) etc.,
> but
> I'm not crazy about them.  BTW, the gic* ones also suffer from the
> BUG
> problem and do not properly handle error conditions.
>
> It would be much cleaner to keep this base address static (and
> local)
> and just create some sar_read/write helpers that can be used from
> other code.
>
I have fixed all of these in one patch and added helper functions
to get the address. Also removed BUG_ON() from gic_*() functions
as well.

> Hmm, I see the assembly code uses this base address to.  For that, a
> helper function to get the base address could be created.
>

Regards,
Santosh
