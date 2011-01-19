From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build
 break because of clktrctrl_mask
Date: Wed, 19 Jan 2011 19:50:51 +0530
Message-ID: <d199cd6e7e9191bc611f1987fd32fdea@mail.gmail.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com><87fwt7z1p3.fsf@ti.com><alpine.DEB.2.00.1101061059590.22048@utopia.booyaka.com><87ipy1vqdi.fsf@ti.com><3f76fc53e9b50d75480bcfe1d2b6312e@mail.gmail.com>
 <874o9ko25j.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:55655 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754155Ab1ASOUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 09:20:53 -0500
Received: by mail-ey0-f176.google.com with SMTP id 10so387145eyz.35
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 06:20:52 -0800 (PST)
In-Reply-To: <874o9ko25j.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Hi Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Saturday, January 08, 2011 2:35 AM
> To: Rajendra Nayak
> Cc: Paul Walmsley; Santosh Shilimkar; linux-omap@vger.kernel.org;
tony@atomide.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for
build break because of clktrctrl_mask
>
> Rajendra Nayak <rnayak@ti.com> writes:
>
> [...]
>
> > Just another trivial fix.
> >
> > From bb46b74d2b0ab3d35e72b760da7e123a891e6813 Mon Sep 17 00:00:00 2001
> > From: Rajendra Nayak <rnayak@ti.com>
> > Date: Fri, 7 Jan 2011 14:07:25 +0530
> > Subject: [PATCH] OMAP: powerdomain: remove unused func declaration
> >
> > Trivial fix to remove the unused function declaration
> > from the powerdomain header.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > ---
> >  arch/arm/mach-omap2/powerdomain.h |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/powerdomain.h
> > b/arch/arm/mach-omap2/powerdomain.h
> > index c66431e..0b7a357 100644
> > --- a/arch/arm/mach-omap2/powerdomain.h
> > +++ b/arch/arm/mach-omap2/powerdomain.h
> > @@ -165,7 +165,6 @@ struct pwrdm_ops {
> >  	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
> >  };
> >
> > -void pwrdm_fw_init(void);
> >  void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_ops
> > *custom_funcs);
>
> Note this is line-wrapped.
>
> Looks like you need to get get-send-email setup so you can avoid having
> the patch sending problems.

Sorry, I seemed to have completely missed this one.
Will repost.

Thanks,
Rajendra

>
> >
> >  struct powerdomain *pwrdm_lookup(const char *name);
>
> In any case, with Paul's ack, I can queue this with the others.
>
> Kevin
