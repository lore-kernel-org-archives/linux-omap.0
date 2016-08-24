From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH -next] ASoC: omap-abe-twl6040: Use
 devm_snd_soc_register_card()
Date: Wed, 24 Aug 2016 10:01:51 +0300
Message-ID: <6b695e17-37b4-6c53-04df-be21fe28a97d@ti.com>
References: <1471993817-10903-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1471993817-10903-1-git-send-email-weiyj.lk@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>
List-Id: linux-omap@vger.kernel.org

On 08/24/16 02:10, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> =

> Using devm_snd_soc_register_card() can make the code
> shorter and cleaner.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/omap/omap-abe-twl6040.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-=
twl6040.c
> index f61b3b5..89fe95e 100644
> --- a/sound/soc/omap/omap-abe-twl6040.c
> +++ b/sound/soc/omap/omap-abe-twl6040.c
> @@ -305,23 +305,14 @@ static int omap_abe_probe(struct platform_device *p=
dev)
>  =

>  	snd_soc_card_set_drvdata(card, priv);
>  =

> -	ret =3D snd_soc_register_card(card);
> +	ret =3D devm_snd_soc_register_card(&pdev->dev, card);
>  	if (ret)
> -		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
> +		dev_err(&pdev->dev, "devm_snd_soc_register_card() failed: %d\n",
>  			ret);
>  =

>  	return ret;
>  }
>  =

> -static int omap_abe_remove(struct platform_device *pdev)
> -{
> -	struct snd_soc_card *card =3D platform_get_drvdata(pdev);
> -
> -	snd_soc_unregister_card(card);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id omap_abe_of_match[] =3D {
>  	{.compatible =3D "ti,abe-twl6040", },
>  	{ },
> @@ -335,7 +326,6 @@ static struct platform_driver omap_abe_driver =3D {
>  		.of_match_table =3D omap_abe_of_match,
>  	},
>  	.probe =3D omap_abe_probe,
> -	.remove =3D omap_abe_remove,
>  };
>  =

>  static int __init omap_abe_init(void)
> =

> =

> =



-- =

P=E9ter
