From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
Date: Tue, 27 Mar 2012 20:39:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203272039010.22961@utopia.booyaka.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com> <4F721A91.7000102@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52868 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab2C1Cjg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Mar 2012 22:39:36 -0400
In-Reply-To: <4F721A91.7000102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Jon,

On Tue, 27 Mar 2012, Jon Hunter wrote:

> On 3/27/2012 4:58, Rajendra Nayak wrote:
>
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c
> > b/arch/arm/mach-omap2/omap_hwmod.c
> > index 8ac26f2..f2a9afa 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > @@ -808,7 +808,7 @@ static void _enable_module(struct omap_hwmod *oh)
> >    */
> >   static int _omap4_wait_target_disable(struct omap_hwmod *oh)
> >   {
> > -	if (!cpu_is_omap44xx())
> > +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> >   		return 0;
> 
> What about omap36xx?

Unfortunately, cpu_is_omap34xx() also covers OMAP36xx :-(

- Paul
