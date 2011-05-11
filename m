From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Wed, 11 May 2011 14:12:47 +0200
Message-ID: <20110511121243.GB5487@opensource.wolfsonmicro.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
 <1304494704-7285-2-git-send-email-archit@ti.com>
 <20110504094050.GI27860@atomide.com>
 <1304595408.30935.16.camel@deskari>
 <20110505130204.GK11744@opensource.wolfsonmicro.com>
 <1304955274.2215.26.camel@deskari>
 <20110509191912.GA6546@opensource.wolfsonmicro.com>
 <1305030652.2045.49.camel@deskari>
 <20110510134730.GB25877@opensource.wolfsonmicro.com>
 <1305105825.2097.49.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34475 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755315Ab1EKQQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 12:16:15 -0400
Content-Disposition: inline
In-Reply-To: <1305105825.2097.49.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

On Wed, May 11, 2011 at 12:23:45PM +0300, Tomi Valkeinen wrote:

> So how should the regulator be set up?

You need to create a new regulator of some kind and then provide a way
for machines to set the supply_regulator in the init_data.

> I should setup a fixed regulator, which is supplied from VCXIO, and
> omapdss will get its powers from this fixed regulator?

Yes, and the example code I've deleted all looks about right.

> static struct fixed_voltage_config omap_dss_fixed_reg_data = {
> 	.supply_name = "what should this be?",
> 	.init_data = &fixed_reg_init_data,
> };

The supply name shold be supplied by the board - it's whatever the
supply that's shared by all the regulators in the OMAP is.

> static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
> 	REGULATOR_SUPPLY("what should this be?", "reg-fixed-voltage.0"),
> };

You don't need to specify a supply to hook the supplies up.  This is a
bit of a wart, but it's the current API - it's specified in the child
regulator rather than the parent which is the other way around to
consumers.
