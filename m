From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Thu, 31 Dec 2015 22:59:06 +0100
Message-ID: <1451599146.9673.2.camel@collins>
References: <1450868319-20513-5-git-send-email-contact@paulk.fr>
	 <20151223115632.GS16023@sirena.org.uk> <568088B4.6090207@ti.com>
	 <1451342963.14631.13.camel@collins> <5681D7A8.2030101@ti.com>
	 <1451387613.18148.9.camel@collins> <568323B7.7080101@ti.com>
	 <1451464521.2531.4.camel@collins> <20151230163307.GW16023@sirena.org.uk>
	 <1451500639.14341.6.camel@collins> <20151231214007.GC16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-dRPTgQ8omuT0YBCYRKe7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151231214007.GC16023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--=-dRPTgQ8omuT0YBCYRKe7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 31 d=C3=A9cembre 2015 =C3=A0 21:40 +0000, Mark Brown a =C3=A9crit =
:
> On Wed, Dec 30, 2015 at 07:37:19PM +0100, Paul Kocialkowski wrote:
> > Le mercredi 30 d=C3=A9cembre 2015 =C3=A0 16:33 +0000, Mark Brown a =C3=
=A9crit :
> > > On Wed, Dec 30, 2015 at 09:35:21AM +0100, Paul Kocialkowski wrote:
>=20
> > > > In my opinion, it would be more elegant to adapt the core regulator
> > > > framework to first enable the GPIO and then call the regulator enab=
le
> > > > ops callback instead of handling the GPIO in the driver.
>=20
> > > Why would we want to actively manage both things at runtime?  It's mo=
re
> > > work, what do we gain from it?
>=20
> > Well, I figured that it would be best to disable the EN pin when we're
> > not using any of the regulators, since that allows the chip to enter
> > standby mode (and thus consume less power).
>=20
> This doesn't sound like it's anything to do with the regulators, that's
> a chip wide power management function which should be implemented via
> runtime PM if there's any value in implementing it at all (if the device
> is a primary PMIC normally this would be handled by the CPU core when it
> enters low power state without any software).  It's not something we
> should be considering on a per regulator basis since it's at the chip
> level and on a per regulator basis it's not doing anything useful for
> the reasons above.

I understand, thanks for pointing this out. Well, for my use case, there
is no use in disabling the chip at any point as it powers the external
mmc.

Would you agree to have the enable pin handled directly (and by that, I
mean enabled once, when requested, as I first suggested in the patchset)
in the driver then?

> > It also doesn't hurt regulators that only use a GPIO for enable.
>=20
> It causes problems for any device with an optional GPIO,  it means that
> we end up mantaining both GPIO and register which as I've said a couple
> of times now defeats the point of having the GPIO.

Fair enough.

--=-dRPTgQ8omuT0YBCYRKe7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWhaUqAAoJEIT9weqP7pUMPuQQAJyIfhnq14kq0vePG2tf/BAF
qVEtMbaE7a6k2yuhh8RE4KKKC5FVIKXKYQI+LbvLXhBiZ+qCQD4ZIGsOpCGHpuSj
5iW7BunQKzH2USuSr8prphHarS7Gns1Vv/AA28uJBlNPf74Z/mcpsuh+5vD8vZrW
5YMWPfxedm95TPbP8Zh0R3RgGlRP9fdNvw4jAkJKquI325jdCwl5Vq8VIKUOlb6D
NekkJoxa163Jn8KqqwR6rswCVGewOj/Yq9UpCGg446+Rlbnb89bwH/yHKOTDYWyf
XgHNsdNgAMLIh7rMAGXuDMrWWZYebxgJSe4knt/sRMS73Qhca32P6//Bog+n/wEq
sIfNJ6W1f1PklWf2ZmqaUvPJMvgN7JE/jn/MzesATN6XU5UocwcDxoN3A56IIuB0
V+XK1kwe4KrHsmnwyL4Jn86nB1vrad2t3r5PtufH49A1qdICzMzgiSkDsh0xLFS5
u5I/mGbxzQN6NrLxklHDz9czZggmIFDdg0Z/dY/v29fBKu5HogVV+EaUwugwyfHo
gbD7FMNrvlpC95MqKvjsWUMWI3/KtBx5BAzYLFNbrEdfivcRZsU8DR0i424iNL2P
tVCso+wLJS3BsWqTRmSWWIN20IllEu7gqucBJfS6V8RMYETybv6NNkm+RsJ/WwQS
cTrRW1pXEEZ4TPgGYGFA
=TJVG
-----END PGP SIGNATURE-----

--=-dRPTgQ8omuT0YBCYRKe7--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
