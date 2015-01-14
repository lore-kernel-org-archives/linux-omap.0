From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 6/7] ARM: OMAP2+: Fix reboot for 81xx
Date: Wed, 14 Jan 2015 13:30:09 -0600
Message-ID: <20150114193009.GP16533@saruman>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
 <1421190837-4692-7-git-send-email-tony@atomide.com>
 <20150114012447.GF18523@saruman>
 <20150114190419.GO2419@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fTD7sGci972winw4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42597 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbbANTbP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2015 14:31:15 -0500
Content-Disposition: inline
In-Reply-To: <20150114190419.GO2419@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

--fTD7sGci972winw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 11:04:19AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150113 17:28]:
> > On Tue, Jan 13, 2015 at 03:13:56PM -0800, Tony Lindgren wrote:
> > > +
> > > +#define TI81XX_PRM_DEVICE_RSTCTRL	0x00a0
> > > +#define TI81XX_GLOBAL_RST_COLD		BIT(1)
> > > +
> > > +/**
> > > + * ti81xx_restart - trigger a software restart of the SoC
> > > + * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
> > > + * @cmd: passed from the userspace program rebooting the system (if =
provided)
> > > + *
> > > + * Resets the SoC.  For @cmd, see the 'reboot' syscall in
> > > + * kernel/sys.c.  No return value.
> > > + */
> > > +void ti81xx_restart(enum reboot_mode mode, const char *cmd)
> > > +{
> > > +	omap2_prm_set_mod_reg_bits(TI81XX_GLOBAL_RST_COLD, 0,
> > > +				   TI81XX_PRM_DEVICE_RSTCTRL);
> >=20
> > do you need to check that mode =3D=3D REBOOT_COLD here ?
>=20
> Looks like not, trying to use the warm reset bit does not seem to do
> anything and probably requires manually resetting clocks into bypass
> mode or something.
>=20
> I'll just add a comment about that.

alright, in that case:

Reviewed-by: Felipe Balbi <balbi@ti.com>

:-)

--=20
balbi

--fTD7sGci972winw4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtsPBAAoJEIaOsuA1yqREXhIP+wbprhb6bJzwKsmYLonXlTQH
uQ9J6EPaO5iBcyPgLU4fJ8sfYGgHuNDQtA2cuCEi2OwOwxUdjKtYwi8FQcRqe111
VA7anCf4rK1b54+wvM+y13W2NjYUvU9DO7Q4f0nvPrGp/1vy+LfbsfV6NNjMYngZ
eHoWj15HQCBVSj4F9BKMrW6Z5wpAwbI9FPglGlebn0tSEW8n3yWP9BGzS0bzcF5i
9tLU/hoIEhpnIe6Rt9KJComsu4kagpmjs3FSrQZbZNgLdm42taBTLuv2i1nXSPF7
8ZPMQeiEsUlweee9gv4ppCQT7bHIPDkLehgArWWDhdS5d3SH55rz73S8VUfLwiDk
udgTqw/Zw7RI6KuunjG+E0Wm/lNFrjtgIjvYprifMtyv4h/S/sQgYdoP8B1TpHvq
+tUjg1P+yg68HFQO5IaMzJR0AUXxsfV3ElDG/+ArtYns1Elr6sPIMFdypw4oxZiy
68FrH+gU//u4EdJtdc+97+woNAU9Zbr+4IL6CV+jeBPeRiWS1V5/WM6zxmd4v5tT
YxpdBic7ZywKR1+yJqFID4j+VRHoMWTv8b3o/6i0GnhBXzw5+WcLmX06qDYHurw+
+czAiFnj96/MvGJdH68gZhYIGGEOdBgbZG55cx+dfir83Kpn8t7od0iFJvfkAwN7
2SRySMy7JgvzhRZ4tYhZ
=DsTo
-----END PGP SIGNATURE-----

--fTD7sGci972winw4--
