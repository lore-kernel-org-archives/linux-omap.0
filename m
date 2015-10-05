From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default
 status for 32k counter
Date: Mon, 5 Oct 2015 12:52:30 -0500
Message-ID: <20151005175230.GG18784@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <4815825.NCBBBMgLGf@wuerfel>
 <20150930141209.GB31865@saruman.tx.rr.com>
 <22213826.1MtkNIZ6W3@wuerfel>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <22213826.1MtkNIZ6W3@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: balbi@ti.com, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2015 at 11:58:16PM +0200, Arnd Bergmann wrote:
> On Wednesday 30 September 2015 09:12:09 Felipe Balbi wrote:
> > On Wed, Sep 30, 2015 at 10:15:25AM +0200, Arnd Bergmann wrote:
> > > On Tuesday 29 September 2015 15:44:06 Felipe Balbi wrote:
> > > > All devices should have a default status. Ignoring
> > > > the arguments if it should be 'okay' or 'disabled'
> > > > by default, let's set them all the 'disabled' and
> > > > have boards enable 32k counter.
> > > >=20
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > >=20
> > >=20
> > > The patch looks good, but the description is slightly incorrect:
> > > There is no reason to list "status=3D'okay'" other than overriding
> > > the 'disabled' status.
> > >=20
> > > I'd phrase it something like:
> > >=20
> > > "We want the use of the 32k counter to be a per-board setting,
> > > so let's disable it by default in each dtsi file and override the
> > > setting in the boards. Any board that does not wire up the counter
> > > should leave it disabled".
> > >=20
> > > However, if you really want all boards to provide the counter all
> > > the time, I'd argue that we're better off dropping this patch. We
> > > use the status=3D"disabled" trick for anything that may or may not
> > > be working based on the board design, but things that are present
> > > everywhere don't need this.
> >=20
> > okay, so here's the thing. While fiddling with the 32k counter, I notic=
ed
> > that even though there was no status listed, the thing still initializes
> > fine. However, when moving 32k to drivers/clocksource and using
> > CLOCKSOURCE_OF_DECLARE(), 32k would *NOT* probe unless I had an explicit
> > status =3D "okay" in DT.
>=20
> Very strange, that sounds like a bug in the clocksource probe code.
> Can you check how this happens?

seems like something overwrites counter's status field, here's a snippet of=
 boot
log:

[    0.000000] =3D=3D=3D> counter is available ??
[    0.000000] =3D=3D=3D> no status -> TRUE!!
[    0.000000] =3D=3D=3D> searching for timer
[    0.000000] =3D=3D=3D> timer is available ??
[    0.000000] =3D=3D=3D> no status -> TRUE!!
[    0.000005] sched_clock: 64 bits at 1000MHz, resolution 1ns, wraps every=
 4398046511103ns
[    0.000014] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_=
cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000047] =3D=3D=3D> searching for timer
[    0.000051] =3D=3D=3D> timer is available ??
[    0.000054] =3D=3D=3D> no status -> TRUE!!
[    0.000307] =3D=3D=3D> searching for counter
[    0.000311] =3D=3D=3D> counter is available ??
[    0.000315] =3D=3D=3D> counter status disabled
[    0.000318] =3D=3D=3D=3D> counter NOT available

note that first time around counter had no status and later it got a status
disabled from somewhere.

--=20
balbi

--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWErjeAAoJEIaOsuA1yqRE9Q8P/iH3A0wSiBTuqUdIckh3k4LH
xLg7sVNz6rLQKR8Kw2UXtMEJuEC61pUp/JnnhUSzesmlIGjKlvnLVKdWLzKeJQNE
KNLBO5OaT/gEw5JPVYUAwMXbAxMoz3mD7avLQEDImwEqxNRcwQP2so4W42aGTjxt
TD9Mk7ME4nDH0dIP51/niz3UUDBteW4Bt8O04B89pLXsijipEy/yNO2avkJKXrZX
J5iIQeAi+CRE7kMj+enpINqVk4rqzkoPochfI7VS7ah1u26fBsfG5zpmQN5cvWiw
ypuWZ5fBQZ2wHIcB5ImvsFXIQRnADtPyFf0G+gcSQlCnT03FJXuoZJ7asTyzlljx
1C5M/h7wgyWXqFefB56ETYRMX0ucONlmJzuqVQ7C4KnkvXgzH9P/cvik6ctfeV3y
sJubOuztWFyLQ7UIRt0kC52UU1DKLXP9OGUfcvS+TyLKajoMI5i5UiD/MsMA9JR7
Qov4VtnFiMrL7avPcc8ZIYRFHOib64ypAzBNd+t2goFsoLpARxsm8xUlItXLr549
NwGPfAJY2h12qPxdk9dg4kmawwhzd39w9dRKmc/1CI4RN23GsRRUzySRbgiadenB
V5jTEKCQtSfkKn9ah+o2JjR337Mkx+UsoKVxGa62vDKJVnCl9BOvo3+QK78RMeo7
/onsXEQKejEgpcae8xUa
=XYgt
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--
