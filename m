From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 11/12] OMAP: Panda & Beagle: DVI: Add i2c_bus_num
Date: Wed, 31 Aug 2011 21:09:38 +0300
Message-ID: <1314814178.2098.29.camel@deskari>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
	 <1314797003-17638-12-git-send-email-tomi.valkeinen@ti.com>
	 <4E5E4C9B.2010504@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:41188 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756967Ab1HaSJn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 14:09:43 -0400
In-Reply-To: <4E5E4C9B.2010504@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Doan <andy.doan@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com, mythripk@ti.com

On Wed, 2011-08-31 at 10:00 -0500, Andy Doan wrote:
> On 08/31/2011 08:23 AM, Tomi Valkeinen wrote:
> > Add i2c bus number for DVI output. The driver uses this to detect if a
> > panel is connected and to read EDID.
> >
> > Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> > ---
> >   arch/arm/mach-omap2/board-omap3beagle.c |    1 +
> >   arch/arm/mach-omap2/board-omap4panda.c  |    1 +
> >   2 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> > index 3ae16b4..13244e9 100644
> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> > @@ -207,6 +207,7 @@ static struct panel_generic_dpi_data dvi_panel = {
> >   	.name = "generic",
> >   	.platform_enable = beagle_enable_dvi,
> >   	.platform_disable = beagle_disable_dvi,
> > +	.i2c_bus_num = 3,
> >   };
> >
> >   static struct omap_dss_device beagle_dvi_device = {
> > diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> > index 9aaa960..d5760e3 100644
> > --- a/arch/arm/mach-omap2/board-omap4panda.c
> > +++ b/arch/arm/mach-omap2/board-omap4panda.c
> > @@ -459,6 +459,7 @@ static struct panel_generic_dpi_data omap4_dvi_panel = {
> >   	.name			= "generic",
> >   	.platform_enable	= omap4_panda_enable_dvi,
> >   	.platform_disable	= omap4_panda_disable_dvi,
> > +	.i2c_bus_num = 3,
> >   };
> >
> >   struct omap_dss_device omap4_panda_dvi_device = {
> 
> Can you add a similar patch for board-overo.c? I've tested earlier 
> versions of this patch series on a Tide+Tobi successfully. Here's a copy 
> of my patch:
> 
>    http://tinyurl.com/3cek5m7

Sure. I only added the boards I know have the ddc i2c on bus 3 (i.e.
those I was able to test).

 Tomi


