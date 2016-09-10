From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: dts: omap3-gta04: reduce panel backlight PWM frequency to 83Hz
Date: Sat, 10 Sep 2016 11:10:17 +0200
Message-ID: <7C9DF12E-32C6-4D7C-BAAD-5CE9F8BA305A@goldelico.com>
References: <954d43b570092fe92b8b49cf8f475c027d3d8342.1473066997.git.hns@goldelico.com> <20160910031736.xwnepaoifpedqfbr@squirrel.local> <3188F52F-1372-4D59-B790-C15E584A44F2@goldelico.com> <CAALWOA8ZZBbgCG-5TRbd6=k27PQV2EHcCj6zwk31sKTHY1A7Bg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAALWOA8ZZBbgCG-5TRbd6=k27PQV2EHcCj6zwk31sKTHY1A7Bg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: David Rivshin <drivshin@allworx.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Marek Belisko <marek@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 10.09.2016 um 10:20 schrieb Matthijs van Duin =
<matthijsvanduin@gmail.com>:
>=20
> On 10 September 2016 at 09:08, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>> Reducing the PWM frequency is good by itself since it should not be =
unnecessarily
>> fast and helps to make the PWM to "average current" translation more =
linear.
>>=20
>> The non-linear effect is that the PWM controlled DC/DC converter =
reacts almost
>> immediately to a 1->0 control transition but needs some time (ca. =
0.5ms) to recover
>> on a 0->1 transition.
>=20
> DT already allows for compensation of many non-linearities by
> specifying the duty cycle of each brightness increment.  Though, as
> you observed, there's one limitation it cannot fix here:
>=20
>> If we just fix the PWM generator to output a steady 1 signal at 100%, =
we have a
>> very significant change if we switch to 99%, depending on PWM =
frequency.
>=20
> Specifically the next-to-brightest step (assuming 0.5ms off-time) =
would be:
> 75%  @ 500 Hz
> 90%  @ 200 Hz
> 95%  @ 100 Hz
> 96%  @  83 Hz

Yes.

>=20
> Note that perceptually the distance to 100% might be smaller due to
> non-linear response of the eye. That's my experience with pwm
> controlled leds anyway, which may or may not apply to backlights

basically it does. Eye is basically logarithmic - but has several =
auto-exposure
and auto-iris mechanisms... So perceived brightness is a very complex =
topic.
It might even depend on the color and contrast of the image presented. =
This
is something we can ever fix by DT...

> (though with my laptop's backlight I never really have use for the
> distinct steps at the brightest end while those at the darkest end
> seem disproportionally large).
>=20
>> This effect becomes smaller if the PWM frequency is reduced and 83Hz =
seems more
>> reasonable (although still a little arbitrary) than the current =
value.
>=20
> While 500Hz is perhaps a bit high, 83Hz actually seems very low to me.

Why? The eye can't even see flicker @ 50 Hz.

And, there is a capacitor that averages the voltage applied, hence it is
low pass filtered. But the capacitor can't compensate for the startup =
delay
of the DC/DC converter.

And, I have tested that on the device targeted by this DTS... No visible
issue (except that maximum brightness decreases if too high).

> Searching a bit around yielded 175 Hz as common frequency for CCFL
> backlights and higher for LED backlights (source:
> http://www.tftcentral.co.uk/articles/pulse_width_modulation.htm).

>=20
> (I may be reacting a bit twitchy here due to having encountered dimmed
> LED lighting that was flickering obnoxiously for me while noone else
> noticed this.)
>=20
> Matthijs

But with the patch submitted, I just want to give the dts of a single
device I have even designed a more reasonable value than in current
linux/master and don't really want to make it a fundamental =
discussion...

BR,
Nikolaus=
