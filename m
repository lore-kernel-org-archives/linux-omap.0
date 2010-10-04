From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 01/10] OMAP2+: Kconfig: disallow builds for boards that
 don't use the currently-selected SoC
Date: Sun, 3 Oct 2010 23:45:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010032343250.13816@utopia.booyaka.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain> <20101001213445.1408.96821.stgit@twilight.localdomain> <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE2FA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52271 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab0JDFp3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 01:45:29 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE2FA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>

On Mon, 4 Oct 2010, Varadarajan, Charulatha wrote:

>  
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Saturday, October 02, 2010 3:05 AM
> > To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Cc: Tony Lindgren
> > Subject: [PATCH 01/10] OMAP2+: Kconfig: disallow builds for 
> > boards that don't use the currently-selected SoC

...

> > +++ b/arch/arm/mach-omap2/board-generic.c
> > @@ -48,10 +48,22 @@ static void __init omap_generic_init(void)
> >  
> >  static void __init omap_generic_map_io(void)
> >  {
> > -	omap2_set_globals_242x(); /* should be 242x, 243x, or 343x */
> > -	omap242x_map_common_io();
> > +	if (cpu_is_omap242x()) {
> > +		omap2_set_globals_242x();
> > +		omap242x_map_common_io();
> > +	} else if (cpu_is_omap242x()) {
> 
> Is this intended for 242x() or 243x()?
> 
> > +		omap2_set_globals_243x();
> > +		omap243x_map_common_io();

That's for 243x().  Thanks, updated that in the branch that's posted on 
git.pwsan.com.


- Paul
