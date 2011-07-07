From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] dmaengine: add new api for preparing simple slave transfer
Date: Thu, 7 Jul 2011 21:37:53 +0200
Message-ID: <CAKnu2MorpLQuzwDGBJ7uSt6NOk=9vgeBN4f+Zx=CSU9okqzvGw@mail.gmail.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940301FE2DED@dbde02.ent.ti.com>
	<20110609124723.GA24636@n2100.arm.linux.org.uk>
	<E0D41E29EB0DAC4E9F3FF173962E9E940301FE2EFB@dbde02.ent.ti.com>
	<1307686140.10976.111.camel@vkoul-udesk3>
	<E0D41E29EB0DAC4E9F3FF173962E9E940301FE3405@dbde02.ent.ti.com>
	<1307724439.10976.188.camel@vkoul-udesk3>
	<E0D41E29EB0DAC4E9F3FF173962E9E9403020B7C2A@dbde02.ent.ti.com>
	<1308203119.10976.234.camel@vkoul-udesk3>
	<E0D41E29EB0DAC4E9F3FF173962E9E9403024F5420@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9403024F5420@dbde02.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Raju, Sundaram" <sundaram@ti.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dan <dan.j.williams@intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

2011/7/7 Raju, Sundaram <sundaram@ti.com>:

> | Just put some enumerator in enum dma_ctrl_cmd in
> | dmaengine.h such as SDMA_TEXAS_STRIDE_CONFIG and call
> | like this:
> |
> | /* However that config struct needs to look, basically */
> | static struct sdma_ti_stride_cgf =3D {
> | =A0 =A0 =A0take =3D M,
> | =A0 =A0 =A0skip =3D N,
> | };
> |
> | ret =3D chan->device->device_control(chan, SDMA_TEXAS_STRIDE_CONFIG=
,
> | &sdma_ti_stride_cfg);
> |
> | Or something like this.
>
> I think this is better option than your 2b. This requires just an add=
ition of
> one more enum in the dma_ctrl_cmd. What do you think about this?
> If Dan and you are okay with this I will send a small patch for this =
asap.

I think this is the best way to solve it atleast. It's clear what is
being done, and it's easy for a client trying to create such a slave
transfer to back out if it turns out that the DMAC in use does not
support this striding.

Send a patch out and I'll Ack it, FWIW.

Linus Walleij
