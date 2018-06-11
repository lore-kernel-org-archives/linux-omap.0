From: Mark Brown <broonie@kernel.org>
Subject: Re: handling voice calls in ALSA soc (on Droid 4)
Date: Mon, 11 Jun 2018 12:10:11 +0100
Message-ID: <20180611111011.GA11580@sirena.org.uk>
References: <20180611102529.GA1272@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611102529.GA1272@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com
List-Id: linux-omap@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2018 at 12:25:30PM +0200, Pavel Machek wrote:

> ...and also. What is right interface for this? Mixer component that
> says if voice call is active or not?

Your modem should be represented as a component in the system and have
an input and an output representing the input and output on the cell
network.  See speyside for an example of how this can look in software
though there's a bunch of different ways modems can appear so you might
not have a fully digital link like that.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlseWI4ACgkQJNaLcl1U
h9DhpAf7BS15OOmveIfPROJ0s61oMffmjz/tM8L1Cn14P8bhfHE4ieEH1l2RDkny
sAviJ40O8vTn9XzuXyUSxj3JX8RD/0QsADPd1+X6w4Kgl8/l9Un6DlWBpLS2ro+t
Ny5QKkIX32NhyrqtRTxdfz4sif3IDOE9DYJ6AwbSyjhOUO6gUEq/uudv5A1KfOFt
DqumXqGRKVN5razt3lTFlel14NEzfdTVbDx4SJmXQz3zHgengRji6pYEdVvq5UqU
VXNE8SKSs2UlANWWtzRo8/8ShHZO0ySgkh7Dxne8TmD74zXwPy71DeVq20qcQrYU
k+/XWyFrbB9KnoHivTTFgjBdqnWgIw==
=dtGy
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
