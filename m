From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH 01/10] ARM: OMAP1: ams-delta: drop GPIO lookup table for serio device
Date: Wed, 13 Jun 2018 03:16:20 +0200
Message-ID: <69494657.T0PeNZxiFJ@z50>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com> <20180612222356.GD38773@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612222356.GD38773@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, "David S . Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, June 13, 2018 12:23:56 AM CEST Dmitry Torokhov wrote:
> Hi Janusz,
> 
> On Sat, Jun 09, 2018 at 04:02:15PM +0200, Janusz Krzysztofik wrote:
> > GPIO lookup table for ams-delta-serio device was introduced by commit
> > 0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables").
> > Unfortunately, a follow up patch "Input: ams_delta_serio: use GPIO
> > lookup table" was not accepted by subystem maintainer who requested
> > conversion of the driver to a platform driver, replacepemnt of IRQ GPIO
> > pin with IRQ resource, replacement of GPIO pin providing keyboard power
> > with a regulator and removal of remaining GPIO pins from the driver as
> > not handled by it.
> > 
> > Let's start with removal of no the longer needed GPIO lookup table from
> > the board init file.
> > 
> > Series created and tested on top of next-20180608 tag from linux-next
> > tree.
> 
> This all is really nice (modulo a couple of questions), thank you for
> implementing this. How do you want to merge this? Through OMAP tree or
> input?

Hi Dmitry,

If Tony doesn't mind, I would prefer it merged through OMAP tree as I still 
have a few board patches built on top of it in my queue.

Thanks,
Janusz
