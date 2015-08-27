From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: hdmi: Reconfigure and restart
 audio when display is enabled
Date: Thu, 27 Aug 2015 17:30:53 +0300
Message-ID: <55DF1F1D.3080203@ti.com>
References: <cover.1440594174.git.jsarha@ti.com>
 <44089dc819903c71e1d0ed0c14dd3ab060ed8c68.1440594174.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8277218285402594884=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <44089dc819903c71e1d0ed0c14dd3ab060ed8c68.1440594174.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org

--===============8277218285402594884==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3uOh6pdtAiXNsKCOwxrpVj0n25LBqGnmL"

--3uOh6pdtAiXNsKCOwxrpVj0n25LBqGnmL
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/08/15 16:11, Jyri Sarha wrote:

I few comments, for the parts I had time to review:

> diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbde=
v/omap2/dss/hdmi5.c
> index 7f87578..f352c4b 100644
> --- a/drivers/video/fbdev/omap2/dss/hdmi5.c
> +++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
> @@ -352,6 +352,7 @@ static int read_edid(u8 *buf, int len)
>  static int hdmi_display_enable(struct omap_dss_device *dssdev)
>  {
>  	struct omap_dss_device *out =3D &hdmi.output;
> +	unsigned long flags;
>  	int r =3D 0;
> =20
>  	DSSDBG("ENTER hdmi_display_enable\n");
> @@ -370,7 +371,37 @@ static int hdmi_display_enable(struct omap_dss_dev=
ice *dssdev)
>  		goto err0;
>  	}
> =20

I think you could refactor parts of the code below into small helper
functions:

> +	if (hdmi.audio_configured) {
> +		spin_lock_irqsave(&hdmi.audio_playing_lock, flags);
> +		hdmi_wp_audio_core_req_enable(&hdmi.wp, false);
> +		hdmi_wp_audio_enable(&hdmi.wp, false);
> +		if (hdmi.wp_idlemode > 0)
> +			REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG,
> +				    hdmi.wp_idlemode, 3, 2);
> +		hdmi.wp_idlemode =3D -1;

The above looks like it's disabling audio output, the same that's done
in hdmi_audio_stop(). Adding a helper func for that makes the code more
readable.

For the wp_idlemode, I think hdmi.wp_idlemode could be initialized to a
valid value, so that it can be set at any time without the if check above=
=2E

> +		spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);
> +
> +		r =3D hdmi5_audio_config(&hdmi.core, &hdmi.wp, &hdmi.audio_config,
> +				       hdmi.cfg.timings.pixelclock);
> +		if (r) {
> +			DSSERR("Error restoring audio configuration: %d", r);
> +			hdmi.audio_abort_cb(&hdmi.pdev->dev);
> +			hdmi.audio_configured =3D false;
> +		}
> +	}
> +
> +	spin_lock_irqsave(&hdmi.audio_playing_lock, flags);
> +	if (hdmi.audio_configured && hdmi.audio_playing) {
> +		/* No-idle while playing audio, store the old value */
> +		hdmi.wp_idlemode =3D
> +			REG_GET(hdmi.wp.base, HDMI_WP_SYSCONFIG, 3, 2);
> +		REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG, 1, 3, 2);
> +
> +		hdmi_wp_audio_enable(&hdmi.wp, true);
> +		hdmi_wp_audio_core_req_enable(&hdmi.wp, true);

And here maybe a helper func to enable the audio output.

> +	}

>  	hdmi.display_enabled =3D true;
> +	spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);
> =20
>  	mutex_unlock(&hdmi.lock);
>  	return 0;
> @@ -382,17 +413,18 @@ err0:
> =20
>  static void hdmi_display_disable(struct omap_dss_device *dssdev)
>  {
> +	unsigned long flags;
> +
>  	DSSDBG("Enter hdmi_display_disable\n");
> =20
>  	mutex_lock(&hdmi.lock);
> =20
> -	if (hdmi.audio_pdev && hdmi.audio_abort_cb)
> -		hdmi.audio_abort_cb(&hdmi.audio_pdev->dev);
> +	spin_lock_irqsave(&hdmi.audio_playing_lock, flags);
> +	hdmi.display_enabled =3D false;
> +	spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);

Shouldn't something be done here in hdmi_display_disable about audio?
You probably want to keep the state flag enabled, so that we know the
user is playing audio, but you could still disable the HDMI audio HW.
I'm sure the audio output dies when the video is disabled, but being
more explicit here makes the code logic easier to follow.

 Tomi


--3uOh6pdtAiXNsKCOwxrpVj0n25LBqGnmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3x8dAAoJEPo9qoy8lh71caIQAJZiEL0rOnoQ4KkUtt8gAn/4
aR8DoJsKk+g9pdPnVqa4nUK4FE3O9mFz50TywENRn+sMb84NLglqvKAsegEub0cu
UPrQw5cTv3VJE20UE3SC7RVqgY8HMqZ5blbyevDdIf3Ci+4xkmis9i4NhC09B19t
UrzQ4CkuK+oZ+iTDoJp1/pfBk1E9p9Lb53nJ6ERwr/kcV2yuUDLmBpjTbtzp41ks
aB2IMkPO/5nSUOCM/RJoNaQVn2s9VWp6LmCreJ1ZvMDvwt3we1xHtt9BuVOCOc8T
4Y/ocX53COvSoNh9Vjn/XQ/JkBM2eQG9aJlR1qBDvCZ65ft9WJU4g9eY+7aGZ3iL
98ZqL+mREgYTZLyf9TL8oLHlEMc2xiZqA97BmpV7btAMQFLdgeAPMSxY535dObsw
Ih9AZKm33PyCTs1exJN4NBetSsPKA1Iwp7yWmcqr7R9qn1SwkUBZbpqkalOVVoC6
0s9DHtJDpql1yS0GOufhCDWIrH9FRM0kJNToN1Uv49v72cj1oenGyLDLVwfBs1Nt
rloH97RnpVrOqgLrJJh58CUSHSgcPMdk4PTtiujk0K5EYDIGYqwL6UCv0oKhkQ0v
95YGKkwipk1FiTt6CdVjTsWSQ++dAvmiTHurmqGk1nD+ZKZv/emTd8fW3rxfvK1X
ky0a1C5X0neJFb6EHmfh
=2Ljn
-----END PGP SIGNATURE-----

--3uOh6pdtAiXNsKCOwxrpVj0n25LBqGnmL--

--===============8277218285402594884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8277218285402594884==--
