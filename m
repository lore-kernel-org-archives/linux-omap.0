From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Wed, 23 Nov 2011 16:21:20 +0100
Message-ID: <DD2280C9-D4E2-41FF-BDE7-9119237B62C0@dominion.thruhere.net>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com> <1321274409-24643-2-git-send-email-rnayak@ti.com> <20111114172312.GI31337@atomide.com> <4EC1EB9D.1000503@ti.com> <CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com> <CAJuYYwSgzkDed5-R=PaBR_F6ssj_EhxLDfCREXUA=UaynkgZyg@mail.gmail.com> <CACRpkdbBQoOU8hyew6tXth3Ohrg5_rN7M+tbVsYFcOjgq73aCw@mail.gmail.com> <CAJuYYwT_useS-8cH+qfDu5t7wh73yUuJAVXMjP5CXBS2VM3bag@mail.gmail.com> <CACRpkdax0GK=mNNao7FPc6JG0RwVywSEzGJPC_u73iJ_eOTgqQ@mail.gmail.com> <20111122175409.GE31337@atomide.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: multipart/signed; boundary="Apple-Mail=_2FE185F8-CC75-4165-BC7A-C98DC4153127"; protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20111122175409.GE31337@atomide.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linus.walleij@stericsson.com, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_2FE185F8-CC75-4165-BC7A-C98DC4153127
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


Op 22 nov. 2011, om 18:54 heeft Tony Lindgren het volgende geschreven:

> * Linus Walleij <linus.walleij@linaro.org> [111122 03:30]:
>> On Tue, Nov 22, 2011 at 12:09 PM, Thomas Abraham
>> <thomas.abraham@linaro.org> wrote:
>>> On 17 November 2011 19:27, Linus Walleij <linus.walleij@linaro.org> =
wrote:
>>>>=20
>>>> Maybe I'm mistaken about the device tree ambitions, but
>>>> I was sort of hoping that it would not contain too much
>>>> custom magic numbers that need to be cross-referenced
>>>> elsewhere ... or rather - the more understandable the device
>>>> tree is, the more we win.
>>>=20
>>> Device tree is expected to describe the hardware. So to
>>> cross-reference the hardware manual to understand device tree should
>>> be fine I guess. For instance, GPIO numbers in dts would be written =
as
>>> a numeric number and not a enum or other format. And by looking up =
the
>>> manual, we understand the actual details of the GPIO pin.
>>>=20
>>> If dt-compiler had a option to support #define like in C, the =
numbers
>>> could have been made more easier to understand. Like, 3 to mean
>>> GPIO_PULL_UP in Exynos dts file.
>>=20
>> OK I think I get it now, so DT bindings shall really NOT be read
>> by any of the pinctrl core, it is *supposed* to be all =
driver-specific.
>> Then it makes perfect sense to have it as it is.
>=20
> Yes the driver nodes should describe in DT which pins to use:
>=20
>        serial@12340000 {
>                compatible =3D "8250";
>                reg =3D <0x12340000 0x40>;
>                reg-shift =3D <2>;
>                interrupts =3D < 10 >;
> 		pins =3D "uart1_rx", "uart1_tx";
>        };
>=20
> Note that we should use the actual signal names, not package specific
> pad names. This way they have a high likelyhood to work for new =
packages
> too by just mapping the signals to the new package.

How would this handle the situation where you can mux a signal to =
multiple pins? IIRC omap3 and am335x can do funny stuff with the display =
pins like being able to map the blue bits to different pinblocks.

regards,

Koen=

--Apple-Mail=_2FE185F8-CC75-4165-BC7A-C98DC4153127
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAk7ND3MACgkQMkyGM64RGpEWvACfei0g0txvQG/njp471anVxrI/
hrUAn1tC9yt9guGJXvoWywRoMoQBzsbv
=cmyQ
-----END PGP SIGNATURE-----

--Apple-Mail=_2FE185F8-CC75-4165-BC7A-C98DC4153127--
