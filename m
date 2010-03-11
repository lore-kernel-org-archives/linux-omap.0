From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
 file
Date: Thu, 11 Mar 2010 14:50:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DD32B51@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
 <1268297945.28571.81.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42797 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754520Ab0CKJUr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 04:20:47 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Thursday, March 11, 2010 2:49 PM
> To: 'Tomi Valkeinen'
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
> file
> 
> 
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Thursday, March 11, 2010 2:29 PM
> > To: Hiremath, Vaibhav
> > Cc: linux-omap@vger.kernel.org; tony@atomide.com
> > Subject: Re: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
> > file
> >
> > Hi,
> >
> > On Thu, 2010-03-11 at 09:55 +0100, ext hvaibhav@ti.com wrote:
> > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > >
> > > With recent changes happened in OMAP2/3 DSS library for regulator
> > interface, it
> > > is required to define DSI regulator supply, without this DSS (in turn
> > Fbdev)
> > > fails to get regulator.
> > >
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/board-omap3evm.c |   16 +++++++++++-----
> > >  1 files changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> > omap2/board-omap3evm.c
> > > index 017bb2f..a05de10 100644
> > > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > > @@ -514,9 +514,15 @@ static struct regulator_init_data omap3_evm_vdac =
> {
> > >  };
> > >
> > >  /* VPLL2 for digital video outputs */
> > > -static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
> > > -	.supply		= "vdvi",
> > > -	.dev		= &omap3_evm_lcd_device.dev,
> > > +static struct regulator_consumer_supply omap3_evm_vpll2_supplies[] = {
> > > +	{
> > > +		.supply		= "vdvi",
> > > +		.dev		= &omap3_evm_lcd_device.dev,
> > > +	},
> >
> > Are you sure vdvi is required by the panel? At least the panel in
> > 3430SDP doesn't require it.
> [Hiremath, Vaibhav] As I mentioned before also, we don't need vdvi supply
> for OMAP3EVM. Infact there is no supply like vdvi coming out of TWL4030
> Since it was being used in panel file I had defined it. But now I can see
> that we are no longer using vdvi supply, so I can safely remove this supply.
> Thanks for pointing me to this.
> 
> I have created another patch which will replace the vdvi with vdds_dsi
> regulator supply; I have tested it on OMAP3EVM.
> 
> Please merge this patch, without this OMAP3EVM DSS/Fbdev will fail in
> regulator_get.
> 
> Thanks,
> Vaibhav
> 
[Hiremath, Vaibhav] Tomi,

Also, there are few patches which still are not merged to main-line, like

commit 98d31bf6566be9e716f6dfdce8eb39d1c1097b7c
Author: Vaibhav Hiremath <hvaibhav@ti.com>
Date:   Wed Jan 13 17:17:10 2010 +0530

    OMAP: AM3517: Enable DSS2 for AM3517EVM board

    Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
    [tomi.valkeinen@nokia.com: removed the board file changes]
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

commit bb8a88ac57564e2e7ccc813be1d74c45bb467549
Author: Vaibhav Hiremath <hvaibhav@ti.com>
Date:   Mon Jan 4 15:34:16 2010 +0100

    OMAP: Enable DSS2 for OMAP3EVM board

    Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
    [tomi.valkeinen@nokia.com: removed the board file changes]
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>


Any specific reason why are holding this back?

Thanks,
Vaibhav

> 
> >
> >  Tomi
> >

