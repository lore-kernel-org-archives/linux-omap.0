From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 1/4] pinctrl: single: Prepare for supporting SoC specific features
Date: Sat, 8 Jun 2013 17:37:36 +0800
Message-ID: <CAN1soZzLYpiakcgPR7mBOC7_mLFW=mZwOG98Dq6JpO+JHUW=cw@mail.gmail.com>
References: <20130607203936.16513.57494.stgit@localhost>
	<20130607205037.16513.84242.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:58470 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab3FHJhi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jun 2013 05:37:38 -0400
Received: by mail-ee0-f53.google.com with SMTP id c41so2077115eek.12
        for <linux-omap@vger.kernel.org>; Sat, 08 Jun 2013 02:37:36 -0700 (PDT)
In-Reply-To: <20130607205037.16513.84242.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Walleij Linus <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>

On Sat, Jun 8, 2013 at 4:50 AM, Tony Lindgren <tony@atomide.com> wrote:
> Let's replace is_pinconf with flags and add struct pcs_soc so we
> can support also other features like pin wake-up events. Let's
> export the probe so the SoC specific modules can pass their
> SoC specific data to pinctrl-single if needed.
>
> Done in collaboration with Roger Quadros <rogerq@ti.com>.
>

Manjunathappa's pinctrl-single patch on enhancing bits is already merged.
This patch conflicts with his patch.

Could you rebase your patches?

> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/pinctrl/pinctrl-single.c |   53 +++++++++++++++++++++++++++-----------
>  drivers/pinctrl/pinctrl-single.h |   15 +++++++++++
>  2 files changed, 52 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/pinctrl/pinctrl-single.h
>
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index b9fa046..0f178d1 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1368,7 +1367,8 @@ static int pcs_probe(struct platform_device *pdev)
>         INIT_LIST_HEAD(&pcs->pingroups);
>         INIT_LIST_HEAD(&pcs->functions);
>         INIT_LIST_HEAD(&pcs->gpiofuncs);
> -       pcs->is_pinconf = match->data;
> +       pcs->flags = soc->flags;
> +       pcs->soc = soc;
>
>         PCS_GET_PROP_U32("pinctrl-single,register-width", &pcs->width,
>                          "register width not specified\n");
> @@ -1437,7 +1437,7 @@ static int pcs_probe(struct platform_device *pdev)
>         pcs->desc.name = DRIVER_NAME;
>         pcs->desc.pctlops = &pcs_pinctrl_ops;
>         pcs->desc.pmxops = &pcs_pinmux_ops;
> -       if (pcs->is_pinconf)
> +       if (pcs->flags & PCS_HAS_PINCONF)
>                 pcs->desc.confops = &pcs_pinconf_ops;
>         pcs->desc.owner = THIS_MODULE;
>
> @@ -1466,8 +1466,20 @@ free:
>
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(pinctrl_single_probe);
> +
> +static int pcs_probe(struct platform_device *pdev)
> +{
> +       const struct of_device_id *match;
> +
> +       match = of_match_device(pcs_of_match, &pdev->dev);
> +       if (!match)
> +               return -EINVAL;
> +
> +       return pinctrl_single_probe(pdev, (struct pcs_soc *)match->data);
> +}

I think that you should declare pcs_probe() as EXPORT_SYMBOL_GPL.
Is it right?

>
> -static int pcs_remove(struct platform_device *pdev)
> +int pinctrl_single_remove(struct platform_device *pdev)
>  {
>         struct pcs_device *pcs = platform_get_drvdata(pdev);
>
> @@ -1478,17 +1490,26 @@ static int pcs_remove(struct platform_device *pdev)
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(pinctrl_single_remove);
Since you redefined pcs_probe(), you needn't change pcs_remove to
pinctrl_single_remove().

> +
> +static struct pcs_soc pinctrl_single = {
> +       .flags = 0,
> +};
> +
> +static struct pcs_soc pinconf_single = {
> +       .flags = PCS_HAS_PINCONF,
> +};
>
>  static struct of_device_id pcs_of_match[] = {
> -       { .compatible = "pinctrl-single", .data = (void *)false },
> -       { .compatible = "pinconf-single", .data = (void *)true },
> +       { .compatible = "pinctrl-single", .data = &pinctrl_single },
> +       { .compatible = "pinconf-single", .data = &pinconf_single },
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, pcs_of_match);
>
>  static struct platform_driver pcs_driver = {
>         .probe          = pcs_probe,
> -       .remove         = pcs_remove,
> +       .remove         = pinctrl_single_remove,
>         .driver = {
>                 .owner          = THIS_MODULE,
>                 .name           = DRIVER_NAME,
> diff --git a/drivers/pinctrl/pinctrl-single.h b/drivers/pinctrl/pinctrl-single.h
> new file mode 100644
> index 0000000..18f3205
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-single.h
> @@ -0,0 +1,15 @@

Do you need append "#ifndef __XX_H" to protect head file
over loading?

> +#define PCS_HAS_PINCONF         (1 << 0)
> +
> +/**
> + * struct pcs_soc - SoC specific interface to pinctrl-single
> + * @data:      SoC specific data pointer
> + * @flags:     mask of PCS_HAS_xxx values
> + */
> +struct pcs_soc {
> +       void *data;
> +       unsigned flags;
> +};
> +
> +extern int pinctrl_single_probe(struct platform_device *pdev,
> +                               const struct pcs_soc *soc);
> +extern int pinctrl_single_remove(struct platform_device *pdev);
>
