From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 3/7] ASoC: hdmi-codec: Add
 hdmi-codec for external HDMI-encoders
Date: Fri, 14 Aug 2015 20:25:21 +0100
Message-ID: <20150814192521.GL10748@sirena.org.uk>
References: <1432666751-24794-1-git-send-email-jsarha@ti.com>
 <1432666751-24794-4-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3762761155945753945=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1432666751-24794-4-git-send-email-jsarha@ti.com>
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
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, moinejf@free.fr, airlied@linux.ie, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============3762761155945753945==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gphVtybrzJJtG9bX"
Content-Disposition: inline


--gphVtybrzJJtG9bX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 09:59:07PM +0300, Jyri Sarha wrote:

> +
> +	mutex_lock(&hcp->current_stream_lock);
> +	if (hcp->current_stream && hcp->current_stream->runtime &&
> +	    snd_pcm_running(hcp->current_stream)) {
> +		dev_info(dev, "HDMI audio playback aborted\n");

Does this really need to be dev_info()?

> +	if (hcp->hcd.ops->get_eld) {
> +		hcp->eld = hcp->hcd.ops->get_eld(hcp->hcd.dev);
> +
> +		/* Call snd_pcm_hw_constraint_eld here */
> +	}

...

> +	dev_dbg(dai->dev, "%s()\n", __func__);
> +
> +	mutex_lock(&hcp->current_stream_lock);
> +	BUG_ON(hcp->current_stream != substream);
> +	hcp->current_stream = NULL;
> +	mutex_unlock(&hcp->current_stream_lock);
> +
> +	hcp->hcd.ops->audio_shutdown(hcp->hcd.dev);

Shouldn't the callback be in or before the lock?  Otherwise we could
potentially race with starting a new stream.

--gphVtybrzJJtG9bX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzkCgAAoJECTWi3JdVIfQ7LIH/AwPVyzSpdoeaqLmonKXGlgW
ITWXMST3RW01j2/OUx3tMqXssVd3trQkkIDav4IFScmnVwJ735CgFl3qK815viB7
0NChnYiZ/h0pOIgjBhGGKsLgWHSj8tpD3cgByIzO1GQ+cZKySJLqoHfC95erjRY1
pkdRS8Xu/HVbESU9iGK/C8F3KNQQ9UGayWiwIfkcEGuB+UYImIFop6lYBLocrnyB
5bg1z4qRrQPcs+DBevo7fYGdiy1HFbm2y0v8SyOnLeI6/K47XbqR5vSvCPYPahrY
9zvdYdP6mL3OWDqeaFuGKWxam0FxhVPWsk5cTrpn21hRbgSTz538pqtb+yiM/rs=
=MTvG
-----END PGP SIGNATURE-----

--gphVtybrzJJtG9bX--

--===============3762761155945753945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3762761155945753945==--
