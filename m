From: Felipe Balbi <balbi@ti.com>
Subject: Re: musb-hdrc: "Vbus off, timeout 1100 msec" message does not belong
 in sysfs
Date: Mon, 13 Jul 2015 15:30:28 -0500
Message-ID: <20150713203014.GB32682@saruman.tx.rr.com>
References: <20150709213922.GA32698@amd>
 <20150709214610.GA20890@amd>
 <559F7193.7090508@linutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <559F7193.7090508@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>, balbi@ti.com, tony@atomide.com, varkabhadram@gmail.com, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 09:17:39AM +0200, Sebastian Andrzej Siewior wrote:
> On 07/09/2015 11:46 PM, Pavel Machek wrote:
> > On Thu 2015-07-09 23:39:22, Pavel Machek wrote:
> >> Hi!
>=20
> Hi,
>=20
> >>
> >> sysfs should contain one value per file. This one has at least two,
> >> with nice english sentence as a bonus.
> >>
> >> root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-=
hdrc.0.auto#
> >> cat vbus
> >> Vbus off, timeout 1100 msec
> >>
> >> :-(.
> >=20
> > Plus, documentation for this is nowhere to be seen:
> >=20
> > pavel@amd:/data/l/linux-n900$ grep -ri musb Documentation/ABI/
> > pavel@amd:/data/l/linux-n900$
>=20
> that is a shame indeed. It is part of the driver since TUSB support was
> merged via commit 550a7375f ("USB: Add MUSB and TUSB support") about 7
> years ago.
> The parameter expects the timeout values which is used to poll the port
> for mode changes (host/device mode) since it can not be detected on its
> own.
> Felipe knows best if it is better to document it or remove it. I can't
> remember that I needed it on am335x.

N900's usersland relies on it, IIRC. But it could be that it was used
just for testing. I'm not entirely sure.

--=20
balbi

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVpB/kAAoJEIaOsuA1yqREiuwP/jGeIFTUre3uZwHrEnsmpzkr
aEIZU6pWRVe5k7Ca8xx1DEc6LRTcibiOeDRLD9EuluWrXb2Licq4RL8RiEnXuDDi
vE1XLpxjr0/FdjzZGE+Is5upxCkDSd/RNJU57BFiA0O2ueNIMpzr4H7Yu38hn99c
YRAP19L/MRaFJExXn7JkzFpFyusYGFM3VpDPIQweCoV40nkhGTQOz9ONQw6XUg5W
+d5RHtswpT7kIzxUx8uivD0Tj0XX9FHACU81oyxDwc6jelFH1yVCtNZUpYidQ6dD
rt5xE3/Miq1+01cAAln0yWrb5P1XfRmvZ9szgRI2dB2pEsv077W/I7EreGUAQEH7
USSiJUx09ZankzlXz5JQEAsmE50e6aiGhinazG3KhB818Q2VXgYZmmW2KVGl+wcH
MFpoAyB2sieFT7Yc+HqMNYA87G28M8gETUenVYXeG9MZ1QYW6c0DoeJBwYq3Qkxj
gkFIdxCivyeW1Thxt9H4UpEc5z/Rcr1AQAfyzpx/O5VAaji7HtqbinJMhfmgCOqU
+iTFAW3KC/4TaUq60o9BaVZlh6RtNYZyS6/wJJbPkGIU/q0BJ+L5PlZHPmeHZw05
CPs0rtJphFBVuGXGjmd/A6pkLaLx6kfox0zdFz1nrP1dV1ao3/CCC/nGyfyaSc1J
ASbj0A373us9L+WbsZ5a
=9Kkp
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
