From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap twl cleanup for v3.1 merge window
Date: Sun, 10 Jul 2011 12:50:25 -0700
Message-ID: <20110710195025.GI5783@atomide.com>
References: <20110708130102.GB5783@atomide.com>
 <201107081741.23425.arnd@arndb.de>
 <20110710065537.GD5783@atomide.com>
 <20110710101705.GF5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:19063 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755085Ab1GJTub (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jul 2011 15:50:31 -0400
Content-Disposition: inline
In-Reply-To: <20110710101705.GF5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

* Tony Lindgren <tony@atomide.com> [110710 03:12]:
> * Tony Lindgren <tony@atomide.com> [110709 23:50]:
> > * Arnd Bergmann <arnd@arndb.de> [110708 08:36]:
> > > On Friday 08 July 2011, Tony Lindgren wrote:
> > > >
> > > >I've attached a conflict resolution patch too, it's trivial execpt
> > > >note that .vdac needs to be removed in board-rx51-peripherals.c.
> > > >
> > > >If this conflict causes problems for you, I can also base this series
> > > >on omap/board.
> > > 
> > > The conflict resolution you suggested doesn't build here:
> > ...
> > 
> > > 
> > > These are removed in the cleanup series, but changed in the fixes branch,
> > > now the removal is undone
> > 
> > Hmm these are added in omap/board. Maybe the issue is caused by not
> > merging omap/board also?
> 
> Looks like what got added in in omap/board should now work with the
> TWL default values in twl-common.c. So most likely those can just be
> dropped. Will check that today.

Yes most of it can be dropped for 4430sdp, but the merge is a pain.

I've merged cleanup-part-2 into my devel-board so if you pull that
into your omap/board, and merge omap/board into your master
branch things should be sorted out. The updated devel-board is at:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-board

The new top commit at 1ad920556f32a5a127397ca461d1a1faaf22c4e0.

As omap/board already depends on omap/cleanup, this does not cause
new dependency issues. I've also added the resolve patch below.

Regards,

Tony


--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@@ -411,41 -324,6 +403,37 @@@ static struct regulator_consumer_suppl
  	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1"),
  };
  
- static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
- 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
- };
- 
 +static struct regulator_consumer_supply omap4_sdp4430_vmmc5_supply = {
 +	.supply = "vmmc",
 +	.dev_name = "omap_hsmmc.4",
 +};
 +
 +static struct regulator_init_data sdp4430_vmmc5 = {
 +	.constraints = {
 +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 +	},
 +	.num_consumer_supplies = 1,
 +	.consumer_supplies = &omap4_sdp4430_vmmc5_supply,
 +};
 +
 +static struct fixed_voltage_config sdp4430_vwlan = {
 +	.supply_name		= "vwl1271",
 +	.microvolts		= 1800000, /* 1.8V */
 +	.gpio			= GPIO_WIFI_PMENA,
 +	.startup_delay		= 70000, /* 70msec */
 +	.enable_high		= 1,
 +	.enabled_at_boot	= 0,
 +	.init_data		= &sdp4430_vmmc5,
 +};
 +
 +static struct platform_device omap_vwlan_device = {
 +	.name		= "reg-fixed-voltage",
 +	.id		= 1,
 +	.dev = {
 +		.platform_data = &sdp4430_vwlan,
 +	},
 +};
 +
  static int omap4_twl6030_hsmmc_late_init(struct device *dev)
  {
  	int ret = 0;
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@@ -916,13 -761,7 +884,12 @@@ static struct twl4030_platform_data rx5
  	.vaux2			= &rx51_vaux2,
  	.vaux4			= &rx51_vaux4,
  	.vmmc1			= &rx51_vmmc1,
 +	.vpll1			= &rx51_vpll1,
 +	.vpll2			= &rx51_vpll2,
  	.vsim			= &rx51_vsim,
- 	.vdac			= &rx51_vdac,
 +	.vintana1		= &rx51_vintana1,
 +	.vintana2		= &rx51_vintana2,
 +	.vintdig		= &rx51_vintdig,
  	.vio			= &rx51_vio,
  };
  
