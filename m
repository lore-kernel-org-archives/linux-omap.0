From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Fri, 30 Mar 2018 15:07:24 +0200
Message-ID: <a2a7a65c-1794-66c7-0f69-5919d32665fb@wizzup.org>
References: <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe> <20180329163716.GA20743@amd>
 <20180329164113.GR5700@atomide.com> <20180329184007.GA27688@amd>
 <20180329215612.GS5700@atomide.com> <20180330103744.GA17404@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hI0ZG3nfavXOuBdbdh9ms3DoDaBj3w1fc"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330103744.GA17404@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hI0ZG3nfavXOuBdbdh9ms3DoDaBj3w1fc
Content-Type: multipart/mixed; boundary="KsFUvhtn0PoJ53wI6USGpD3sGO1CJsV2E";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Dan Williams <dcbw@redhat.com>
Message-ID: <a2a7a65c-1794-66c7-0f69-5919d32665fb@wizzup.org>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
References: <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe> <20180329163716.GA20743@amd>
 <20180329164113.GR5700@atomide.com> <20180329184007.GA27688@amd>
 <20180329215612.GS5700@atomide.com> <20180330103744.GA17404@amd>
In-Reply-To: <20180330103744.GA17404@amd>

--KsFUvhtn0PoJ53wI6USGpD3sGO1CJsV2E
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 30/03/18 12:37, Pavel Machek wrote:
> On Thu 2018-03-29 14:56:13, Tony Lindgren wrote:
>> * Pavel Machek <pavel@ucw.cz> [180329 18:41]:
>>> Thanks. I got call working including outgoing audio: in capture
>>> settings, right->mic 1, Mic1 + Mic2 in alsamixer -> 100%. But I had
>>> the other phone muted, so I don't yet know if such call would be of
>>> usable quality.
>>
>> Great, good to hear that :)
>=20
> I also got ofonod to work, with rather crazy hacks. But I now have
> incoming/outgoing calls with GUI :-).

Would you mind sharing those hacks - I would like to play around with
ofonod as well. Maybe I can help with a way forward.

Cheers,
Merlijn


--KsFUvhtn0PoJ53wI6USGpD3sGO1CJsV2E--

--hI0ZG3nfavXOuBdbdh9ms3DoDaBj3w1fc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWr42lQAKCRAGN09rynK8
WqIOAPsEJaQgN9irgNhKw3gSFFCWFTUtdRRIZww8B7hKwSil0wD/ftOoBZ/qkCxQ
hjBUIt8wHI2Cppi8doUUm7HOqyDQ6A4=
=0iGc
-----END PGP SIGNATURE-----

--hI0ZG3nfavXOuBdbdh9ms3DoDaBj3w1fc--
