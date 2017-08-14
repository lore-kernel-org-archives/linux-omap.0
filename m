From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] mfd: tps65010: move header file out of I2C realm
Date: Mon, 14 Aug 2017 09:44:12 +0100
Message-ID: <20170814084412.dfbsqfwrgmy5bsu3@dell>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-3-wsa@the-dreams.de>
 <20170523071819.4zpdef7ofzz3moil@dell>
 <20170813133445.vqbfelwshvrififp@ninjato>
 <20170814064355.foiilzr5cmwk65hr@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170814064355.foiilzr5cmwk65hr@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 14 Aug 2017, Lee Jones wrote:

> On Sun, 13 Aug 2017, Wolfram Sang wrote:
> 
> > On Tue, May 23, 2017 at 08:18:19AM +0100, Lee Jones wrote:
> > > On Mon, 22 May 2017, Wolfram Sang wrote:
> > > 
> > > > include/linux/i2c is not for client devices. Move the header file to a
> > > > more appropriate location.
> > > > 
> > > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > > ---
> > > >  arch/arm/mach-omap1/board-h2-mmc.c      | 2 +-
> > > >  arch/arm/mach-omap1/board-h2.c          | 2 +-
> > > >  arch/arm/mach-omap1/board-h3-mmc.c      | 2 +-
> > > >  arch/arm/mach-omap1/board-h3.c          | 2 +-
> > > >  arch/arm/mach-omap1/board-osk.c         | 2 +-
> > > >  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
> > > >  arch/arm/mach-s3c24xx/mach-osiris.c     | 2 +-
> > > 
> > > >  drivers/mfd/tps65010.c                  | 2 +-
> > > 
> > > For my own reference:
> > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Same here: ok for 4.14 or something needed?
> 
> Can this patch be applied on its own, or does it have dependencies?

Even if it doesn't, it still requires Acks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
