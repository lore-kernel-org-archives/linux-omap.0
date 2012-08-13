From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] mfd/regulator: tps65217: Move regulator plat data
 handling to regulator
Date: Mon, 13 Aug 2012 13:35:55 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA11ABF@DBDE01.ent.ti.com>
References: <1342776601-8773-1-git-send-email-anilkumar@ti.com>
 <20120813082732.GA31722@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20120813082732.GA31722@darwin>
Content-Language: en-US
Sender: linux-next-owner@vger.kernel.org
To: Matthias Kaehlcke <matthias.list@kaehlcke.net>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Matthias,

On Mon, Aug 13, 2012 at 13:57:32, Matthias Kaehlcke wrote:
> Hi,
> 
> El Fri, Jul 20, 2012 at 03:00:01PM +0530 AnilKumar Ch ha dit:
> 
> > Regulator platform data handling was mistakenly added to MFD
> > driver. So we will see build errors if we compile MFD drivers
> > without CONFIG_REGULATOR. This patch moves regulator platform
> > data handling from TPS65217 MFD driver to regulator driver.
> > 
> >
> > diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
> > index 6caa222..9730f1d 100644
> > --- a/drivers/regulator/tps65217-regulator.c
> > +++ b/drivers/regulator/tps65217-regulator.c
> >
> > +static struct tps65217_board *tps65217_parse_dt(struct platform_device *pdev)
> > +{
> > +	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
> > +	struct device_node *node = tps->dev->of_node;
> > +	struct tps65217_board *pdata;
> > +	struct device_node *regs;
> > +	int i, count;
> > +
> > +	regs = of_find_node_by_name(node, "regulators");
> > +	if (!regs)
> > +		return NULL;
> > +
> > +	count = of_regulator_match(pdev->dev.parent, regs,
> > +				reg_matches, TPS65217_NUM_REGULATOR);
> > +	of_node_put(regs);
> > +	if ((count < 0) || (count > TPS65217_NUM_REGULATOR))
> > +		return NULL;
> > +
> > +	pdata = devm_kzalloc(&pdev->dev, count * sizeof(*pdata),
> > GFP_KERNEL);
> 
> this allocates a struct tps65217_board for each regulator specified in
> the device tree. the structure itself provides arrays for the pointers
> to the regulator init data and the regulator device tree node, so only
> one instance of it is needed

Agree, I will fix that issue in my next version of patch

> 
> also the tps65217_board structure should be renamed to something like
> tps65217_regulators, now that it is specific to the regulator

Not required because tps65217_board might contain platform data for WLED/
Battery charger driver if require. So the struct was named as tps65217_board

Regards
AnilKumar
