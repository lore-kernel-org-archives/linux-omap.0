From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/6] HSI: omap_ssi: built omap_ssi and omap_ssi_port into
 one module
Date: Sun, 1 May 2016 11:43:49 +0200
Message-ID: <20160501094349.GE14243@amd>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
 <1461982153-19139-6-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461982153-19139-6-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> Merge omap_ssi and omap_ssi_port into one module. This
> fixes problems with module cycle dependencies introduced
> by future patches.

Interesting way of saying that this prepares us for future patch
:-).


> +++ b/drivers/hsi/controllers/Makefile
> @@ -2,5 +2,5 @@
>  # Makefile for HSI controllers drivers
>  #
>  
> -obj-$(CONFIG_OMAP_SSI)		+= omap_ssi.o
> -obj-$(CONFIG_OMAP_SSI_PORT)	+= omap_ssi_port.o
> +omap_ssi-objs		+= omap_ssi_core.o omap_ssi_port.o
> +obj-$(CONFIG_OMAP_SSI)	+= omap_ssi.o

Can you simply do

obj-$(CONFIG_OMAP_SSI)       +=  omap_ssi_core.o omap_ssi_port.o

instead?

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
