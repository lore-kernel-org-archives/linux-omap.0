From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: dwc3: Fix gadget pullup in SS mode
Date: Wed, 19 Sep 2012 20:24:44 +0300
Message-ID: <20120919172442.GA7784@arwen.pp.htv.fi>
References: <1348054229-27362-1-git-send-email-kishon@ti.com>
 <1348054229-27362-3-git-send-email-kishon@ti.com>
 <20120919115306.GG3772@arwen.pp.htv.fi>
 <CAEgRx2zOVn0zV39-cuPuj4n4HRgQmywy_NY4KTe0qEgeC+NEkw@mail.gmail.com>
 <20120919160450.GA7510@arwen.pp.htv.fi>
 <CAEgRx2yXStORBknr2hoMcobMO8wFGuKr4bvzZwEQHQQcHVH76Q@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEgRx2yXStORBknr2hoMcobMO8wFGuKr4bvzZwEQHQQcHVH76Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2012 at 11:50:53AM -0500, Sonasath, Moiz wrote:
> Felipe,
>=20
> On Wed, Sep 19, 2012 at 11:04 AM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>=20
> > Hi,
> >
> > On Wed, Sep 19, 2012 at 10:02:48AM -0500, Sonasath, Moiz wrote:
> > > Felipe,
> > >
> > > On Wed, Sep 19, 2012 at 6:53 AM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > >
> > > > Hi,
> > > >
> > > > On Wed, Sep 19, 2012 at 05:00:27PM +0530, Kishon Vijay Abraham I wr=
ote:
> > > > > From: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
> > > > >
> > > > > For the gadget pullup functionality to work in
> > > > > SS mode it requires a particular sequence of
> > > > > toggling the run-stop bit. Here is the required
> > > > > sequence:
> > > > >
> > > > > - Set DCTL[31]
> > > > > - Clear DCTL[31]
> > > > > - Clear OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]
> > > > > - Clear DCTL[8:5] =3D 0x00
> > > > > - Set DCTL[8:5] =3D 0x05
> > > > > - Wait 25 Ms
> > > > > - Set DCTL[31]
> > > > > - Set OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]
> > > > >
> > > > > Tested rigourously the gadget pull-up functionality
> > > > > in bot HS and SS modes.
> > > > >
> > > > > Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
> > > > > Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> > > >
> > > > this needs to split into three patches:
> > > >
> > > > add new poweron field, implement it on omap-usb3, use it on
> > > > dwc3/gadget.c
> > > >
> > > > btw, I don't think the changes to run_stop bit are necessary and if
> > they
> > > > are, that'd either be a silicon errata or it would've been mentione=
d on
> > > > the databook. I don't remember seeing that on the databook so I'm
> > > > assuming that this is caused by a bad use of the PHY.
> > > >
> > > > Why that mdelay(25) ? why 25 ms ? That's quite a long time, actuall=
y.
> > > >
> > >
> > > Felipe, This is infact a HW bug that the Si-Val team did accept and g=
ave
> > us
> > > this workaround sequence with the precise delay :-)
> > >
> > > Supposedly this will be fixed in ES 2.0.
> >
> > in that case this doesn't have to go to mainline since we're not
> > supporting ES1.0 in mainline :-)
> >
> > at minimum this should've come with a proper revision check anyway.
> >
>=20
> Actually most of it is under a rev check :)

fair enough.

> Perhaps the last: usb_phy_shutdown(dwc->usb3_phy);
> in the else part should be in
> if (dwc->revision <=3D DWC3_REVISION_187A) check

Is this an OMAP errata or Synopsys errata ? If it's a Synopsys errata we
need to make sure to add the comment above the workaround, if it's an
OMAP errata, we can't apply the workaround to all users since they might
not need it, so we need a more clever scheme.

On top of that, if it's an ES1 errata, I rather not have this in
mainline since we won't support ES1 at all in mainline, which means this
workaround will be useless in a mainline kernel tree.

--=20
balbi

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQWf/aAAoJEIaOsuA1yqRE510QAJ3AvIMlr8uitTIc0ZVRHAyS
WNkErvBdOczMlmL3vNRIzAbwTCRvIfchJ7zGmVjvoIbkgXQxwzxFHU+4ZR9yDKhZ
bMSc5EZXsTvFUedeB388hU91lTSkW78Osj6AmB7fHomNgPCUNKJS4RZltX6LsaFn
8f/0ke7vhjWqyZpAR3aHecAqqHKpXQfHhNPCgwuMP0ZMIGuXSDpmetCDBOPKdFWl
dNJV4lOdLbdDKmyj4A2MjDMYqo/2OST92MoQDeBoTxyEtIO7l33L1F3UrtZCX0J9
9aew53ADt3Ys08dAZYBH6mOrHNfMiZolR2f3V1qSdrHnymcEICDltXGOWiw+5OCz
HisL1Yt8o/kn5ZRzD/E+2xsfjWr4Y0qILj00961FQA1TvUws1MD0EvzoyVjQ+Kgc
KSUxFY3S5fBCyJdHf4k1qZ8MImERHf52r1yhEFkMd1qWv2kUHM3Ga9KGK8HTD1Z2
yBE/i8/HwAhp40A86JFeV+yjjSw3w1sFOuf8hBX+QRPHzE3QdllUItn6FcEOfl1t
Wyt8/d/iduuDGxVDbKOuMZXzc9fWo9ighuvYExD4pvdy0MvIZ5jQnzHOXznAXJ1u
yMUGxxKTRyHzkMqx7C0U9aIF+hb2bODq7ezyCOOn+nrOsZKgaPCxlzhWSWAxSHjr
NJ9orpBzPOWhlg0ZeBAp
=pE5w
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
