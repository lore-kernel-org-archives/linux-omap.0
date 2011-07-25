From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2 V2] OMAP3+: PM: SR: add suspend/resume handlers
Date: Tue, 26 Jul 2011 01:57:18 +0300
Message-ID: <20110725225718.GA31619@legolas.emea.dhcp.ti.com>
References: <1311526357-7578-1-git-send-email-nm@ti.com>
 <20110725084238.GC18062@legolas.emea.dhcp.ti.com>
 <CAOMWX4dC60SuF9=KDCrQo7zD5_PhTJhwuyqRkqj0ag8FHDQaxw@mail.gmail.com>
 <20110725171317.GH18062@legolas.emea.dhcp.ti.com>
 <CAOMWX4dnD+GX+G8eFBgqqtwF0=+mgcqdJc2vfhf7eMW+LLnwSw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44840 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752062Ab1GYW5X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jul 2011 18:57:23 -0400
Received: by mail-ey0-f178.google.com with SMTP id 4so5318305eye.37
        for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 15:57:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMWX4dnD+GX+G8eFBgqqtwF0=+mgcqdJc2vfhf7eMW+LLnwSw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: balbi@ti.com, Kevin <khilman@ti.com>, Colin <ccross@google.com>, l-a <linux-arm-kernel@lists.infradead.org>, l-o <linux-omap@vger.kernel.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 25, 2011 at 12:55:39PM -0500, Menon, Nishanth wrote:
> On Mon, Jul 25, 2011 at 12:13, Felipe Balbi <balbi@ti.com> wrote:
> [..]
> >> > while at that, SR's IRQ is never freed on exit path, could fix it wh=
ile
> >> > you're already there ?
> >>
> >> This is not really related to this patch is it? IMHO IRQ handling is
> >
> > I didn't say to put it on the same patch ;-) I meant that while at that,
> > you could add that simple fix before this patch ;-)
> Not really that simple - it is just one part of the equation, my point
> being - if we are cleaning up, we better cleanup completely on that
> thread at least.

fair enough :-)

> >> broken badly. Current support is for SmartReflex class3 - which does
> >> not use the IRQ, Class2 and Class1.5 use it, but the current code
> >> requires major fixes which I dont intend to support in this series.
> >
> > And that's exactly what I mean. IMHO it's far better to fix the mess
> > before adding more stuff, otherwise it just becomes an even bigger mess,
> > even more difficult to fix in the long run. We've seen that with GPIO
> > and sDMA drivers _at_least_ ;-(
>=20
> I tried pushing the cleanups in my series
> http://marc.info/?l=3Dlinux-omap&m=3D129933897910785&w=3D2
>=20
> few of them did go through and I have since personally lost interest
> and depending on my next free slot (not forthcoming for next few
> months), I might want to retry it, but I guess there is more interest
> in turning things into regulators than add new code.
>=20
> I am ok if folks want to drop this patch - like previously, things
> tend to get forgotten..

I didn't really say that, but ok ;-)

> >> >> @@ -998,10 +1020,75 @@ static int __devexit omap_sr_remove(struct p=
latform_device *pdev)
> >> >> =A0 =A0 =A0 return 0;
> >> >> =A0}
> >> >>
> >> >> +static int omap_sr_suspend(struct device *dev)
> >> >> +{
> >> >> + =A0 =A0 struct omap_sr_data *pdata;
> >> >> + =A0 =A0 struct omap_sr *sr_info;
> >> >> +
> >> >> + =A0 =A0 pdata =3D dev_get_platdata(dev);
> >> >
> >> > I'm not sure you need to use platform data here...
> >> see below
> >> >
> >> >> + =A0 =A0 if (!pdata) {
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: platform data missing\n=
", __func__);
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> >> + =A0 =A0 }
> >> >> +
> >> >> + =A0 =A0 sr_info =3D _sr_lookup(pdata->voltdm);
> >> >
> >> > this field is held on struct omap_sr. Can't you:
> >> >
> >> > =A0 =A0 =A0 =A0struct omap_sr =A0*info =3D dev_get_drvdata(dev);
> >> >
> >> > ?? I see that a platform_set_drvdata() is missing from the driver, b=
ut
> >> > maybe you should add that instead of accessing platform_data.
> >> omap_sr_data is added in arch/arm/mach-omap2/sr_device.c
> >>
> >> With the current handling - it needs sr_data from which sr_info is
> >> pulled out. in the current implementation, sr_data contains the voltdm
> >> pointer from which sr_info is pulled out.
> >
> > but sr_info is allocated on probe() isn't it ? if you add
> > platform_set_drvdata(pdev, sr_info) on probe, you won't need sr_data to
> > fetch sr_info, all you need is to use dev_get_drvdata(dev). Am I missing
> > something ?
> sr_info - I am not debating that this is not possible - I am just
> explaining how it is being done now. I just dont have the bandwidth to
> kill all evils in smartreflex driver. :(

I see... ok then, I'll see if I find some time to play with that, should
be kinda fun - not. Is this the only patch pending for that driver ?
Should I base off of v3.0 and everything should be ok ?

--=20
balbi

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOLfTOAAoJEAv8Txj19kN1H/8H/0r2aL9Y+DzYy7khA0wmu5aV
oEA9KAB6CxoJxhPImoXRtDH/AwLvHu3igdt8009E5pA+IFFVXirp51VKUpygFZN+
WRzZb3bS5R0asKDjFcYn86MH/xPekJJkNeLpmprDqr/mSKCEwVGicQk73kc2+j8I
B7kMEWKvJ1WtvPXVV/QBNB9ynhlEgGQHp3QpnSIPVTTzL/rM4a8p4l41OvH6tDLs
V8XYukjZVQAnBFA42l33eGwxahxe+LFIkjUrsu39L/Ok6xJrLO++ZtdsOx299muU
+0mKJw+XstG/51ES8+XesAYA7o98EzM2KVXL6vaEX4sW2JeskkXnh/4fabmvzAs=
=sndT
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
