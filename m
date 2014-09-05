From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH V2 3/3] mfd: palmas: Add support for optional wakeup
Date: Fri, 5 Sep 2014 23:13:38 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1409052311210.5472@nanos>
References: <1409950311-25236-1-git-send-email-nm@ti.com> <1409950311-25236-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409950311-25236-4-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 5 Sep 2014, Nishanth Menon wrote:
> +	if (!palmas->wakeirq)
> +		goto no_wake_irq;
> +
> +	ret = devm_request_irq(palmas->dev, palmas->wakeirq,
> +			       palmas_wake_irq,
> +			       IRQF_ONESHOT | pdata->irq_flags,

Why is this marked IRQF_ONESHOT?

> +			       dev_name(palmas->dev),
> +			       &palmas);
> +	if (ret < 0)
> +		goto err_i2c;

Why err and not doing the obvious clearing of palmas->wakeirq and
keep at least the i2c functional?

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
