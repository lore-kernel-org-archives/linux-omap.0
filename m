From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build
 break because of clktrctrl_mask
Date: Mon, 10 Jan 2011 12:16:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101101214430.5731@utopia.booyaka.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com> <87fwt7z1p3.fsf@ti.com> <alpine.DEB.2.00.1101061059590.22048@utopia.booyaka.com> <87ipy1vqdi.fsf@ti.com> <3f76fc53e9b50d75480bcfe1d2b6312e@mail.gmail.com> <874o9ko25j.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54016 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab1AJTQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 14:16:29 -0500
In-Reply-To: <874o9ko25j.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Hi Kevin

On Fri, 7 Jan 2011, Kevin Hilman wrote:

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
> 
> >
> >  struct powerdomain *pwrdm_lookup(const char *name);
> 
> In any case, with Paul's ack, I can queue this with the others.

Normally I would wait for the .39 merge window with something like this, 
but you're welcome to queue it for the -rc fixes if you feel it's 
appropriate:

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
