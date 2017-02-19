From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 13:07:26 +0100
Message-ID: <FA96689F-AFD0-4FC9-95D9-639299341C8B@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws> <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218032233.3qh5xdjbx5kkq5hm@earth> <95E59EB0-6F96-40BB-B74C-9CD56DDD7783@goldelico.com> <20170218234422.vza3toc3bphixsdn@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_77E5155C-9B02-4B8D-997C-5D50BA7ACE42"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20170218234422.vza3toc3bphixsdn@earth>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Petr
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_77E5155C-9B02-4B8D-997C-5D50BA7ACE42
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Sebastian,

> Am 19.02.2017 um 00:44 schrieb Sebastian Reichel <sre@kernel.org>:
>=20
> Hi,
>=20
> On Sat, Feb 18, 2017 at 12:33:34PM +0100, H. Nikolaus Schaller wrote:
>> Hi Sebastian,
>>=20
>>> Am 18.02.2017 um 04:22 schrieb Sebastian Reichel <sre@kernel.org>:
>>>=20
>>> Hi,
>>>=20
>>> On Fri, Feb 17, 2017 at 12:40:41PM -0800, Dmitry Torokhov wrote:
>>>>> AFAIK there is no mainline board using the DT except ours (and the =
upcoming
>>>>> OMAP5-Pyra), so we shouldn't care too much. If you prefer, you can =
remove this
>>>>> compatibility property. We don't need it for our devices.
>>>=20
>>> $ cd linux.git/arch
>>> $ git grep -l tsc2004
>>> arm/boot/dts/imx6qdl-nit6xlite.dtsi
>>> arm/boot/dts/imx7d-nitrogen7.dts
>>> arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
>>> arm/boot/dts/omap4-var-som-om44.dtsi
>>> $ git grep -l tsc2005
>>> arm/boot/dts/omap3-n900.dts
>>=20
>> Those are not relevant since tsc2004/5 and tsc2007 are independent =
drivers and don't
>> share code.
>=20
> Yes, I'm aware.
>=20
>> Hence the N900 is not influenced by this patch series.
>> If it has a similar issue, it should be fixed of course.
>=20
> Right. I added them to see every board affect by the patch suggested
> by me in my last paragraph.

Ok!

>=20
>>> $ git grep -l tsc2007
>>> arm/boot/dts/imx28-tx28.dts
>>> arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
>>> arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
>>> arm/boot/dts/imx53-tx53-x03x.dts
>>> arm/boot/dts/imx6qdl-tx6.dtsi
>>> arm/boot/dts/imx6ul-tx6ul.dtsi
>>> arm/boot/dts/omap3-gta04.dtsi
>>> sh/boards/mach-ecovec24/setup.c
>>=20
>> Sorry, I was a little imprecise here, because I looked for the =
min/max properties.
>> Of course, the imx devices use the tsc2007 as well.
>>=20
>> Maybe we should edit all these DTS and set the "ti,report-resistance" =
property
>> by default. Then, no user should notice a difference.
>=20
> I suggest to create a patch without the report-reistance stuff and
> add it early after the merge window and see what happens. If no
> users notices anything the change is not an ABI break from kernel's
> PoV.

That looks like a good strategy.

>=20
>> Is any user/maintainer of these devices following this discussion and =
can comment?
>>=20
>>>=20
>>>> You seem to be treating DT data as something very fluid, which is =
wrong.
>>>> You need to treat it as a firmware, unlikely to change once device =
is
>>>> shipped. Unlike legacy platform data, the fact that DTS files are =
not
>>>> present in mainline does not mean that we can ignore such users and
>>>> change behavior at will.
>>>>=20
>>>> That said, if driver behavior is out of line from the subsystem
>>>> expectations, we need to fix it.
>>>>=20
>>>>=20
>>>>> That the function name is wrong is a second issue and this double =
negation might
>>>>> confuse a litte.
>>>>>=20
>>>>> Please test on a real device if the patched driver reports =
pressure now (unless
>>>>> ti,report-resistance is specified).
>>>>=20
>>>> I unfortunately can not test this driver as I do not have the =
hardware.
>>>> So all my observations are from code and data sheets.
>>>>=20
>>>> That said, what is the values emitted as ABS_PRESSURE when finger =
is not
>>>> touching the device, barely touching the device, or pressing =
firmly?
>>>> It seems that between TSC2007, TSC2004, TSC2005, and ADS7846, we =
have
>>>> confusion as to what is being reported.
>>>=20
>>> As far as I can see all calculate Rtouch and ADS7846 reports
>>> (Rmax - Rtouch), which looks sensible.
>>=20
>> I don't see where this subtraction from Rmax takes place for the =
tsc2007:
>>=20
>> =
http://lxr.free-electrons.com/source/drivers/input/touchscreen/tsc2007.c#L=
131
>=20
> sorry if I wrote this ambiguous, let me split my sentence
>=20
> 1. tsc200x & ads7846 calculate Rtouch
> 2. ads7846 reports Rmax - Rtouch
> (3. tsc200x does not, it reports Rtouch instead)
> 4. ads7846 behaviour looks sensible to me

agreed.

>=20
>>>> I am adding a few more folks to the CC so we can try and soft this =
out.
>>>> Sebastian, Pali, Pavel, any input here?
>>>=20
>>> I think tsc200x works, since usually userspace is Xorg and I think
>>> it only cares for x/y coordinates + boolean pressure. Since
>>> no-pressure is correctly reported as 0, everything works as
>>> expected.
>>=20
>> No pressure is usually treated as a special case in these drivers,
>> so reduction to "boolean" in user-space works well by accident and
>> might still hide a bug.
>=20
> That's what I assumed.
>=20
> Btw. how did you notice that tsc2007 sends "inverted" pressure values?
> Just in evtest or in some non-development application? (Just asking =
because
> the behavour obviously changes at least for that usecase)

I don't really remember when we noticed it first. Maybe it was back in =
tslib times
some years ago where setting the sensitivity threshold made problems. We =
then
carried along our patch for a long time in our local repo (and modified =
it
several times) and only started upstreaming some months ago. So it was =
included
but we never thought about it being something as important as the =
pre-calibration
which is really a benefit for setup and immediate useability of the =
whole system.
Hence we buried it a little in this pre-calibration, flipping and =
rotation patch.

>=20
>>> I currently don't have X running on my N900 due some
>>> omapdrm bug, so I can't test this, sorry.
>>=20
>> I usually look with evtest if ABS_PRESSURE is monotonic.
>=20
> That would not have helped to check if X handles the touchscreen in
> a boolean way. I can provide some N900 evtest data, though (tomorrow,
> I don't have my dev N900 with me at the moment).

AFAIK, GIMP and for example https://sourceforge.net/projects/xournal/ =
appear
to be able to handle X pressure, but I haven't running and tested either =
one
on our devices. Pressure is used in such drawing tools to simulate that =
some
physical pens make wider strokes on higher pressure.

This seems to indicate that X can handle pressure in a non-boolean way, =
but rarely does.
Especially I think the usual menu, click, drag, scroll gestures are only =
based
on BTN_TOUCH status and not on ABS_PRESSURE. So it is rarely noticed to =
make
a difference.

>=20
>>> I suggest to put the resistance vs pressure thing in its own patch,
>>> that also fixes tsc200x-core and merge it to linux-next after the
>>> merge window.

Ok. I will propose a patch.

BR,
Nikolaus


--Apple-Mail=_77E5155C-9B02-4B8D-997C-5D50BA7ACE42
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqYp+AAoJEIl79TGLgAm6ltYP/0nlIh/R2WTdIGc3mfYbdHvf
pLIXszH3zjel9hkG+ZY23UNfT2hQGLRpn69ybnuU/ne2+URkpmdVvkvrf+8BSq51
ALsnVWz3WDE5LelAAVdic8b3twhFuCC98p6eFVC5nDZ+IE7xPc0827b/2bOn74wO
5txIy4lpgURtmx7IeOqmNefqplX6KKoQuyoCitImJOnjAW1rlO8+AmoBm9VupYFb
lO2AdPcJ1/638Zk6+koW6JvmYURgCpYcLrOz4lnKHoqIfKS5iJkPvaIdWKKt1v9J
Xy2pCWFXSHSQx0brPUUqp0iD0RF63QFNeFPjY1Mcb2UBcVkRZ0Lw2gZehCGoOo2z
XK8mJ4eozICz6nm/fejbO/1dkhm2HFWMy0GUM4c4ijstpKWJ7QfCnjYgnjrMH5Rk
H57gB1ebSaN+hXeL01HFbS8yZlMTl/ERyp611yvOk934oJy2l41If9Uo7v4wbBNN
mH7C2nwSlJaXVkQhwU9cyRZ1/BN4ch1EIZOqC+Qv1t9mX9oMwDyQcO5mjV5fEMoY
1wBRTohnxlbIglaDDh/4ihX1gG51ZOQYrKUPHZ/bVrDYVGGsQi7f3kExmlB7j0+3
jFsPVPQgiGcuV/yky44fSNiGPPhZhuoh1TSuMPbHTZsrdVtr0hlTq9q63yC+vPlb
4a4hXei37QabEc9ceDyZ
=pL58
-----END PGP SIGNATURE-----

--Apple-Mail=_77E5155C-9B02-4B8D-997C-5D50BA7ACE42--
