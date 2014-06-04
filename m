From: Mark Brown <broonie@kernel.org>
Subject: Re: mainline boot: 37 passed 4 failed
 (mainline/v3.15-rc8-4569-g3de0ef8)
Date: Wed, 4 Jun 2014 10:01:11 +0100
Message-ID: <20140604090111.GE2520@sirena.org.uk>
References: <538e6a20.0168440a.7895.422b@mx.google.com>
 <CAOesGMg4ESoPVvCc4is7wpA8PVOOSDzh5=VZZ67NnJjD3jUzmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52835 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbaFDJBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2014 05:01:45 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMg4ESoPVvCc4is7wpA8PVOOSDzh5=VZZ67NnJjD3jUzmw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Kevin Hilman <khilman@linaro.org>, kernel-build-reports@lists.linaro.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2014 at 06:26:14PM -0700, Olof Johansson wrote:
> On Tue, Jun 3, 2014 at 5:36 PM, Olof's autobooter <build@lixom.net> wrote:

> > [    2.816920] smps9: failed to get the current voltage

> This seems to be from palmas registration failing, which in turns
> causes vmmc regulator lookup to fail. See the errors about palmas-pmic
> above.

Always CC maintainers on things.  This is a bug in the driver, it needs
to support retrieving voltages at all times (and would probably run into
trouble anyway).

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjuBOAAoJELSic+t+oim9XpIP/1arsqKLGJwlL2Jd6SV7gdCK
uGBfeb1GBAZzokFlXl48Xq26K3RbAC1Xd4awC52lAkNE2SD9oXNQSBVSMeLoYJ+9
leGvuEkI6SbYF8sKo6pxX830vdiOQHGMuJAoxr5vhh7hN03seS8LkY6hdaNkYH/d
ixedtaYRCH97Prybv9FPQxjvGF/speakZsKpCQVk+Q91WFlRVgTs2iuyca2jvj1w
UmnPg0EwRovzw07ll0p/j4yuh7r3UoZcdtj7aBF1tFHi0fjJMpbgwqpNn6uSdN+z
SjpBon0J9tKKTeolGujFrH5XP8gMTp7NOwzOvZLBWqo6IfSQtNu4OSgnf3QSzyix
g+cmDGIZxhr7+Q7rE7lTL7wbQ9c1Z2f6UAdOq1NwchBl98S5X4RTz3TsOcTx02HH
xHQTQsbeMcKODRM67t3ot5oGcoOr7ei3xm0sYslTONo468vE/Vs0NuBJJK2RaytN
3poiXeubLxWi6PBnzVdFEscehq48qPFGHJz6e3DqRRaO7bz02an7wTsPM+hr+7Nv
zfNmpye6DvPUID7FSLAmn/l1peEsqfK0vz8N8X3wG+vSQgzcOPBIZ8vW3UkChJth
Xe6WhpqOZV4zZAl1NRdlnldfmbLxd2b+Qysp7OjZgDafJKT3RxpoOwxjxT0ktWeP
aN+337VOKJGTiCq/9hpZ
=15Xr
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
