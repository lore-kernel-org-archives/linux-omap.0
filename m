From: Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: Re: [PATCH v2] backlight: Add TPS65217 WLED driver
Date: Tue, 18 Sep 2012 22:05:07 +0200
Message-ID: <20120918200507.GC14300@darwin>
References: <20120809204231.GF30282@darwin>
 <20120916230936.GK3647@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50049 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395Ab2IRUFi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 16:05:38 -0400
Content-Disposition: inline
In-Reply-To: <20120916230936.GK3647@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, Richard Purdie <rpurdie@rpsys.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Samuel,

El Mon, Sep 17, 2012 at 01:09:36AM +0200 Samuel Ortiz ha dit:

> On Thu, Aug 09, 2012 at 10:42:31PM +0200, Matthias Kaehlcke wrote:
> > The TPS65217 chip contains a boost converter and current sinks which can be
> > used to drive LEDs for use as backlights. Expose this functionality via the
> > backlight API.
> > 
> > Tested on an AM335x based custom board with a single WLED string, using
> > different values for ISEL and FDIM (though it would be hard to tell the
> > difference except for the value in WLEDCTRL1). Both instantiation through the
> > device tree and by passing platform data have been tested. Testing has been
> > done with an Androidized 3.2 kernel from the rowboat project
> > 
> > This patch is based on the mfd tree, it also applies on linux-next (20120809)
> It doesn't seem to apply to my for-next branch.

i suppose your for-next branch evolved during the last month

> Also, some comments:
> 
> > @@ -174,6 +174,10 @@ static struct tps65217_board *tps65217_parse_dt(struct i2c_client *client)
> >  		pdata->of_node[i] = reg_matches[i].of_node;
> >  	}
> >  
> > +	node = of_find_node_by_name(node, "backlight");
> > +	if (node)
> > +		pdata->of_node[TPS65217_SUBDEV_BL] = node;
> > +
> >  	return pdata;
> >  }
> >  
> > @@ -250,7 +254,32 @@ static int __devinit tps65217_probe(struct i2c_client *client,
> >  		platform_device_add(pdev);
> >  	}
> >  
> > +	if (pdata->bl_pdata || pdata->of_node[TPS65217_SUBDEV_BL]) {
> > +		tps->bl_pdev = platform_device_alloc("tps65217-bl", 0);
> > +		if (!tps->bl_pdev) {
> > +			dev_err(tps->dev, "Cannot create backlight platform device\n");
> > +			ret = -ENOMEM;
> > +			goto err_alloc_bl_pdev;
> > +		}
> > +
> > +		tps->bl_pdev->dev.parent = tps->dev;
> > +
> > +		if (pdata->bl_pdata)
> > +			tps->bl_pdev->dev.platform_data = pdata->bl_pdata;
> > +		else
> > +			tps->bl_pdev->dev.of_node =
> > +				pdata->of_node[TPS65217_SUBDEV_BL];
> > +
> > +		platform_device_add(tps->bl_pdev);
> > +	}
> > +
> The MFD API probably allows you to do exactly that by defining a specific cell
> for bl. Could you please try to use this API or otherwise justify not using
> it?

you seem to have missed v3 of the patch which addresses this, it was
sent on 22 Aug 2012

in the next days i'll submit v4, with changes based on the comments
received for v3

best regards


-- 
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

  Si deseas mantener tu libertad, debes estar preparado para defenderla
                          (Richard Stallman)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
