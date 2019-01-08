From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: syscon: Fix syscon name for device tree
Date: Mon, 7 Jan 2019 16:15:43 -0800
Message-ID: <20190108001543.GJ5544@atomide.com>
References: <20190108000558.54914-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190108000558.54914-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190108 00:06]:
> I'm now seeing the following error on omap5 during boot:
> 
> (NULL device *): Failed to create dummy-scm_conf@0 debugfs directory
> 
> This is because we have two separate scm_conf syscon regions in the
> dts. Let's fix the issue by setting a proper name if syscon is
> configured via device tree.
> 
> See also related fix for commit 500f9ff518cf ("mfd: syscon: Set name
> of regmap_config").
> 
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/syscon.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -241,6 +241,8 @@ static int syscon_probe(struct platform_device *pdev)
>  	syscon_config.max_register = res->end - res->start - 3;
>  	if (pdata)
>  		syscon_config.name = pdata->label;
> +	else
> +		syscon_config.name = dev_name(dev);
>  	syscon->regmap = devm_regmap_init_mmio(dev, base, &syscon_config);
>  	if (IS_ERR(syscon->regmap)) {
>  		dev_err(dev, "regmap init failed\n");

Hmm this fixes the error, but I'm still seeing only one
entry for /sys/kernel/debug/regmap/dummy-scm_conf@0.

Anybody got better ideas for setting the default name,
maybe dev->of_node->name if it exists?

Regards,

Tony
