From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-hdmi-audio: Add missing error
	check for devm_kzalloc
Date: Thu, 12 Feb 2015 11:22:41 +0200
Message-ID: <54DC70E1.50300@ti.com>
References: <1423732082-23815-1-git-send-email-kiran.padwal@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1423732082-23815-1-git-send-email-kiran.padwal@smartplayin.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kiran Padwal <kiran.padwal@smartplayin.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, "Sarha,
 Jyri" <jsarha@ti.com>, Kiran Padwal <kiran.padwal21@gmail.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On 02/12/2015 11:08 AM, Kiran Padwal wrote:
> This patch add a missing check on the return value of devm_kzalloc,
> which would cause a NULL pointer dereference in a OOM situation.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
> ---
>  sound/soc/omap/omap-hdmi-audio.c |    3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-=
audio.c
> index ccfb41c..f7eb42a 100644
> --- a/sound/soc/omap/omap-hdmi-audio.c
> +++ b/sound/soc/omap/omap-hdmi-audio.c
> @@ -352,6 +352,9 @@ static int omap_hdmi_audio_probe(struct platform_devi=
ce *pdev)
>  		return ret;
>  =

>  	card =3D devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
> +	if (!card)
> +		return -ENOMEM;
> +
>  	card->name =3D devm_kasprintf(dev, GFP_KERNEL,
>  				    "HDMI %s", dev_name(ad->dssdev));
>  	card->owner =3D THIS_MODULE;
> =



-- =

P=E9ter
