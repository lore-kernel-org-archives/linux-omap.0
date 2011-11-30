From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 04/15] omap4: add pmic startup / shutdown times
Date: Wed, 30 Nov 2011 11:45:41 +0200
Message-ID: <1322646341.21753.1.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <1322236188-19456-5-git-send-email-t-kristo@ti.com>
	 <CAOMWX4dfTTd6DHX=RhtymyvMEdfoWWQbATqYqbf2svNYHsQGhw@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54956 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757189Ab1K3Jpo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Nov 2011 04:45:44 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAU9jiTS012583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 03:45:44 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAU9ji3A009492
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 03:45:44 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAU9jigo001531
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 03:45:44 -0600 (CST)
In-Reply-To: <CAOMWX4dfTTd6DHX=RhtymyvMEdfoWWQbATqYqbf2svNYHsQGhw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com

On Tue, 2011-11-29 at 12:30 -0600, Menon, Nishanth wrote:
> On Fri, Nov 25, 2011 at 09:49, Tero Kristo <t-kristo@ti.com> wrote:
> > Both startup and shutdown take 500us at maximum, value taken from
> > TWL6030 data manual.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_twl.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> > index 62ed050..bd99328 100644
> > --- a/arch/arm/mach-omap2/omap_twl.c
> > +++ b/arch/arm/mach-omap2/omap_twl.c
> > @@ -207,6 +207,8 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
> >  static struct omap_voltdm_pmic omap4_core_pmic = {
> >        .slew_rate              = 4000,
> >        .step_size              = 12660,
> > +       .startup_time           = 500,
> 549?

Where do you get 549? You looking at a different version of the DM? Or
are you adding something to the value?

-Tero

> > +       .shutdown_time          = 500,
> >        .vp_erroroffset         = OMAP4_VP_CONFIG_ERROROFFSET,
> >        .vp_vstepmin            = OMAP4_VP_VSTEPMIN_VSTEPMIN,
> >        .vp_vstepmax            = OMAP4_VP_VSTEPMAX_VSTEPMAX,
> > --
> > 1.7.4.1
> >
> 
> 
> Regards,
> Nishanth Menon


