From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 2/5] regulator: omap smps regulator driver
Date: Thu, 14 Jul 2011 10:23:55 +0300
Message-ID: <1310628235.4331.107.camel@sokoban>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com> <1310565638-13140-3-git-send-email-t-kristo@ti.com> <20110714062904.GC22467@google.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35981 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038Ab1GNHYC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 03:24:02 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110714062904.GC22467@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, "Girdwood, Liam" <lrg@ti.com>, "Hilman, Kevin" <khilman@ti.com>

On Thu, 2011-07-14 at 08:29 +0200, Todd Poynor wrote:
> On Wed, Jul 13, 2011 at 05:00:35PM +0300, Tero Kristo wrote:
> > OMAP SMPS regulator driver provides access to OMAP voltage processor
> > controlled regulators. These include VDD1 and VDD2 for OMAP3 and additionally
> > VDD3 for OMAP4. SMPS regulators use the OMAP voltage layer for the actual
> > voltage regulation operations.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> ...
> > +	for (i = 0; i < pdata->num_regulators; i++) {
> > +		initdata = pdata->regulators[i];
> > +
> > +		c = &initdata->constraints;
> > +		c->valid_modes_mask &= REGULATOR_MODE_NORMAL;
> > +		c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE;
> > +		c->always_on = true;
> > +
> > +		voltdm = omap_voltage_domain_lookup(
> > +			initdata->consumer_supplies[0].dev_name);
> > +
> > +		if (IS_ERR(voltdm)) {
> > +			dev_err(&pdev->dev, "can't find voltdm %s, %ld\n",
> > +				initdata->consumer_supplies[0].dev_name,
> > +				PTR_ERR(voltdm));
> > +			return PTR_ERR(voltdm);
> 
> 
> Or maybe continue to next loop iteration.

Not sure about this. If one of the regulators fails, it is probably
better to fail/disable them all, otherwise we end up in partly
functioning situation. I think I'll just change this into a setup where
all the SMPS regulators are disabled if init of any of them fails.

> 
> > +		}
> > +		info = kzalloc(sizeof(struct omap_smps_reg_info), GFP_KERNEL);
> > +
> > +		info->voltdm = voltdm;
> 
> 
> Check kzalloc NULL return.

True.

> 
> > +		info->desc.ops = &omap_smps_ops;
> > +		info->desc.name = c->name;
> > +		info->desc.type = REGULATOR_VOLTAGE;
> > +		info->desc.n_voltages = 0;
> > +		rdev = regulator_register(&info->desc, &pdev->dev, initdata,
> > +			info);
> > +		if (IS_ERR(rdev)) {
> > +			dev_err(&pdev->dev, "can't register %s, %ld\n",
> > +				info->desc.name, PTR_ERR(rdev));
> > +			return PTR_ERR(rdev);
> 
> Or suggest continue to next loop iteration.

Same as above continue comment.

> 
> > +		}
> > +		platform_set_drvdata(pdev, rdev);
> 
> Performed in a loop, but only last iteration's rdev is set as the
> driver data for pdev.  Platform driver data should be pdata?

I'll check what the cleanup part needs and fix it.

> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int omap_smps_reg_remove(struct platform_device *pdev)
> > +{
> > +	regulator_unregister(platform_get_drvdata(pdev));
> 
> 
> Should kfree() the struct omap_smps_reg_info data structure(s) and
> platform_set_drvdata(pdev, NULL) ?

Same as above.

> 
> 
> Todd



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

