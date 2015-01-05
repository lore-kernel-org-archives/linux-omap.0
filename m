From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V4] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
Date: Mon, 5 Jan 2015 11:45:33 -0600
Message-ID: <20150105174533.GL19336@saruman>
References: <1420475549-28492-1-git-send-email-nm@ti.com>
 <20150105172737.GK19336@saruman>
 <54AACAFE.7050609@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L1EIGrW/+75u5Nmw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39501 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbbAERqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2015 12:46:37 -0500
Content-Disposition: inline
In-Reply-To: <54AACAFE.7050609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, sre@kernel.org

--L1EIGrW/+75u5Nmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2015 at 11:33:50AM -0600, Nishanth Menon wrote:
> On 01/05/2015 11:27 AM, Felipe Balbi wrote:
> > On Mon, Jan 05, 2015 at 10:32:29AM -0600, Nishanth Menon wrote:
> >> TPS gpio now controls a 5v 500mA TL5209 regulator which may be supply
> >> a fan (such as AFB02505HHB) over J1 connector for various purposes.
> >> Provide device tree node to enable the same.
> >>
> >> Signed-off-by: Nishanth Menon <nm@ti.com>
> >> ---
> >> V4: Change format of the speed-map used.
> >> V3: https://patchwork.kernel.org/patch/5562121/
> >> V2: https://patchwork.kernel.org/patch/5445111/
> >> V1: https://patchwork.kernel.org/patch/5444911/
> >>
> >> Enable and disable can be controlled by (post the RPM, it finds
> >> closest match - even a 1 will do)
> >>
> >> echo '13000' > /sys/class/hwmon/hwmon0/fan1_target
> >> and
> >> echo '0' > /sys/class/hwmon/hwmon0/fan1_target
> >>
> >> Test log: http://slexy.org/view/s2T0ajh46z
> >>
> >> requires CONFIG_GPIO_PALMAS and CONFIG_SENSORS_GPIO_FAN to be operatio=
nal
> >=20
> > oh, perhaps add these as modules to omap2plus_defconfig ?
> >=20
>=20
> In a different patch I suppose if Tony wants it that way.

right, different patch :-)

--=20
balbi

--L1EIGrW/+75u5Nmw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUqs29AAoJEIaOsuA1yqREQUEP/jyT0lyDVTONa1EoYyE74kEU
lo8GGXjzRuNTTRM42388uryBOxg0ui0eLyqhLvUo4WYNgmjZRvgskDjgvOD80uCR
XirSUainPX0Crg4I0AC686IWRCA6JnmP2K+GzVqPvZFqv7ad+2uSLqob6tE1qhs7
8B//LHtbmzWKbwlmMBoNENsbEr6SSEMhcuWjKIuOa+cH29tq6v2lxp1qmHcf2dBk
RFUOhaBNLcO10BHCNl8kndwePzn6c483ErzOo4VDsd8YOSvUqxoTTwUOUGOT79yq
zq0xLECkUKRciIbVsSQQ2dcYJ5nZwn80TG6oG8SWZ5Fvdsj1Q5sUeFk4/NX4GJ6c
8KwAW+Lo2OeZ9bLPsChAA4hzHy3ndERPZ/67Q6SR+bQ6I0opeWXoJrXPgx3K9XuG
xUeZV93zWYFN9uHcl8nW/4lFSZZP3yXd33qJ2LAgEx3fGzmO4awd6AEhqbasJr/4
DZZXEXxo71KAxPPixiMmG/BeppwdnuUGzA//8YSlcjHDLiXJAGorRR4MvXvfT61J
RQ1TVxNOPCJqjpCROrKQpGrPi3/dRNYyZ1dmHrfyKSdpN5DWXOep2gtKsYRBBZ6E
5ya52hVJvtDicEBwoX+BkU4kjwv7ukRvTbrmHHTw2bLhedrwEvBLPlgVUUO/4MJP
iABvYFqPw10msyi6fMfh
=UdJx
-----END PGP SIGNATURE-----

--L1EIGrW/+75u5Nmw--
