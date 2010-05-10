From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/4 v2] ARM: add framebuffer support for ap4evb
Date: Mon, 10 May 2010 08:12:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005100807120.15250@axis700.grange>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
 <Pine.LNX.4.64.1005071105140.4777@axis700.grange>
 <Pine.LNX.4.64.1005071641440.4777@axis700.grange> <uvdawbopi.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <uvdawbopi.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

Hello Morimoto-san

On Mon, 10 May 2010, Kuninori Morimoto wrote:

> > diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> > index 9003ea9..e216132 100644
> > --- a/arch/arm/mach-shmobile/Kconfig
> > +++ b/arch/arm/mach-shmobile/Kconfig
> > @@ -42,6 +42,7 @@ config MACH_AP4EVB
> >  	bool "AP4EVB board"
> >  	depends on ARCH_SH7372
> >  	select ARCH_REQUIRE_GPIOLIB
> > +	select SH_LCD_MIPI_DSI
> 
> Why is this "select" needed here ?
> Do you want "force select MIPI DSI" on AP4 ?

Not on all AP4 systems, only on ap4evb board, because I thought, that's 
the display, that it is using.

> I asked because AP4 board can select other type LCD.
> (not only MIPI DSI)

ap4evb can also have other LCDs attached to it? Then this will have to 
become a "choice" between various display types, where the MIPI DSI one 
will select SH_LCD_MIPI_DSI. We can either do this now or later when more 
LCD types are added.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
