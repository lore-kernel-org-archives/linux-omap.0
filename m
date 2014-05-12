From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 12 May 2014 17:55:05 +0300
Message-ID: <5370E0C9.8050201@ti.com>
References: <20140507150343.GA9502@atomide.com> <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com> <20140508233300.GI2198@atomide.com> <536C8293.4070506@ti.com> <20140509155504.GE17814@atomide.com> <53707A64.2060203@ti.com> <CABxcv=kwhodeFTHoVpn1nHeh9+kV5fwMN9s3Kbk6h7_xJp4UYA@mail.gmail.com> <53709706.10501@ti.com> <CABxcv=mY0a+yJgmCTPN=BhSQD57Pw022zOd5_KxEgvvF_-=O7Q@mail.gmail.com> <20140512142646.GA31772@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Ujt9mCI21xMm5QlwAq6oCkDSJO5x0DdVH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60177 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758731AbaELOze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 10:55:34 -0400
In-Reply-To: <20140512142646.GA31772@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--Ujt9mCI21xMm5QlwAq6oCkDSJO5x0DdVH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/14 17:26, Tony Lindgren wrote:

>>> The omapdss case is different, there the "omapdss" points to a sw thi=
ng,
>>> it does not describe the hardware. It's only needed as we don't have
>>> proper sw drivers for the devices.
>>>
>>> That said, I think what you describe would work. But I would rather k=
eep
>>> the .dts files clean and correct, and keep that hacks hidden inside t=
he
>>> kernel.
>>>
>>
>> Thanks for the explanation. Since DT are meant to describe hardware
>> and not software I agree with you that we shouldn't leak an
>> implementation detail to the DeviceTrees.
>>
>> And after all fortunately we don't have a stable API in the kernel
>> like the one that is enforced in the DT so we can fix it later ;-)
>=20
> This remapping of compatible flags sounds smelly to me, please discuss
> it first with the device tree people.

It's already in v3.15.

I agree it's smelly, but it smelly only inside the kernel, not visible
anywhere, and we can remove it when we have common panel drivers,
without any modifications to .dts files.

> I think we're better off just using the compatible properties limited
> to the simple-panel.txt for now and actually describe the real
> hardware. The fact that the panel is connected to DSS should be possibl=
e
> to find out based on the phandles.

I'm not sure what you mean. We do describe only the real hardware. The
compatible string in the .dts file is "sharp,ls037v7dw01".

Prepending the "omapdss" to the compatible string is required for the
device/driver matching to work, because we can't use the
"sharp,ls037v7dw01" compatible string in our omap specific panel driver.

I'm not sure what it would give us to try to be compatible with
simple-panel.txt. The simple-panel bindings won't probably be compatible
with the future common display drivers in any case, as the simple-panel
binding is just too limited and doesn't describe the hardware fully.

 Tomi



--Ujt9mCI21xMm5QlwAq6oCkDSJO5x0DdVH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcODJAAoJEPo9qoy8lh71bgkP/Rdv+TTwx5W9V3BmWRNvfdZJ
FlN6/WaYYBjzZqbQtzK/Wpe08ZINIgCZY+Y+g784fiZDPLH3friVwLvtBNodiQF6
e5Z/JNQjZNDGCrJvVv6KGjRcHYP5U0AeYTRuGf1lr+oaJkSWRdh1ThhiWRCl8NHw
WH9xmJKTGZvlTTnhBUdK2Hl9gCMjG2ILdcg8M9toGiXBMA27IyhfeP0KcDHVcKrK
JLDgSENncj/MX7Ug7A1jYGM1R67oas7h3qki9xuIK7AeEngCwei4ppaXz6HGYYm/
WstJfejv6hq3KVUvhqLjcmMNn+HIvDWHbJ956xtiodZ9mhfR21MvwvmncaTMhTgt
iyzbTknNWEPINo0qZn4psZgAu/eWTpgZlQngFbJ8Z69f/ZqSRQFdurzFdFaDyw2o
YjqupZIkC+D7tXHSQt37ovFkR3iECnPEVeMB0JjnBYmLYnmw3O6B2lyPzdRXsOlT
1llaJw0mEPznu4zR12tw1t1UHDFu8S8varkt1S0CflDYFOBcqs7/CMru8vwNtgs2
7wFmtkk2cQBWgxYcHZ9NKSa2QxJnFn3iNUyL7PdcuFtItlRYiFMjcwDJvBuGyiPQ
sW4UJhlToYSMeqVGF4SiMUtm7YAdp3/XWzpMgv6kcx+EqXmOyzYUOxVdo//qkmZ+
C1znj2iJHxd/7MkrL3ZE
=XD6Y
-----END PGP SIGNATURE-----

--Ujt9mCI21xMm5QlwAq6oCkDSJO5x0DdVH--
