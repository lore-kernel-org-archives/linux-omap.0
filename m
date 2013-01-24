From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: make wakeupgen_lock raw
Date: Thu, 24 Jan 2013 20:22:33 +0200
Message-ID: <20130124182159.GL4424@arwen.pp.htv.fi>
References: <1354891787-24119-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UUMz/kfoogzZ9WLZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42800 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932Ab3AXSW6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 13:22:58 -0500
Content-Disposition: inline
In-Reply-To: <1354891787-24119-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>

--UUMz/kfoogzZ9WLZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 07, 2012 at 04:49:47PM +0200, Felipe Balbi wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>=20
> When applying RT patch on top of Linux, spinlocks are
> implemented as RT-mutexes, which means they are preemptable.
>=20
> Current GIC implementation on OMAP is using a spinlock
> to protect against preemption. As it turns out, we need
> to convert that lock into a raw_spinlock so that OMAP's
> interrupt controller works as expected after RT-patch
> is applied.
>=20
> This patch is simply to decrease the amount of changes
> RT-team needs to carry out of tree. It doesn't cause any
> changes in behavior.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

ping

--=20
balbi

--UUMz/kfoogzZ9WLZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRAXvpAAoJEIaOsuA1yqREQ/8P+wZ1K04yH5X2scriP6XBHdT9
oV5z/p3mre+abUR5e/+ecbiZMaoW3lZHZsjcc+T3IEw2KoUK12jaZng/zVtwPdDO
tFYQLC1XygdgHhjf9bQzd5ptNd/Ui5cM2fJGFj2vru0xRP3Ylr/pXgcMocahR9qf
q7ToN82tSmdGmNugny1RH6jZoPPdVFwXHwttHvHzKfNJJo+ChKdKV7eKWWjyhqLx
KR8MBcDl97eSuVE63FFu6o0G0bb9XapWNcS2hkCHQ173c5XfsBHrhmubIs88dG9J
lzD7d0reLIPYTSK5wAiTibg22lkdyJEhJRpoEdByHlIx6bjLr/mb/axHO7yC2Pdf
avQkdMBKlRTX7IPpsEq33dUw8WpLka6zdmp6ngpjQSJ7c6LfC/nEl3lu++Nwrel+
Ly33vk/C5rBVKxtsxj5JEyJa46inyHLbVtLhg3ZNto0WQXvQCd+Hq/xt1pjAtPzn
xUqHqcIvhGMru8VVM3w3aXYti/43GbjVLsB5fSuHAm1IMLlp1oXbJZJCMl4KYCK0
LW63c7lbJcM30gkXDbVzD7y/KrB8kmTmv9T50n5mNqUoKC5bbLHeIb3836d+jZor
P8MofuS+qkxsAy/rkYr1cOnlByXYzvfYC9DsOB+us+Zjr3tcPY1URbvhC9funASF
H2g+FERV23bUL7sL3hed
=101W
-----END PGP SIGNATURE-----

--UUMz/kfoogzZ9WLZ--
