From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Wed, 11 May 2011 12:23:45 +0300
Message-ID: <1305105825.2097.49.camel@deskari>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
	 <1304494704-7285-2-git-send-email-archit@ti.com>
	 <20110504094050.GI27860@atomide.com> <1304595408.30935.16.camel@deskari>
	 <20110505130204.GK11744@opensource.wolfsonmicro.com>
	 <1304955274.2215.26.camel@deskari>
	 <20110509191912.GA6546@opensource.wolfsonmicro.com>
	 <1305030652.2045.49.camel@deskari>
	 <20110510134730.GB25877@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:39525 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932532Ab1EKQTZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 12:19:25 -0400
Received: by mail-ey0-f169.google.com with SMTP id 9so290054eyd.14
        for <linux-omap@vger.kernel.org>; Wed, 11 May 2011 09:19:20 -0700 (PDT)
In-Reply-To: <20110510134730.GB25877@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

On Tue, 2011-05-10 at 15:47 +0200, Mark Brown wrote:
> On Tue, May 10, 2011 at 03:30:52PM +0300, Tomi Valkeinen wrote:
> 
> > This sounds just the thing we need here. Do you think there's a chance
> > the code could get merged in the next window? And I'm also happy to test
> > the code with omapdss, whenever you have something ready.
> 
> Patch is below, tested with my "hey look, this compiles!" test plan -
> I'd be a bit surprised if it ran straight off.

So how should the regulator be set up?

If we currently have in the board file:

static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.1"),
};

static struct regulator_init_data sdp4430_vcxio = {
	.constraints = {
		...
	},
	.num_consumer_supplies	= ARRAY_SIZE(sdp4430_vcxio_supply),
	.consumer_supplies	= sdp4430_vcxio_supply,
};

I should setup a fixed regulator, which is supplied from VCXIO, and
omapdss will get its powers from this fixed regulator?

So, in the common display file:

static struct regulator_consumer_supply fixed_supply[] = {
	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.1"),
};

static struct regulator_init_data fixed_reg_init_data = {
	.constraints = {
		...
	},
	.num_consumer_supplies	= ARRAY_SIZE(fixed_supply),
	.consumer_supplies	= fixed_supply,
};

static struct fixed_voltage_config omap_dss_fixed_reg_data = {
	.supply_name = "what should this be?",
	.init_data = &fixed_reg_init_data,
};

static struct platform_device omap_dss_fixed_reg_device = {
	.name	= "reg-fixed-voltage",
	.id	= 0,
	.dev	= {
		.platform_data	= &omap_dss_fixed_reg_data,
	},
};

And in the board file:

static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
	REGULATOR_SUPPLY("what should this be?", "reg-fixed-voltage.0"),
};

static struct regulator_init_data sdp4430_vcxio = {
	.constraints = {
		...
	},
	.num_consumer_supplies	= ARRAY_SIZE(sdp4430_vcxio_supply),
	.consumer_supplies	= sdp4430_vcxio_supply,
};

If so, it's again slightly difficult. I want to do the common display
stuff in a one place, used by all the boards. If I setup the fixed
regulator in the common file, I need to give it an id which may conflict
with a possible fixed regulator set up in the board file.

Or am I totally on the wrong track here =)?

 Tomi


