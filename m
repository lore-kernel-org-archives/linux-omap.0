From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] omap: convert to devm_ioremap_resource()
Date: Tue, 12 Mar 2013 18:44:28 +0000
Message-ID: <20130312184428.GN19942@opensource.wolfsonmicro.com>
References: <1363017537-11602-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R92lf0Oi2sxyK3LA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363017537-11602-1-git-send-email-silviupopescu1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--R92lf0Oi2sxyK3LA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2013 at 05:58:57PM +0200, Silviu-Mihai Popescu wrote:
> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
>=20
> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.

Applied, thanks.  Please use subject lines appropriate to the subsystem.

--R92lf0Oi2sxyK3LA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3eFAAoJELSic+t+oim9ALkP/2nF5//KmXxUPFsESx/eInNW
jBt5NsaSwhUMzWpY8zvkIe+RwQ2WWfDxaTSF6/U1mAE8/6ZjP7SvfCtUpJHB1JHW
EKuO2Ye6mwkAEoG55whSfAUlsoBS0I+OCJYPFXlE1D6n899SBynztsYSk7L9fT8h
XVKqUt2uGWclFUjepcQtW+cRyNIx+2vnQLqyEHZuHbXEoKl0tmgjcgkCRtgd00nM
dHqtQeg1zAMnEnQj6oUqzXHkdLMN9mIX9NeHqShYr3msO3LF7IkAucinzBeggPuR
0Qn45nlsuUqnkq9IRSAYXg+99k4yrkjxW+1spnUn0t3a37VVtebHXBDq/4HZDkTq
9vqu/rjUZPhoORRabRGWUsoCy6f7/2dGvic3012Ug97+q97dbcy6mTdigjVppXYO
0zplXDndjGj0AjxWAuJvjlyvxMxsofQAoys2WoxeTbFLTJpVgXJlMFYOvmj7Jgwh
xaxMlazphyfL+a52IWyHcCNJwSWT74WNR16aaoJUBXjMpM6KUlf16go0jQpVMD1P
nnIkM5jwrFBE3cBjfsYZ6bwA0wXHyQhEBhgo1MyHEfpvVOJMj9e4FbzmdqPGPfun
7IeUBsUr3UDG8D77idT/nMZVeJ4eQVoTZBFfyFhyb7SU9kLz/eTRTHufZ7Xw+RKM
iWaAQ3uGroIh1+Jh9yFO
=tJ1Y
-----END PGP SIGNATURE-----

--R92lf0Oi2sxyK3LA--
