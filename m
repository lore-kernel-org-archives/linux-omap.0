From: Felipe Balbi <balbi@ti.com>
Subject: Re: New l3-noc error with CPUFREQ_DT built-in with v4.0-rc1
Date: Mon, 23 Feb 2015 20:24:33 -0600
Message-ID: <20150224022433.GB5198@saruman.tx.rr.com>
References: <20150223235947.GC25954@atomide.com>
 <20150224015903.GP32521@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59853 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbbBXCZ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 21:25:26 -0500
Content-Disposition: inline
In-Reply-To: <20150224015903.GP32521@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 23, 2015 at 05:59:04PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150223 16:09]:
> > Hi Nishanth,
> >=20
> > Olof told me about a new L3 error happening on omap5-uevm with
> > v4.0-rc1:
> >=20
> > WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_ha=
ndler+0x214/0x340()
> > 4000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle): Data Acce=
ss in Supervisor mode during Functional access
> > ...
> >=20
> > I tried bisecting this with no luck, but narrowed it down to
> > having CONFIG_CPUFREQ_DT=3Dy causing it, while =3Dm wont' trigger
> > it. This got changed by commit 40d1746d2eee ("ARM:
> > omap2plus_defconfig: use CONFIG_CPUFREQ_DT").
> >=20
> > Any ideas?
>=20
> Hmm so setting CONFIG_CPUFREQ_DT=3Dm in arch/arm/configs/omap2plus_defcon=
fig
> produces the same output with make omap2plus_defconfig as with =3Dy.. So
> CPUFREQ_DT can't be the real cause of the problem.
>=20
> It's now looking like the l3-noc warning does not get triggered on
> every boot.
>=20
> It also seems the zImage triggering the error does not trigger the
> error on every boot. To trigger the error, it seems the device needs to
> be powered down for at least 10 or so seconds between the boots.
> So far no luck reproducing the error on v3.19.
>=20
> The easy way to reproduce is to power down omap5 for at least 10 seconds,
> make omap2lus_defconfig on v4.0-rc1 and boot it.
>=20
> And so far it looks like next-20150204 works and next-20150209
> failed at once so far. But of course I would not trust anything
> at this point :)

got a log of the failure ? Is it pointing to a device or one of the L4s?

Might be worth to boot with just the bare minimum (UART & timers) and
disable everything else. You might need to build busybox and append that
to the kernel so you don't need to rely on MMC/USB/etc for rootfs.

After that, you could start enabling modules one by one (as modules, not
built-in) and loading them one by one to see which one causes the
failure. Big PITA, I know, but I can't think of any other way to go
about this.

--=20
balbi

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU6+DhAAoJEIaOsuA1yqRERWQP/2pZkmiku5nmZmCrJNSfvHGG
q/1NCg8/hwAjzMDT5nHqlPNvAb1ziPIpSENXYnkmuTlSdoenYeAkXD5vPr9ne95H
q2sfsfXs0A3rww5mCEqlwtf8qsa6X8wbbbOuSb3tElVteNtdPPT//LXs5DDcMeeB
SUv/HGtFJbpZw7yf44+VBrhFaEt+uubIaG9GBtr8OGKPYOSRZKe0UOJ2wiWflJZb
Ogulpfiz9C4svv2AZcvYjyhedvo8MLS3BJYm2XHKbgZOlwd1dBEp4o6F3S1c7hON
QNC6iR9pMUcPhukvukCmtiX6pdvBjPZ6W302Ux6AR3owHAEX950xbBWzP350rodw
D9yZ4h3HqJN2jFOcErRkSZEiWLlDF4O4LxYtIcFoKjqERw0/QkVKltxvOykId4CH
ObAFw9qujndpCDF3Y0ZYqZWMFmwmQD/6Tgm/Zrud2FQIMZFg25lGOOghM1XJ7NPC
9DGmtQRbPU6Y1LcMdkLb5hh255FZ9tBmeRHCsu8OhrxTaZDKEmic581myx/ZIxeJ
p8r56ofDYZoeZlSj2kkYW7vK4NWOBwAGnhK8ftcvMGzNxwOKHGq2jx6qIH2IF3yw
drYVkn6vvtLDU6EQpwkbiy7eZW7ftitHyI+2CMcJxXfWFns85vPBN26yHwis6RnP
iN9jeukhz99petKNnKLo
=2/yu
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
