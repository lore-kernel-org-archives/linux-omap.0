From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 02/10] OMAPDSS: HDMI: OMAP4: Remove CEA-861 audio
 infoframe and IEC-60958 enums
Date: Fri, 27 Apr 2012 09:31:34 +0300
Message-ID: <1335508294.1700.4.camel@lappyti>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
	 <1332974305-4578-3-git-send-email-ricardo.neri@ti.com>
	 <1335186769.1535.30.camel@lappy> <4F977185.1060107@ti.com>
	 <4F99F718.2040603@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uJfyNuho7VmVHlaXXjVS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:59067 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751278Ab2D0Gbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 02:31:41 -0400
Received: by lbbgi11 with SMTP id gi11so288916lbb.12
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 23:31:38 -0700 (PDT)
In-Reply-To: <4F99F718.2040603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org


--=-uJfyNuho7VmVHlaXXjVS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-04-26 at 20:32 -0500, Ricardo Neri wrote:
> On 04/24/2012 10:37 PM, Ricardo Neri wrote:

> >> Are the defines left in the hdmi_audio_i2s_config something that are I=
P
> >> specific? Are they even used? I'm just wondering why many of the defin=
es
> >> are in sound headers, but some are left here.
> > Some are specific to the OMAP4 HDMI IP, such as HDMI_AUDIO_I2S_SDx_EN.
> > Some others refer to generic I2S concepts (such as
> > I2S_SCK_EDGE_FALLING/RISING) but defines are used to configure register=
s
> > and such configuration may be different in other hardware. The defines
> > that this patch removes are values that are effectively transmitted to
> > the sink and are clearly defined in the relevant standards. Anyways, I
> > will look at it further to see if some of them can be removed as well.
> > Also, the I2S is the same for most of the supported use-cases, if not
> > all of them. Maybe I can remove the unused ones.
>=20
> I took at a second look at the hdmi_audio_i2s_config. As they are used=
=20
> to set IP-specific registers, I think they should be kept. Regarding the=
=20
> unused defines, they are not too many, do not do harm and let you know=
=20
> what other config values are available. I would like to keep them. What=
=20
> do you think?

Sounds ok to me. I was just worried that there could be some kind of
mixup as only parts of the hdmi_audio_i2s_config were removed. But if
the rest are IP specific, I think it's fine.

 Tomi


--=-uJfyNuho7VmVHlaXXjVS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPmj1AAAoJEPo9qoy8lh71mOgP/0VJttJqyCb9sIA9tl6H7AVj
94cP4xo3AH/CnIQFnRyezp1jXGF133nonMlJAkmafuYK7pW04Q8IyNNRZKL/8LzN
AuUKAqVEUV1p/r6P+fImE1rU+blWYlPlRjJEKWdnzRvnJ/qeYxgYTGsYTHgVzEBc
fkSNxQDZHEasiiYMcnNcBLlqlmU3HDxk8Xr8e0GDpc1P5HKsBqU4vKy++Q/qrfNz
Wg4125V++P2GpR6j3UnVKxAGiu/ZbA2jwNluU3aPA5JCZFGVwMYauAnhLiN1FNMt
TRQ4uC9nYGZfpz3wJFlcX1Hhu4FoTRehFSU3qlG+R9C9gZB/olyOc7lPnGzumB1W
JU5qS1Gel94MwwRnwoXsl/ASWriwj+nzgODdnXxq7ChBPgoyzi8FIqGB91l3dNfE
mXvR6N+kPm6AvtczWUcwbwNC6mZTdKWhzyri4paFCups/JyMfDCSQlACpcnDErFh
t8YJ/psBPR17XR3pclndDWoUgaDAhHKiDsNeeONx558C8LoNNGQZH3mDP5lWcnAT
I/GsvESP9A+gnR8X4BQHsTPJvxkt+BBPBEECQQyMcDY/EU9+1icNRGV3sKRPOoyG
Pj1moT2ak6GIFDo87waGl8ctvDC3kK43H8MLMcQuMJAU1AXeUX2VBiqWIeigRUyx
xuunXGSSteZglDS+ZOjz
=3HCe
-----END PGP SIGNATURE-----

--=-uJfyNuho7VmVHlaXXjVS--

