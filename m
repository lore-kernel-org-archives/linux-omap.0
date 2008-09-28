From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 11/9] move twl4030-gpio to drivers/gpio
Date: Sun, 28 Sep 2008 06:14:13 +0300
Message-ID: <20080928031411.GF8468@frodo>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <20080927222900.GC8468@frodo> <20080927230902.GD8468@frodo> <200809271645.20782.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41680 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbYI1DOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Sep 2008 23:14:25 -0400
Content-Disposition: inline
In-Reply-To: <200809271645.20782.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jean Delvare <khali@linux-fr.org>

On Sat, Sep 27, 2008 at 04:45:20PM -0700, David Brownell wrote:
> On Saturday 27 September 2008, Felipe Balbi wrote:
> > We need something like the patch below (I can't find a substitute
> > to twl4030_set_gpio_edge_ctrl and twl4030_set_gpio_debounce):
>=20
> Something like that, yes.  I have other patches queued up though.
>=20
> And meanwhile, your build seems goofed ... fix that first.

Yeah, it only happens when both mmc and twl4030-gpio are built as
modules. Still sounds weird since we have EXPORT_SYMBOL() for those
twl-specific crap.

Basically I'm using 3040sdp defconfig changing twl4030-gpio and mmc to
modules.

> For the moment I'm waiting until HSMMC works again in the OMAP
> tree before I submit patches for any of those issues ... and
> some of them imply updates from upstream.  Like these two:
>=20
>   http://marc.info/?l=3Dlinux-kernel&m=3D122239480403730&w=3D2
>   http://marc.info/?l=3Dlinux-kernel&m=3D122239472903349&w=3D2
>=20
> For the "edge control" thing, I have a patch pushing that into
> the standard IRQF_TRIGGER_{RISING,FALLING} and set_irq_type()
> calls ... there was never a need for a twl-specific call here.
>=20
> For debouncing, see this LKML RFC:
>=20
>   http://marc.info/?l=3Dlinux-kernel&m=3D122228602206108&w=3D2

the debouncing mechanism looks really good :-)

> > @@ -48,7 +49,7 @@
> > =A0
> > =A0static int hsmmc_card_detect(int irq)
> > =A0{
> > -=A0=A0=A0=A0=A0=A0=A0return twl4030_get_gpio_datain(irq - TWL4030_=
GPIO_IRQ_BASE);
> > +=A0=A0=A0=A0=A0=A0=A0return gpio_get_value(irq - TWL4030_GPIO_IRQ_=
BASE);
>=20
> That's a non-portable version of irq_to_gpio() ... and one
> which should use gpio_get_value_cansleep().  My patches use
> a simpler scheme, which among other things lets other GPIOs
> be used for card detect.
>=20
> (I understand that not all OMAP3 customers want to use twl4030
> for their power management ... and in any case, having this kind
> of needless dependency between drivers is a Bad Thing.)

That's true. Didn't got that at first look. We should use something
like:

return gpio_get_value_cansleep(irq_to_gpio(irq));

right ??

it's good that you've been playing with twl4030-gpio. You've written
gpiolib anyways, so you might better than I do where stuff should go.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
