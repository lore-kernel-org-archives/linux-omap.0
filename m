From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] omap3: clocks: Fix build error 'CK_3430ES2' undeclared
 here
Date: Mon, 10 Jan 2011 11:58:06 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101101156220.5731@utopia.booyaka.com>
References: <1294611373-1992-1-git-send-email-santosh.shilimkar@ti.com> <4D2B0B86.3010201@ti.com> <32cc9f4ba82187480f1e4d15d4e93dc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43232 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab1AJS6H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 13:58:07 -0500
In-Reply-To: <32cc9f4ba82187480f1e4d15d4e93dc0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Santosh, Tony,

On Mon, 10 Jan 2011, Santosh Shilimkar wrote:

> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Anand Gadiyar
> > Sent: Monday, January 10, 2011 7:07 PM
> > To: Santosh Shilimkar
> > Cc: linux-omap@vger.kernel.org; tony@atomide.com; linux-arm-
> > kernel@lists.infradead.org; Paul Walmsley
> > Subject: Re: [PATCH] omap3: clocks: Fix build error 'CK_3430ES2'
> > undeclared here
> >
> > On 1/10/2011 3:46 AM, Santosh Shilimkar wrote:
> > > At latest mainline commit 0c21e3aaf6a,  omap2plus build is broken.
> > This
> > > patch is trivial fix for the missed usb clock node for
> > CK_3430ES2PLUS
> > > flag update.
> > >
> > >  CHK     include/generated/compile.h
> > >   CC      arch/arm/mach-omap2/clock3xxx_data.o
> > > arch/arm/mach-omap2/clock3xxx_data.c:3289: error: 'CK_3430ES2'
> > undeclared
> > > here (not in a function)
> > > make[1]: *** [arch/arm/mach-omap2/clock3xxx_data.o] Error 1
> > > make: *** [arch/arm/mach-omap2] Error 2
> > >
> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > ---
> > >  arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-
> > omap2/clock3xxx_data.c
> > > index d3ab1c9..c54cc33 100644
> > > --- a/arch/arm/mach-omap2/clock3xxx_data.c
> > > +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> > > @@ -3286,7 +3286,7 @@ static struct omap_clk omap3xxx_clks[] = {
> > >  	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2PLUS
> > | CK_AM35XX | CK_36XX),
> > >  	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2PLUS |
> CK_AM35XX
> > | CK_36XX),
> > >  	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS
> > | CK_AM35XX | CK_36XX),
> > > -	CLK("ehci-omap.0",	"usbtll_fck",	&usbtll_fck,
> > 	CK_3430ES2 | CK_AM35XX),
> > > +	CLK("ehci-omap.0",	"usbtll_fck",	&usbtll_fck,
> > 	CK_3430ES2PLUS | CK_AM35XX),
> >
> > Was about to post something similar.
> >
> > Can you update this line to add CK_36XX as well. Without this, we
> > won't be able to use
> > the USBHOST on 36xx/37xx platforms.
> >
> > With this, feel free to add my
> > Acked-by: Anand Gadiyar <gadiyar@ti.com>
> >
> ok. I can add CK_36XX and repost it with your ack

Looks good to me.  Tony, do you want to merge this one as part of the -rc 
series?  If so then it is:

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
