From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: Configuring a TWL GPIO pin as an interrupt
Date: Mon, 23 Feb 2009 00:07:25 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705D61AF093@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com>
 <20090221023924.GD6224@gandalf>,<200902202112.23307.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39559 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbZBWGHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 01:07:45 -0500
In-Reply-To: <200902202112.23307.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>, Mark Brown <broonie@sirena.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > I'm interested in bringing headset detection feature for audio. The
> > detection is done through TWL GPIO_2. How can I configure a GPIO pin
> > to generate an interrupt? Is there any API? Could you please point
> > out another driver using that functionality so I can use as reference?

>In the setup() callback for the TWL4030 GPIOs:
> {
>  int GPIO_NUMBER = gpio_base + 2;
> gpio_request(GPIO_NUMBER, "Headset IRQ");
> gpio_direction_input(GPIO_NUMBER);
>  lm8323_board_info.irq = gpio_to_irq(GPIO_NUMBER);
>  ... something registers this board_info ...
>  return 0;
> }
>
> and then later the lm8323 driver will use that IRQ:
>
> request_irq(client->irq, lm8323_irq, flags | IRQF_SHARED, DRIVER_NAME, dev);
>
> that should do it :-)
>
> see that GPIO_NUMBER will be gpio_base + 2, base is board-specific
>
> .... and hence client->irq is also board-specific,
> which is why it needs to be set up

In the particular case of ALSA SoC, could the machine/board driver be a better place to handle all GPIO/IRQ configuration? That driver also contains only board specific code.