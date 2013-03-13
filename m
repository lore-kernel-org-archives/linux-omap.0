From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: omap4 pandaboard: clock input for TiWi module inactive
Date: Wed, 13 Mar 2013 09:29:57 +0100
Message-ID: <51403905.3020102@ti.com>
References: <CAEYbN3QotnnAUU=7c7=r1sHDnZ5VhgNfXfP6ANf3+ssCzmEa=A@mail.gmail.com> <513D9CB7.2010402@ti.com> <513DA92F.7020908@ti.com> <CAEYbN3T97W=74nMG4x4tVECRkff2RSasapvZQowpUwhJtUd=JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35398 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282Ab3CMIaG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 04:30:06 -0400
In-Reply-To: <CAEYbN3T97W=74nMG4x4tVECRkff2RSasapvZQowpUwhJtUd=JQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Levi Pearson <levipearson@gmail.com>
Cc: "Coelho, Luciano" <coelho@ti.com>, linux-omap@vger.kernel.org, Balaji T Krishnamoorthy <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

On 03/12/2013 05:33 PM, Levi Pearson wrote:
> I spent some more time looking at clk-twl6030.c, and it seems it just=
 turns the
> twl6030 chip on when you ask it to enable the clock, and as far as I
> can tell that
> happens based on module dependencies?  There aren't any explicit refe=
rences to
> it that I can find, so I'm not entirely sure how a clk-twl6040 would
> cause a clock
> to be enabled.

The clk-twl6040 is not really a good example for you start with. We onl=
y need
it to turn on in order to get the clock on the output. But the principl=
e is
the same at the end. you need to enable/disable the clock from twl6030.=
=2E.

>>>> If for whatever reason the commits cannot be reverted, would creat=
ing
>>>> a driver like drivers/clk/clk-twl6040.c that enabled the twl6030's
>>>> clock output be a suitable alternative?  I'd be willing to take a =
stab
>>>> at writing it if there's not something like that in the works alre=
ady.
>>
>> If you can take this it would be great. It is still in my to-do list=
 to
>> integrate the clk-twl6040 clock with the omap-mcpdm driver. I alread=
y got
>> working code, but it is not working in a way I would really wanted t=
o be.
>> Integrating external clock to the SoC's clock tree does not seams to=
 be that
>> straight forward: at boot time when the clock tree is initialized th=
e external
>> chip is yet to be probed -> the root clock is not there, but later o=
n for some
>> reason I can not get the CCF to enable the clock tree correctly.
>=20
> I looked into the early boot clock setup code, and that does look a l=
ot less
> straightforward.

Yes, this is what I thought for the twl6040 clock integration with McPD=
M. It
turned out a bit more complicated.
At boot time you do not have the twl clock driver loaded.
You have the clock tree already defined.
When you boot further you add the clock for twl6040.
You want to hook it up with the existing clock tree - to set it as pare=
nt of
one of the clock root (which you already modified to not to be the root=
 clock).
I shall work, but it does not:
for external chips we need to do the configuration/enable in clk_prepar=
e time
(because they are over i2c).
So the driver goes and asks for a clock (which supposed to be at the en=
d
rooted to this new external clock).
Nothing happens.
The relevant clock tree has been already got prepared earlier so new pr=
epare
will not going to go down to the root, leaving the root clock disabled.

I'm still looking a way to somehow fix this, but my time is limited rig=
ht now.


> There are already a few 32k clocks listed there, and
> I *think* they
> all source from the twl6040; do they just come up automatically at po=
wer-on?
> From what I can tell, clk32kg is just a gated fork of the regular 32k
> clock that is
> available at boot from twl6040.  I am surprised it doesn't come on by=
 default.

I have not checked the schematics, but it could be that we have crystal=
 32K on
board as well. TWL6030 can gate some of it's 32K outputs and this is th=
e case
with WiLink on PandaBoard.

>=20
> I also don't have a TRM for twl6040 that matches up with what twl-reg=
ulator.c is
> doing to enable the clk32kg output; it looks like it's adding it to
> one of the power
> modes, but I'm not entirely sure how the registers it's writing to wo=
rk, so my
> confidence level in being able to get it transplanted to a separate
> driver has lowered
> quite a bit.

I'm not sure if I have twl6030 TRM either, but I can try to come up wit=
h a
basic driver for the twl6030 clocks.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
