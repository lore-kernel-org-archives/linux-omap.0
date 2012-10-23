From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: sched: stop sched_clock() during suspend
Date: Tue, 23 Oct 2012 20:24:49 +0300
Message-ID: <20121023172449.GA32517@arwen.pp.htv.fi>
References: <1350906877-19410-1-git-send-email-balbi@ti.com>
 <873916h1yi.fsf@deeprootsystems.com>
 <CACRpkdY6ox+iJAGdSD=e7Yj55TzDWqOmLqu2fSRXvKJxqwfkhQ@mail.gmail.com>
 <20121023092231.GE28061@n2100.arm.linux.org.uk>
 <87a9vdclxe.fsf@deeprootsystems.com>
 <20121023160331.GF28061@n2100.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8408405735999357342=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121023160331.GF28061@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Walker <dwalker@fifo99.com>, Thomas Gleixner <tglx@linutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Barry Song <21cnbao@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lennert Buytenhek <kernel@wantstofly.org>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, John Stultz <john.stultz@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Alexander Schulz <alex@shark-linux.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Bryan
List-Id: linux-omap@vger.kernel.org

--===============8408405735999357342==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 23, 2012 at 05:03:31PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 23, 2012 at 07:17:33AM -0700, Kevin Hilman wrote:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > > No, printk() does not need this.  You think it does, but it doesn't. =
 What
> > > we have is a difference between ARM and x86, and this difference is b=
reaking
> > > the scheduler.
> > >
> > > The fact that the printk timestamp increments while suspended is a bu=
g.  It
> > > doesn't on x86.
> >=20
> > Russell, I agree that it's a bug, but does it qualify as a something
> > you're willing to take for v3.7-rc?
>=20
> Definitely.  Our current behaviour across suspend for the scheduler is
> wrong.  This is one of the questions I had when I created the sched_clock
> stuff - but no one at the time could answer.  So, now that we have our
> answer, let's get it fixed to conform.

I have just pushed the patch the your patch system, hope I did it all
right.

--=20
balbi

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhtLhAAoJEIaOsuA1yqREV/UQAKkabpJ8c54Oq8LUttFO0beT
wTpqigU2qU1k8tzZqO+Wn2GNceW09W1RF6lVlW+lTeI1eP/EY/uiyo9JoZUXq5uZ
h3bks+bsSCEgOvfNdevjBmzln3PpjhKttAcr6peRiuNRlLvAGSd6Ol0nVBO/j8dp
2Sgf3B2LhgTcSwMT5S0KoVZtdBeoHElbiHRV4vJOw3YO2cgxEzZfxQgPt/cbQe3c
oMbKTHQwp1VAfLUumm/3eTDUi1Tyv5qS8JljVJ9n8Fh5lkcB4Tm/mykdhPIN0uGL
6ghDMWqiXptIQo4S4dOY/l+ZvhotzzKbt06LIhaoheCrMKwwt/gDTCu5kL+U84aN
fHVkIcMrgymJ4qhqwZ8cpGwMDLcTntyqgNy7Y5uubeirwwb6vuNcBVvuYzAULk4v
cNTBmU5aEW1mlFiyh/EY9BwwPa3u/9pyaVOWb80467xgPtWSQhWfcI0dv65cmo1c
euEmM0B5pC7/RuUOZ+opOHvt8IwkU5fOyx9hWL0+QWHu/in8cLq2J90R+fxLS2rd
FdW8TZPs+Fd/dwPTlPZeZsTF7sI+M7zSCdH2qgYjOvO1Xsz0iCj7AV5uUfnNuVmI
VmclhHyMxtjIoPdCynvnInr10zQIS64RswYXLy72ZzEoAoetnxMbYcOK5hVH3/Cj
a6Lcrfh3HI6GIXrxzQzv
=BXQV
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


--===============8408405735999357342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8408405735999357342==--
