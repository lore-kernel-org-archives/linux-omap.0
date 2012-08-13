From: Matthias Kaehlcke <matthias.list@kaehlcke.net>
Subject: Re: [PATCH] mfd/regulator: tps65217: Move regulator plat data
 handling to regulator
Date: Mon, 13 Aug 2012 10:27:32 +0200
Message-ID: <20120813082732.GA31722@darwin>
References: <1342776601-8773-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1342776601-8773-1-git-send-email-anilkumar@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, sameo@linux.intel.com, dan.carpenter@oracle.com, rdunlap@xenotime.net, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

El Fri, Jul 20, 2012 at 03:00:01PM +0530 AnilKumar Ch ha dit:

> Regulator platform data handling was mistakenly added to MFD
> driver. So we will see build errors if we compile MFD drivers
> without CONFIG_REGULATOR. This patch moves regulator platform
> data handling from TPS65217 MFD driver to regulator driver.
> 
>
> diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
> index 6caa222..9730f1d 100644
> --- a/drivers/regulator/tps65217-regulator.c
> +++ b/drivers/regulator/tps65217-regulator.c
>
> +static struct tps65217_board *tps65217_parse_dt(struct platform_device *pdev)
> +{
> +	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
> +	struct device_node *node = tps->dev->of_node;
> +	struct tps65217_board *pdata;
> +	struct device_node *regs;
> +	int i, count;
> +
> +	regs = of_find_node_by_name(node, "regulators");
> +	if (!regs)
> +		return NULL;
> +
> +	count = of_regulator_match(pdev->dev.parent, regs,
> +				reg_matches, TPS65217_NUM_REGULATOR);
> +	of_node_put(regs);
> +	if ((count < 0) || (count > TPS65217_NUM_REGULATOR))
> +		return NULL;
> +
> +	pdata = devm_kzalloc(&pdev->dev, count * sizeof(*pdata),
> GFP_KERNEL);

this allocates a struct tps65217_board for each regulator specified in
the device tree. the structure itself provides arrays for the pointers
to the regulator init data and the regulator device tree node, so only
one instance of it is needed

also the tps65217_board structure should be renamed to something like
tps65217_regulators, now that it is specific to the regulator
driver. besides the regulators the tps65217 can have other subdevices,
so for the non device tree use case it makes sense to keep a chip wide
platform data structure around which contains the subdevice specific
ones

best regards

-- 
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

                   If you pay peanuts, you get monkeys
                           (James Goldsmith)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
