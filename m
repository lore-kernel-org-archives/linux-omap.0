From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 09/23] OMAPDSS: Create links between managers,
 outputs and devices
Date: Fri, 31 Aug 2012 17:45:44 +0300
Message-ID: <1346424344.16067.39.camel@deskari>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	  <1346326845-16583-1-git-send-email-archit@ti.com>
	  <1346326845-16583-10-git-send-email-archit@ti.com>
	 <1346422242.7508.18.camel@lappyti> <5040C907.5090000@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-mkJLWgJXiFBFiv6NR8Ai"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:45003 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753666Ab2HaOpu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 10:45:50 -0400
Received: by lagy9 with SMTP id y9so2327390lag.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 07:45:47 -0700 (PDT)
In-Reply-To: <5040C907.5090000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-mkJLWgJXiFBFiv6NR8Ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-31 at 19:54 +0530, Archit Taneja wrote:
> On Friday 31 August 2012 07:40 PM, Tomi Valkeinen wrote:
> > On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
> >> Links between DSS entities are made in dss_recheck_connections when a =
new panel
> >> is probed. Rewrite the code in dss_recheck_connections to link manager=
s to
> >> outputs, and outputs to devices.
> >>
> >> The fields in omap_dss_device struct gives information on which output=
 and
> >> manager to connect to. The desired manager and output pointers are ret=
rieved and
> >> prepared(existing outputs/devices unset, if default display)) to form =
the
> >> desired links. The output is linked to the device, and then the manage=
r to the
> >> output. If a probed device's required manager isn't free, the required=
 output
> >> is still connected to the device so that it's easier to use the panel =
in the
> >> future.
> >
> > I've been pondering this one, and I can't come to a conclusion. The
> > recheck_connections is just so ugly that I'd like to get rid of it =3D)=
. I
> > guess this patch doesn't make it any more ugly, so we can include it in
> > the patch series.
> >
> > And as I mentioned earlier, I think we should get rid of the
> > OMAP_DISPLAY_TYPE_* enum, as it's kinda extra now. But doing that would
> > require changing all board files. That's not out of the question, but I
> > think we should first make sure we know what we are doing with the boar=
d
> > files so we don't go back and forth there.
>=20
> Yes, I didn't remove it for the same reason.
>=20
> >
> > Just gathering my thoughts:
> >
> > When we define a panel in DT/board file, we should also define the
> > output instance, because that's part of the hardware design. But there
>=20
> It's a part of hardware design if the panel can't be detached. But yes,=
=20
> even for detachable panels, we can assume that the panel would=20
> eventually connect to that output.
>=20
> > are no hardcoded links between mgrs and outputs, so that doesn't belong
> > to the DT/board file. For example, omap4460's DSI1 can take input from
> > LCD1 or LCD2.
>=20
> Right, so we don't need an equivalent of the dssdev->channel field in DT=
=20
> info. As you said, we need the output instance, is that why you were=20

What I'm planning for DT is a direct link to the output instance.
Something like this (not correct, just to give the idea):

dss {
	dpi {
	};
};

i2c {
	/* an i2c controlled panel */
	my-panel {
		video-bus =3D <&dpi>;
	};
};

Then my-panel can get the handle from video-bus, and it'll get the
output device directly, without need for any IDs or such.

> sceptical about it being defined as an enum in previous patches?=20
> Probably we could define output instances in DT as a pair of instance=20
> number and instance type {number, type}. It would be sort of hard to=20
> play around with those within OMAPDSS though.

Well, optimally we wouldn't need to know about display types or output
instances, at least in most of the cases. We'd just have a bunch of
managers, and a bunch of outputs, and rules how these can be connected.
And the panel devices would have a link to the output it's connect in HW
level.

There are probably some cases where we need some kind of ID, so that we
can handle the DSI PLL's and such. And we need to setup the rules above
somewhere, and perhaps that code needs IDs to set it up. I'm not sure.

And, well, if we don't have IDs, the rules above need to be some kind of
lists of pointers. Perhaps having a bit mask is just simpler, as we'll
never have too many output instances.

So I'm not really against having the enum. It just would've been neat to
have the output type and instance number encoded into this enum, so that
it'd be easy to extract either one. But that kinda ruins the possibility
to use it in a bit mask.

> > So who could/should make the decision which mgr to use... Well, I don't
> > know on what basis the decision can be made, but I still think omapdss
> > can't make good decisions on that, so probably the whole "chain" should
> > be configured in the omapfb/omapdrm level.
>=20
> Which manager to chose could be simply picking up the next free manager=
=20
> which can connect to that output. omapfb/drm can take care of that.

That's a good default implementation, but not quite perfect. If there
are two displays, often the other display (well, output) can only be
connected to one particular manager, whereas the other one could use two
managers. And if both try to use the same manager, especially if the one
with two options is selected first, the other one is left without a mgr.

 Tomi


--=-mkJLWgJXiFBFiv6NR8Ai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQM4YAAoJEPo9qoy8lh71TusP/2D2ebFnwXitcBpU/vHCJy4Y
Xmy+86VMohfpRSftKEiTmNrzwy9/zqqfbT8LycA7GhRYyCX38/7INvRY/pDomofK
V1BjAsnpYiRWVww3aGKcxVqGobs5PalduIbg6Id8yXT9X7K0UWo/rx5ACLD0H8oW
B/NE+5yOD35LmGiqZ9tifDMZ+WnYLyJBtiePvNkGmXw0/0ksleKGJOl/PVavUG3A
yOBjJFJUZW5xmyaIs7fDbdMPdiv6ClBmew+guSnIubDJBRj0VIGvLJ7pt+gbFqHh
EgBfrw2U9HBZgb1nIIEX2IGTEDOCNJf/Te//C+me8DZgzMi9ql2GSzQfKmD9tX1T
G4Sh9z6W1vfIBa5dNWtl1m5dSVkAmQWGkh6dEb8oEIRAJ2QkWocnc9Q9amY8o3Gv
R5xAxgy0Ati06RDDMztZaO64qHHVf/vUa+QPqGt6rYiVhdRJUk7ldq+iYNPIQxSO
LYMBBXUGjkRtt8Lfe76wLTqNUM/bQh6uP9iLzG5VjjfcQs8NNiChBAyEaXtNkRan
Xh3e85ULoll+Km0JR2hd0McHn7dybEsEZg4dTvbqOrTxyAu59Z/1J7EdJpOBWAxL
7ujIfg4Qg/Y037t/84OmkajksNX7gBHMGzvkDCIapzaSYGt73p/e3lqmydfXHPTI
ZshVhCmg7C8Vru3ukZi3
=x7nK
-----END PGP SIGNATURE-----

--=-mkJLWgJXiFBFiv6NR8Ai--

