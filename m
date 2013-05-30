From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/32] OMAPDSS: DPI: fix regulators for DT
Date: Thu, 30 May 2013 15:05:00 +0200
Message-ID: <201305301505.00529.arnd@arndb.de>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <20130530111253.GJ19468@game.jcrosoft.org> <51A73990.5040709@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50780 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab3E3NFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 09:05:08 -0400
In-Reply-To: <51A73990.5040709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On Thursday 30 May 2013, Tomi Valkeinen wrote:
>   On 30/05/13 14:12, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
> >> On some platforms DPI requires a regulator to be enabled to power up the
> >> output pins. This regulator is, for some reason, currently attached to
> >> the virtual omapdss device, instead of the DPI device. This does not
> >> work for DT, as the regulator mappings need to be described in the DT
> >> data, and the virtual omapdss device is not present there.
> >>
> >> Fix the issue by acquiring the regulator in the DPI device. To retain
> >> compatibility with the current board files, the old method of getting
> >> the regulator is kept. The old method can be removed when the board
> >> files have been changed to pass the regulator to DPI.
> > 
> > as discuss with Arnd we should handle regular enable and disable at device
> > probe for every device as we do for pinctrl
> 
> I'm not sure what you mean. Enable of what? The regulator? Why would we
> enable it in the device's probe, as the device may never even be used?

It's an idea I had a while ago, but not yet discussed in the open.

Jean-Christophe just posted patches to move the mapping of interrupt numbers
into platform_drv_probe(), just before calling the driver ->probe() callback,
and we already have similar code to set up the default pinctrl state of
a device before calling probe().

This can be extended to further subsystems, but that has to be done
carefully to avoid regressions. Ideally we would move a lot of boilerplate
code out of the driver specific ->probe() function into common code.
Possible candidates for this include:

* calling devm_request_mem_region for the "reg" property
* calling devm_ioremap on the "reg" property"
* calling devm_gpio_request for all gpio lines
* calling devm_regulator_get on all regulators
* calling devm_reset_control_get on all reset lines
* calling devm_dma_request_slave_channel on all dma channels
* calling devm_of_pwm_get for all pwm channels
* ...

For most of these (maybe all), I think we need some form of opt-in
model on the driver side because there are cases where aquiring some
of these resources is not mandatory, and it only works if the driver
is using DT probing.

IF we want to do this, it also needs a lot of thought, and we shouldn't
do it carelessly. We might also need some extra infrastructure in revres
to simplify access to the resources we got from the OF node.

The irq resources are particularly trivial because we already claim
them in of_platform_populate, so moving that to platform_drv_probe()
is straightforward and solves existing bugs without creating a huge
regression potential, but it's harder for the others.

	Arnd
