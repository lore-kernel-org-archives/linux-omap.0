From: Mark Brown <broonie@kernel.org>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Date: Tue, 29 Jan 2019 17:15:38 +0000
Message-ID: <20190129171538.GH10524@sirena.org.uk>
References: <20190129164813.GA5720@atomide.com>
 <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
 <20190129171151.GC5720@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129171151.GC5720@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Doug Anderson <dianders@chromium.org>, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--BXr400anF0jyguTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 09:11:51AM -0800, Tony Lindgren wrote:

> OK. Let's see if Sebastian spots where pwm_vibrator_start()
> and pwm_vibrator_stop() might get called multiple times
> or something similar.

Given that nobody has noticed that the driver stops working entirely
it's possible that the pattern is something like:


    pwm_vibrator_start()
    pwm_vibrator_stop()
    pwm_vibrator_stop()
    pwm_vibrator_start()

so it's a temporary underflow that gets corrected (or it could be that
not many people are using mainline kernels on these systems).  On your
system it's the dummy driver but presumably some other users have it
connected to actual regulators.

--BXr400anF0jyguTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQijkACgkQJNaLcl1U
h9A4cwf/aclPNONX4zH51MhkLG5+5pZu6gbqGvweUIvCUzuMLek/X/ryb4N6TYlo
ku47rPQwnXAif8zc1WEHu3cbPxoPW5duseH8192orcrGc0KPSGnFkJVhU6fvNVu4
qIlZRwy7EMzWsPq/BXIz6WEQCMa/RcRGL0I7jpKd136ROJRQbrQxWF2iixSMHOuU
qtMyEgni1HZMFYt1nB2EUlkwMiWdJmMBQgfMzQMORKoiPWWZvebeayTohFsjbGIM
mu8Bu6AkJ/BEOpH4KKlC4FA+8SVHc0bGDvrfu/BG0ykfh6O0m/uC3f4aUztfIrLe
1Si0xmVD0bI64+AYC2bQUMmB0g0Gag==
=9aT2
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--
