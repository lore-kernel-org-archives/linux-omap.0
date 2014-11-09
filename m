From: Sebastian Reichel <sre@kernel.org>
Subject: Re: tsc2005 touchscreen: implement disable attribute
Date: Sun, 9 Nov 2014 13:40:25 +0100
Message-ID: <20141109124025.GA21763@earth.universe>
References: <20141109115636.GA3106@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141109115636.GA3106@amd>
Sender: linux-input-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, B38611@freescale.com, jg1.han@samsung.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Nov 09, 2014 at 12:56:37PM +0100, Pavel Machek wrote:
> Implement disable attribute for tsc2005 touchscreen. It is useful to
> avoid wakeups when phone is in the pocket.

I don't think this should be some driver specific sysfs node.
Instead a generic method from the input subsystem should be
used.

-- Sebastian

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUX2C5AAoJENju1/PIO/qaSPwP/RPPUv9RIf9ERAxg+8kg6AGY
T0S4iMku3oUttA7+a4k9xvhBR7jDny1jpiyEoyOcxAp61Oa9Mk0FR2W+RkozHvii
tzgJRNCoRjJ24Dug3jjk8fspJCpeIuJyAHHD20YIHlHyl5yfvzZ1a9LELysUBxPN
g833x8+QCf6txz6RKIOFIayl8I+U1LeiItV05hsjxX9OGagaOgIOLEsor6CmBAMS
lI+u431i3HJ1oZw2SDQvvR6xUiHl4xU7Ijhc9WgefOYZWLaYONnsPUj64rTr8aCb
N4DwSlLaFFrxUS0Lfb20uc8f/jh/Md8+Q1mQaROaWW2nbEiKAMDIPqhZ2m3EQeOy
c+DxPQmPWcd4Rt/dANAHrgsZUB2i931tZwj4btU8eNy0pwkxTjgNM7zavp/21MB/
sPcVuKh3ZOzl9lXXx2Z/hBhpQHs4nnW16LBNw+oQ7nz8sp/vLdDydQ+pjdVrNGJv
tMFkcLq4k3IftGvN+rBn0V6lkdTtLPzTT2L7iEDLC3XyLhnMMz5OLI2AaOvt5J+A
zr4Wb9TK1kEPvRGggw7yQlmW+URx7oBxWDMwaduybQnmwEfVmJI+EfK9gwYivPNb
hgCg9N5IejOIQxifwIcE7DuXLcUIjWysbnJKcb4kSBxmp7qC8OoVhTYIIkTkDuVv
420ojTy1RK+2l95PzAbp
=I6L6
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
