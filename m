From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] omap: convert to devm_ioremap_resource()
Date: Tue, 12 Mar 2013 09:16:20 +0100
Message-ID: <513EE454.5040302@ti.com>
References: <1363017537-11602-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1363017537-11602-1-git-send-email-silviupopescu1990@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 03/11/2013 04:58 PM, Silviu-Mihai Popescu wrote:
> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
> =

> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.

I believe both of the drivers has been patched for this:
omap-mcbpdm:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-February/059484.h=
tml
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-February/059427.h=
tml

omap-dmic:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-February/059485.h=
tml

and they should be already queued for next.

-- =

P=E9ter

> =

> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
> ---
>  sound/soc/omap/omap-dmic.c  |    9 +++------
>  sound/soc/omap/omap-mcpdm.c |    8 +++-----
>  2 files changed, 6 insertions(+), 11 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
> index 77e9e7e..8ebaf11 100644
> --- a/sound/soc/omap/omap-dmic.c
> +++ b/sound/soc/omap/omap-dmic.c
> @@ -493,12 +493,9 @@ static int asoc_dmic_probe(struct platform_device *p=
dev)
>  		goto err_put_clk;
>  	}
>  =

> -	dmic->io_base =3D devm_request_and_ioremap(&pdev->dev, res);
> -	if (!dmic->io_base) {
> -		dev_err(&pdev->dev, "cannot remap\n");
> -		ret =3D -ENOMEM;
> -		goto err_put_clk;
> -	}
> +	dmic->io_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(dmic->io_base))
> +		return PTR_ERR(dmic->io_base);
>  =

>  	ret =3D snd_soc_register_dai(&pdev->dev, &omap_dmic_dai);
>  	if (ret)
> diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
> index 079f277..ddfcc18 100644
> --- a/sound/soc/omap/omap-mcpdm.c
> +++ b/sound/soc/omap/omap-mcpdm.c
> @@ -464,11 +464,9 @@ static int asoc_mcpdm_probe(struct platform_device *=
pdev)
>  	if (res =3D=3D NULL)
>  		return -ENOMEM;
>  =

> -	mcpdm->io_base =3D devm_request_and_ioremap(&pdev->dev, res);
> -	if (!mcpdm->io_base) {
> -		dev_err(&pdev->dev, "cannot remap\n");
> -		return -ENOMEM;
> -	}
> +	mcpdm->io_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(mcpdm->io_base))
> +		return PTR_ERR(mcpdm->io_base);
>  =

>  	mcpdm->irq =3D platform_get_irq(pdev, 0);
>  	if (mcpdm->irq < 0)
> =
