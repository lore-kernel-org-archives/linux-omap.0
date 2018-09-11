From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4: support for manually updated display
Date: Tue, 11 Sep 2018 14:54:28 +0200
Message-ID: <20180911125428.GA24639@amd>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
 <20180910212820.ygr3japdw6td2qvm@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180910212820.ygr3japdw6td2qvm@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > A large omapdrm change set from Laurent was merged into drm-next, and
> > > I'm certain they conflict with this series. Laurent also has continued
> > > that work, and while those new patches haven't been sent for review y=
et,
> > > I fear they'll also conflict with these.
> > >=20
> > > So in the minimum, a rebase on top of drm-next is needed.
> > >=20
> > > I also continue to be very worried that adding DSI support to omapdrm=
 at
> > > this stage will be a huge extra burden for Laurent's work.
> > >=20
> > > We should transform the panel-dsi-cm.c towards the common DRM model.
> > > With a quick look, there seems to be a driver for Samsung's S6E63J0X03
> > > panel. So possibly all the DSI features are there in the DRM framewor=
k,
> > > but someone needs to check that and start working on panel-dsi-cm.c so
> > > that it's ready when we finally switch to the DRM model.
> > >=20
> > > In my opinion, which I've also expressed before, the above work is mu=
ch
> > > easier to do by first changing the omapdrm to DRM model, without any =
DSI
> > > displays, and then add the DSI command mode support. But if people
> > > insist on adding the DSI support already now, I would appreciate the
> > > same people working on the DSI support so that Laurent doesn't have to
> > > do it all.
> >=20
> > I want to make it clear that I don't want to claim any privilege in get=
ting=20
> > patches merged first. I am however worried that, without an easy way to=
 test=20
> > DSI support, and without enough time to focus on it, I would break what=
ever=20
> > would be merged now in future reworks. I would thus like to find out ho=
w to=20
> > collaborate on this task, hopefully to move towards usage of drm_bridge=
 and=20
> > drm_panel for DSI-based pipelines.
>=20
> I'm currently quite busy and barely find enough time to do my work
> as power-supply subsystem maintainer, but I already started to
> rebase the series. I agree, that it would be very nice to move towards
> usage of common DRM framework(s), but it's also nice to see which
> patch breaks DSI ;)

I was thinking of doing rebase myself... so if you need some help, or
run out of a time and will need someone to finish it, let me know.

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluXuwMACgkQMOfwapXb+vKHOQCeK83aOj+SVN05+v8miJMvHAwh
dPcAniPZ+WTaohAIH+bW/823V7bkwKiZ
=PuAf
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
