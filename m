From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 15/26] ARM: omap4-panda.dts: add display information
Date: Mon, 9 Dec 2013 17:30:56 +0200
Message-ID: <52A5E230.4010901@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>	<1386160133-24026-16-git-send-email-tomi.valkeinen@ti.com>	<CABxcv=m+-9V2qwvuQgJavQ3qOb2+fBcAoW9G_Mi33BTHCWE85g@mail.gmail.com>	<52A5BDF4.2070304@ti.com> <CABxcv==-aknRfzybA6ify5JSHeiquS9bqAEXumJwhnS6PT0MfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="4duuXIeLVqLNCRgn2UfVTAoLsmpupwcJF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48025 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761105Ab3LIPbD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Dec 2013 10:31:03 -0500
In-Reply-To: <CABxcv==-aknRfzybA6ify5JSHeiquS9bqAEXumJwhnS6PT0MfA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo Serra <eballetbo@gmail.com>

--4duuXIeLVqLNCRgn2UfVTAoLsmpupwcJF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-12-09 17:09, Javier Martinez Canillas wrote:
> Hi Tomi,
>=20
> On Mon, Dec 9, 2013 at 1:56 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
>> On 2013-12-06 10:57, Javier Martinez Canillas wrote:
>>
>>>> +       tfp410: encoder@0 {
>>>> +               compatible =3D "ti,tfp410";
>>>> +               gpios =3D <&gpio1 0 0>;   /* 0, power-down */
>>>> +
>>>
>>> Please use the constants from include/dt-bindings/ instead of magic
>>> numbers, i.e:
>>>
>>> gpios =3D <&gpio1 0 GPIO_ACTIVE_HIGH>;   /* 0, power-down */
>>
>> Thanks, fixed now (for all .dts files)
>>
>> However... The TFP410 gpio is "power-down". I think we should actually=

>> mark it as GPIO_ACTIVE_LOW, as setting it to 0 powers down the device.=

>>
>=20
> yes, I looked at the TFP410 datasheet [0] and the Power Down pin is
> indeed an active-low, I just replaced to GPIO_ACTIVE_HIGH since you
> were using a constant 0 and include/dt-bindings/gpio/gpio.h defines
> GPIO_ACTIVE_HIGH  as 0.
>=20
> I just asked to Enric why we use GPIO_ACTIVE_HIGH for the PD pin on
> the IGEPv2 DTS instad and is because the IGEP board uses a hardware
> signal inverter but that is a special case. I don't know about the
> Panda board since I haven't looked at its datasheet.

Oh. Does it work on igep? The TFP410 driver always handles the PD GPIO
as it were active-low. The flag is ignored.

 Tomi



--4duuXIeLVqLNCRgn2UfVTAoLsmpupwcJF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSpeIwAAoJEPo9qoy8lh712vwP/junXGTfx4TuqekJmb/Ku/Bv
BmKGuZ8RmHKhLpvOU+byZycjgYLpW0GNhc3VBb311Sya8KUlg94Q9RNBiwfnx5Tv
xkiAkkOVuQaV5RxztR9uATIGmbFsrZWP8Ksx+CSE7eBGRDvtqxOJ8NjYMzxEkwEQ
0XbxMEV8rfFPMmMC3HeAqy6YSVwi+K0F7vvPyJ9ljW0XjmBEHqZmHC3H3O1ip/06
n7dsn63rkTCx0SJ7JVxI1VzIIcDFEHx1tFh1ghUQ4iLFlPpXxiTNCJDKqhQrxLBA
nDFxvP2pDBAH9YC4mWazzo6CXJhBXmvBdgHenhnFpn9uuzF3cdbbvWQ3BZennzbn
B2DTPPc6nQYKZPUerVhtGFFI/w5TVt7llbksApAov8fSr+cVqJhs+epxvNslvGp7
vz98w0zggQuCyVAKdEUdT0QJpYGmpH8k6rJpJiZJofBejA+XPmXsxb+esE+aBfkI
kN5r/KRTttQ2oO7VBD7Um2aa7C06cJ2TGbUJIKBJAKC+wqDgo7rPjXk3MPfPjhSS
El5f9nokc7/fZ/IMZ149/BBeaKyhEEuA3Fp9dEIfy2obSr1QIdbEH0gfN8PEQJ2L
Hs27jlcVc6ik0OQ7GW5iZDgkIkZC8VGCadRu3edMT9YISL+sYMQHF1VqbZ3/9IQc
g791tyWvg05eP1vg4O14
=uMAt
-----END PGP SIGNATURE-----

--4duuXIeLVqLNCRgn2UfVTAoLsmpupwcJF--
