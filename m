From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Thu, 20 Nov 2014 12:59:44 +0200
Message-ID: <546DC9A0.8060700@ti.com>
References: <cover.1415803064.git.jsarha@ti.com> <20141112222344.GU3815@sirena.org.uk> <54646648.5030807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="KOm0QGWw94tfVQ6w097nXl6lFc0Hrw5Tp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43234 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbaKTK7x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2014 05:59:53 -0500
In-Reply-To: <54646648.5030807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com

--KOm0QGWw94tfVQ6w097nXl6lFc0Hrw5Tp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On 13/11/14 10:05, Tomi Valkeinen wrote:
> Hi Mark,
>=20
> On 13/11/14 00:23, Mark Brown wrote:
>> On Wed, Nov 12, 2014 at 04:40:51PM +0200, Jyri Sarha wrote:
>>
>>> It would make the most sense to get these in trough fbdev tree. So it=

>>> would be nice to get acked-bys (if the patches are Ok) for ASoC side
>>> changes from appropriate maintainers.
>>
>> So, this is a very large series which gets reposted every so often to =
no
>> apparent interest from the video side, there's been no response at all=

>=20
> Sorry for the lack of communication. We've been discussing this series
> on irc. It's been mostly about how to manage the device/driver split
> between drivers/video/ and sound/ sides.
>=20
>> that I can remember and even the earlier bits of the series before it
>> starts touching audio don't seem to be getting merged.  What's going o=
n
>> here?
>=20
> The series is all audio in terms of functionality. The first few patche=
s
> could probably be merged independently, but I've wanted this whole OMAP=

> HDMI audio rewrite to be in one series.
>=20
> I'll start testing this latest series, and I hope we can merge it for
> the next merge window so that we'll finally get the OMAP HDMI audio wor=
king.
>=20
> I don't have much knowledge of the asoc architecture, so I probably
> can't comment much on the sound/ side design. For me the most important=

> things are that 1) it works 2) I can easily unload/load the modules
> (which was broken in some of the earlier versions).

The series looks good to me, and works for me.

Do you have any comments for the sound/ parts? If not, I can merge this
series via fbdev tree, and for that I'd like your ack on the sound/ patch=
es.

 Tomi



--KOm0QGWw94tfVQ6w097nXl6lFc0Hrw5Tp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUbcmgAAoJEPo9qoy8lh71tSoQAJib29Jg0UfS/a3bbi5Ck4wJ
EIR3qvutuUj7LGemWrAGTwe/lbAuwnTjcgW4uBfY6qEIOTkh5N8VALfKTOla/gei
W7punQ2wDNGrXtN9infG+cBI/WMxk4TZEcrZNVpAD0rWoewwgZfh1v8lcn+wfgHI
t7z2blyyMqWNFFpGF7H5NU4Q5i6xjNXqbSNdWiCHNsOZWDaJVae55UKJcISRKs5z
xLtvG5oeToNLfz00Y11ZqBzRkncf+4hugVegx+o1LR6NWzP0AMu9EEtKAhC6GgHn
f34Rw5Nn5ErVHY2JBS4mNTwUK/5OhoAg3Acb4oEH2ixVtLB6LFvb07759mKP9owP
/2VVJfZMZ9PVdG1aN/2LdPKPt6KmMWp1DFlhjXClFj9Mh+XAfPmphtarq+LtyZQo
4WBYXrn2sGQAczo5pSd4s34cL2PUWkIHlQ0mBCntrBIK9Hy/066BR6UYRJbWMiCf
O2+rai2Dt58gCHp7+IuBBnJMA3Y+Pn1Zj1EcXZrv1zFwxf4Q32cq1d7zB/tFKruD
wU+BOY6fkp8xJM7sH1ZYYj1/5XYIAsYQGy9WGYm9XM2PkJ4j9/+SxMts3BGTmqS4
A+jLwk9E30Oj58WVlBMRZiA76osvRAiq18XILLtPftT4crD7EVDliMMyHstgB7ed
Ivdpi0gtWblT2iPYZh3H
=A7KX
-----END PGP SIGNATURE-----

--KOm0QGWw94tfVQ6w097nXl6lFc0Hrw5Tp--
