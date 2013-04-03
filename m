From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Wed, 3 Apr 2013 16:44:52 +0300
Message-ID: <20130403134452.GD14680@arwen.pp.htv.fi>
References: <5133E268.5010604@gmail.com>
 <51388D64.9000005@gmail.com>
 <513A1580.90303@gmail.com>
 <514863BD.5010503@gmail.com>
 <87620nwmd2.fsf@dell.be.48ers.dk>
 <515C19D7.6080702@gmail.com>
 <20130403120454.GX25837@arwen.pp.htv.fi>
 <515C23D4.3010206@gmail.com>
 <20130403130807.GB14680@arwen.pp.htv.fi>
 <62C108BE-894A-4F1D-BE85-14DB3217120E@dominion.thruhere.net>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <62C108BE-894A-4F1D-BE85-14DB3217120E-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Santhapuri, Damodar" <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 03, 2013 at 03:12:11PM +0200, Koen Kooi wrote:
> > On Wed, Apr 03, 2013 at 02:43:00PM +0200, Daniel Mack wrote:
> >> On 03.04.2013 14:04, Felipe Balbi wrote:
> >>> On Wed, Apr 03, 2013 at 02:00:23PM +0200, Daniel Mack wrote:
> >>=20
> >>>> Felipe, could you explain the background on how the dsps driver is
> >>>> supposed to work in host mode at boot time with the rework of the dr=
iver
> >>>> you did for 3.7? It might just be me not understanding the rationale
> >>>> behind all these changes, but appearantly, I'm not the only one who's
> >>>> affected by that.
> >>>=20
> >>> right, so the idea with that was to drop the huge amount of ifdeferry
> >>> hack from the MUSB driver. It would be great if someone would send
> >>> *CLEAN* patches adding Kconfig-based role choices again.
> >>=20
> >> Are Kconfig-based rules really what we want here after all? Wouldn't
> >> run-time configured settings make much more sense, considering that
> >=20
> > we need both. Say that you want to build a product with MUSB hardwired
> > as host, why would you enable gadget framework ?
> >=20
> > I can think of at least am335x where this would be perfectly plausible
> > (no EHCI available, only MUSB).
>=20
> Nice that you mention am335x, since the beaglebone has 2 MUSB
> controllers: one hardwired as host and one hardwired as slave. So how
> will KConfig options solve that?

you can't be asking this... are you serious ? For beaglebone it won't
help in anything, but beaglebone is nothing but *ONE* user of am335x.

You need to consider a product, what if someone decides to build a
product with am335x but uses either a single port in host-only mode (or
peripheral-only) or, both ports in same mode ?

Will that not help ? Spend 5 minutes thinking harder before sending this
attack emails.

--=20
balbi

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXDJUAAoJEIaOsuA1yqREKuAP/j5g3ZwkQ2xfSj4Y4VcV8v0K
oVrT1DXELB81lX1lcthhN04D1cHtFbkqf+kdeFrKjtEZX99FmKDUUuVZQkdl+wwq
eiiP5XzvXR34tY7TahZ1Pjfbd+ko/tM7p1pI/arL/FQmUPQF2RdgrviXURFV7BAa
jzn9ZopsmHyOZl7zhUv3GNmtQIrcmod27qzny3GUDaGjW8g6oBZq4KoDV1HEQAR1
nmkO6UhHvglLr+sLq/Ow1CPGq4uPiHqU9amHLBTxfCuAg7OcRgxqKhgCQM9ls8i0
t2sbXr9Nxbk/2WpuEm5qAyfUKm/rQCFewqecRdaP+JTfIma630yDSr3dEga99cmv
DcOOOhOPHSptkdxoOzkDyqssoF1OvcvXaBrJa0xUtRJQkWkl6czwsS0KY64T3cw2
pu1pi8goPD+QdV6Z/Q8qvmJV05U0/biTFxsacif/aqBux3yyOxi+85hAkCssp3fs
6wxcMomwxhPHdoVuM1h8W3+6cyifV9PFyEJa6OecuKISrWXtzOV7AH+TN2DvjyVX
rswIKLk8hqQm4MAJ/n2W/TJxzASjxfwuqCgun+jvGQ8DYOnbcPcCYtI2TVblNv0A
sFNRaTEYP8c9MC98F7KtjKXAQYM8eInKYELBE81hBfx8vtbDDX7wo44SOBuMsMTd
8DmkMMdnlkogijZ77H1T
=hwqL
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
