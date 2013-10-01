From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 5/5] usb: musb: dsps: add support for suspend and
 resume
Date: Tue, 1 Oct 2013 11:03:36 -0500
Message-ID: <20131001160336.GA1476@radagast>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com>
 <1380634797-29541-6-git-send-email-zonque@gmail.com>
 <20131001145919.GZ1476@radagast>
 <524AE464.3020201@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o5hfEDzsoqw8wJwC"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <524AE464.3020201-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--o5hfEDzsoqw8wJwC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 05:04:04PM +0200, Daniel Mack wrote:
> On 01.10.2013 16:59, Felipe Balbi wrote:
> > On Tue, Oct 01, 2013 at 03:39:57PM +0200, Daniel Mack wrote:
> >> The dsps platform needs to save save some registers at suspend time and
> >> restore them after resume. This patch adds a struct for these register=
s,
> >> and also lets the musb core know that the core registers need to be
> >> saved as well.
> >>
> >> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >=20
> > this last patch didn't apply. can you rebase on my 'testing' branch ?
>=20
> I've seen that you already applied the others, so I'm going to resend
> only that last one. Hope that's ok.

That's perfectly fine ;-) Thanks

--=20
balbi

--o5hfEDzsoqw8wJwC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSSvJYAAoJEIaOsuA1yqRE3U0P/1Oj681SSP7myWvsiB/lIbJR
YFocH/F/HIDraBPP6cA4oaG7MCwUFS0s/Won7JFW+4pNXMn8jqIABQuCQx1Weo1n
HkFeLPMIWljJ325symCTgkHGDDIWY9khfMvFPi9biaD3XibqHBswCelRc1Vi2i0y
cayyy+lksRrCb5+U5YkaVxRrCg7TEdLaqKTICE3vpEf6a82/KQPAqP1FT3vyZQ4R
YjBS3xidcCUVe8jxWxpJpI9cNBO+3RvM/RjnQDZb1zaAjbO+SiaWhiHCygV+NrC0
otL5+TWwbZqp5JdI+GfzkamslsZneuGex0FawJyZG+4Lo3pVALnMoDBGjE//yZ6F
EdMfAm033OJYELBrUVZNokJRXReU1no5pPlUsEByQBItibwn9/IPSdesrlGkdGEF
0U6B4rLkgQIct5/II6TJdNfJKiTbyw/Z4JFUnlMHC6+cE4s0xUki1wV0dCafWpxy
i33tlsxkMVLjVGlt5uJ1KnQBmzvfCtayPbJ1TwIv29roBxAke7IZHzNM/qKP0OJQ
DR6008QHgIJd4g6SQ1peZKDKXZ+cQ/TX1nwyFayo+Fr5eFnT5T2xn9zw1HiWH/Cw
rsSqjT1Xq85prVuOnp9hOIn6O1t2B//uXRCr5pKdWC6FhmvDZRamLm3cp5IgmkoS
5CzEOH2IJTnuZr6zMPTM
=9M7t
-----END PGP SIGNATURE-----

--o5hfEDzsoqw8wJwC--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
