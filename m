From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] backlight: Add TPS65217 WLED driver
Date: Wed, 8 Aug 2012 09:25:29 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA0E4D1@DBDE01.ent.ti.com>
References: <20120731194838.GJ4701@darwin>
 <331ABD5ECB02734CA317220B2BBEABC13EA0D18A@DBDE01.ent.ti.com>
 <20120807204305.GA30282@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33048 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab2HHJZp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 05:25:45 -0400
In-Reply-To: <20120807204305.GA30282@darwin>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Kaehlcke <matthias@kaehlcke.net>
Cc: Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kaehlcke,

On Wed, Aug 08, 2012 at 02:13:06, Matthias Kaehlcke wrote:
> Hi AnilKumar,
> 
> thanks for your comments
> 
> El Tue, Aug 07, 2012 at 08:59:17AM +0000 AnilKumar, Chimata ha dit:
> 
> > Can you re-submit the patch based on linux-next tree?
> 
> will do

Cross check with mfd/master also.

> 
> > Comments inline
> > 
> > On Wed, Aug 01, 2012 at 01:18:38, Matthias Kaehlcke wrote:
> > > The TPS65217 chip contains a boost converter and current sinks which can be
> > > used to drive LEDs for use as backlights. Expose this functionality via the
> > > backlight API.
> > 
> > Can you provide more details here, like patch is based on which
> > tree?
> 
> this patch was based on current mainline at the time of submission
> 
> > Testing details of the driver?
> 
> the driver has been tested (without device tree) on a custom AM335x
> board, running an Androidized 3.2 kernel with AM335x support (rowboat
> project)

Mention this is patch description.

> 
> > > +#if defined(CONFIG_BACKLIGHT_TPS65217) || defined(CONFIG_BACKLIGHT_TPS65217_MODULE)
> > > +#define tps_has_bl() true
> > > +#else
> > > +#define tps_has_bl() false
> > > +#endif
> > > +
> > 
> > Is this really required?
> 
> was inspired by the twl-core driver, but can do without it
> 
> > >  /**
> > >   * tps65217_reg_read: Read a single tps65217 register.
> > >   *
> > > @@ -174,6 +180,47 @@ static struct tps65217_board *tps65217_parse_dt(struct i2c_client *client)
> > >  		pdata->of_node[i] = reg_matches[i].of_node;
> > >  	}
> > >  
> > > +	if (tps_has_bl()) {
> > > +		struct device_node *np = of_find_node_by_name(node, "backlight");
> > > +		if (np) {
> > 
> > This can be changed to
> > np = of_find_node_by_name(node, "backlight");
> > if (np) {
> > }
> > 
> > else fall into non-backlight case.
> 
> ok
> 
> > > +			u32 val;
> > > +
> > > +			pdata->bl_pdata = devm_kzalloc(&client->dev, sizeof(*pdata->bl_pdata), GFP_KERNEL);
> > > +			if (!pdata->bl_pdata)
> > > +				return NULL;
> > > +
> > > +			if (!of_property_read_u32(np, "isel", &val)) {
> > > +				if (val == 1) {
> > > +					pdata->bl_pdata->isel = TPS65217_BL_ISET1;
> > > +				} else if (val == 2) {
> > > +					pdata->bl_pdata->isel = TPS65217_BL_ISET2;
> > > +				} else {
> > > +					dev_err(&client->dev, "invalid value for backlight current limit selection in the device tree\n");
> > 
> > fix checkpatch.pl errors before submitting the patches. More than
> > 80 ch.
> 
> in this case it will be hard to read the 80 character limit without
> modifying the log string or breaking it artifically into several
> lines. i understand the 80 character limit is a soft limit, which can
> be violated if readability is actually improve by the violation. i'd
> suggest to make the line slightly shorter by putting the log string in
> it's own line, but not break the string in between just to reach the
> 80 char limit

I am leaving it to maintainer

> 
> > > +					return NULL;
> > 
> > Should not return here, need to handle rest of dt portion.
> 
> ok
> 
> > > +				}
> > > +			} else {
> > > +				pdata->bl_pdata->isel = TPS65217_BL_ISET1;
> > > +			}
> > 
> > This can be changed to
> > 
> > pdata->bl_pdata->isel = TPS65217_BL_ISET1;
> > of_property_read_u32(np, "isel", &val)
> > if (val > TPS65217_BL_ISET2 || val < TPS65217_BL_ISET1) {
> > 	dev_err(...);
> > 	goto rest_dt_portion;
> > } else {
> > 	pdata->bl_pdata->isel = val;
> > }
> 
> ok, this also requires the TPS65217_BL_ISETx enum to start at 1
> 
> > > +
> > > +			if (!of_property_read_u32(np, "fdim", &val)) {
> > > +				if (val == 100) {
> > > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_100HZ;
> > > +				} else if (val == 200) {
> > > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_200HZ;
> > > +				} else if (val == 500) {
> > > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_500HZ;
> > > +				} else if (val == 1000) {
> > > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_1000HZ;
> > > +				} else {
> > > +					dev_err(&client->dev, "invalid value for backlight dimming frequency in the device tree\n");
> > > +					return NULL;
> > > +				}
> > > +			} else {
> > > +				pdata->bl_pdata->fdim = TPS65217_BL_FDIM_200HZ;
> > > +			}
> > > +		}
> > > +	}
> > 
> > Same here.
> 
> not exactly, the value specified in the device tree for the dimming
> frequency will be a frequency, not a value corresponding to the enum,
> so a range check + assignment isn't enough. if you'd like to see a
> similar handling an option would be to set TPS65217_BL_FDIM_100HZ to
> 100, TPS..._200HZ to 200, ..., and do:
> 
> switch (val) {
>   case TPS65217_BL_FDIM_100HZ:
>   case TPS65217_BL_FDIM_200HZ:
>   ...
>     pdata->bl_pdata->fdim	= val;
>     break;
> 
>   default:
>     /* error handling */
> }
> 

This looks better.

Regards
AnilKumar
