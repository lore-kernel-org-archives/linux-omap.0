From: Pavel Machek <pavel@ucw.cz>
Subject: Re: regression v4.16 on Nokia N900: sound does not work
Date: Tue, 27 Feb 2018 00:13:36 +0100
Message-ID: <20180226231336.GA18565@amd>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0697714206306230627=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>, linus.walleij@linaro.org
Cc: martijn@brixit.nl, Linux-ALSA <alsa-devel@alsa-project.org>, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, Mark Brown <broonie@kernel.org>, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, peter.ujfalusi@ti.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>, abcloriens@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, "Andrew F . Davis" <afd@ti.com>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============0697714206306230627==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-02-26 16:02:22, Daniel Baluta wrote:
> On Mon, Feb 26, 2018 at 3:13 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> JFYI: This issues is tracked in the regression reports for Linux 4.16
> >> (http://bit.ly/lnxregrep416 ) with this id:
> >>
> >> Linux-Regression-ID: lr#4b650f
> >
> > Ok, so it seems that issue is bigger: whole sound subsystem does not
> > work. /proc/asound/cards is empty.
> >
> > 7e6127c1240ed569cdda2a67c8f03836f9f28c05 seems to be bad already.
> >
> > I tried to revert sound/soc changes, and sound is broken, too. Nasty
>=20
>=20
> dmesg log?

Partial dmesg is at:
https://github.com/pavelmachek/missy/blob/master/db/phone/nokia/n900/pavel/=
2018.1291171648263/dmesg.out

I should be able to get full one...

I did git bisect, and the winner seems to be:

pavel@duo:/data/l/linux-n900$ git bisect bad
c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
commit c85823390215e52d68d3826df92a447ed31e5c80
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Wed Dec 27 16:37:44 2017 +0100

    gpio: of: Support SPI nonstandard GPIO properties

    Before it was clearly established that all GPIO properties in the
        device tree shall be named "foo-gpios" (with the deprecated
        variant
	    "foo-gpio" for single lines) we unfortunately merged a few
        bindings
	    which named the lines "gpio-foo" instead.

    This is most prominent in the GPIO SPI driver in Linux which names
        the lines "gpio-sck", "gpio-mosi" and "gpio-miso".

    As we want to switch the GPIO SPI driver to using descriptors, we
        need devm_gpiod_get() to return something reasonable when
        looking
	    up these in the device tree.

    Put in a special #ifdef:ed kludge to do this special lookup only
        for the SPI case and gets compiled out if we're not enabling
        SPI.
	    If we have more oddly defined legacy GPIOs like this, they
        can be
	    handled in a similar manner.

    Reviewed-by: Rob Herring <robh@kernel.org>
        Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Unfortunately, it does not seem to revert cleanly on my v4.16 branch.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqUlJ8ACgkQMOfwapXb+vKASQCfdxxKqVMl+wtMQMhG4xobuWfg
aGMAoJAYqZc27+2AfYbfRnKyCDcd4vKm
=XNfI
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

--===============0697714206306230627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0697714206306230627==--
