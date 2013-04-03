From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Wed, 3 Apr 2013 16:46:12 +0300
Message-ID: <20130403134612.GE14680@arwen.pp.htv.fi>
References: <51388D64.9000005@gmail.com>
 <513A1580.90303@gmail.com>
 <514863BD.5010503@gmail.com>
 <87620nwmd2.fsf@dell.be.48ers.dk>
 <515C19D7.6080702@gmail.com>
 <20130403120454.GX25837@arwen.pp.htv.fi>
 <515C23D4.3010206@gmail.com>
 <20130403130807.GB14680@arwen.pp.htv.fi>
 <62C108BE-894A-4F1D-BE85-14DB3217120E@dominion.thruhere.net>
 <515C2B95.7050408@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38179 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759699Ab3DCNql (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Apr 2013 09:46:41 -0400
Content-Disposition: inline
In-Reply-To: <515C2B95.7050408@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, balbi@ti.com, Peter Korsgaard <jacmet@sunsite.dk>, "Mohammed, Afzal" <afzal@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Santhapuri, Damodar" <damodar.santhapuri@ti.com>, "B, Ravi" <ravibabu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>

--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 03, 2013 at 03:16:05PM +0200, Daniel Mack wrote:
> On 03.04.2013 15:12, Koen Kooi wrote:
> >=20
> > Op 3 apr. 2013, om 15:09 heeft Felipe Balbi <balbi@ti.com> het
> > volgende geschreven:
> >=20
> >> Hi,
> >>=20
> >> On Wed, Apr 03, 2013 at 02:43:00PM +0200, Daniel Mack wrote:
> >>> On 03.04.2013 14:04, Felipe Balbi wrote:
> >>>> On Wed, Apr 03, 2013 at 02:00:23PM +0200, Daniel Mack wrote:
> >>>=20
> >>>>> Felipe, could you explain the background on how the dsps
> >>>>> driver is supposed to work in host mode at boot time with the
> >>>>> rework of the driver you did for 3.7? It might just be me not
> >>>>> understanding the rationale behind all these changes, but
> >>>>> appearantly, I'm not the only one who's affected by that.
> >>>>=20
> >>>> right, so the idea with that was to drop the huge amount of
> >>>> ifdeferry hack from the MUSB driver. It would be great if
> >>>> someone would send *CLEAN* patches adding Kconfig-based role
> >>>> choices again.
> >>>=20
> >>> Are Kconfig-based rules really what we want here after all?
> >>> Wouldn't run-time configured settings make much more sense,
> >>> considering that
> >>=20
> >> we need both. Say that you want to build a product with MUSB
> >> hardwired as host, why would you enable gadget framework ?
> >>=20
> >> I can think of at least am335x where this would be perfectly
> >> plausible (no EHCI available, only MUSB).
> >=20
> > Nice that you mention am335x, since the beaglebone has 2 MUSB
> > controllers: one hardwired as host and one hardwired as slave. So how
> > will KConfig options solve that?
> >=20
>=20
> You would enable DUAL_ROLE and then let run-time code sort out the
> actual config. Which is what most people would do if they are uncertain,
> and which leaves the Kconfig option only for opting out some binary size.
>=20
> Also, we already have CONFIG_USB_GADGET_MUSB_HDRC which is there to
> remove all the gadget-only bits, right?

kinda, it's there but it's unused :-) But you got the idea. We use
Kconfig to opt-out of some features if we're certain our product won'
use it.

--=20
balbi

--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXDKkAAoJEIaOsuA1yqREYy0P/2oBqMNC0P6b2Jp+usXr/+yP
kCMPatxdlrUXBAaQmKKKccE2Gg8KoYDPgFbpMSIjvm+++77Ti7y2xCgr0pEZDC7m
duLPpWiyaAB2cax+Cr7WszebVOQxllEHbX+Rkv+HP15k39i6VHlFLOdKdiDo+Meh
3+1NS1SBB4ZtuVDi7oQxrvq4G704Wrs833O5KDE54YIS3mmkpv99zTahp/fdabvU
GdCEIpfcbawdqQJGL7/vDEXEChZWhe1NQrmRgmfn3UOowOx3lAppNL2s5qLF5ntp
mzqOohdHTaqwALN03GIvUtYPgs7D5KHobXi/DsLdx/yq6fs5kkykMhxa/bVsMLvw
SesBVvNTqIAfcl1fEy2hWejIaCqxvMTy6i+V9q9hv6qOnGpQYgBuRrskaJwqGJd0
7P2aVKEllso/pHyT+/TdBhwX7PvrcsNlXuVce3/v+Nh9Jsm6U7FkXzTtZUHyrzji
i7wRiw8nQP1mMoKKceXSwO85x43U1amn6W1ZR+DaaYPT6LBTNw8B6hfOrxACkwUM
b7kQDLs2V+5++Io+IBPn55I8ZMzjk2DBf9mhRnBySaZYaJVbjezwoNqIH0jV/irW
caW7CRrgKqjEKrDGVcZER5XHVmRZAhUmSu5VqpK6LRKt1PRWrlnT0erLn/NP4Yrl
rPHEY5LMlIidlsokCB+H
=tMR8
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--
