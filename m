From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 01/22] mfd/ti_am335x_tscadc: remove regmap
Date: Thu, 04 Jul 2013 11:02:41 +0200
Message-ID: <51D53A31.3080704@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <1370950268-7224-2-git-send-email-bigeasy@linutronix.de> <20130611142336.GE29135@zurbaran> <51B7358D.7000605@linutronix.de> <20130614135358.GR1403@sirena.org.uk> <51BEF5F4.4090600@linutronix.de> <20130617160326.GE1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39978 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab3GDJCu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jul 2013 05:02:50 -0400
In-Reply-To: <20130617160326.GE1403@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org

Sorry for the long pause=85

On 06/17/2013 06:03 PM, Mark Brown wrote:
>> This is a lot of for a simple mmio access. In terms of
>> performance: If I add a trace point to my read and write I have
>> still less code which is called and it can be disabled. This
>> regmap overhead is always there chasing pointers.
>=20
> Equally well what you're implementing here is support for
> something that's typically implemented with an I2C or SPI control
> interface so you're already going to be quite a way ahead of the
> norm.  This is part of what's confusing me, usually for this
> application things aren't that bad performance wise even on a
> massively slower bus.
>=20
> If all you're saying here is that there's some overhead that's fine
> if a bit surprising, but the way you're talking made it sound like
> there was some issue that made the API actually unusable.

No, sorry for that confusion. I had a problem with the locking in irq
context, changed the driver & pointed out the problem, been told that
there is a fix, applied it, never complained again.

This is simply about I am forced to use regmap and I don't agree with
it.

>> As I said before: I doubt that you get this regmap access in an
>> one GiB network driver and in turn remove their trace points to
>> register access.
>=20
> Well, of course for that sort of thing the general trick is not to
> talk to the hardware at all and do as much as possible with memory
> that the hardware can DMA - there's actually still non-trivial
> costs in talking over the buses.

That is true but even while doing DMA you have enough handshake with
the HW to trigger the transfer and if you are lucky your DMA
descriptors are in cached memory.

>> Please don't get me wrong: It is still nice for slow buses and
>> this ADC driver isn't anything close to high performance like a
>> 1GiB network driver but it adds a lot of unwanted overhead which
>> I prefer not to have.
>=20
> OK, but equally well remember that from a subsystem maintainer
> point of view having things factored out is a win in itself; for
> example with the MFDs locking on the register I/O has been a
> persistent issue in the past.

I agree with that. But:

The driver here does not use atomic updates but read followed by write
so your locking here is futile. So the API/regmap alone does not make
it right. And look: the MFD part uses regmap. Its children (IIO &
input) do not use it. After I told this Samuel he said that it is okay.
So here I am. Using regmap in MFD which is only used once on init and
never again. It has regmap.

The register access in both child driver is split making sure they do
not use the same ones. I added one function which writes a common
register. That one is reset after an operation and needs to be written
by the currently active child so the HW continues to work. Haven't seen
anything close to it in regmap.

I ask, politely I hope, to get this patch in and remove regmap since
none of its features are used in this driver.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
