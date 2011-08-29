From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 3/4] omap: smps: add smps regulator init to voltage.c
Date: Mon, 29 Aug 2011 11:06:49 +0300
Message-ID: <1314605209.3699.7.camel@sokoban>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com> <1311853739-18984-4-git-send-email-t-kristo@ti.com> <87k4arr0bi.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44532 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026Ab1H2IGx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 04:06:53 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7T86qlW008402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 03:06:52 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7T86qei022470
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 03:06:52 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <87k4arr0bi.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-08-05 at 23:54 +0200, Hilman, Kevin wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > All voltagedomains that have support for vc and vp are now automatically
> > registered with SMPS regulator driver. Voltage.c builds a platform device
> > structure for this purpose during late init.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> [...]
> 
> > +static void smps_add_regulator(struct platform_device *smps_dev,
> > +			       struct voltagedomain *voltdm)
> > +{
> > +	struct omap_smps_platform_data *info;
> > +	struct regulator_init_data *init_data;
> > +	struct regulator_consumer_supply *supply;
> > +
> > +	if (!smps_dev || !voltdm)
> > +		return;
> > +
> > +	info = smps_dev->dev.platform_data;
> > +
> > +	init_data = kzalloc(sizeof(struct regulator_init_data), GFP_KERNEL);
> > +	supply = kzalloc(sizeof(struct regulator_consumer_supply), GFP_KERNEL);
> > +
> > +	if (!init_data || !supply) {
> > +		kfree(init_data);
> > +		kfree(supply);
> > +		return;
> > +	}
> > +	supply->supply = "vcc";
> > +	supply->dev_name = voltdm->name;
> > +	init_data->constraints.min_uV = 600000;
> > +	init_data->constraints.max_uV = 1450000;
> 
> These values should come from the OMAP/PMIC limitations, not from hard
> coded values.

True. Should this wait until the work is finished with the PMIC
parameter work or should I try to figure out a way to do this already
now?

> 
> Kevin



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

