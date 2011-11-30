From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 04/15] omap4: add pmic startup / shutdown times
Date: Wed, 30 Nov 2011 15:08:10 +0200
Message-ID: <1322658490.21753.28.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <1322236188-19456-5-git-send-email-t-kristo@ti.com>
	 <CAOMWX4dfTTd6DHX=RhtymyvMEdfoWWQbATqYqbf2svNYHsQGhw@mail.gmail.com>
	 <1322646341.21753.1.camel@sokoban>
	 <CAOMWX4cbVfytPbaZp_F1mVH=Qn4gtcFJ0EKBthhhaP94Xa3R8g@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42444 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab1K3NIN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 08:08:13 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAUD8D5m027131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 07:08:13 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAUD8C7H020116
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 07:08:12 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAUD8CMS022438
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 07:08:12 -0600 (CST)
In-Reply-To: <CAOMWX4cbVfytPbaZp_F1mVH=Qn4gtcFJ0EKBthhhaP94Xa3R8g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com

On Wed, 2011-11-30 at 06:20 -0600, Menon, Nishanth wrote:
> On Wed, Nov 30, 2011 at 03:45, Tero Kristo <t-kristo@ti.com> wrote:
> >
> > On Tue, 2011-11-29 at 12:30 -0600, Menon, Nishanth wrote:
> > > On Fri, Nov 25, 2011 at 09:49, Tero Kristo <t-kristo@ti.com> wrote:
> > > > Both startup and shutdown take 500us at maximum, value taken from
> > > > TWL6030 data manual.
> Might be good to add reference version as well for traceability.

Good point.

> 
> > > >
> > > > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > > > ---
> > > >  arch/arm/mach-omap2/omap_twl.c |    2 ++
> > > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> > > > index 62ed050..bd99328 100644
> > > > --- a/arch/arm/mach-omap2/omap_twl.c
> > > > +++ b/arch/arm/mach-omap2/omap_twl.c
> > > > @@ -207,6 +207,8 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
> > > >  static struct omap_voltdm_pmic omap4_core_pmic = {
> > > >        .slew_rate              = 4000,
> > > >        .step_size              = 12660,
> > > > +       .startup_time           = 500,
> > > 549?
> >
> > Where do you get 549? You looking at a different version of the DM? Or
> > are you adding something to the value?
> >
> woohoo.. welcome to TWL6030 doc hell ;)
> Data Sheet: 0.05: T on =500Usec
> *but* TRM 0.1 says T on = 500uSec for SMPS  not freq locked, and upto
> 3ms with SMPS frequency locked).
> *then* Functional spec rev 0.12 says "Enable VCORE[1,2,3] = 549uSec.

Oh yea, thats great. Well, lets see what the design team says what we
should actually use. :)

-Tero


