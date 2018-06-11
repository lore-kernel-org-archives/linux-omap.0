From: Mark Brown <broonie@kernel.org>
Subject: Re: handling voice calls in ALSA soc (on Droid 4)
Date: Mon, 11 Jun 2018 13:15:49 +0100
Message-ID: <20180611121548.GB11580@sirena.org.uk>
References: <20180611102529.GA1272@amd>
 <20180611111011.GA11580@sirena.org.uk>
 <20180611120158.GA21745@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611120158.GA21745@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com
List-Id: linux-omap@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2018 at 02:01:58PM +0200, Pavel Machek wrote:

> With setup like that, how does userland tell kernel that the baseband
> <-> microphone/speaker connection should be activated?

Audio routing should be done as normal, and ideally the driver for the
modem will be able to figure out if there's an active call or not.  If
userspace has to enable the input and output manually then you can set
up SOC_DAPM_PIN_SWITCH()es as normal.

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlseZ/QACgkQJNaLcl1U
h9BWCAf+LfKjwzLUVvOhcbxLYboqZYnFlFCooMmWX2b09RJ3uwQ7PLbyseWWD2Cw
zTFAji62KlZDfX5Wb/MHpUd+ojkBSKL0TkBWLKtCF52cVaQFFmLdsle44FRjABEb
yzcFQ9RN8s4fQPW3rl12gNjsBD10njZA38OEvePT0mpEy7Iq8zZue/sejMwWyXlC
vr3tiMFqguBGiCugS9leBEGT844muxf+SE9x2eEiVzD7Ga++fSD9JtxgEwta20/N
XzzpY+3rA/Vr9DJj0OYYDZ3M+iGh6x1gcHCVfenoWrgy7/nFY43yFbDrR4JKaVbq
rt74olPQuK/c1jj3xKgIN43f12hhqw==
=87wS
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
