From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6 v2] arm: omap: usb: global Suspend and resume support
 of ehci and ohci
Date: Mon, 4 Jul 2011 11:25:54 +0300
Message-ID: <20110704082553.GH15044@legolas.emea.dhcp.ti.com>
References: <1309546474-15363-7-git-send-email-keshava_mgowda@ti.com>
 <Pine.LNX.4.44L0.1107011504530.1624-100000@iolanthe.rowland.org>
 <11640ef76f97628579e457b5c6a74cc3@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <11640ef76f97628579e457b5c6a74cc3-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, Vishwanath Sripathy <vishwanath.bs-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 04, 2011 at 10:36:54AM +0530, Partha Basak wrote:
> >-----Original Message-----
> >From: Alan Stern [mailto:stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org]
> >Sent: Saturday, July 02, 2011 12:37 AM
> >To: Keshava Munegowda
> >Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> >kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org; gadiyar-l0cyMroinI0@public.gmane.org;
> >sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org;
> >khilman-l0cyMroinI0@public.gmane.org; b-cousson-l0cyMroinI0@public.gmane.org; paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org; johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org;
> >vishwanath.bs-l0cyMroinI0@public.gmane.org
> >Subject: Re: [PATCH 6/6 v2] arm: omap: usb: global Suspend and resume
> >support of ehci and ohci
> >
> >On Sat, 2 Jul 2011, Keshava Munegowda wrote:
> >
> >> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
> >>
> >> The global suspend and resume functions for ehci and ohci
> >> drivers are implemented; these functions does the
> >> pm_runtime_get_sync and pm_runtime_put_sync of the
> >> parent device usbhs core driver respectively.
> >>
> >> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> >> ---
> >>  drivers/usb/host/ehci-omap.c  |   22 ++++++++++++++++++++--
> >>  drivers/usb/host/ohci-omap3.c |   21 +++++++++++++++++++++
> >>  2 files changed, 41 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-
> >omap.c
> >> index 178f63e..a02a684 100644
> >> --- a/drivers/usb/host/ehci-omap.c
> >> +++ b/drivers/usb/host/ehci-omap.c
> >> @@ -259,14 +259,32 @@ static void ehci_hcd_omap_shutdown(struct
> >platform_device *pdev)
> >>  		hcd->driver->shutdown(hcd);
> >>  }
> >>
> >> +static int omap_ehci_resume(struct device *dev)
> >> +{
> >> +	if (dev->parent)
> >> +		pm_runtime_get_sync(dev->parent);
> >> +	return 0;
> >> +}
> >> +
> >> +static int omap_ehci_suspend(struct device *dev)
> >> +{
> >> +	if (dev->parent)
> >> +		pm_runtime_put_sync(dev->parent);
> >> +	return 0;
> >> +}
> >
> >I don't see any point in these routines (and likewise for
> >omap_ohci_suspend/resume).  When the whole system is going to sleep
> >anyway, what reason is there for enabling runtime PM on the parent
> >device?
>=20
> Both for EHCI & OHCI, the clocks are owned by the parent (uhh-tll).
>=20
> Calling pm_runtime_put_sync(dev->parent) within omap_ehci_suspend
> will turn-off the parent clocks in the Suspend path.
>=20
> Similarly, calling pm_runtime_get_sync(dev->parent) within
> omap_ehci_resume
> will turn-on the parent clocks in the resume path.
>=20
> This way, all reference counting are implicit within the Runtime PM layer
> and takes care of all combinations of only EHCI insmoded, OHCI insmoded,
> both insmoded etc.
>=20
> When both EHCI & OHCI are suspended, parent clocks will actually be
> turned OFF and vice-versa.

not sure this is necessary. I would expect:

pm_runtime_get_sync(dev) to propagate up the parent tree and enable all
necessary resources to get the child in a working state. IOW, you
shouldn't need to manuall access the parent device.

Kevin ? Paul ?

--=20
balbi

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOEXkRAAoJEAv8Txj19kN1sBoH/R27TmiRxy57oUe/Uhme6Gsq
GhOWyoBSGPewW58lF/+GXcWMDiD8/KmMkOmJ8hO6IXbGVebeJp4spyviURmT5GqH
xZNWLQ5N6FDy981s1cSzBv9ZoLnSCCnhs2NqfpwappLYujEkOPaqyp6dl/fbFlXo
mZkRIo70WJYT8lIrHuWVlITGXoBaQslVVP8tXAahma6rvPNxJ3nVJwldYcTIcwdR
Dji5F9fdJyJvxcn06wPzXPdYLVwsVwAV333dXne2RPVjfjpZUGroWl50PWJ9TlKp
IrRwDbQPJR2tPAz5Y0cemmCxP0l4SwEMiE61t5oQYIU6VdzAsgwGyaU+LWnqcOI=
=GCbv
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
