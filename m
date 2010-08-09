From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 09/13 v5] OMAP: GPIO: Introduce support for OMAP2PLUS chip GPIO init
Date: Mon, 09 Aug 2010 16:58:49 -0700
Message-ID: <87eie7bao6.fsf@deeprootsystems.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
	<1281098065-24177-3-git-send-email-charu@ti.com>
	<1281098065-24177-4-git-send-email-charu@ti.com>
	<1281098065-24177-5-git-send-email-charu@ti.com>
	<1281098065-24177-6-git-send-email-charu@ti.com>
	<1281098065-24177-7-git-send-email-charu@ti.com>
	<1281098065-24177-8-git-send-email-charu@ti.com>
	<1281098065-24177-9-git-send-email-charu@ti.com>
	<1281098065-24177-10-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33563 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757318Ab0HIX6w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 19:58:52 -0400
Received: by pwj7 with SMTP id 7so1535020pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 09 Aug 2010 16:58:52 -0700 (PDT)
In-Reply-To: <1281098065-24177-10-git-send-email-charu@ti.com> (Charulatha
	V.'s message of "Fri, 6 Aug 2010 18:04:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, "Basak, Partha" <p-basak2@ti.com>

Charulatha V <charu@ti.com> writes:

> This patch adds support for handling GPIO as a HWMOD FW adapted
> platform device for OMAP2PLUS chips.
>
> gpio_init needs to be done before machine_init functions access
> gpio APIs.Hence gpio_init is made as a postcore_initcall.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Basak, Partha <p-basak2@ti.com>
> ---

[...]

> +static int omap2_init_gpio(struct omap_hwmod *oh, void *user)
> +{
> +	struct omap_device *od;
> +	struct omap_gpio_platform_data *pdata;
> +	char *name = "omap-gpio";
> +	static int id;
> +	struct omap_gpio_dev_attr *gpio_dev_data;
> +
> +	if (!oh) {
> +		pr_err("Could not look up omap gpio %d\n", id + 1);
> +		return -EINVAL;
> +	}
> +
> +	pdata = kzalloc(sizeof(struct omap_gpio_platform_data),
> +					GFP_KERNEL);
> +	if (!pdata) {
> +		pr_err("Memory allocation failed gpio%d\n", id + 1);
> +		return -ENOMEM;
> +	}
> +
> +	gpio_dev_data = (struct omap_gpio_dev_attr *)oh->dev_attr;
> +
> +	pdata->gpio_attr = gpio_dev_data;
> +	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * id;
> +	switch (oh->class->rev) {
> +	case 0:
> +	case 1:
> +		pdata->bank_type = METHOD_GPIO_24XX;
> +		break;
> +	case 2:
> +		pdata->bank_type = METHOD_GPIO_44XX;
> +		break;
> +	default:
> +		WARN(1, "Invalid gpio bank_type\n");
> +		break;
> +	}
> +	gpio_bank_count++;
> +
> +	od = omap_device_build(name, id, oh, pdata,
> +				sizeof(*pdata),	omap_gpio_latency,
> +				ARRAY_SIZE(omap_gpio_latency),
> +				false);
> +	WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
> +				name, oh->name);
> +

pdata should be free'd here as omap_device_build makes a copy for
itself.

Kevin
