From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH] omapfb: setting GOLCD bit for shadow registers to make
	effect
Date: Tue, 9 Sep 2008 15:35:49 +0300
Message-ID: <20080909123549.GL31563@intune.research.nokia.com>
References: <c656a4d20809080219q545ccff3v13221d2287f6de30@mail.gmail.com> <yw1xtzcq76dr.fsf@thrashbarg.mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40359 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbYIIMfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 08:35:55 -0400
Content-Disposition: inline
In-Reply-To: <yw1xtzcq76dr.fsf@thrashbarg.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: linux-omap@vger.kernel.org


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2008 at 09:02:56PM +0100, ext M=E5ns Rullg=E5rd wrote:
> "arun c" <arunedarath@mistralsolutions.com> writes:
> > +	while (dispc_read_reg(DISPC_CONTROL) & (1 << 5))
> > +		continue;
> > +	MOD_REG_FLD(DISPC_CONTROL, 1 << 5, 1 << 5);
> > +
> >  	return height * screen_width * bpp / 8;
> >  }
>=20
> This looks good.  However, the same thing is needed in
> omap_dispc_enable_plane() as well.  Placing the loop+set in a function
> (go_lcd()?) would make sense.

Preferably something with a slightly more generic name, so it could
also fire GODIGITAL for digital out, when support for that exists.

Cheers,
Daniel

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjGbaUACgkQ68xJuWtYYdX+ngCeJIqWCy8XkhrpWQjVEB/ikZ42
DqwAoIUDFacua3AGLCqwBggOBCnRD2Ny
=TWhc
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--
