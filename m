From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Wed, 26 Nov 2014 13:02:11 +0200
Message-ID: <5475B333.4010804@ti.com>
References: <cover.1415803064.git.jsarha@ti.com> <20141112222344.GU3815@sirena.org.uk> <54646648.5030807@ti.com> <546DC9A0.8060700@ti.com> <20141121112317.GQ3815@sirena.org.uk> <546F317B.9030004@ti.com> <20141121161435.GS3815@sirena.org.uk> <5472E9D7.7000908@ti.com> <20141124173920.GL7712@sirena.org.uk> <54744B4C.2030105@ti.com> <20141125181020.GJ7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="92BocwDsoc75xCRvPE3SNfuofJwOdGvws"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34060 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbaKZLCU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2014 06:02:20 -0500
In-Reply-To: <20141125181020.GJ7712@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com

--92BocwDsoc75xCRvPE3SNfuofJwOdGvws
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/11/14 20:10, Mark Brown wrote:
> On Tue, Nov 25, 2014 at 11:26:36AM +0200, Tomi Valkeinen wrote:
>> On 24/11/14 19:39, Mark Brown wrote:
>=20
>>>> The whole series is about HDMI audio, not video.
>=20
>>> You know exactly what I mean - the early patches are in drivers/video=
,
>>> don't touch anything outside of that and have no obvious dependencies=
=2E
>=20
>> My point was, there's no particular reason to apply those patches
>> individually. It's an independent series, about HDMI audio, and applyi=
ng
>> only some of the earlier patches does not improve the kernel in visibl=
e
>> manner.
>=20
> Can you please apply them, I'll try to get round to reviewing the audio=

> bits soon but either these will need applying if the rest of it's OK or=

> if there does turn out to be a problem they cut down on the size of the=

> series.  I really do want to read it closely, but hopefully by the
> weekend.

Ok, I've picked the following patches:

OMAPDSS: hdmi.h: Add members to hdmi drvdata for audio implementation
OMAPDSS: hdmi: Add pdev pointer for audio_pdev in HDMI DRV data
OMAPDSS: hdmi: Make hdmi structure public
OMAPDSS: hdmi_wp: Add function for getting audio dma address
OMAPDSS: hdmi4_core: Remove unused hdmi4_audio_get_dma_port()
OMAPDSS: hdmi: Remove most of OMAP[45]_DSS_HDMI_AUDIO ifdefs
OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
OMAPDSS: hdmi5_core: Initialize mandatory sample_order parameter
OMAPDSS: hdmi_wp: Protect reserved bits in hdmi_wp_audio_config_format()

 Tomi



--92BocwDsoc75xCRvPE3SNfuofJwOdGvws
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdbMzAAoJEPo9qoy8lh71kqUQAJh8MwPiz8eWsu3tdfcpvkYC
oU8PIhIrt5kZaA0A3EWnnpfDOEqK1lVkLRGqMQQcE6IEdxQJZejv9CmkctSXJsNT
+dy7gWPRGlfrzidUoktU4NKjJJhSIXAY+CZ6YJfBHUQYm/NPflnYrsn1fHKN3g7R
LYy5+8xB6sb4CeqJHnccflZT/LqCnUd8c9EdWg9A1ckc84MFmFzkYzdUets3bvin
81HP2XJT4CGZhTv+J2E5iQ435AUQK0wsays0QcsodDPFOtZFvvYqW6f1eLbYMRm8
9tIwlCeZbkxh7NTA26SV0mMQ2ua4x299YgifPTtxUMa3GYdH+t7Ljj5+Fmjsj5iQ
U/vfqRkRr0mvFoBvNE4ThRyjAUf5hDhxhfIZ7wtlMN8NXZLiNg3H3ozsKvQACcyx
i7r+mG5W/kgIVRQ9QjHy0eyNvyu0fdXzDiRpBCROmfUiECwmFwTSb48PxwgRif5b
t5rfS/pIWOiLq7Ko+DyFp4HVMwUcxT7E0gENLWkcqgpzyYRhqQGBV8FO+EqI58Oy
CTijKJ0gm4wwcf0wzri+lebp2oimGepOWVsT99tHE2hjENWbE5nK25hnb55o7Q69
lnf9JEZm1VRkij97TMSHy8RTFD0Y1jdfrjLrObNLadjsycp9Iq6DJilPrjR3n3lY
aiLUoKV7b6HSzMzm5/wU
=XQji
-----END PGP SIGNATURE-----

--92BocwDsoc75xCRvPE3SNfuofJwOdGvws--
