From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: hdmi: Reconfigure and restart
 audio when display is enabled
Date: Fri, 28 Aug 2015 16:04:32 +0300
Message-ID: <55E05C60.2090400@ti.com>
References: <1440764660-10417-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5289489441173830985=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1440764660-10417-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com
List-Id: linux-omap@vger.kernel.org

--===============5289489441173830985==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uNxNaqpBGd0I5KtthamrM5fxvUM0EjG4q"

--uNxNaqpBGd0I5KtthamrM5fxvUM0EjG4q
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 28/08/15 15:24, Jyri Sarha wrote:
> Reconfigure and restart audio when display is enabled, if audio
> playback was active before. The audio configuration is stored when is

'is' -> 'it' above

> is successfully applied and a boolean is set when playback has started
> and unset when stopped. This data is used to reconfigure the audio
> when display is re-enabled. Abort audio playback if reconfiguration
> fails.

It would be good to start the description by telling what the current
problem is. And probably the subject could also be better... This fixes
the audio playback when a video mode change happens (or such), right?

> A new spin lock is introduced in order to protect state variables
> related to audio playback status. This is needed for the transitions
> from display enabled state (when audio start/stop commands can be
> written to HW) to display disabled state (when audio start/stop
> commands update only the hdmi.audio_playing variable) to always
> serialize correctly with the start/stop audio commands.
>=20
> For example: when display is turned back on we take the spinlock and
> we can be sure that the audio start/stop status won't change while we
> update the HW according to hdmi.audio_playing state and set
> hdmi.display_enabled to true. After releasing the lock
> hdmi.display_enabled is true and all audio_start and audio_stop
> commands write their stuff directly to HW.

The question is (which was my point in the earlier mail), we already
have mutex, so why a new spinlock?

I think the answer is that audio start/stop (anything else?) are called
in atomic context, so mutex cannot be used.

Also (not exactly related to this patch), if the audio callbacks must be
atomic, could we use a workqueue to run the audio start/stop work in
non-atomic context? Protecting the whole hdmi state with a single mutex
would be much nicer.

> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
> I dropped the ASoC maintainers from the recipient list as this patch
> hardly concerns them.
>=20
>  drivers/video/fbdev/omap2/dss/hdmi.h  |  9 +++-
>  drivers/video/fbdev/omap2/dss/hdmi4.c | 69 +++++++++++++++++++++++++--=
---
>  drivers/video/fbdev/omap2/dss/hdmi5.c | 79 +++++++++++++++++++++++++++=
+-------
>  3 files changed, 130 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev=
/omap2/dss/hdmi.h
> index e4a32fe..e48aefd 100644
> --- a/drivers/video/fbdev/omap2/dss/hdmi.h
> +++ b/drivers/video/fbdev/omap2/dss/hdmi.h
> @@ -351,13 +351,20 @@ struct omap_hdmi {
>  	struct regulator *vdda_reg;
> =20
>  	bool core_enabled;
> -	bool display_enabled;
> =20
>  	struct omap_dss_device output;
> =20
>  	struct platform_device *audio_pdev;
>  	void (*audio_abort_cb)(struct device *dev);
>  	int wp_idlemode;
> +
> +	bool audio_configured;
> +	struct omap_dss_audio audio_config;
> +
> +	/* This lock should be taken when booleas bellow is touched. */

typo above.

Otherwise, looks much cleaner than the previous one. I tested it and
worked fine for me: I could play audio while turning on and off the
video output, and the audio would resume, except when the video was off
for long enough.

 Tomi


--uNxNaqpBGd0I5KtthamrM5fxvUM0EjG4q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV4FxhAAoJEPo9qoy8lh711rIQAKwvsWUzHExdF7F3ERL2MjH6
ytRDux1MCw6rWix4ZX1DODI6uWrAkreA56eS7ptoc1aw7fecdJwyYlr74RmNL7go
u5uEBCZFDsuRn5kcz6QqyCmy8/XBaCTdRJ5nUucZFon0rbw+UBYZ4aEBPYR0hdoz
4aRyNXpG/PRn4oo6+xSS9PJrHvp72lHKAYugxCyhFjYpr/VyckW+pgfbWNKIVCeQ
sJQvw/VYJkktTOVX78qH7UQTZCIDu/dxyQCYuV3L3u6zfZxiybv4r/kF2SizOaZ7
pv7X+ovSJbmicHlQfa+dIG8ZTkn4fYnZDwIXyE2CQqV19og3y4wforqKYJg187oG
TY9cROiuRWsznhJaD6Htz0fCOJPDHCcmHEuQ8CwJII41CgW4Bp6lquD36uEk5/os
aZGwU2auO06KKvLJ+mBHoRNk3R2us8qgMknCIwHrl6yCzdal0eiA0bXnuocAV1en
8Wlz07XWo5TYkqwvfoZITe7PwzYllmdp8GMkaeWFlboy1p45A2y0dktLTR/ajyuu
YWMSLkpzBlWCfR8wxmj2+dqW68gM3UZf1LiQvp9GiAArFva4WplqCem9rDCnbzL+
FB5Gor5eUqFIo09XpdA70aGhlBwbm+xmWtOiG3uY2MuWuF5IZeZAZmiNCfxbHuy2
VbqXrFXyu8jybiej1Moj
=ThpX
-----END PGP SIGNATURE-----

--uNxNaqpBGd0I5KtthamrM5fxvUM0EjG4q--

--===============5289489441173830985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5289489441173830985==--
