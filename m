From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/22] ARM: omap1: move perseus spi pinconf to board file
Date: Fri, 9 Aug 2019 13:29:13 +0200
Message-ID: <CAK8P3a0qTvDFMj4GrKfD=2mkPpKN=eRJ--mp0r7mqAH+b2r=kg@mail.gmail.com>
References: <20190808212234.2213262-1-arnd@arndb.de> <20190808212234.2213262-8-arnd@arndb.de>
 <20190808222408.GS3795@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808222408.GS3795@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Boris Brezillon <bbrezillon@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 9, 2019 at 12:24 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 08, 2019 at 11:22:16PM +0200, Arnd Bergmann wrote:
> > The driver has always had a FIXME about this, and it seems
> > like this trivial code move avoids a mach header inclusion,
> > so just do it.
>
> This appears to be part of a series but I've no cover letter or anything
> else from it.  What's the story for dependencies and merging?

Sorry for missing you on the cover letter. The patch is part of a series
to make omap1 part of ARCH_MULTIPLATFORM. I'd like to merge the entire
series through the arm-soc tree to avoid dependencies:

https://lore.kernel.org/linux-arm-kernel/20190808212234.2213262-1-arnd@arndb.de/T

      Arnd
