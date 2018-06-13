From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH 09/10] Input: ams_delta_serio: use IRQ resource
Date: Wed, 13 Jun 2018 03:10:31 +0200
Message-ID: <1688832.aCTLqTvW5e@z50>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com> <20180609140224.32606-9-jmkrzyszt@gmail.com> <20180612222104.GC38773@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612222104.GC38773@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, "David S . Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday, June 13, 2018 12:21:04 AM CEST Dmitry Torokhov wrote:
> On Sat, Jun 09, 2018 at 04:02:23PM +0200, Janusz Krzysztofik wrote:
> > ...
> > @@ -141,14 +141,11 @@ static int ams_delta_serio_init(struct
> > platform_device *pdev)> 
> >  	 * at FIQ level, switch back from edge to simple interrupt handler
> >  	 * to avoid bad interaction.
> >  	 */
> > 
> > -	irq_set_handler(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
> > -			handle_simple_irq);
> > +	irq_set_handler(irq, handle_simple_irq);
> 
> Do we still need to do this here, or it can be moved into board file?

You're right, it should be possible to move it. I'll check possible options 
and submit a follow up patch.

Thanks,
Janusz
