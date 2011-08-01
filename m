From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple
 platform_device from omap_device
Date: Mon, 1 Aug 2011 21:50:09 +0300
Message-ID: <20110801185009.GA5217@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-9-git-send-email-khilman@ti.com>
 <20110730120332.GA15539@n2100.arm.linux.org.uk>
 <20110731025807.GA24334@ponder.secretlab.ca>
 <20110731150540.GA3019@n2100.arm.linux.org.uk>
 <871ux5nnop.fsf@ti.com>
 <CACxGe6t4tNeD-Pn6WFt1XOMC=_Q0cf4uD3kRkOckKH+S1JUJDA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:37256 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752880Ab1HASuP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 14:50:15 -0400
Received: by mail-fx0-f53.google.com with SMTP id 23so5478876fxd.26
        for <linux-omap@vger.kernel.org>; Mon, 01 Aug 2011 11:50:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACxGe6t4tNeD-Pn6WFt1XOMC=_Q0cf4uD3kRkOckKH+S1JUJDA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 01, 2011 at 04:44:20PM +0100, Grant Likely wrote:
> On Mon, Aug 1, 2011 at 4:42 PM, Kevin Hilman <khilman@ti.com> wrote:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> >
> >> On Sat, Jul 30, 2011 at 08:58:07PM -0600, Grant Likely wrote:
> >>> On Sat, Jul 30, 2011 at 01:03:32PM +0100, Russell King - ARM Linux wr=
ote:
> >>> > On Thu, Jul 21, 2011 at 04:52:18PM -0700, Kevin Hilman wrote:
> >>> > > Rather than embedding a struct platform_device inside a struct
> >>> > > omap_device, decouple them, leaving only a pointer to the
> >>> > > platform_device inside the omap_device.
> >>> > >
> >>> > > This patch uses devres to allocate and attach the omap_device to =
the
> >>> > > struct device, so finding an omap_device from a struct device mea=
ns
> >>> > > using devres_find(), and the to_omap_device() helper function was
> >>> > > modified accordingly.
> >>> > >
> >>> > > RFC/Hack alert:
> >>> > >
> >>> > > Currently the driver core (drivers/base/dd.c) doesn't expect any
> >>> > > devres resources to exist before the driver's ->probe() is called=
=2E =A0In
> >>> > > this patch, I just comment out the warning, but we'll need to
> >>> > > understand why that limitation exists, and if it's a real limitat=
ion.
> >>> > > A first glance suggests that it's not really needed. =A0If this i=
s a
> >>> > > true limitation, we'll need to find some way other than devres to
> >>> > > attach an omap_device to a struct device.
> >>> > >
> >>> > > On OMAP, we will need an omap_device attached to a struct device
> >>> > > before probe because device HW may be disabled in probe and drive=
rs
> >>> > > are expected to use runtime PM in ->probe() to activate the hardw=
are
> >>> > > before access. =A0Because the runtime PM API calls use omap_devic=
e (via
> >>> > > our PM domain layer), we need omap_device attached to a
> >>> > > platform_device before probe.
> >>> >
> >>> > This feels really wrong to overload devres with this. =A0devres pur=
pose is
> >>> > to provide the device's _drivers_ with a way to allocate and free r=
esources
> >>> > in such a way to avoid leaks on .remove or probe failure. =A0So I t=
hink that
> >>> > overloading it with something that has a different lifetime is comp=
letely
> >>> > wrong.
> >>>
> >>> I disagree; extending devres to also handle device lifetime scoped
> >>> resources makes perfect sense. It is a clean extension, and struct de=
vice
> >>> is really getting rather huge. =A0I certainly prefer re-scoping devres
> >>> to adding more elements to struct device.
> >>
> >> The point is you're asking something which is designed to have a well
> >> defined lifetime of driver-bind...driver-unbind to do a lot more than
> >> that - extending its lifetime conditional on some flag to the entire
> >> device lifetime instead.
> >>
> >> Such extensions tend to be a disaster - and a recipe for confusion as
> >> people will no longer have a clear idea of the lifetime issues. =A0We
> >> already know that people absolutely struggle to understand lifed
> >> objects - we see it time and time again where people directly kfree
> >> stuff like platform devices without thinking about whether they're
> >> still in use.
> >>
> >> So no, extending devres is a _big_ mistake and is far from clean.
> >>
> >> Not only that, but if most of the platform devices are omap devices,
> >> (as it would be on OMAP), you'll consume more memory through having to
> >> have the additional management structs for the omap_device stuff than
> >> a simple pointer.
> >>
> >> As for struct device getting rather huge, last time I looked it contai=
ned
> >> a load of stuff which was there whether or not a platform used it. =A0=
Eg,
> >> you get 4 bytes wasted for an of_node whether you have DT support or n=
ot.
> >> If sizeof(struct device) really is a problem, then it needs the unused
> >> stuff ifdef'd away. =A0So I don't buy the "its getting rather huge" ar=
gument.
> >>
> >>> > We could add a new member to struct dev_archdata or pdev_archdata t=
o carry
> >>> > a pointer to this data, which I think would be a far cleaner (and s=
aner)
> >>> > way to deal with this. =A0In much the same way as we already have a=
n of_node
> >>> > member in struct device.
> >>>
> >>> Since this is just for omap_device, which by definition is arm-only, I
> >>> don't have any strong objection to using pdev_archdata. If it was
> >>> cross-architecture, then I'd argue strongly for the devres approach.
> >>
> >> Indeed, which is why I think putting it in the platform device archdata
> >> makes total sense, more sense than buggering up the clean devres lifet=
ime
> >> rules that we have today.
> >
> > OK, so I'll continue this approach using pdev_archdata, which would work
> > fine for me. =A0It's currently empty, so I'll just add a 'void *' if it=
's
> > OK with you Russell:
> >
> > diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/devic=
e.h
> > index 9f390ce..bb777cd 100644
> > --- a/arch/arm/include/asm/device.h
> > +++ b/arch/arm/include/asm/device.h
> > @@ -13,6 +13,7 @@ struct dev_archdata {
> > =A0};
> >
> > =A0struct pdev_archdata {
> > + =A0 =A0 =A0 void *p;
> > =A0};
>=20
> struct omap_device *p;
>=20
> Otherwise it is just asking for type safety problems.

considering that struct omap_device isn't ARM-wide, is it really wise to
to do that ? I guess a void * will do better here.

--=20
balbi

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJONvVhAAoJEAv8Txj19kN1ZCAH/0dyT/K2Njlc/wOHrVrk+N9w
qrdxfj/6kUSTYzdMXRvYpe/iO/3kxR4unDkoINs2tCBU+/AOiO+XiKu73elAveTp
lHhsEEKtKJYyauUC+sRkdkRtzqUWanvb3NFgvSPzgybSaK/YdyUuIEGnwKuCZ5Va
2RuRcoM7JpElzCRdxGpTmn6ecYmMXeCNhMQDGdEigwSqSHRx6ho/JWgAY10DiE6j
qyutim4L+mr6Va1Est/e3DU2GaljUQFOCy4UZPdjgw5AfRAz64WiageslucuQXAn
Sa3be2GJ1La5N1zMF47WlcvtH+rrUVcslu5nyLa9wAl6YUlw7X3Wwzo7hAtb5cM=
=zqd8
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
