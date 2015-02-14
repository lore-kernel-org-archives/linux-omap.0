From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-hdmi-audio: Add missing error check for
 devm_kzalloc
Date: Sat, 14 Feb 2015 13:33:01 +0900
Message-ID: <20150214043301.GD9110@finisterre.sirena.org.uk>
References: <1423732082-23815-1-git-send-email-kiran.padwal@smartplayin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423732082-23815-1-git-send-email-kiran.padwal@smartplayin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kiran Padwal <kiran.padwal@smartplayin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kiran Padwal <kiran.padwal21@gmail.com>
List-Id: linux-omap@vger.kernel.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 12, 2015 at 02:38:02PM +0530, Kiran Padwal wrote:
> This patch add a missing check on the return value of devm_kzalloc,
> which would cause a NULL pointer dereference in a OOM situation.

Applied, thanks.

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU3s/8AAoJECTWi3JdVIfQXLEH/1Rp1q149VrHeeDzWwfzH9TC
3UH+z0WLpleBdVG5sFi2DAa95Ql8QG2dRxYq/yhMWY/9e+esYfbX/nrDgFGodElg
NlUoTDD7wncdwxXOlNFJl0vleUtICCdzrTU6iclwB/Jq6BWuRIuJNym2QKiiMX6X
5J6alJQ5/mo1sh0K142/hj31e4bRWrl+0fhc+oCtRC0Z/W8oPqb7TIO9Ig0fI7o8
s3I7C8GVr4cDIFQ968IS6xQUX6NkxMEAtszy9S8yULJIPNgBlFvgJikAoOm2gHq5
ywEo1vormHeIulQVEPiPgn7SbT8MdxSjNXmPXvGCJ+8mSl1C6pitRlbED58E2Ic=
=7KQt
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
