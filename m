From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap:
 revert "i2c: omap: switch to threaded IRQ support")
Date: Fri, 19 Oct 2012 19:30:27 +0300
Message-ID: <20121019163027.GD1493@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
 <87ipaanljt.fsf_-_@deeprootsystems.com>
 <20121017140002.GI11394@arwen.pp.htv.fi>
 <20121017143534.GJ11394@arwen.pp.htv.fi>
 <87txtsitpt.fsf@deeprootsystems.com>
 <20121018055136.GF11137@arwen.pp.htv.fi>
 <1350655227.2768.11.camel@twins>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1350655227.2768.11.camel@twins>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2012 at 04:00:27PM +0200, Peter Zijlstra wrote:
> On Thu, 2012-10-18 at 08:51 +0300, Felipe Balbi wrote:
> > > So the primary question remains: is RT runtime supposed to include the
> > > time spent suspended?  I suspect not.=20
> >=20
> > you might be right there, though we need Thomas or Peter to answer :-s=
=20
>=20
> re, sorry both tglx and I have been traveling, he still is, I'm trying
> to play catch-up :-)
>=20
> Anyway, yeah I'm somewhat surprised the clock is 'running' when the
> machine isn't. From what I could gather, this is !x86 hardware, right?
>=20
> x86 explicitly makes sure our clocks are 'stopped' during suspend, see
> commit cd7240c0b900eb6d690ccee088a6c9b46dae815a.
>=20
> Can you do something similar for ARM? A quick look at
> arch/arm/kernel/sched_clock.c shows there's already suspend/resume
> hooks, do they do the wrong thing?

if I understand correctly, then below should be enough. I did't test it
though:

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_=
32k.c
index 87ba8dd..c9260e6 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -116,7 +116,7 @@ int __init omap_init_clocksource_32k(void __iomem *vbas=
e)
 		return ret;
 	}
=20
-	setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
+	setup_sched_clock_needs_suspend(omap_32k_read_sched_clock, 32, 32768);
 	register_persistent_clock(NULL, omap_read_persistent_clock);
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
=20

Russell, would you have any comments here ? Should we make sure all ARMs
call setup_sched_clock_needs_suspend() and 'stop' counting during
suspend ?

I will test the above diff tomorrow, unless you have any other (better)
idea on how to deal with the problem.

cheers

--=20
balbi

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgYAjAAoJEIaOsuA1yqREAF0QAKe8aKPrmRVrEEGf3AISgLT5
tVlc3OvrI+pw3WKc3ioIg4Cu83+fptjMiy1KgX6eURJu75obXJ9K9qx51Exji8DT
KwO+4jhgU/FEvs0TjJOe7EZX/QAquc7MXlph1kOGfhvSz0xMZixE2e0lR/sQ2aj+
zJnzMUb/AiABEDYX3w8p14OOlkoafl7sDbJukL5ukoE/T07qOsLOb+1IBPVyj7TH
PVLBTWbu5DdHfLo1eggX4OgXxo6oe6Un3wnj15Bmni2m+ls8NcGCCzMJFLTXAaRO
UXkl69rMnFiyi6GH6uBSyMelAP5A0SOu9cB2T15CDWnHpTIExBDCzQcdsIAUWZtL
VAmvrU9cFWjiChcRCtWzoPtOsihtGxLY/3zm1tyxdkr8jVWhMJuXDryl9GzEMoDq
OgdlSNLB4tPK+M3KnY7VbEaLdAfdpbo20YQz5S/scslDThFwEsHEBz1HX+5Q+D1t
OKyyCIgHGHIaYeJcy703AuMcwtV0CpeKLbW68PFfC9eeYNKjWI090MD2EPL9u425
PmPN75c1cTWT0/rIm3k/4kJOX60AYiVxeskRt5KxHqbH5df2fnEuQ2Nbbp3ggj5Q
OKJ0hHlXxZHJSD6igUYttJUePMPh+nDVTPvTKe/7W3qfo9+RIgBosBv//5XS7Z9T
1uBbo4yYNeIhOCb2FZiM
=wWGp
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
