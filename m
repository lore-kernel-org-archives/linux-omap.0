From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 09/13] OMAPDSS: SDI: Create a function to set timings
Date: Wed, 15 Aug 2012 09:43:26 +0300
Message-ID: <1345013006.11980.14.camel@lappyti>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	   <1344512989-4071-1-git-send-email-archit@ti.com>
	   <1344512989-4071-10-git-send-email-archit@ti.com>
	  <1344951845.4845.58.camel@lappyti> <502A8322.6000309@ti.com>
	 <1344965600.2345.70.camel@deskari> <502AA232.1040305@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-zj86KZQ7MY3NrZHmty5P"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:47030 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751566Ab2HOGnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Aug 2012 02:43:32 -0400
Received: by lagp5 with SMTP id p5so623744lag.9
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 23:43:29 -0700 (PDT)
In-Reply-To: <502AA232.1040305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Rob Clark <rob@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-zj86KZQ7MY3NrZHmty5P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-15 at 00:38 +0530, Archit Taneja wrote:
> On Tuesday 14 August 2012 11:03 PM, Tomi Valkeinen wrote:
> > On Tue, 2012-08-14 at 22:26 +0530, Archit Taneja wrote:
> >> On Tuesday 14 August 2012 07:14 PM, Tomi Valkeinen wrote:
> >
> >> I guess it depends on how drm/fb want to use it. I guess an output
> >> should have a set_timings() kind of op if it can do it seamlessly. I
> >> guess we can do that easily in DPI, for example, we could reduce the f=
ps
> >> from 60 to 30 without causing an artefacts(I think). For outputs which
> >
> > Yes, that kind of thing is easy to do by just changing the pck divider,
> > which is in a shadow register. I mean, "easy" in theory, at least. Our
> > clock calculation doesn't work like that currently, though, so it could
> > end up changing DSS fck.
> >
> >> can't do it, we could remove the set_timings totally.
> >
> > But we do need set_timings for other outputs also (like sdi). We just
> > can't change them just like that. Only outputs that do not need timings
> > are DSI command mode and rfbi.
> >
> >> However, it'll be kind of inconsistent for some outputs to set timings=
,
> >> and for others to not, and if in the future drm/fb gets exposed to ops
> >> too, we may have dirty checks to see if set_timings is populated or no=
t.
> >>
> >> The easiest way would be to make all set_timings just update the copy =
of
> >> the timings output has, and expect drm/fb to disable and re enable the
> >> panel. We may end up doing unnecessary gpio resets and configuration o=
f
> >> the panels though.
> >
> > I think changing things like timings is quite a rare operation. The onl=
y
> > case it'd be necessary to change timings often, with speed, and without
> > artifacts would be the fps drop you mentioned, for lower power use with
> > panels that don't mind the fps drop.
> >
> > If I understood correctly, Rob said that drm already disables the outpu=
t
> > when changing the mode, when I asked if it's ok for the apply's
> > set_timings to require the output to be off.
> >
> > In any case this is not a big issue, I mean, it's not causing any
> > problems. Somebody is going to disable the output anyway when changing
> > the timings. Perhaps even these patches are good, because they make the
> > set_timings consistent across the output drivers (don't they?).
>=20
> Yes, they do, there isn't a set_timings for RFBI though, only a=20
> set_size, and DSI has set_timings for video mode and a set_size for=20
> command mode, I haven't put checks in the ops for a panel driver to=20
> wrongly call set_timings in commmand mode, and set_size in video mode.

Ok. Well, perhaps we should go forward with these patches then. They
make things consistent, and we don't really know which would be the best
way to handle this, so the method in your patches is as good as some
other.

The dssdev->state needs to be removed at some point, but that can be a
separate task.

> I haven't done that yet because a future patch of mine will have a DSI=
=20
> specific op called set_operation_mode() to make us independent of=20
> dssdev->panel.dsi_mode, there is no guarantee that the panel driver to=
=20
> first call set_operation_mode(), and then set_timings(), so I'm not sure=
=20
> yet how to deal with that. Probably having a mode/state which says that=
=20
> a field is unintialized might help, but that would overcomplicate things.

Well, we can define that set_operation_mode needs to be called before
any other dsi functions. They are kernel drivers, we can presume they
act correctly (although we should of course try to handle error cases
anyway). If they don't, we need to fix them.

If you want to be extra safe there, you could add third value to the
dsi_mode enum: UNDEFINED or such (I guess this is what you meant also).
By default dsi's mode would be undefined, and functions could check it.
But I agree it'd add lots of checks all around.

 Tomi


--=-zj86KZQ7MY3NrZHmty5P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQK0UOAAoJEPo9qoy8lh71dnIP/RbR3fx18cgizFtBUbroWz2j
TSrIQdAqr+e7rt3k/QgvH5WwhODXbm9LihGv7MzG0ARqeCxP8xifHg8Q0s/AV1zV
/ZX3u61aRuur3jawGC2daDDmpIsieENlbLNn76HDw5OIbpQultSinECIwXO58qQL
e8ZsmWpm3FEKWE5GikjL2HNMq/FFNk+VyDeMcGbvwK+m3XfoTxWTxSM1e3QYpnaS
leduxNuW5sbKUeRvK8A20f0zjscs6OfjfW2lSaxf3RqX4upeQqQ2XBj5OOqRU5eU
dlsF1/LUhZhGG4KmIRZc38SAdmkdFrOWmg8iRwyNbTP7jGFLxGy4AfnL8LQy/qiC
wYNSL6iBa6HSJBpS6/WIZULXYmpxO+wXuox5dsopCeznkpzB+0oNqEr7ppRwtiIS
nAJxRo/d8ceBZmVP6TrVtQxtt4Xbo6PQ+sdqDGtraP104bGRYcytR2H89FgvhG/Z
9Z0mPFGnFbBM9VyoKmbBZiO8739E/uxzJriHdqpjZFYwcD9d/3IVyBwE2898QOHy
KGku0HkSvt/URGNEO7B+W6FMhXqd/pJX/fc2ned1RsBvXINZp0WqmUD09DURMUIo
tPrRuHZS7LwgC5gm5spfLQjgEwomimpGu/jOz44saS89H4w6Oakqnfj4jzmwj1bF
EFhTVE7nVZ3AA/p5tLkn
=bAaK
-----END PGP SIGNATURE-----

--=-zj86KZQ7MY3NrZHmty5P--

