From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 03/11] arm: omap2: timer: remove __omap_gptimer_init()
Date: Mon, 5 Oct 2015 11:08:54 -0500
Message-ID: <20151005160854.GE18784@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-4-git-send-email-balbi@ti.com>
 <20151005110144.GW23801@atomide.com>
 <20151005152454.GC18784@saruman.tx.rr.com>
 <20151005160224.GC23801@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151005160224.GC23801@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, daniel.lezcano@linaro.org, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2015 at 09:02:25AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [151005 08:29]:
> > On Mon, Oct 05, 2015 at 04:01:45AM -0700, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [150929 13:48]:
> > > > since now we can reuse __omap_sync32k_timer_init()
> > > > for OMAP3-like devices, we can safely remove
> > > > __omap_gptimer_init().
> > >=20
> > > There are tons of boards out there that need to use the
> > > high frequency ocillator source with gptimer because of the
> > > beagleboard B4 and earlier issue #7. So we need to provide
> > > both options for the boards. Using the high frequency
> > > oscillator source blocks deeper idle states in hardware
> > > so those devices are usable.
> >=20
> > have a closer look, that hasn't changed
>=20
> Oh right, you added the argument in the previous patch.
> Maybe update the description a bit to make that clear?
> I understood that we can only use the sync32k source now..
>=20
> The __omap_sync32k_timer_init should not be called
> "sync32k" as that's TRM name for the always-on counter :)

that's renamed on a follow-up patch, too ;-)

--=20
balbi

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWEqCWAAoJEIaOsuA1yqREHeYP/3zewDihmDb9CtlrIP8w0fOK
BOdxty8P+KpUQpUMzQzqHQZMMNrKpa2f+cO5u9xnPJt0PtemPBprD/f0jQFrLUwj
VEGZf0Jz+4jOkTbqWjA3SwOuVuXCs6MvwuP7N3PesPkS2kJWHb+CsMItqKpJHl1H
uRbrQB1svrvklmAAi6emRkl//uhMr1cjeURhZN7atkmUEr9TM8iM9+dKvzyvziOz
3sKj1QFkZOfSYs7B2jrHaVc1NI33PiB8og0pOhCVbvoO2dEEdk/0jaNgQ+zqADX2
9u0jvV6y98EUDom3EY23v76+qvWAnG8KpZr72eFWFNr7YDB4oykvPkRHqWUxb7QY
uTTRBrpP5mrqCp3UWz4pwCeb2/JNg6skAZYJhS02tLbUSkseYebjBQTJvFnilYhW
+ioMzl74ZTtG47tWKByTqOQleEzIQfEbQtwvYodAOLIp6TaXf87zpCPueIjMkUCs
c+QIufsVLcddObB4E2i7AMDW0AET80hSzcvGzIFzMmNVIqzG1+JMQy6GAJFQfTjj
AUl6vBR6VaQjcn0TypHpkaGrgthf/S51jaJUhr+dlcZwT0OhyscOfxpTUOOVKFNn
TVYkuJ1b7FyP3htF7WMk5ymZ5L6Q39hTk1oCCeTh2JWMO+zwmQcpnDOMKdYX5Ug/
YYXBeWywcH+OhT0gcXC5
=QGro
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
