From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 7 Aug 2012 12:14:16 +0300
Message-ID: <20120807091415.GN8468@arwen.pp.htv.fi>
References: <cover.1343912532.git.cmahapatra@ti.com>
 <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
 <20120807084815.GK8468@arwen.pp.htv.fi>
 <1344330329.4091.16.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Y142/9l9nQlBiaj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:40131 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750978Ab2HGJSD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 05:18:03 -0400
Received: by lagp5 with SMTP id p5so122604lag.23
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 02:17:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344330329.4091.16.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: balbi@ti.com, Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--4Y142/9l9nQlBiaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2012 at 12:05:29PM +0300, Tomi Valkeinen wrote:
> On Tue, 2012-08-07 at 11:48 +0300, Felipe Balbi wrote:
>=20
> > you're not really removing. You're moving cpu_is_* somewhere else. A
> > better approach, IMHO, would be to use the DSS_REVISION register to
> > differentiate the DSS IP itself, not the OMAP.
>=20
> Unfortunately we can't, DSS_REVISION contains bogus information.
>=20
> I didn't look at these patches yet, but the idea has been to move the
> cpu_is_* checks to only a few central places, not scattered all over.
>=20
> At some point we could perhaps either move the cpu_is_ check code to
> somewhere under arch/arm, or, more probably, create our own DSS version
> IDs which are found out via cpu_is or soc_is or such.

Or you could use the driver_data field on the platform_device_id and
of_device_id structures for that. Something like:

static const struct platform_device_id dss_id_table[] __initconst =3D {
{
	{ "omap2-dss", omap2_dss_features },
	{ "omap3-dss", omap3_dss_features },
	{ "omap4-dss", omap4_dss_features },
	{ "omap5-dss", omap5_dss_features },
	{} /* Terminating entry */
};

then, on your probe, you just need to copy id->driver_data to your own
structures so you can reference them later. No need for cpu_is_* or
soc_is_* or machine_is_* anywhere.

On your platform_code, wherever you create the dss device, you need to
fix up the name though. The platform_device name should match
platform_device_id name, not platform_driver name.

--=20
balbi

--4Y142/9l9nQlBiaj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQINxnAAoJEIaOsuA1yqRE1mMQAJvHFuqTUO5/vGal5Ca2smzh
LTnVITaIebnSfJZxNQvADXG08v4bmnZKP8tB31GdxXCcRf/EAcoZDev2xHRLR1fN
ynLCFZG3rkrSglCEUrmUeGfILoAEnrONI42wxxxaZmZXP0jisI0pIS4B8YVbj18k
1BSnB/ah9fkyZKypkCMkwc4O+UgfShkHF7Tamheo5YK62YjCSWaU8pekdAbtvH4s
7aLz0S2V5QbQNdcIOaURem8BpHxjDOSpbEYTp48mK0sgkXjSD2foWh29QTUQaRt9
Snpq6UUQoqvQBIsUgOweh0Kz54D1VFh75+vr72vUSOAj164M7TLzM2vtlh5IdPqN
OzRY+gc2Cg/hoj6Xz/KE4WTHrl0yfe5ri4+85Fcw0HstocWRQP/fBQG7BnjX9+4m
2ReTmzREQDl5UV01a5yJHx+0B1a2x0iNMzOnTWzcETQna8LRFFQZMTXjoqTyvO0g
8ENm5lRxPK87NkKJI250lrjSWYjG5Cd+ags1JWSOArepkGTZnx5c19W2cc9AB72+
+ZKR3XOP3DXXoJKrlhLbZzmJyw85IS3vsOQNHm1C6rh6uVG+YKr5AWYVUEhcSkxW
tsE4kwysVFCqC3jQAOmw46nXG4gOYHjvqIhNKSDgmq12R3LmcTv9CJvFe2dSpZDn
s87qLvH0Fd+SvFpsfc57
=ZLdW
-----END PGP SIGNATURE-----

--4Y142/9l9nQlBiaj--
