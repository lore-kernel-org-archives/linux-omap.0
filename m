From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 03/14] arm: omap3+: voltage: parameter segregation
Date: Thu, 23 Feb 2012 11:08:53 +0200
Message-ID: <1329988133.4102.500.camel@sokoban>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
	 <1329833098-19900-4-git-send-email-t-kristo@ti.com>
	 <CAOMWX4d+M9oagDtmSqG=X8Ln4kUEyLaqpfB9Pz0Y+6RmK=sjYw@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55138 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2BWJI7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 04:08:59 -0500
In-Reply-To: <CAOMWX4d+M9oagDtmSqG=X8Ln4kUEyLaqpfB9Pz0Y+6RmK=sjYw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Wed, 2012-02-22 at 19:37 -0600, Menon, Nishanth wrote:
> On Tue, Feb 21, 2012 at 08:04, Tero Kristo <t-kristo@ti.com> wrote:
> [...]
> > diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> > index 949938d..940a0d6 100644
> > --- a/arch/arm/mach-omap2/voltage.h
> > +++ b/arch/arm/mach-omap2/voltage.h
> 
> [...]
> > @@ -171,6 +169,18 @@ struct omap_voltdm_pmic {
> >        u8 (*uv_to_vsel) (unsigned long uV);
> >  };
> >
> > +struct omap_vp_param {
> > +       u32 vddmax;
> > +       u32 vddmin;
> > +};
> > +
> 
> Thinking a little deeper about this(SoC level vdd min and max) on a
> slightly different angle- core of the question that intend to answer
> are:
>  - what is the least voltage we want to allow in active transtion? it
> should not be lower than retention voltage.

I think this is a fair assumption, so we could init the vddmin to be the
same as the retention voltage for the domain (or even drop the
parameter.)

> - what is the max voltage we want to allow in active transition? it
> should be the max Nom voltage of all the OPPs for that domain.

Isn't it higher? I guess smartreflex can scale voltages even up from the
nominal level if we have a really old and/or bad silicon. Limiting this
to max opp would be bad, no? Maybe we could use max opp voltage + some
margin though... but what would be a safe margin here?

> 
> In effect, why do we even need to register
> "voltdm->vp_param->vdd[min|max]"? We already have that info - right?
> On the other hand it might be safer to do this way to handle quirks in
> future SoCs.. but thought I'd spit it out anyways..
> 
> > +struct omap_vc_param {
> and elsewhere - please add kernel-doc struct documentation as well
> when new structs are introduced?

Yea, I can add those for next version.

> > +       u32 on;
> > +       u32 onlp;
> > +       u32 ret;
> > +       u32 off;
> > +};
> > +
> [...]
> 
> Regards,
> Nishanth Menon


