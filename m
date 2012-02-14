From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of
 idle when HDMI is enabled
Date: Tue, 14 Feb 2012 15:33:24 +0200
Message-ID: <1329226404.1845.118.camel@deskari>
References: <1328854552-30714-1-git-send-email-archit@ti.com>
	 <1329220678.1845.68.camel@deskari>  <4F3A5A5D.4020906@ti.com>
	 <1329225311.1845.109.camel@deskari>  <4F3A61EF.4030803@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-JBcT5jFwgMUA99CVCucJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:60684 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755040Ab2BNNd3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 08:33:29 -0500
In-Reply-To: <4F3A61EF.4030803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org


--=-JBcT5jFwgMUA99CVCucJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-14 at 19:00 +0530, Archit Taneja wrote:
> Hi,
>=20
> On Tuesday 14 February 2012 06:45 PM, Tomi Valkeinen wrote:
> > On Tue, 2012-02-14 at 13:58 +0100, Cousson, Benoit wrote:
> >> Hi Tomi,
> >
> >>> Benoit, do you think we'll get the MODULEMODE mess cleaned up in the
> >>> hwmod/clk framework at some point, and the drivers could do without
> >>> these kinds of hacks? =3D)
> >>
> >> The best way to fix that for my point of view is to go to device tree
> >> or/and to consider the DSS as the parent of all the DSS modules.
> >> pm_runtime will then always ensure that the parent is enabled before a=
ny
> >> of the child are used.
> >
> > Ah, right. Sounds fine to me.
> >
> > But is that a proper "fix"? Are we sure the MODULEMODE will then always
> > be handled correctly? Isn't the core problem still there, it just
> > doesn't happen with the setup anymore?
> >
> > I mean, if we have these special requirements regarding MODULEMODE, and
> > the code doesn't really know about it, would it get broken easily with
> > restructuring/changes?
> >
> > And no, I don't have any clear idea why/how it would break, but I have
> > just gotten the impression that the MODULEMODE is not handled quite
> > properly (and so we have these current problems), and having dss_core a=
s
> > the parent of other dss modules doesn't really fix that in any way.
>=20
> I agree with that.
>=20
> In the current approach, we have multiple platform devices for DSS, and=
=20
> all of them belong to the same clock domain, and the clock domain has=20
> just one MODULEMODE bit field.
>=20
> When shutting off a platform device(by calling pm_runtime_put()), hwmod=
=20
> enables/disables MODULEMODE without taking into mind that other active=
=20
> platform devices may still need it. So, for example, if we have 2=20
> platform devices, say dss and dispc, and we have code like:
>=20
> dispc_foo()
> {
> 	pm_runtime_get(dispc_pdev);
> 		...
> 		...
> 	pm_runtime_put(dispc_pdev);
> }
>=20
> dss_foo()
> {
> 	pm_runtime_get(dss_pdev);
> 		...
> 		...
> 		dispc_foo(); /* MODULEMODE off after this */
> 		...
> 		...
> 	pm_runtime_put(dss_pdev);
> }
>=20
> This will lead to the situation of one platform device disabling=20
> MODULEMODE even though other platform devices need it.
>=20
> This may not be resolved in device tree either. We would need to have=20
> some use count mechanism for these bits, or attach MODULEMODE only to=20
> one platform device, and don't give others control to enable/disable it.

Hmm, are you sure? Not that I checked the code, but isn't MODULEMODE
mapped to a dss clock (was it "dss_clk")?. And so, the clock's refcount
should keep the MODULEMODE enabled/disabled?

 Tomi


--=-JBcT5jFwgMUA99CVCucJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPOmKkAAoJEPo9qoy8lh71+vgP/i5FLhZIFGsR/towoVkzfEY8
1PzWLv5I16XVDhVXQjlucAq6JSERCb1Nx/DAT0GHtiTAlK0QH13PhDtOGXSoUAW5
cczGzZzvvzGE8H/+fSVRdo9/9QD0HdwvecnEWKBGzvuZA9cLlReNH5HN4PxTB20S
rxJimqh2Up0wYZn+rfISKasFKvmu1Z+OoVO3WFn7+Q4YtbKfnm8Pnqy9YowX9lYb
Td+oKEez0XIRe2GeQLN/KS6a4Gjs7wTUw47B/phn85vCtHHEde7iaNX7JT9j92aH
vVv9zKVc3We8mvX9zR+5Ib4w9CPshjFDKBOttSk86rUNKbVaoOEWtaPBh4lu+ks3
Lijc4bMmMYNLzEv/YLwb87B/1z+dZEaxuJineVEjOPoWXAh8rxc9+5ruBrh9I4yb
7waqn0MGpHuyAcKFcWZOv1zbk7LlXJLYOmAKgRlM2XwhIq/yBl2KkEgA4F0lgwqT
fY50nUoDHTjfSqoanPhxnM2kJ76lkm7BAPis6BUMFX0QC0srDz4ONAL5K85HpIhX
9Ah1rkQFQj1mdb+zhMdyw48ZtZoMSDNUiG7jn6AqBrU7567jVr7d8ycuuWyK8JDL
f6Qj7z9udJaD1f0jCCpO7oohGSyQKuSAjKAMN8jtiWnoAsY2COfL4gdQN6xRCQz0
OFym5YT9BFy8jB3FAAnI
=fLrX
-----END PGP SIGNATURE-----

--=-JBcT5jFwgMUA99CVCucJ--

