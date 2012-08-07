From: Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: Re: [PATCH] backlight: Add TPS65217 WLED driver
Date: Tue, 7 Aug 2012 22:43:06 +0200
Message-ID: <20120807204305.GA30282@darwin>
References: <20120731194838.GJ4701@darwin>
 <331ABD5ECB02734CA317220B2BBEABC13EA0D18A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45328 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab2HGUn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 16:43:56 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA0D18A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi AnilKumar,

thanks for your comments

El Tue, Aug 07, 2012 at 08:59:17AM +0000 AnilKumar, Chimata ha dit:

> Can you re-submit the patch based on linux-next tree?

will do

> Comments inline
> 
> On Wed, Aug 01, 2012 at 01:18:38, Matthias Kaehlcke wrote:
> > The TPS65217 chip contains a boost converter and current sinks which can be
> > used to drive LEDs for use as backlights. Expose this functionality via the
> > backlight API.
> 
> Can you provide more details here, like patch is based on which
> tree?

this patch was based on current mainline at the time of submission

> Testing details of the driver?

the driver has been tested (without device tree) on a custom AM335x
board, running an Androidized 3.2 kernel with AM335x support (rowboat
project)

> > +#if defined(CONFIG_BACKLIGHT_TPS65217) || defined(CONFIG_BACKLIGHT_TPS65217_MODULE)
> > +#define tps_has_bl() true
> > +#else
> > +#define tps_has_bl() false
> > +#endif
> > +
> 
> Is this really required?

was inspired by the twl-core driver, but can do without it

> >  /**
> >   * tps65217_reg_read: Read a single tps65217 register.
> >   *
> > @@ -174,6 +180,47 @@ static struct tps65217_board *tps65217_parse_dt(struct i2c_client *client)
> >  		pdata->of_node[i] = reg_matches[i].of_node;
> >  	}
> >  
> > +	if (tps_has_bl()) {
> > +		struct device_node *np = of_find_node_by_name(node, "backlight");
> > +		if (np) {
> 
> This can be changed to
> np = of_find_node_by_name(node, "backlight");
> if (np) {
> }
> 
> else fall into non-backlight case.

ok

> > +			u32 val;
> > +
> > +			pdata->bl_pdata = devm_kzalloc(&client->dev, sizeof(*pdata->bl_pdata), GFP_KERNEL);
> > +			if (!pdata->bl_pdata)
> > +				return NULL;
> > +
> > +			if (!of_property_read_u32(np, "isel", &val)) {
> > +				if (val == 1) {
> > +					pdata->bl_pdata->isel = TPS65217_BL_ISET1;
> > +				} else if (val == 2) {
> > +					pdata->bl_pdata->isel = TPS65217_BL_ISET2;
> > +				} else {
> > +					dev_err(&client->dev, "invalid value for backlight current limit selection in the device tree\n");
> 
> fix checkpatch.pl errors before submitting the patches. More than
> 80 ch.

in this case it will be hard to read the 80 character limit without
modifying the log string or breaking it artifically into several
lines. i understand the 80 character limit is a soft limit, which can
be violated if readability is actually improve by the violation. i'd
suggest to make the line slightly shorter by putting the log string in
it's own line, but not break the string in between just to reach the
80 char limit

> > +					return NULL;
> 
> Should not return here, need to handle rest of dt portion.

ok

> > +				}
> > +			} else {
> > +				pdata->bl_pdata->isel = TPS65217_BL_ISET1;
> > +			}
> 
> This can be changed to
> 
> pdata->bl_pdata->isel = TPS65217_BL_ISET1;
> of_property_read_u32(np, "isel", &val)
> if (val > TPS65217_BL_ISET2 || val < TPS65217_BL_ISET1) {
> 	dev_err(...);
> 	goto rest_dt_portion;
> } else {
> 	pdata->bl_pdata->isel = val;
> }

ok, this also requires the TPS65217_BL_ISETx enum to start at 1

> > +
> > +			if (!of_property_read_u32(np, "fdim", &val)) {
> > +				if (val == 100) {
> > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_100HZ;
> > +				} else if (val == 200) {
> > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_200HZ;
> > +				} else if (val == 500) {
> > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_500HZ;
> > +				} else if (val == 1000) {
> > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_1000HZ;
> > +				} else {
> > +					dev_err(&client->dev, "invalid value for backlight dimming frequency in the device tree\n");
> > +					return NULL;
> > +				}
> > +			} else {
> > +				pdata->bl_pdata->fdim = TPS65217_BL_FDIM_200HZ;
> > +			}
> > +		}
> > +	}
> 
> Same here.

not exactly, the value specified in the device tree for the dimming
frequency will be a frequency, not a value corresponding to the enum,
so a range check + assignment isn't enough. if you'd like to see a
similar handling an option would be to set TPS65217_BL_FDIM_100HZ to
100, TPS..._200HZ to 200, ..., and do:

switch (val) {
  case TPS65217_BL_FDIM_100HZ:
  case TPS65217_BL_FDIM_200HZ:
  ...
    pdata->bl_pdata->fdim	= val;
    break;

  default:
    /* error handling */
}

> > +struct tps65217_bl_pdata tps65217_bl_default_pdata = {
> > +	.isel	= TPS65217_BL_ISET1,
> > +	.fdim	= TPS65217_BL_FDIM_200HZ
> 
> Comma missed at the end, if some other parameters added to this
> struct after some time then this line should be updated. Which is
> not necessary if we take care now.

ok

> > +static int tps65217_bl_hw_init(struct tps65217_bl *tps65217_bl, struct tps65217_bl_pdata *pdata)
> 
> Greater than 80 Chs

ok

> > +		/* select ISET2 current level */
> > +		rc = tps65217_set_bits(tps65217_bl->tps,
> > +				TPS65217_REG_WLEDCTRL1,
> > +				TPS65217_WLEDCTRL1_ISEL,
> > +				TPS65217_WLEDCTRL1_ISEL,
> > +				TPS65217_PROTECT_NONE);
> 
> Can reduce number of lines and should not exceed 80 ch. Same can be done
> at other places.

ok

> 
> > +		if (rc) {
> > +			dev_err(tps65217_bl->dev,
> > +				"failed to select ISET2 current level: %d\n", rc);
> > +			return rc;
> > +		}
> > +
> > +		dev_dbg(tps65217_bl->dev, "selected ISET2 current level\n");
> > +	}
> 
> Switch gives better readability.

ok

> > +static int tps65217_bl_probe(struct platform_device *pdev)
> > +{
> > +	int rc;
> > +	struct i2c_client *i2c_client = to_i2c_client(pdev->dev.parent);
> > +	struct tps65217 *tps = i2c_get_clientdata(i2c_client);
> > +	struct tps65217_bl *tps65217_bl;
> > +	struct tps65217_bl_pdata *pdata;
> > +	struct backlight_properties bl_props;
> > +
> > +	tps65217_bl = kzalloc(GFP_KERNEL, sizeof(*tps65217_bl));
> > +	if (tps65217_bl == NULL) {
> > +		dev_err(&pdev->dev, "allocation of struct tps65217_bl failed\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	tps65217_bl->tps = tps;
> > +	tps65217_bl->dev = &pdev->dev;
> > +	tps65217_bl->on = 0;
> > +
> 
> DT handling for backlight should be done here.

ok

> > +static int tps65217_bl_remove(struct platform_device *pdev)
> > +{
> > +	struct tps65217_bl *tps65217_bl = (struct tps65217_bl *)platform_get_drvdata(pdev);
> 
> type cast is not required.

ok

> > +MODULE_LICENSE("GPL");
> 
> GPLv2

ok

best regards

-- 
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

     La guerra es un acto abominable en el que se matan personas que no
      se conocen, dirigidas por personas que se conocen y no se matan
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
