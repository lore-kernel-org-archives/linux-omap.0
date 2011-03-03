From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 08/17] omap4: pm: Add GIC save/restore support
Date: Thu, 3 Mar 2011 21:59:04 +0530
Message-ID: <000b275e5d210abd5dec6c09c5508734@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-9-git-send-email-santosh.shilimkar@ti.com>
 <8739n55f75.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:59016 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758263Ab1CCQ3H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 11:29:07 -0500
Received: by qyk7 with SMTP id 7so1171302qyk.17
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 08:29:06 -0800 (PST)
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
[...]

> > @@ -67,6 +82,17 @@ struct omap4_cpu_pm_info {
> >
> >  static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
> >
> > +/* Helper functions */
> > +static inline void sar_writel(u32 val, u32 offset, u8 idx)
> > +{
> > +	__raw_writel(val, sar_ram_base + offset + 4 * idx);
> > +}
>
> aha, this is what I was thinking of in the earlier SAR patch.
>
> Something like this should be part of the SAR code, not here.
>
If you remember during the internal review, this helpers
are added to improve the readability and they are inline
functions. Same is the case with wakeupgen save code.

If you move this code to SAR file and GIC helper
to gic file, the save routine will become highly
un-optimal.

In General Save is like below.
	Read_Harfware_register()
	Write_it_sar_location()

This happens for every GIC and wakeupgen
registers and hence moving this across files
and calling them from there is going add un-necessary
stack overhead.

I already got rid-off the global address pointers. I will
get those now using omap4_get_*_base() and store it for
local use in the file.


> > +static inline u32 gic_readl(u32 offset, u8 idx)
> > +{
> > +	return __raw_readl(gic_dist_base_addr + offset + 4 * idx);
> > +}
>
> Similarily, it would be nice tos see this as part of GIC code so
> this code doesn't have to access a global base address pointer.
>
Same comment applies here too.

Regards
Santosh
