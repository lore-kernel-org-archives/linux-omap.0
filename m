From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 0/3] solving omapdrm/omapdss layering issues
Date: Tue, 31 Jul 2012 16:40:34 +0300
Message-ID: <1343742034.2633.56.camel@deskari>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-5MFr78YAjnDwqCLsWKMf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:60381 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753689Ab2GaNki (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 09:40:38 -0400
Received: by lbbgg6 with SMTP id gg6so5445362lbb.22
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 06:40:35 -0700 (PDT)
In-Reply-To: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>


--=-5MFr78YAjnDwqCLsWKMf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2012-07-27 at 20:07 -0500, Rob Clark wrote:
> From: Rob Clark <rob@ti.com>
>=20
> I've been working for the better part of the week on solving some of
> the omapdss vs kms mismatches, which is one of the bigger remaining
> issues in the TODO before moving omapdrm out of staging.
>=20
> The biggest place that this shows up is in GO bit handling.  Basically,
> some of the scanout related registers in DSS hw block are only shadow
> registers, and if the GO bit is set during the vblank the hw copies
> into the actual registers (not accessible to CPU) and clears the GO
> bit.  When the GO bit is set, there is no safe way to update these
> registers without undefined results.  So omapdss tries to be friendly
> and abstract this, by buffering up the updated state, and applying it

It's not really about being friendly. Omapdss tries to do as little as
possible, while still supporting all its HW features. Shadow registers
are a bit tricky creating this mess.

> on the next vblank once the GO bit is cleared.  But this causes all
> sorts of mayhem at the omapdrm layer, which would like to unpin the
> previous scanout buffer(s) on the next vblank (or endwin) irq.  Due
> to the buffering in omapdss, we have no way to know on a vblank if we
> have switched to the scanout buffer or not.  Basically it works ok as
> long as userspace is only ever updating on layer (either crtc or drm
> plane) at a time.  But throw together hw mouse cursor (drm plane)
> plus a window manager like compiz which does page flips, or wayland
> (weston drm compositor) with hw composition (drm plane), and things
> start to fail in a big way.
>=20
> I've tried a few approaches to preserve the omapdss more or less as it
> is, by adding callbacks for when GO bit is cleared, etc.  But the
> sequencing of setting up connector/encoder/crtc is not really what
> omapdss expects, and would generally end up confusing the "apply"
> layer in omapdss (it would end up not programming various registers
> because various dirty flags would get cleared, for example mgr updated
> before overlay connected, etc).

Can you give more info what the problem is? It shouldn't end up not
programming registers, except if there's a bug there.

Didn't the apply-id stuff I proposed some months ago have enough stuff
to make this work?

The thing about shadow registers is that we need to manage them in one
central place. And the same shadow registers are used for both the
composition stuff (overlays etc) and output stuff (video timings &
configuration). If omapdrm handles the composition shadow registers, it
also needs to handle all the other shadow registers.

> Finally, in frustration, this afternoon I hit upon an idea.  Why not
> just use the dispc code in omapdss, which is basically a stateless
> layer of helper functions, and bypass the stateful layer of omapdss.

If you do this, you'll need to implement all the stuff of the stateful
layer in omapdrm. You can't just call the dispc funcs and expect things
to work reliably. Things like enabling/disabling overlays with fifomerge
requires possibly multiple vsyncs. And output related shadow registers
may be changed separately from the composition side.

The apply.c is not there to make the life of the user of omapdss's easy,
it's there to make the DSS hardware work properly =3D).

> Since KMS helper functions already give us the correct sequence for
> setting up the hardware, this turned out to be rather easy.  And fit
> it quite nicely with my mechanism to queue up updates when the GO bit
> is not clear.  And, unlike my previous attempts, it actually worked..
> not only that, but it worked on the first boot!

Well, not having read the omapdrm code, I'm not in the best position to
comment, but I fear that while it seems to work, you have lots of corner
cases where you'll get glitches. We had a lot simpler configuration
model in the omapdss for long time, until the small corner cases started
to pile up and new features started to cause problems, and I wrote the
current apply mechanism.

> So I am pretty happy about how this is shaping up.  Not only is it
> simpler that my previous attepmts, and solves a few tricky buffer
> unpin related issues.  But it also makes it very easy to wire in the
> missing userspace vblank event handling without resorting to duct-
> tape.

Why is giving an event from omapdss at vsync "duct-tapy"?

> Obviously there is stuff still missing, and some hacks.  This is
> really just a proof of concept at this stage.  But I wanted to send an
> RFC so we could start discussing how to move forward.  Ie. could we
> reasonably add support to build dispc as a library of stateless helper
> functions, sharing it and the panel drivers between omapdrm and the
> legacy omapdss based drivers.  Or is there no clean way to do that, in
> which case we should just copy the code we need into omapdrm, and
> leave the deprecated omapdss as it is for legacy drivers.

I agree that we need to get omapdrm work well, as it's (or will be) the
most important display framework. And if managing that requires us to
combine omapdss and omapdrm, I'm fine with it.

But, again, so far I don't understand why it's so difficult to have them
separate with omapdss giving notifications of important events, and also
how combining the two drivers would fix any issues (though I agree it
could simplify some code somewhat).

So what I propose is first to look at the problems you have, so that I
understand what the problem is with omapdss-omapdrm interaction.

 Tomi


--=-5MFr78YAjnDwqCLsWKMf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQF+BSAAoJEPo9qoy8lh71vroP/iIslSTX5zw1BTXQJf9ruSF0
RrDAPB3CNg5zTlJPt/lyElv0fCDiiSt9eh/zI+lVwSbjfCjMnQwlRd+0uVPHea2g
+Z4Qwqi02SUUcT4f/SAkNqwjWRgNxHiMBlXafHu+6LmLhaPzK7O5ATDPICMBVrZA
Oc9BB1TIY6RKdb+DfGvYCDFbduGquimywo2LxeKHP2Ates+p9hPTFx39b2tp9br6
He/AZjqAZj+0Pq2/46ztHpEDbaeg++GqFi4oJaHndihOFtnhH1I4bBWn8RprJbTm
xZTUmHflxx3/XLrIGvkI98CQwCKJ4eXBJmx6xsaelJkJlZNDWPmUUG9Lu4aziiHw
jwlEmtY7etVNV1Pj1mRMb6jSuFAezz6qbHT1eFRIqp953brIEVBjfSxK+XWN3Zrw
EZC6rkrv0X3AxE/kzlxRFteaBiS1v4AhKmG/FU45F6g+m4HW7tAfWEB9F7dmBm6j
lh+h5HrGodBPx5NK1IRA8sOlLg7Gme4/0GhvWVgXUKabjiYoLGR0HTk9LCJXtXkv
I/VXotmKj+SjKhm//cZeSXRYNCNH9WCNa95Fsq8rwg2/J/2UjO8YQrfbGJqXND57
2KjZzWOPw6NZzH1RBjj7ZSm5LxbpvsiXy2Hld0Uk3gKq4ZIDwwDB/pFlzcvfmMaO
haa75/a9zm93uJ1a7GdG
=oS8f
-----END PGP SIGNATURE-----

--=-5MFr78YAjnDwqCLsWKMf--

