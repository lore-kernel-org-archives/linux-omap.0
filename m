From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 06/32] OMAPDSS: DPI: fix regulators for DT
Date: Thu, 30 May 2013 17:54:11 +0200
Message-ID: <20130530155411.GN19468@game.jcrosoft.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
 <20130530111253.GJ19468@game.jcrosoft.org>
 <51A73990.5040709@ti.com>
 <201305301505.00529.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:54421 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933831Ab3E3P6V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 11:58:21 -0400
Received: from mail439.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id E45FAFFB36E
	for <linux-omap@vger.kernel.org>; Thu, 30 May 2013 17:58:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201305301505.00529.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On 15:05 Thu 30 May     , Arnd Bergmann wrote:
> On Thursday 30 May 2013, Tomi Valkeinen wrote:
> >   On 30/05/13 14:12, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
> > >> On some platforms DPI requires a regulator to be enabled to power up the
> > >> output pins. This regulator is, for some reason, currently attached to
> > >> the virtual omapdss device, instead of the DPI device. This does not
> > >> work for DT, as the regulator mappings need to be described in the DT
> > >> data, and the virtual omapdss device is not present there.
> > >>
> > >> Fix the issue by acquiring the regulator in the DPI device. To retain
> > >> compatibility with the current board files, the old method of getting
> > >> the regulator is kept. The old method can be removed when the board
> > >> files have been changed to pass the regulator to DPI.
> > > 
> > > as discuss with Arnd we should handle regular enable and disable at device
> > > probe for every device as we do for pinctrl
> > 
> > I'm not sure what you mean. Enable of what? The regulator? Why would we
> > enable it in the device's probe, as the device may never even be used?
> 
> It's an idea I had a while ago, but not yet discussed in the open.
> 
> Jean-Christophe just posted patches to move the mapping of interrupt numbers
> into platform_drv_probe(), just before calling the driver ->probe() callback,
> and we already have similar code to set up the default pinctrl state of
> a device before calling probe().
> 
> This can be extended to further subsystems, but that has to be done
> carefully to avoid regressions. Ideally we would move a lot of boilerplate
> code out of the driver specific ->probe() function into common code.
> Possible candidates for this include:
> 
> * calling devm_request_mem_region for the "reg" property
> * calling devm_ioremap on the "reg" property"
> * calling devm_gpio_request for all gpio lines
> * calling devm_regulator_get on all regulators
> * calling devm_reset_control_get on all reset lines
> * calling devm_dma_request_slave_channel on all dma channels
> * calling devm_of_pwm_get for all pwm channels
> * ...
> 
> For most of these (maybe all), I think we need some form of opt-in
> model on the driver side because there are cases where aquiring some
> of these resources is not mandatory, and it only works if the driver
> is using DT probing.
> 
> IF we want to do this, it also needs a lot of thought, and we shouldn't
> do it carelessly. We might also need some extra infrastructure in revres
> to simplify access to the resources we got from the OF node.
> 
> The irq resources are particularly trivial because we already claim
> them in of_platform_populate, so moving that to platform_drv_probe()
> is straightforward and solves existing bugs without creating a huge
> regression potential, but it's harder for the others.

Yeah I agree with Arnd

we need to start to move this way but for DT only first and carefully

Best Regards,
J.
> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
