From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: ti_am335x_tscadc: Update logic in CTRL register for
 5-wire TS
Date: Wed, 24 Sep 2014 12:26:00 +0100
Message-ID: <20140924112600.GJ19999@lee--X1>
References: <1409850117-5156-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409850117-5156-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Jeff Lance <j-lance1@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 04 Sep 2014, Sebastian Andrzej Siewior wrote:

> From: Jeff Lance <j-lance1@ti.com>
>=20
> The logic in AFE_Pen_Ctrl bitmask in the CTRL register is different f=
or five
> wire versus four or eight wire touschscreens. This patch should fix t=
his for
> five-wire touch screens. There should be no change needed here for fo=
ur and
> eight wire tousch screens.
>=20
> Signed-off-by: Jeff Lance <j-lance1@ti.com>
> [bigeasy: keep the change mfd only]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> I've been looking at moving this piece and the idle mode setting into=
 the
> TSC driver. Kinda odd that I have to patch within the MFD driver for =
this
> TSC related change.
> Anyone disagrees?
>=20
>  drivers/mfd/ti_am335x_tscadc.c       | 30 +++++++++++++++++---------=
----
>  include/linux/mfd/ti_am335x_tscadc.h |  1 +
>  2 files changed, 18 insertions(+), 13 deletions(-)

I hope this has been fully tested.

Looks like it could work though, so applied, thanks.

> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_t=
scadc.c
> index dd4bf5816221..6c9cfb8c1d01 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -241,18 +241,20 @@ static	int ti_tscadc_probe(struct platform_devi=
ce *pdev)
>  	tscadc_writel(tscadc, REG_CLKDIV, tscadc->clk_div);
> =20
>  	/* Set the control register bits */
> -	ctrl =3D CNTRLREG_STEPCONFIGWRT |
> -			CNTRLREG_STEPID;
> -	if (tsc_wires > 0)
> -		ctrl |=3D CNTRLREG_4WIRE | CNTRLREG_TSCENB;
> +	ctrl =3D CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
>  	tscadc_writel(tscadc, REG_CTRL, ctrl);
> =20
>  	/* Set register bits for Idle Config Mode */
> -	if (tsc_wires > 0)
> +	if (tsc_wires > 0) {
> +		tscadc->tsc_wires =3D tsc_wires;
> +		if (tsc_wires =3D=3D 5)
> +			ctrl |=3D CNTRLREG_5WIRE | CNTRLREG_TSCENB;
> +		else
> +			ctrl |=3D CNTRLREG_4WIRE | CNTRLREG_TSCENB;
>  		tscadc_idle_config(tscadc);
> +	}
> =20
>  	/* Enable the TSC module enable bit */
> -	ctrl =3D tscadc_readl(tscadc, REG_CTRL);
>  	ctrl |=3D CNTRLREG_TSCSSENB;
>  	tscadc_writel(tscadc, REG_CTRL, ctrl);
> =20
> @@ -324,21 +326,23 @@ static int tscadc_suspend(struct device *dev)
>  static int tscadc_resume(struct device *dev)
>  {
>  	struct ti_tscadc_dev	*tscadc_dev =3D dev_get_drvdata(dev);
> -	unsigned int restore, ctrl;
> +	u32 ctrl;
> =20
>  	pm_runtime_get_sync(dev);
> =20
>  	/* context restore */
>  	ctrl =3D CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> -	if (tscadc_dev->tsc_cell !=3D -1)
> -		ctrl |=3D CNTRLREG_TSCENB | CNTRLREG_4WIRE;
>  	tscadc_writel(tscadc_dev, REG_CTRL, ctrl);
> =20
> -	if (tscadc_dev->tsc_cell !=3D -1)
> +	if (tscadc_dev->tsc_cell !=3D -1) {
> +		if (tscadc_dev->tsc_wires =3D=3D 5)
> +			ctrl |=3D CNTRLREG_5WIRE | CNTRLREG_TSCENB;
> +		else
> +			ctrl |=3D CNTRLREG_4WIRE | CNTRLREG_TSCENB;
>  		tscadc_idle_config(tscadc_dev);
> -	restore =3D tscadc_readl(tscadc_dev, REG_CTRL);
> -	tscadc_writel(tscadc_dev, REG_CTRL,
> -			(restore | CNTRLREG_TSCSSENB));
> +	}
> +	ctrl |=3D CNTRLREG_TSCSSENB;
> +	tscadc_writel(tscadc_dev, REG_CTRL, ctrl);
> =20
>  	tscadc_writel(tscadc_dev, REG_CLKDIV, tscadc_dev->clk_div);
> =20
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd=
/ti_am335x_tscadc.h
> index fb96c84dada5..e2e70053470e 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -155,6 +155,7 @@ struct ti_tscadc_dev {
>  	void __iomem *tscadc_base;
>  	int irq;
>  	int used_cells;	/* 1-2 */
> +	int tsc_wires;
>  	int tsc_cell;	/* -1 if not used */
>  	int adc_cell;	/* -1 if not used */
>  	struct mfd_cell cells[TSCADC_CELLS];

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
