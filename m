From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: hdmi: Reconfigure and restart
 audio when display is enabled
Date: Fri, 28 Aug 2015 13:37:48 +0300
Message-ID: <55E039FC.8090707@ti.com>
References: <cover.1440594174.git.jsarha@ti.com>
 <44089dc819903c71e1d0ed0c14dd3ab060ed8c68.1440594174.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5457779316318902483=="
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
To: Jyri Sarha <jsarha@ti.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============5457779316318902483==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5w4dupJFCaf6moRaT6cCk9Q4Fvqd3Ch1g"

--5w4dupJFCaf6moRaT6cCk9Q4Fvqd3Ch1g
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 26/08/15 16:11, Jyri Sarha wrote:

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
> +	if (hdmi.audio_configured) {
> +		spin_lock_irqsave(&hdmi.audio_playing_lock, flags);
> +		hdmi_wp_audio_core_req_enable(&hdmi.wp, false);
> +		hdmi_wp_audio_enable(&hdmi.wp, false);
> +		if (hdmi.wp_idlemode > 0)
> +			REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG,
> +				    hdmi.wp_idlemode, 3, 2);
> +		hdmi.wp_idlemode =3D -1;
> +		spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);

Here I think the audio HW is always disabled already. It has to be,
because the whole HDMI IP has been off. So the above should not be needed=
=2E

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
> +	}
>  	hdmi.display_enabled =3D true;
> +	spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);

Maybe you've looked at the locking carefully, but it's not obvious to
me. So is hdmi_audio_start and hdmi_audio_stop the only functions that
are called from atomic context? Every other function is protected with
the mutex?

 Tomi


--5w4dupJFCaf6moRaT6cCk9Q4Fvqd3Ch1g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV4Dn8AAoJEPo9qoy8lh71nXYP/27J5UYkq3O+u2WSMS8W1gvx
TlLeHNYTkBpGOgNhme7+XF/jq+v8Gg/ejBrjYsP8ftZRRQGZ18vgmlTGr9lNWbb8
YshWeP5VSQ0r9VmgN6/jZloBJqsHjdRwQFm8c5E8ndnFwltoCnc6tPXSXS1iheQd
OPiYKIFkr8t0YEIGvzOI9zqkdmEJ+w4TPyq9jAfidTBYFFKjPi/3hPGeOi9TtKJ4
Xw12+h4A6GCLvnshHD/Prrsa/5oVrnsx4BpTK7pY7VLEcXEjKgDwMUFb7v3uAPPV
J8X3jPZ2m3Zv77/u20XvNDkwRdNTebgDEoSRBvpj1qCneSBNrkP0KC0Dg09EnfE8
lKgipg6YzbAoWfjFW/1eDLZreVfnZPNueaJa8vQFRGsfSt/LqdBHKgI59ba/iQKE
0ny6V3ZGw/hplzLsuLJG0je7zAuAFWsLcvEnmpuASj9TvG39Jvcgn0FNDQ1yT0Tf
LTTzFzOZJ97ttJv9XrVKSMckDbpYodYjp1xvQmGID7sj8KoWRsqAVhSFfhhURxGh
pTnk/SHtQq3EnI5IIz2OqFftbv/u/o6toATqiZglw7ZEyOdyOIIzP1zb9t3jCgDv
L4TOoJNrDvvKRCn5Ml4QjKv0KqIzyh3O6U9IY9RFAJYkxXcJV2ar1tOw50l4hNBf
mIXgCkpfjrVGRB7ZozjE
=mIy+
-----END PGP SIGNATURE-----

--5w4dupJFCaf6moRaT6cCk9Q4Fvqd3Ch1g--

--===============5457779316318902483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5457779316318902483==--
