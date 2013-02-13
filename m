From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcpdm: Clean up with devm_*
	function
Date: Wed, 13 Feb 2013 14:17:09 +0100
Message-ID: <511B9255.7090505@ti.com>
References: <1360740114-4117-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1360740114-4117-1-git-send-email-s-guiriec@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On 02/13/2013 08:21 AM, Sebastien Guiriec wrote:
> Clean up McPDM driver with devm_ function.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
> ---
>  sound/soc/omap/omap-mcpdm.c |   14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
> index 5ca11bd..079f277 100644
> --- a/sound/soc/omap/omap-mcpdm.c
> +++ b/sound/soc/omap/omap-mcpdm.c
> @@ -369,7 +369,7 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
>  	pm_runtime_get_sync(mcpdm->dev);
>  	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, 0x00);
>  =

> -	ret =3D request_irq(mcpdm->irq, omap_mcpdm_irq_handler,
> +	ret =3D devm_request_irq(mcpdm->dev, mcpdm->irq, omap_mcpdm_irq_handler,
>  				0, "McPDM", (void *)mcpdm);
>  =

>  	pm_runtime_put_sync(mcpdm->dev);
> @@ -389,7 +389,6 @@ static int omap_mcpdm_remove(struct snd_soc_dai *dai)
>  {
>  	struct omap_mcpdm *mcpdm =3D snd_soc_dai_get_drvdata(dai);
>  =

> -	free_irq(mcpdm->irq, (void *)mcpdm);
>  	pm_runtime_disable(mcpdm->dev);
>  =

>  	return 0;
> @@ -465,14 +464,11 @@ static int asoc_mcpdm_probe(struct platform_device =
*pdev)
>  	if (res =3D=3D NULL)
>  		return -ENOMEM;
>  =

> -	if (!devm_request_mem_region(&pdev->dev, res->start,
> -				     resource_size(res), "McPDM"))
> -		return -EBUSY;
> -
> -	mcpdm->io_base =3D devm_ioremap(&pdev->dev, res->start,
> -				      resource_size(res));
> -	if (!mcpdm->io_base)
> +	mcpdm->io_base =3D devm_request_and_ioremap(&pdev->dev, res);
> +	if (!mcpdm->io_base) {
> +		dev_err(&pdev->dev, "cannot remap\n");
>  		return -ENOMEM;
> +	}
>  =

>  	mcpdm->irq =3D platform_get_irq(pdev, 0);
>  	if (mcpdm->irq < 0)
> =



-- =

P=E9ter
