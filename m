From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] mfd: omap: fix the crash during omap ehci or ohci driver
 initialization
Date: Mon, 20 Jun 2011 16:28:52 +0300
Message-ID: <20110620132851.GJ14262@legolas.emea.dhcp.ti.com>
References: <1307367739-20110-1-git-send-email-keshava_mgowda@ti.com>
 <20110620132626.GJ22420@sortiz-mobl>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="++alDQ2ROsODg1x+"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110620132626.GJ22420@sortiz-mobl>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--++alDQ2ROsODg1x+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 20, 2011 at 03:26:26PM +0200, Samuel Ortiz wrote:
> On Mon, Jun 06, 2011 at 07:12:19PM +0530, Keshava Munegowda wrote:
> > From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
> >=20
> > Oops are produced during initialization of ehci and ohci
> > drivers. This is because the run time pm apis are used by
> > the driver but the corresponding hwmod structures and
> > initialization is not merged.=20
> You mean they're currently checked in a different tree ? Is that a
> public one?

it was supposed to go via linux-omap tree but the patches got lost in
the limbo :-(

--=20
balbi

--++alDQ2ROsODg1x+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN/0sTAAoJEAv8Txj19kN1cowH/2ukogGk7X4iTCZUcyrazn/d
CwSFIMKdC6/nXoIUjXpNiBwzF4ws6aR5r+MnBG4zKT5sz7Zxq50lHC/sHHyYMMkM
/MDwMPRs7aOZDgJGLtQrh7JAvmzDDp+RC/hhQKPPXz+ESiAfCBQJDk5IZm+f9ILT
sin4VpRSxd13aRfvd6q6RpaY+g8wlb5A1U5Q//jRLDOzrVt/n87ry/B7zxYOm5uq
SML0NTDXVJ6LC6VkYKu1RTAzvUuW8U+aP3b3qJujveftHAfVJ9ceHOhLPCW2orUW
yF2lcDjqMd/Ndt1LJGLMeic+0NDuWagvn0aZHWxkFNCLp2hQIts3YO1zQh4CMoA=
=XcKM
-----END PGP SIGNATURE-----

--++alDQ2ROsODg1x+--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
