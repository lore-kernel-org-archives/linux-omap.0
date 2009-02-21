From: David Brownell <david-b@pacbell.net>
Subject: Re: Configuring a TWL GPIO pin as an interrupt
Date: Fri, 20 Feb 2009 21:12:23 -0800
Message-ID: <200902202112.23307.david-b@pacbell.net>
References: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com> <20090221023924.GD6224@gandalf>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n5b.bullet.sp1.yahoo.com ([69.147.64.186]:35587 "HELO
	n5b.bullet.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751435AbZBUFOG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Feb 2009 00:14:06 -0500
In-Reply-To: <20090221023924.GD6224@gandalf>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: "Lopez Cruz, Misael" <x0052729@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 20 February 2009, Felipe Balbi wrote:
> On Fri, Feb 20, 2009 at 08:27:54PM -0600, Lopez Cruz, Misael wrote:
> > Hi,
> > 
> > I'm interested in bringing headset detection feature for audio. The
> > detection is done through TWL GPIO_2. How can I configure a GPIO pin
> > to generate an interrupt? Is there any API? Could you please point
> > out another driver using that functionality so I can use as reference?   

I don't think there is one.  I hacked my Beagleboard to test
those ... Rev B boards don't have EHCI, so GPIO-1 is easily
available.

In the setup() callback for the TWL4030 GPIOs:

{
  int GPIO_NUMBER = gpio_base + 2;

> gpio_request(GPIO_NUMBER, "Headset IRQ");
> gpio_direction_input(GPIO_NUMBER);

  lm8323_board_info.irq = gpio_to_irq(GPIO_NUMBER);
  ... something registers this board_info ...

  ...
  return 0;
}

and then later the lm8323 driver will use that IRQ:

> request_irq(client->irq, lm8323_irq, flags | IRQF_SHARED, DRIVER_NAME, dev);
> 
> that should do it :-)
> 
> see that GPIO_NUMBER will be gpio_base + 2, base is board-specific

..... and hence client->irq is also board-specific,
which is why it needs to be set up


