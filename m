From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [PATCH] twl4030: Add some error checking to twl4030
	init
Date: Wed, 3 Jun 2009 09:53:18 -0700
Message-ID: <20090603165317.GF5026@atomide.com>
References: <200904231416.37219.david-b@pacbell.net> <1241611418-19730-1-git-send-email-amit.kucheria@verdurent.com> <20090603084958.GO16000@everest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50421 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbZFCQxT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 12:53:19 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=localhost.localdomain)
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1MBtiJ-0008mB-BQ
	for linux-omap@vger.kernel.org; Wed, 03 Jun 2009 16:53:21 +0000
Content-Disposition: inline
In-Reply-To: <20090603084958.GO16000@everest>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* Amit Kucheria <amit.kucheria@verdurent.com> [090603 01:51]:
> Bump..
> 
> This patch was acked by David Brownell earlier in the thread.

OK, I add it, but will reset all the twl stuff to mainline after 2.6.30.

These patches need to get submitted to mainline, all the other twl code is
there already.

Tony
 
> Regards,
> Amit
> 
> On Wed, May 06, 2009 at 03:03:38PM +0300, Amit Kucheria wrote:
> > Check for return values of i2c read/write operations and size of scripts being
> > uploaded to TWL4030
> > 
> > (Removed the unrelated string changes based on David Brownell's comment)
> > 
> > Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
> > ---
> >  drivers/mfd/twl4030-power.c |   52 +++++++++++++++++++++++++++++++-----------
> >  1 files changed, 38 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> > index 9dc493b..8f5d149 100644
> > --- a/drivers/mfd/twl4030-power.c
> > +++ b/drivers/mfd/twl4030-power.c
> > @@ -257,36 +257,40 @@ static int __init config_warmreset_sequence(u8 address)
> >  	return err;
> >  }
> >  
> > -void twl4030_configure_resource(struct twl4030_resconfig *rconfig)
> > +static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
> >  {
> >  	int rconfig_addr;
> > +	int err;
> >  	u8 type;
> >  
> >  	if (rconfig->resource > NUM_OF_RESOURCES) {
> >  		printk(KERN_ERR
> >  			"TWL4030 Resource %d does not exist\n",
> >  			rconfig->resource);
> > -		return;
> > +		return -EINVAL;
> >  	}
> >  
> >  	rconfig_addr = res_config_addrs[rconfig->resource];
> >  
> >  	/* Set resource group */
> > -
> >  	if (rconfig->devgroup >= 0)
> > -		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> > +		err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> >  					rconfig->devgroup << 5,
> >  					rconfig_addr + DEVGROUP_OFFSET);
> > +	if (err < 0) {
> > +		printk(KERN_ERR
> > +		       "TWL4030 failed to program devgroup");
> > +		return err;
> > +	}
> >  
> >  	/* Set resource types */
> > -
> > -	if (twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER,
> > -					&type,
> > -					rconfig_addr + TYPE_OFFSET) < 0) {
> > +	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &type,
> > +				  rconfig_addr + TYPE_OFFSET);
> > +	if (err < 0) {
> >  		printk(KERN_ERR
> > -			"TWL4030 Resource %d type could not read\n",
> > -			rconfig->resource);
> > -		return;
> > +		       "TWL4030 Resource %d type could not be read\n",
> > +		       rconfig->resource);
> > +		return err;
> >  	}
> >  
> >  	if (rconfig->type >= 0) {
> > @@ -299,8 +303,15 @@ void twl4030_configure_resource(struct twl4030_resconfig *rconfig)
> >  		type |= rconfig->type2 << 3;
> >  	}
> >  
> > -	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> > +	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> >  				type, rconfig_addr + TYPE_OFFSET);
> > +	if (err < 0) {
> > +		printk(KERN_ERR
> > +		       "TWL4030 failed to program resource type");
> > +		return err;
> > +	}
> > +
> > +	return 0;
> >  
> >  }
> >  
> > @@ -309,6 +320,12 @@ static int __init load_triton_script(struct twl4030_script *tscript)
> >  	u8 address = triton_next_free_address;
> >  	int err;
> >  
> > +	/* Make sure the script isn't going beyond last valid address */
> > +	if ((address + tscript->size) > (END_OF_SCRIPT-1)) {
> > +		printk(KERN_ERR "TWL4030 script too big error\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	err = twl4030_write_script(address, tscript->script, tscript->size);
> >  	if (err)
> >  		return err;
> > @@ -346,15 +363,22 @@ void __init twl4030_power_init(struct twl4030_power_data *triton2_scripts)
> >  
> >  	for (i = 0; i < triton2_scripts->size; i++) {
> >  		err = load_triton_script(triton2_scripts->scripts[i]);
> > -		if (err)
> > +		if (err < 0) {
> > +			printk(KERN_ERR "TWL4030 failed to load scripts");
> >  			break;
> > +		}
> >  	}
> >  
> >  	resconfig = triton2_scripts->resource_config;
> >  	if (resconfig) {
> >  		while (resconfig->resource) {
> > -			twl4030_configure_resource(resconfig);
> > +			err = twl4030_configure_resource(resconfig);
> >  			resconfig++;
> > +			if (err < 0) {
> > +				printk(KERN_ERR
> > +				       "TWL4030 failed to configure resource");
> > +				break;
> > +			}
> >  		}
> >  	}
> >  
> > -- 
> > 1.6.0.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> -------------------------------------------------------------------------
> Amit Kucheria,				 Kernel Developer, Verdurent
> -------------------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
