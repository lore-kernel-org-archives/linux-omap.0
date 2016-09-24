From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sat, 24 Sep 2016 07:55:27 +0200
Message-ID: <E8C59C6C-23D4-4417-8A9E-3E9AE5D2D100@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com> <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com> <20160923224726.GA4639@rob-hp-laptop> <20160924003133.htaaiphjrm7vy52t@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_E760FB48-DF2C-4591-A7F0-A5F9B8D28409"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160924003133.htaaiphjrm7vy52t@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_E760FB48-DF2C-4591-A7F0-A5F9B8D28409
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

> Am 24.09.2016 um 02:31 schrieb Sebastian Reichel <sre@kernel.org>:
>=20
> On Fri, Sep 23, 2016 at 05:47:26PM -0500, Rob Herring wrote:
>> On Fri, Sep 23, 2016 at 02:41:09PM +0200, H. Nikolaus Schaller wrote:
>>> commit b98abe52fa8e ("Input: add common DT binding for =
touchscreens")
>>> introduced common DT bindings for touchscreens [1] and a helper =
function to
>>> parse the DT.
>>>=20
>>> commit ed7c9870c9bc ("Input: of_touchscreen - add support for =
inverted / swapped axes")
>>> added another helper for parsing axis inversion and swapping
>>> and applying them to x and y coordinates.
>>>=20
>>> Both helpers have been integrated to accommodate any orientation of =
the
>>> touch panel in relation to the LCD.
>>>=20
>>> A new feature is to introduce scaling the min/max ADC values to the =
screen
>>> size.
>>>=20
>>> This makes it possible to pre-calibrate the touch so that is =
(almost)
>>> exactly matches the LCD pixel coordinates it is glued onto. This =
allows to
>>> well enough operate the touch before a user space calibration step =
can
>>> improve the precision.
>>>=20
>>> Finally, calculate_pressure has been renamed to calculate_resistance
>>> because that is what it is doing.
>>=20
>> Seems like you are breaking compatibility with old DTs. I can't tell =
for
>> sure though.
>>=20
>>>=20
>>> [1]: =
Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>>>=20
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> .../bindings/input/touchscreen/tsc2007.txt         |  20 ++--
>>> drivers/input/touchscreen/tsc2007.c                | 126 =
+++++++++++++++++----
>>> include/linux/i2c/tsc2007.h                        |   8 ++
>>> 3 files changed, 123 insertions(+), 31 deletions(-)
>>>=20
>>> diff --git =
a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt =
b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>>> index ec365e1..6e9fd55 100644
>>> --- =
a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>>> +++ =
b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>>> @@ -6,6 +6,7 @@ Required properties:
>>> - ti,x-plate-ohms: X-plate resistance in ohms.
>>>=20
>>> Optional properties:
>>> +- generic touch screen properties: see touchscreen binding [2].
>>> - gpios: the interrupt gpio the chip is connected to (trough the =
penirq pin).
>>>   The penirq pin goes to low when the panel is touched.
>>>   (see GPIO binding[1] for more details).
>>> @@ -13,17 +14,20 @@ Optional properties:
>>>   (see interrupt binding[0]).
>>> - interrupts: (gpio) interrupt to which the chip is connected
>>>   (see interrupt binding[0]).
>>> -- ti,max-rt: maximum pressure.
>>> -- ti,fuzzx: specifies the absolute input fuzz x value.
>>> -  If set, it will permit noise in the data up to +- the value given =
to the fuzz
>>> -  parameter, that is used to filter noise from the event stream.
>>> -- ti,fuzzy: specifies the absolute input fuzz y value.
>>> -- ti,fuzzz: specifies the absolute input fuzz z value.
>>> +- ti,max-rt: maximum pressure resistance above which samples are =
ignored
>>> +  (default: 4095).
>>> +- ti,report-resistance: report resistance (no pressure =3D max_rt) =
instead
>>> +  of pressure (no pressure =3D 0).
>>> +- ti,min-x: minimum value reported by X axis ADC (default 0).
>>> +- ti,max-x: maximum value reported by X axis ADC (default 4095).
>>> +- ti,min-y: minimum value reported by Y axis ADC (default 0).
>>> +- ti,max-y: maximum value reported by Y axis ADC (default 4095).
>>=20
>> Seems like these could be common too. They make more sense than =
giving x
>> and y sizes in pixel units which really should come from the panel.
>=20
> The generic touchscreen properties are described "(in pixels)" in
> the DT, but they are used in the same way.
>=20
> So ti,max-[xy] is basically the same as touchscreen-size-[xy],

No it is not the same and should be kept separate.

> except, that the generic bindings don't support min-[xy] !=3D 0.

What would be the purpose of this? Every user-space I know
about (X11, Replicant) expects coordinates in some range
0..max so setting min in device tree makes no sense to me.

>=20
> So maybe change the generic bindings like this:
>=20
> touchscreen-min-x: minimum value reported by X axis ADC (default 0)
> touchscreen-max-x: maximum value reported by Y axis ADC
> touchscreen-min-y: minimum value reported by Y axis ADC (default 0)
> touchscreen-max-y: maximum value reported by Y axis ADC
> touchscreen-size-x: deprecated alias for touchscreen-max-x
> touchscreen-size-y: deprecated alias for touchscreen-max-y
>=20

Initially I had thought about this but it does not solve the problems
with touch pre-calibration. Since it mixes raw coordinates with
system coordinates.

To achieve the goal of having a roughly precalibrated touch which
should provide (0,0) at the lower left corner and =
(touchscreen-size-x,touchscreen-size-y)
in pixel coordinates of the panel. Hence it roughly works without
a calibration matrix in user space (e.g. xorg.conf or Replicant).

Why do we need pre-calibration? Because some systems might need
touch interaction before they can offer (force) the user into
a touch calibration step. We use these drivers and approach in
our production kernels for GTA04, OpenPandora and Pyra for a while
and nobody was even missing a user-space calibration tool any more.

The underlaying problem is that you can have the same controller chip
in different board designs and there are different touch panel types.
Each one has certain physical properties but they can differ.
But you certainly want touchscreen-size-x/y to be a constant.

Now if we make touchscreen-max-x/y the same as touchscreen-size-x/y
and change the panel, we have to adjust user space transformation
each time we change the panel. This does not seem to be right
and can be done better by keeping them separately.

This is what this approach does: the roughly correct scaling of
raw values to pixel values.

ti,min-x   ->   0
...
x          ->   some value between 0 and touchscreen-size-x
                calculated by
			touchscreen-size-x * (x - min-x) / (max-x - =
min-x)
...
ti,max-x   ->   touchscreen-size-x

Hence the ti,min/max values describe the range of expected input
values from the ADC and the touchscreen-size-x describes the touch
in LCD pixels passed as input events.

Example:

ti,min-x =3D 64
ti,max-x =3D 4016
touchscreen-size-x =3D 480

If we change the panel type which presents a slightly different ADC =
range:

ti,min-x =3D 100
ti,max-x =3D 3900
touchscreen-size-x =3D 480

and we still get a coordinate range (0 .. 480).

Note that this feature can be effectively disabled if ti,min-x=3D0 and
ti,max-x=3D4095 and touchscreen-size-x=3D4095, i.e. reports the full
range of ADC values because then it multiplies by 1.

Our proposed driver does use these values if they are missing from DT
and therefore it should not break old DT files which expect raw values
to be reported.

I hope this clarifies what we need to achieve and you can
agree.

BR and thanks,
Nikolaus

--Apple-Mail=_E760FB48-DF2C-4591-A7F0-A5F9B8D28409
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX5hVQAAoJEIl79TGLgAm6cNcP/RJCK2G5XiL7xOr9LxRmlsIu
aeHPCKiA4fkTYSju2Sm343Hrv4Noh/PmI6n5WU78LadKHUs+uyeftjYTEZlfNqMF
zH/wnt1UEnou1CXQwMc+n3skonE8zivxve9i6JRYSHvRnsOh3XYRpLH96AhdnuSG
QzQRejbVBPmuY+OjB1MoaFhrbqlcJiALjcKhlXDCR4sbIbR3yvfI1gHdlvWUGVp6
bsajX+9RhMKB1WlaPL+3LXtIN3c5Wesl6ouSWqZKP65L+SqJHLH5zs0vs81CIAcB
B70nItq7zWlU91VvrhpWebpeUKjAQH3PZX8AA+I1grNbUttazG3TJW54iLoum7a6
1wBoAwOTWD7WXXJMj46wVOy8M/mu9UhKZF1H6pqL6FPXd2byE86mfE2njLCSLSqd
y9ux4fvYW5Oeq8cG/hA21G09cpWsMOUJ7kemkItLeyawEB/5uIQABblufdjid6GB
NZ9tqGH+YCrgcvAFbczMy2WEemAErZB6/PeiPNxM+ChNUsAk/CwChnVVJwluTdVk
Z+l/+X3dmtPRGlsxevkgO/RuRZw965ySATIPHVbwVpN2PL+RoH6ANNLAfuqdTtNi
PO3jz2zcxYpJnxfppLi2j2Jb9GqyNvT7d8T9kVWiyDaL32DkeDPuRJG56bTdmi47
fAkpW/vkkI5gGaSBtMLX
=9Iws
-----END PGP SIGNATURE-----

--Apple-Mail=_E760FB48-DF2C-4591-A7F0-A5F9B8D28409--
