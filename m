From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC][PATCH] board-omap3beagle: Remove duplicate DVI reset gpio
 handling
Date: Wed, 30 Jun 2010 11:44:32 -0500
Message-ID: <A24693684029E5489D1D202277BE89445638FF34@dlee02.ent.ti.com>
References: <1277843560-25630-1-git-send-email-saaguirre@ti.com>
 <1277887269.2474.117.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57607 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530Ab0F3Qoi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 12:44:38 -0400
In-Reply-To: <1277887269.2474.117.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Koen Kooi <koen.kooi@gmail.com>

Hi Tomi,

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Wednesday, June 30, 2010 3:41 AM
> To: Aguirre, Sergio
> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Koen Kooi
> Subject: Re: [RFC][PATCH] board-omap3beagle: Remove duplicate DVI reset
> gpio handling
> 
> On Tue, 2010-06-29 at 22:32 +0200, ext Sergio Aguirre wrote:
> > Following commit missed to remove this:
> >
> >   commit 044d32ffbcb4a1d400088e3575508f46c0a9face
> >   Author: Koen Kooi <koen.kooi@gmail.com>
> >   Date:   Thu Apr 22 10:23:42 2010 +0200
> >
> >       board-omap3-beagle: add DSS2 support
> >
> > Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> > Cc: Koen Kooi <koen.kooi@gmail.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3beagle.c |    7 ++-----
> >  1 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-
> omap2/board-omap3beagle.c
> > index 7b95cc1..867a4ad 100644
> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> > @@ -169,6 +169,8 @@ static void __init beagle_display_init(void)
> >  {
> >  	int r;
> >
> > +	omap_mux_init_gpio(beagle_dvi_device.reset_gpio, OMAP_PIN_INPUT);
> 
> It's a reset gpio (actually power up/down, if I recall right), it should
> be configured as output, shouldn't it?

You're probably right :)

I just shuffled around the same code, which I guessed that works already. (right beagleboard guys?).

Regards,
Sergio

> 
>  Tomi
> 

