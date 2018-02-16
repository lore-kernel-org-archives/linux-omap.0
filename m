From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv4 2/4] ASoC: codec: cpcap: new codec
Date: Fri, 16 Feb 2018 11:39:01 +0000
Message-ID: <20180216113901.GC5886@sirena.org.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2390728037833373288=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============2390728037833373288==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2018 at 11:07:39PM +0100, Sebastian Reichel wrote:

> +config SND_SOC_CPCAP
> +	tristate "Motorola CPCAP codec"
> +	depends on MFD_CPCAP
> +	default MFD_CPCAP
> +

We don't have default lines like this for other MFDs...

> +	SOC_ENUM("Hifi Left Phase Playback Switch",
> +		cpcap_hifi_l_phase_inv_enum),
> +	SOC_ENUM("Ext Left Phase Playback Switch",
> +		cpcap_ext_l_phase_inv_enum),

If this is a Switch control it should be a simple on/off binary control.
If it's an enumeration it shouldn't have Switch at the end of the name
since that's a keyword interpreted by userspace.  Either option seems
fine in this case, if it's a switch it should be "Foo Invert Switch" or
similar.

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqGwtUACgkQJNaLcl1U
h9Bl0Qf9G0/FzroOGeLykBCGn9UJFAuxOww1IVCOSq1yX5MXbRzKLndkj7wl8xSr
0LZlqyI9uEMR7neVga+k982xlUUNz1OfJxbBJyiH/26Y3BXi1kZ+DOnjb/LItj8Y
IAHYvEn3ND6HjZtm2jf73BBCvkyAxBt/KuT87P/eOPov/F/ASsGhKZhs4agvGAId
2rUnSrG3X++fgMd2GhxOgl58MsGW+5O2CEgwom06UUTeiPgCoF1HaEuZoh3p4dZY
r6SPYStZlMFCNRqWrlfy2Yi5KwNCJwd2Y7u9spg94xMXI7j2V5Vbt42yrH1F6uz2
fReE5awls/jlY8KpC4hmo4tb0zDutQ==
=vnov
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--

--===============2390728037833373288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2390728037833373288==--
