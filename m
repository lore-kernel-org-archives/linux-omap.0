From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH/RFC] pwm: omap: Add PWM support using dual-mode timers
Date: Thu, 12 Dec 2013 13:59:30 +0100
Message-ID: <20131212125929.GL11524@ulmo.nvidia.com>
References: <20131024173620.0cbbefcf@notabene.brown>
 <20131029212318.GI15154@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mit9XoPEfICDqq/V"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131029212318.GI15154@atomide.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: NeilBrown <neilb@suse.de>, Thierry Reding <thierry.reding@avionic-design.de>, Grant Erickson <marathon96@gmail.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Mit9XoPEfICDqq/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2013 at 02:23:18PM -0700, Tony Lindgren wrote:
> * NeilBrown <neilb@suse.de> [131023 23:36]:
> >=20
> > I submitted this in December last year.  I got lots of good feedback
> > and fixed some things, but it never got accepted.  Not entirely sure
> > why, maybe I dropped the ball.
> >=20
> > Anyway, here is again with device-tree support added.
> >=20
> > This is only an RFC and not a real submission for two reasons, both of =
which
> > are really directed as Jon.
> >=20
> > 1/ I have to=20
> >=20
> > #include <../arch/arm/plat-omap/include/plat/dmtimer.h>
> >=20
> > which is incredibly ugly.
> > Is there any reason this cannot be moved to include/linux/omap-dmtimer.=
h?
>=20
> Yes that's what at least dw_apb_timer and sh_timer are doing.
> =20
> > 2/ I found that I need to call
> >=20
> > 	omap_dm_timer_write_counter(omap->dm_timer, DM_TIMER_LOAD_MIN);
> >=20
> >  when using device-tree.  This is because with devicetree
> >  omap_timer_restore_context() is called much more often and it sets the=
 counter
> >  register to 0 .. it takes a long time to count up to DM_TIMER_LOAD_MIN=
 from there.
> >=20
> >  Now I don't object to calling omap_dm_timer_write_counter (though it m=
ight be nice if
> >  omap_dm_timer_set_load wrote the one value to both LOAD_REG and COUNTE=
R_REG).
> >  However it seems wrong that I have to call it *after* starting the cou=
nter.
> >  Currently _write_counter refuses to run if the timer hasn't been start=
ed.
> >=20
> >  So Jon:=20
> >    a/ can we change omap_dm_timer_write_counter to work when the timer =
isn't
> >       running?
> >    b/ can we have omap_dm_timer_set_load also set the counter?
> >=20
> >=20
> > For anyone else generous enough to read my code: is this otherwise acce=
ptable?
>=20
> Did not look beyond the dmtimer stuff, but let's start by moving dmtimer.=
c to
> live under drivers and move the header, then do the pwm patches.

Why does the driver have to move? There is certainly some precedent for
having arch-specific code in arch/ but expose the public API via some
header in include/linux. Sometimes there's just no proper place for the
driver elsewhere, so rather than moving it somewhere more or less random
keeping it in arch/arm/plat-omap is just as good.

Thierry

--Mit9XoPEfICDqq/V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqbMxAAoJEN0jrNd/PrOhDzsP/2QW9YeGGC+X6DWkeMsTLCWG
FnPD2E1IBemOjD3EKVC85XfgN79PwweiqYISwJm4bjhr+N2GVt5V2KDNo2Lk0ab3
QDgVWXq2TOBFOOFhMSmCnVvoF71y3n3x8Oxl8R6CR+Q2lzWKR3W5b/aCw9spNu+z
PV2ypPLvpp83VCJ08osGXUm1Z3ARRZ7Qy+HwfIeY5oyvpFgL7OzDgJMxDF7Adw8p
4JOWS5Q+/KXgk/P2D5Du4+24uKCOwRLWTimxhe/D1Wd4DWqS++nEdX3YbpgKVNF3
epbGQ9N6P0f1hcZf1BHIFvf7Rcqoh1o8LcFK3Npu3Eh19jdGaVKvJY7oZmfFiazj
lRsh1JJphqCKhUxZ9zmueG5OcFC0ZusKZe+TpZG0Iei2ZSV5upvzR8ypvDr7p0hk
kgC0XdOphkOkrlnaxmx0qpvtdsNp+EDJsAV17JOVwSIC/cDNyHOBoYr18vqHJ8QT
BiRDVUeeWW04JhnrA4eDFBH0uXcJ25Wl/Gz+BkapGd1xi94eGKllgU3F9bj8flWv
rY9nVU6fN5Efi6fDShpjDBSh53mHzfx3Y+d2x74E6nWb8IWLJB4M+Y7QBhTecVzu
4Z1JaqBBAAOz3cbZMYpHiHj8E8Y+QNQkwRP9czkDQyW1WCEC4yFqrFb0HynYCFDx
va3ogpRAltWM9iPWaRsO
=hUqv
-----END PGP SIGNATURE-----

--Mit9XoPEfICDqq/V--
