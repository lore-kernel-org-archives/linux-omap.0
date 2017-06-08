From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: host: omap_hsmmc: use mmc_regulator_get_supply()
 to get regulators
Date: Thu, 8 Jun 2017 09:12:40 +0200
Message-ID: <CAPDyKFrsrUYTmpYE9WYgCfvNkvhtfaFDXUrgr8rxtNVUk0BxTQ@mail.gmail.com>
References: <20170607083612.14224-1-kishon@ti.com> <20170607083612.14224-3-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20170607083612.14224-3-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

>         host->pbias = devm_regulator_get_optional(host->dev, "pbias");
> @@ -2143,7 +2136,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_irq;
>
> -       mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
> +       if (mmc_pdata(host)->ocr_mask)
> +               mmc->ocr_avail = mmc_pdata(host)->ocr_mask;

This should rather be:

if (!mmc->ocr_avail)
     mmc->ocr_avail = mmc_pdata(host)->ocr_mask

In other words, fall back to the platform ocr mask.

>
>         omap_hsmmc_disable_irq(host);
>
> --
> 2.11.0
>

Kind regards
Uffe
