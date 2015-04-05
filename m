From: Sebastian Reichel <sre@kernel.org>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Sun, 5 Apr 2015 15:39:34 +0200
Message-ID: <20150405133934.GC9186@earth>
References: <55198BA4.5010207@bitmer.com>
 <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth>
 <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth>
 <551F0F50.1030701@gmail.com>
 <20150403221517.GX10805@atomide.com>
 <551F186B.90608@gmail.com>
 <20150403225212.GY10805@atomide.com>
 <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38132 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbbDENkF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 5 Apr 2015 09:40:05 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 05, 2015 at 06:13:47AM +0200, Matthijs van Duin wrote:
> On 4 April 2015 at 00:52, Tony Lindgren <tony@atomide.com> wrote:
> > Right, it affects n900 for sure. My point is that it also seems to
> > affect 37xx versions not listed to suffer from this issue.
>=20
> They shouldn't... erratum 430973 only affected Cortex-A8 r1, and the
> dm37xx should have an r3p2 right?
>=20
> A word of caution though: at least on the DM814x and AM335x, secure
> ROM sets bit 6 (IBE) in the Auxiliary Control Register, thereby
> enabling BTB invalidate instructions (which normally execute as nops).
> This is presumably a leftover of the erratum 430973 workaround, but it
> means there is a risk of running afoul of erratum 687067 if BTB
> invalidate by MVA instructions are actually used.
>=20
> I would actually suggest clearing IBE if it set on Cortex-A8 r2 or
> later processors and a secure monitor call is available to do so
> (there is on the DM814x and AM335x, dunno about the 37xx), also for
> performance reasons: BTB invalidates are quite expensive instructions
> (when enabled).

So if I understand the issue correct, it would be ok to enable the
430973 workaround in cpu_v7_switch_mm for arm multiplatform kernels
(mcr p15, 0, r2, c7, c5, 6 @ flush BTAC/BTB). On unaffected
Cortex-A8 platforms the IBE bit should be unset (resulting in a nop
instead of the BTB flush).

So assuming, that the same is true for non Cortex-A8 platforms: Can
the workaround simply be enabled by default if CPU_V7 is selected?

-- Sebastian

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVITsTAAoJENju1/PIO/qag48P/i89fvzVnWNkLeDLXMt2TDB9
my0QaMTuwEUcb42dFH4xy+IerRSsWp7imMevWbMjNJeEbt+EdDoWdFC1luVVtoUt
VG8v3QxU//u2xkKV2tUtvtLjzimQQ5Pmbyl0IazXlB1+u4Rm477lxhjWIxGYOon9
zaj1sMS8Vjg6BFS5lUJUM8KwFH4fi/ASB6XUR/zgkldgw2uTr+2D+eVqf7ff1bBV
LWnXv5v5r0VgnU4XtU3iRsoeYsSun4PL7p85w2On/ZcszckuMgKj2B95IlqNpGEz
yAE5sRRQ6IaM4pnKgbkAfWVQ2VarICqARl0iaGjVCbzKbnrdZqSwLHFx3jQdH1jS
ucJQrW+WH7rM3jiW2lK08RgGQAz3ckl5wzZ5KV+jkktivJq6zsziH8mSlMtg/1DZ
pd5gkkzwRov+tI6V7pzBVgkyc96oVlWeehbXHxbHHo8hCtjuEHtQ6ycBjSd9hnOZ
pmSeGF9nqFQjd7PR5d3SVk6YWfTfyhBwmKy5A+jpxbQgYgOyLW/L6e+FsEoKjhfP
b2RVuoDDDNt/NzYQjcpNdkbBxywm0daeMEV6ENo6PzgcWIvp289BZnv5sb0GkB+V
Tyi1IBnME/dvxHl1IxggKwkSYrEef0e4fMo6VUrmUSuobsElR7NuwjbtVEmC8+8m
V+0DK8n5WIFCZQ+aXuq9
=3/SU
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
