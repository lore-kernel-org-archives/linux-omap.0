From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 2/2] OMAP3: wdtimer: Fix CORE idle transition
Date: Thu, 10 Mar 2011 12:32:21 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B065FCE@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1299754448-24888-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1299754448-24888-3-git-send-email-kalle.jokiniemi@nokia.com>
 <4D78B488.1060507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:20049 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828Ab1CJMck convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 07:32:40 -0500
In-Reply-To: <4D78B488.1060507@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: paul@pwsan.com, khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

Hi,

> -----Original Message-----
> From: ext Cousson, Benoit [mailto:b-cousson@ti.com]
> Sent: 10. maaliskuuta 2011 13:23
> To: Jokiniemi Kalle (Nokia-MS/Tampere)
> Cc: paul@pwsan.com; Hilman, Kevin; tony@atomide.com; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH 2/2] OMAP3: wdtimer: Fix CORE idle transition
> 
> On 3/10/2011 11:54 AM, Kalle Jokiniemi wrote:
> > From: Paul Walmsley<paul@pwsan.com>
> >
> > The HW superwised smart idle for wdtimer in OMAP3 prevents CORE
> power
> > domain idle transitions. Disable it by swithing to SW supervised
> > transitions.
> 
> We should probably highlight that this looks like a HW bug.
> Smartidle and clockactivity are supposed to be supported by this module on
> OMAP3.
> 
> Some further investigation with TI HW folks are needed to understand that.

I added a comment also to the code in the last version of the 2/2 patch, in case you find something and want to do some improvements.

- Kalle

> 
> Regards,
> Benoit
> 
> >
> > Signed-off-by: Kalle Jokiniemi<kalle.jokiniemi@nokia.com>
> > Signed-off-by: Paul Walmsley<paul@pwsan.com>
> > ---
> >   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
> >   1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> > b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> > index 196a834..a99a4f3 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> > @@ -1293,6 +1293,7 @@ static struct omap_hwmod
> omap3xxx_wd_timer2_hwmod = {
> >   	.slaves		= omap3xxx_wd_timer2_slaves,
> >   	.slaves_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
> >   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> > +	.flags		= HWMOD_SWSUP_SIDLE,
> >   };
> >
> >   /* UART common */

