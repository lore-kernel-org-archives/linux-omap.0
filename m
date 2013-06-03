From: NeilBrown <neilb@suse.de>
Subject: Re: Strange OMAP3 LCD display regression - bisected.
Date: Mon, 3 Jun 2013 21:20:50 +1000
Message-ID: <20130603212050.5a28fad6@notabene.brown>
References: <20130602165019.655da2eb@notabene.brown>
	<CAGGh5h0ZsY0J4o6TbMDjD+kOs94SqkFv4gxEhQLgiX9ihdYnPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/D/MeYLm00/4xyArgJMTaH3q"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54904 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755764Ab3FCLVD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jun 2013 07:21:03 -0400
In-Reply-To: <CAGGh5h0ZsY0J4o6TbMDjD+kOs94SqkFv4gxEhQLgiX9ihdYnPA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean-philippe francois <jp.francois@cynove.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rajendra Nayak <rnayak@ti.com>, Mike Turquette <mturquette@ti.com>, Paul Walmsley <paul@pwsan.com>

--Sig_/D/MeYLm00/4xyArgJMTaH3q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Jun 2013 10:13:18 +0200 jean-philippe francois
<jp.francois@cynove.com> wrote:

> 2013/6/2 NeilBrown <neilb@suse.de>:
> >
> > Hi Tomi, Rajendra and other,
> >  I have run into a rather strange regression with the LCD panel display=
 on my
> >  GTA04 (OMAP3630 based phone) that you might be able to help me with.
> >
> >  I bisected down to two patches, neither of which cause the problem by
> >  themselves, but both together do.
> >
> >  They are:
> >
> > commit bd0f5cc3641cb76ae8fa2cc4924c29da157f8b2d
> > Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Date:   Thu Dec 13 14:21:30 2012 +0200
> >
> >     OMAPDSS: fix TV-out issue with DSI PLL
> >
> > and
> >
> > commit f7f73aab3d5bd19ba0f72ff00fb6b3be28e1a4d3
> > Author: Rajendra Nayak <rnayak@ti.com>
> > Date:   Fri Apr 27 16:27:51 2012 +0530
> >
> >     ARM: OMAP: clock: Switch to COMMON clk
> >
> >
> > Yes - rather odd.
> >
>=20
> Does this patch solve your issue ?
>=20
> https://patchwork.kernel.org/patch/2634161/
>=20

Yes.  Thank you and Paul for pointing me to this patch.  I apply it and the
strange artefact goes away.

Panel isn't 100% yet - sometimes uniform white again after resume from
suspend, and I see

[  202.881500] omapdss APPLY error: cannot set timings for lcd: manager nee=
ds to be disabled
[  202.881530] omapdss APPLY error: cannot apply lcd config for lcd: manage=
r needs to be disabled

which I don't think I saw before, but I'm happy to track that down myself

So you can add a

   Tested-by: NeilBrown <neilb@suse.de>

to that patch if you like.

Thanks,
NeilBrown

--Sig_/D/MeYLm00/4xyArgJMTaH3q
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUax8Ejnsnt1WYoG5AQK4sQ/+PTiLYuQFAkvoF4R2HH3oOS4S6eWBd1iq
ZWZVeZRSO3tqn05tZqSkz/uTeGXBjW2D4DYvsQ+rUC4S7GRgQxZn3a/xYjALGoFu
OTIy5MbqISPjB/8B84BAIZ96ubQAWfU4XczEUP74YR8Fnjp2YIhpd7ESdDkXzEza
maKGl3oJo2uetTHnMBfgb/Wtff1xkWtY5RsKtdqZZR8ngjPsYymLNprYre1CLH+n
zDsioeE1pyRdJYk44XZ/CsmS3TEJlaqafQVfqSWekpwFfCc7bwC5wkv3UFJ+IxTC
dCRvWFQ7dhdLHxcPv26vFNe9xNdhZQ1Q3oAE86jznwqWCj8QHiGefJIoM/KXPoYN
S+0j87OiNCQ/g7lOray3KJ8QzL3/9i8WfFvD6RrxloAHZLOz7uBZx/8y23IysFu9
iEAVuovgLJ1m9TgFendB8PxlDG5PydT9NArqxn6kl3jEMi1VEI74InpsX2/NkiWr
blIEsOK2HEa1NVGFZjLmUg1LiWUWpNVmY0Lt0avpasGvAybvJfl5LDliQ7vcme8T
A+Q0y4LfJreuY6YHoyC63VgHTJTmLqR2/z439fvAv9cq/jnEVbZSImaNrqWKF+CH
mXRCKyszoGwLCt94mF9Mif/wxoybf5HIR0bvljw8aZB4For1hyWJxDE3BISKupQ9
cg2n8S3Xi0A=
=Gv+d
-----END PGP SIGNATURE-----

--Sig_/D/MeYLm00/4xyArgJMTaH3q--
