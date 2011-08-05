From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 3/4] omap: smps: add smps regulator init to voltage.c
Date: Fri, 05 Aug 2011 14:54:41 -0700
Message-ID: <87k4arr0bi.fsf@ti.com>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com>
	<1311853739-18984-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:51966 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752786Ab1HEVyo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 17:54:44 -0400
Received: by mail-gw0-f52.google.com with SMTP id 15so3749748gwj.25
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 14:54:43 -0700 (PDT)
In-Reply-To: <1311853739-18984-4-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Thu, 28 Jul 2011 14:48:58 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> All voltagedomains that have support for vc and vp are now automatically
> registered with SMPS regulator driver. Voltage.c builds a platform device
> structure for this purpose during late init.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

[...]

> +static void smps_add_regulator(struct platform_device *smps_dev,
> +			       struct voltagedomain *voltdm)
> +{
> +	struct omap_smps_platform_data *info;
> +	struct regulator_init_data *init_data;
> +	struct regulator_consumer_supply *supply;
> +
> +	if (!smps_dev || !voltdm)
> +		return;
> +
> +	info = smps_dev->dev.platform_data;
> +
> +	init_data = kzalloc(sizeof(struct regulator_init_data), GFP_KERNEL);
> +	supply = kzalloc(sizeof(struct regulator_consumer_supply), GFP_KERNEL);
> +
> +	if (!init_data || !supply) {
> +		kfree(init_data);
> +		kfree(supply);
> +		return;
> +	}
> +	supply->supply = "vcc";
> +	supply->dev_name = voltdm->name;
> +	init_data->constraints.min_uV = 600000;
> +	init_data->constraints.max_uV = 1450000;

These values should come from the OMAP/PMIC limitations, not from hard
coded values.

Kevin
