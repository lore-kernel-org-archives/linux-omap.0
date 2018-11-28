From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: ti_am335x_tscadc: Provide unique name for child
 mfd cells
Date: Wed, 28 Nov 2018 09:07:26 +0000
Message-ID: <20181128090726.GS4272@dell>
References: <20181119064236.28902-1-vigneshr@ti.com>
 <20181119064236.28902-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119064236.28902-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 19 Nov 2018, Vignesh R wrote:

> Provide unique names for child mfd cells, this is required in order to
> support registering of multiple instances of same ti_am335x_tscadc IP.

I don't think it is.  What is the error you are receiving?

> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index c2d47d78705b..ee08af34f81d 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -248,7 +248,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (tsc_wires > 0) {
>  		tscadc->tsc_cell = tscadc->used_cells;
>  		cell = &tscadc->cells[tscadc->used_cells++];
> -		cell->name = "TI-am335x-tsc";
> +		cell->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s:%s",
> +					    dev_name(&pdev->dev), "tsc");
>  		cell->of_compatible = "ti,am3359-tsc";
>  		cell->platform_data = &tscadc;
>  		cell->pdata_size = sizeof(tscadc);
> @@ -258,7 +259,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (adc_channels > 0) {
>  		tscadc->adc_cell = tscadc->used_cells;
>  		cell = &tscadc->cells[tscadc->used_cells++];
> -		cell->name = "TI-am335x-adc";
> +		cell->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s:%s",
> +					    dev_name(&pdev->dev), "adc");
>  		cell->of_compatible = "ti,am3359-adc";
>  		cell->platform_data = &tscadc;
>  		cell->pdata_size = sizeof(tscadc);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
