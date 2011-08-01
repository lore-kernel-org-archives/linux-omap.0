From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple
 platform_device from omap_device
Date: Tue, 2 Aug 2011 01:55:55 +0300
Message-ID: <20110801225554.GC6244@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-9-git-send-email-khilman@ti.com>
 <20110730120332.GA15539@n2100.arm.linux.org.uk>
 <20110731025807.GA24334@ponder.secretlab.ca>
 <20110731150540.GA3019@n2100.arm.linux.org.uk>
 <871ux5nnop.fsf@ti.com>
 <CACxGe6t4tNeD-Pn6WFt1XOMC=_Q0cf4uD3kRkOckKH+S1JUJDA@mail.gmail.com>
 <20110801185009.GA5217@legolas.emea.dhcp.ti.com>
 <20110801200743.GA21535@n2100.arm.linux.org.uk>
 <87pqkon5n6.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:42078 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752473Ab1HAWz7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 18:55:59 -0400
Received: by mail-fx0-f47.google.com with SMTP id 11so6284363fxg.20
        for <linux-omap@vger.kernel.org>; Mon, 01 Aug 2011 15:55:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87pqkon5n6.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 01, 2011 at 03:11:57PM -0700, Kevin Hilman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>=20
> > Help the typechecker do its job.  As we have only one (at the moment...)
> > And make it:
> >
> > +struct omap_device;
> >
> >  struct pdev_archdata {
> > +#ifdef CONFIG_ARCH_OMAP
> > +	struct omap_device *omap;
> > +#endif
> >  };
> >
> > for bonus points, so we only get the additional pointer for OMAP.
>=20
> OK, will do it this way.

this has the tendency to grow larger, no ? What if all other ARMs decide
to add their own pointers there too ? Counting the mach directories we
have:

$ ls arch/arm/ | grep mach | wc -l
64

minus a few duplicates like mach-omap1 and mach-omap2. Still, if we
count 40 different subarchs and each one of them adds their own pointer
here, this will become quite a messy piece of code, no ?

I agree we should try to have type checks, but considering the
possibility of many different pointers, does it really make sense ?
Nothing against it either, though.

--=20
balbi

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJONy76AAoJEAv8Txj19kN1WnUIAKgv9lrV7ktK4mDX94sb1WCE
UhTWbmrXnE17RMi07ReJ/vawKLCijW3ng9l/SqESLspxu0yWysPrM5SR7VQdeXq2
H/JakYmI6tbJ1qo31U85emiLKoBxEiRNSeGo5xSETKSnKnVwufUDZg5PgnnX+huf
0dly/ibX2Ti3hZOT8YnWFDgrvCa3eNwVXtSNQzQ0Ji3UHx6ZAKQeenNoLRbr7hhq
eSO/swizP+4m8yUvLW+5sZEmLAVSk/U152cFsvw4uS7B8zt53n4dZvAHTgfOh/jU
qiseuhsRqxuWfmaqzIhbARXVfluI2+feeMoZshXcUGYoMJTCKKhmjG1PHU6Qbh0=
=ghcP
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
