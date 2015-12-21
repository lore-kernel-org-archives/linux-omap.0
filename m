From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/4] ASoC: omap-hdmi-audio: add NULL test
Date: Mon, 21 Dec 2015 11:35:18 +0200
Message-ID: <5677C7D6.3030909@ti.com>
References: <1450610153-7746-1-git-send-email-Julia.Lawall@lip6.fr>
 <1450610153-7746-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1450610153-7746-3-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, "Sarha, Jyri" <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On 12/20/2015 01:15 PM, Julia Lawall wrote:
> Add NULL test on call to devm_kzalloc.
> =

> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> =

> // <smpl>
> @@
> expression x;
> identifier fld;
> @@
> =

> * x =3D devm_kzalloc(...);
>   ... when !=3D x =3D=3D NULL
>   x->fld
> // </smpl>
> =

> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/omap/omap-hdmi-audio.c |    2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-=
audio.c
> index 584b237..f83cc2b 100644
> --- a/sound/soc/omap/omap-hdmi-audio.c
> +++ b/sound/soc/omap/omap-hdmi-audio.c
> @@ -368,6 +368,8 @@ static int omap_hdmi_audio_probe(struct platform_devi=
ce *pdev)
>  	card->owner =3D THIS_MODULE;
>  	card->dai_link =3D
>  		devm_kzalloc(dev, sizeof(*(card->dai_link)), GFP_KERNEL);
> +	if (!card->dai_link)
> +		return -ENOMEM;
>  	card->dai_link->name =3D card->name;
>  	card->dai_link->stream_name =3D card->name;
>  	card->dai_link->cpu_dai_name =3D dev_name(ad->dssdev);
> =



-- =

P=E9ter
