From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-dmic: use managed interfaces
Date: Thu, 10 Jul 2014 09:30:23 +0300
Message-ID: <53BE32FF.80601@ti.com>
References: <20140709212112.GA11848@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20140709212112.GA11848@himangi-Dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Himangi Saraogi <himangi774@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: linux-omap@vger.kernel.org

On 07/10/2014 12:21 AM, Himangi Saraogi wrote:
> This patch moves data allocated using clk_put and
> snd_soc_register_component to the corresponding managed interfaces and
> does away with the functions to free memory in the probe and remove
> functions. The probe function is no longer required and is completely
> removed.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  sound/soc/omap/omap-dmic.c | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
> index 6925d71..b315b27 100644
> --- a/sound/soc/omap/omap-dmic.c
> +++ b/sound/soc/omap/omap-dmic.c
> @@ -466,7 +466,7 @@ static int asoc_dmic_probe(struct platform_device *pd=
ev)
>  =

>  	mutex_init(&dmic->mutex);
>  =

> -	dmic->fclk =3D clk_get(dmic->dev, "fck");
> +	dmic->fclk =3D devm_clk_get(dmic->dev, "fck");
>  	if (IS_ERR(dmic->fclk)) {
>  		dev_err(dmic->dev, "cant get fck\n");
>  		return -ENODEV;
> @@ -475,8 +475,7 @@ static int asoc_dmic_probe(struct platform_device *pd=
ev)
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
>  	if (!res) {
>  		dev_err(dmic->dev, "invalid dma memory resource\n");
> -		ret =3D -ENODEV;
> -		goto err_put_clk;
> +		return -ENODEV;
>  	}
>  	dmic->dma_data.addr =3D res->start + OMAP_DMIC_DATA_REG;
>  =

> @@ -484,34 +483,17 @@ static int asoc_dmic_probe(struct platform_device *=
pdev)
>  =

>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
>  	dmic->io_base =3D devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(dmic->io_base)) {
> -		ret =3D PTR_ERR(dmic->io_base);
> -		goto err_put_clk;
> -	}
> -
> +	if (IS_ERR(dmic->io_base))
> +		return PTR_ERR(dmic->io_base);
>  =

> -	ret =3D snd_soc_register_component(&pdev->dev, &omap_dmic_component,
> -					 &omap_dmic_dai, 1);
> +	ret =3D devm_snd_soc_register_component(&pdev->dev, &omap_dmic_componen=
t,
> +					      &omap_dmic_dai, 1);
>  	if (ret)
> -		goto err_put_clk;
> +		return ret;
>  =

>  	ret =3D omap_pcm_platform_register(&pdev->dev);
>  	if (ret)
> -		goto err_put_clk;
> -
> -	return 0;
> -
> -err_put_clk:
> -	clk_put(dmic->fclk);
> -	return ret;
> -}
> -
> -static int asoc_dmic_remove(struct platform_device *pdev)
> -{
> -	struct omap_dmic *dmic =3D platform_get_drvdata(pdev);
> -
> -	snd_soc_unregister_component(&pdev->dev);
> -	clk_put(dmic->fclk);
> +		return ret;
>  =

>  	return 0;
>  }
> @@ -529,7 +511,6 @@ static struct platform_driver asoc_dmic_driver =3D {
>  		.of_match_table =3D omap_dmic_of_match,
>  	},
>  	.probe =3D asoc_dmic_probe,
> -	.remove =3D asoc_dmic_remove,
>  };
>  =

>  module_platform_driver(asoc_dmic_driver);
> =



-- =

P=E9ter
