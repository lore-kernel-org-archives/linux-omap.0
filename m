From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Thu, 15 May 2014 11:27:31 -0700
Message-ID: <20140515182730.GE23659@atomide.com>
References: <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com>
 <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com>
 <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com>
 <536C924E.5000307@ti.com>
 <20140509153008.GC17814@atomide.com>
 <20140513212639.GA18001@atomide.com>
 <5374BC01.7030802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60096 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbaEOS1g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 14:27:36 -0400
Content-Disposition: inline
In-Reply-To: <5374BC01.7030802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140515 06:08]:
> On 14/05/14 00:26, Tony Lindgren wrote:
> 
> > +static int sharp_ls_probe_of(struct platform_device *pdev)
> > +{
> > +	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> > +	struct device_node *node = pdev->dev.of_node;
> > +	struct omap_dss_device *in;
> > +
> > +	ddata->vcc = devm_regulator_get(&pdev->dev, "envdd");
> > +	if (IS_ERR(ddata->vcc)) {
> > +		dev_err(&pdev->dev, "failed to get regulator\n");
> > +		return PTR_ERR(ddata->vcc);
> > +	}
> > +
> > +	/* lcd INI */
> > +	ddata->ini_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "enable");
> > +	if (PTR_ERR(ddata->ini_gpio) == -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> 
> Hmm, the GPIOs are optional, but shouldn't we react somehow to real
> errors? I guess we should do something like:
> 
> ddata->ini_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "enable");
> if (IS_ERR(ddata->ini_gpio) {
> 	int err = PTR_ERR(ddata->ini_gpio);
> 	if (err == -EPROBE_DEFER || err != -ENOENT)
> 		return err;
> }

Yeah that makes sense to me.

Regards,

Tony
