From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 REPOST 2/8] ASoC: davinci-evm: Add
 named clock reference to DT bindings
Date: Tue, 31 Dec 2013 13:16:17 +0000
Message-ID: <20131231131617.GZ31886@sirena.org.uk>
References: <cover.1387535299.git.jsarha@ti.com>
 <c1ae738c9b6cd9f2e595eed1f4981378ded46925.1387535302.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1451494275712135355=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <c1ae738c9b6cd9f2e595eed1f4981378ded46925.1387535302.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============1451494275712135355==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J8ZfMsDg90ddfAv1"
Content-Disposition: inline


--J8ZfMsDg90ddfAv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 12:38:27PM +0200, Jyri Sarha wrote:

> +static int evm_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +	struct snd_soc_card *soc_card =3D rtd->codec->card;
> +	struct clk *mclk =3D ((struct snd_soc_card_drvdata_davinci *)
> +			    snd_soc_card_get_drvdata(soc_card))->mclk;

Why do you need to cast away void?  Ths indicates something is going
wrong here though I can't see what.

> +	mclk =3D of_clk_get_by_name(np, "ti,codec-clock");
> +	if (PTR_ERR(mclk) =3D=3D -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(mclk)) {
> +		dev_dbg(&pdev->dev, "Codec clock not found.\n");
> +		mclk =3D NULL;
> +	}

The driver will unconditionally enable and disable the clock which I'd
not expect to work well if we got an error, I'd expect either NULL checks=
=20
on use or a fixed clock to be registered from code in the case where
we're using the old binding.

I'd also expect to see devm_clk_get() used here, with the standard
clock-names based lookup from DT.

--J8ZfMsDg90ddfAv1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwsOeAAoJELSic+t+oim9TvYP/2lw1WlGV/oGkMjoMdVkMFbo
ZafydcLIL6kzYNuC3K3rTb4ZF+EXPnYOJYArw+tqpSs5mglhAzYYL9hjNum0G/Ol
D8HyxixvzSovodizKvsnBjg65izmJxeIG0YEGhS4fuYReecltZjveuBiPS8prRdi
L16vmhLbavyFHIPMXjay0pGu5d/DSgnyq+r9gd7fOnBmUL/LV05fgWyHhql0Q/sG
87lnSjKzxcEtjHiBRF3SnGNNieOoLMGy9/YtivRJqajkxyEeJX9AB7dga1hN+dHh
f97HIn16m3ZOv8Zv3GE0fbbV5xuLTzy38VUU74nh3J7XgtQj4SH4O900VA2ZWVZT
+q18wi3UKvoc2bmEFt5Z7Gd7gFUUYI+a2k4ZiKo3UuHctTtN8c/gATEtenqxQtLH
3UQW8HGmfkht0tmpae1KIPa0tPN4q4RiG9IfNRu7tKX2aVzJPmbreGzSR8nChUhI
O5KXARuiGpJgFpaLYIuzEhW/WL52Vx5iVjaMOo0xAS0+D9z7qE3WWdMsa+f0GnZ+
ddAlU/9vm36lie1s0e37P1+4agChSVyBwu7hBR+sC3X5AvMYAGt9fzuff4kvTwbr
jkU+aq6Q0bkZcaHEveU1sdrRfrfQxy8DWTfN8MLoSOo3robOxsf4cgZkBraZr70d
wzQ+4PeGJdn0rPF6kI17
=hA/O
-----END PGP SIGNATURE-----

--J8ZfMsDg90ddfAv1--

--===============1451494275712135355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1451494275712135355==--
