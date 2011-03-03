From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 10/17] omap4: pm: Add L2 cache lowpower support
Date: Thu, 3 Mar 2011 22:00:00 +0530
Message-ID: <5d01c6484d0d490b88624e841b6f10ae@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-11-git-send-email-santosh.shilimkar@ti.com>
 <878vwx40bh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:58167 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758286Ab1CCQaC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 11:30:02 -0500
Received: by mail-qy0-f182.google.com with SMTP id 27so1099935qyk.20
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 08:30:01 -0800 (PST)
In-reply-to: <878vwx40bh.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 4:06 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 10/17] omap4: pm: Add L2 cache lowpower support
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > When MPUSS hits off-mode e, L2 cache is lost. This patch adds L2X0
> > necessary maintenance operations and context restoration in the
> > low power code.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap4-mpuss-lowpower.c |   11 +++++
> >  arch/arm/mach-omap2/omap4-sar-layout.h     |    2 +
> >  arch/arm/mach-omap2/sleep44xx.S            |   64
> ++++++++++++++++++++++++++++
> >  3 files changed, 77 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> > index a30f19b..bff768f 100644
> > --- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> > +++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> > @@ -49,6 +49,7 @@
> >  #include <asm/system.h>
> >  #include <asm/irq.h>
> >  #include <asm/hardware/gic.h>
> > +#include <asm/hardware/cache-l2x0.h>
> >
> >  #include <plat/omap44xx.h>
> >  #include <mach/omap4-common.h>
> > @@ -341,6 +342,7 @@ int __init omap4_mpuss_init(void)
> >  {
> >  	struct omap4_cpu_pm_info *pm_info;
> >  	u8 i;
> > +	u32 val;
>
> This will cause an 'unused variable' compiler warning when
> !CONFIG_CACHE_L2X0
>
Good catch. Fixed
