From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 29/35] arm: omap: intc: switch over to linear irq domain
Date: Wed, 30 Jul 2014 09:40:59 -0500
Message-ID: <20140730144059.GA7272@saruman.home>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-30-git-send-email-balbi@ti.com>
 <20140729121425.GR29045@atomide.com>
 <20140729141522.GB17808@saruman.home>
 <20140729152052.GV29045@atomide.com>
 <20140729154057.GE17808@saruman.home>
 <20140729163345.GF17808@saruman.home>
 <20140730060420.GY29045@atomide.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140730060420.GY29045-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Tue, Jul 29, 2014 at 11:04:21PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140729 09:36]:
> > Hi,
> >=20
> > On Tue, Jul 29, 2014 at 10:40:57AM -0500, Felipe Balbi wrote:
> > > On Tue, Jul 29, 2014 at 08:20:52AM -0700, Tony Lindgren wrote:
> > > > * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140729 07:18]:
> > > > > Hi,
> > > > >=20
> > > > > On Tue, Jul 29, 2014 at 05:14:25AM -0700, Tony Lindgren wrote:
> > > > > > * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140728 14:19]:
> > > > > > > now that we don't need to support legacy board-files,
> > > > > > > we can completely switch over to a linear irq domain
> > > > > > > and make use of irq_alloc_domain_generic_chips() to
> > > > > > > allocate all generic irq chips for us.
> > > > > >=20
> > > > > > This patch seems to somehow break off-idle for omap3=20
> > > > > > where it no longer wakes up.
> > > > >=20
> > > > > Sure your bisection is correct ? This patch just switches from le=
gacy
> > > > > irq domain to linear irq domain.
> > > >=20
> > > > Yes, I tried it a few times. Just enabling
> > > > retention idle hangs too with this patch.
> > > >=20
> > > > Maybe it's omap3_prcm_irq_setup that relies on
> > > > 11 + OMAP_INTC_START? There may be other such issues
> > >=20
> > > lol.
> > >=20
> > > OMAP4 has the same nonsense.
> >=20
> > made me think why (if) OMAP4 works with that same setup. Does wake from
> > OFF work with OMAP4 ?
>=20
> Not without similar changes, omap4+ has the same issue.. There's a RFC
> series from Nishant to fix some of this, and Tero is moving the PRCM
> into a driver.
> =20
> > Anyway, here's a quick little hack to check if that's the reason for the
> > regression:
>=20
> OK yeah that's along the same lines with Nishant's RFC series in thread
> "[RFC PATCH 0/7] ARM: OMAP4+: PRM: minor cleanups and dt support of
> interrupts"
>=20
> FYI, it did not compile, needs to include linux/of_irq.h. But yes,

I might have sent the wrong version as I had that same build error and
fixed it localy.

> it fixes the regression for me, Also now the whole series works for
> me :)

good to know.

What do you want to do now ? Wait for PRCM to become a driver ? Wait for
Nishanth's series to get accepted ? I guess the same thing could be done
for OMAP3 and AM33, then we would have a chance of having working wake
=66rom idle with the new irqchip.

cheers

--=20
balbi

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT2QP7AAoJEIaOsuA1yqREgIUP/2vUvhBPj5xV9YNr23uTCN4S
b8Z7e+hlT5qqSLBybLy/JRXDgOeUpyIKB0rYb08db4Si6FONL7t5UQQ1I2NdW8Yp
loydoTlqZjLYYGSG6oUM5TgPRqN6rM+1kqJD3SlN+9sRpi15ucehSnqRnA/dTVuA
6nzR+CTFond4F2gXmQsVR91/yvfc4Bm2i/bdroScuzRiF8fX3aDRnbyEpBvhN7fE
jwXHc4JkEdBKLdp4dm4ybnj1QKOk51uE/AocJcqhjZydUzGT8wFA3CMpto0Dk4IP
wHspzn1PiSyMWsSudDaCjLJ7DkTTEZpadPji7Z041xD40KDuJ+yBHoKIDRVqL9bC
qtj4eD0rlmxueaa4ExXWh6ZGLIDDcSllaitb5beJs9YJpl3kPGTxOWjB6JWt82HM
VxI8rBYCIQ7RuRpc00jEwW6z0jqIPOQ/mRGm5dapI+iHQd07qqgmKDTBanVeUmD0
M7eIy0EHsNAhvF8jHwjp2Y/fdaegHkG8xag/KPyplVyLiNp3bvob9L7v7hSEjGlb
oYgGmLTHi5WBh9ZxAwjpTEKiN077BqOJpH+zr74xrmuqTuJIYI1I1uGF81yOIfL/
5cHFGrcjEaVsbcYc2KTVss+SEH2EcxQz6DvWGbSsWnRyGZr2FQdhbkxa7yCq1jak
V0g2TIJg587ICK4ee0CF
=DjTN
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
