From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/6] HSI: omap_ssi: built omap_ssi and omap_ssi_port into
 one module
Date: Sun, 1 May 2016 23:22:06 +0200
Message-ID: <20160501212205.GA19739@amd>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
 <1461982153-19139-6-git-send-email-sre@kernel.org>
 <20160501094349.GE14243@amd>
 <20160501193409.GA29870@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160501193409.GA29870@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Sun 2016-05-01 21:34:10, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, May 01, 2016 at 11:43:49AM +0200, Pavel Machek wrote:
> > > +++ b/drivers/hsi/controllers/Makefile
> > > @@ -2,5 +2,5 @@
> > >  # Makefile for HSI controllers drivers
> > >  #
> > >  
> > > -obj-$(CONFIG_OMAP_SSI)		+= omap_ssi.o
> > > -obj-$(CONFIG_OMAP_SSI_PORT)	+= omap_ssi_port.o
> > > +omap_ssi-objs		+= omap_ssi_core.o omap_ssi_port.o
> > > +obj-$(CONFIG_OMAP_SSI)	+= omap_ssi.o
> > 
> > Can you simply do
> > 
> > obj-$(CONFIG_OMAP_SSI)       +=  omap_ssi_core.o omap_ssi_port.o
> 
> No, that would result in omap_ssi_core.ko and omap_ssi_port.ko if
> CONFIG_OMAP_SSI is enabled. Basically it's an optimized variant of
> the current behaviour, but it still builds two modules.

Aha... I was not thinking about modular build.

Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
