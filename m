From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the omap_dss2 tree with the omap tree
Date: Fri, 7 May 2010 13:43:34 +1000
Message-ID: <20100507134334.75808884.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <roger.quadros@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

Today's linux-next merge of the omap_dss2 tree got a conflict in
arch/arm/mach-omap2/board-rx51-peripherals.c between commit
e87da74e34ad151e6ae75ebb7a7bf447f02c0004 ("omap: rx51: Add supplies for
the tlv320aic3x codec driver") from the omap tree and commit
a693839eab0292aa234d7a6f48d40389389baebb ("OMAP: RX51: Add "vdds_sdi"
supply voltage for SDI") from the omap_dss2 tree.

Just overlapping additions. I fixed it up (see below) and can carry the
fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/arm/mach-omap2/board-rx51-peripherals.c
index 8179d55,020f354..0000000
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@@ -287,35 -315,19 +315,48 @@@ static struct regulator_consumer_suppl
  	.dev_name = "mmci-omap-hs.1",
  };
  
 +static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
 +	/* tlv320aic3x analog supplies */
 +	{
 +		.supply		= "AVDD",
 +		.dev_name	= "2-0018",
 +	},
 +	{
 +		.supply		= "DRVDD",
 +		.dev_name	= "2-0018",
 +	},
 +	/* Keep vmmc as last item. It is not iterated for newer boards */
 +	{
 +		.supply		= "vmmc",
 +		.dev_name	= "mmci-omap-hs.1",
 +	},
 +};
 +
 +static struct regulator_consumer_supply rx51_vio_supplies[] = {
 +	/* tlv320aic3x digital supplies */
 +	{
 +		.supply		= "IOVDD",
 +		.dev_name	= "2-0018"
 +	},
 +	{
 +		.supply		= "DVDD",
 +		.dev_name	= "2-0018"
 +	},
 +};
 +
+ #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+ extern struct platform_device rx51_display_device;
+ #endif
+ 
+ static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
+ #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+ 	{
+ 		.supply	= "vdds_sdi",
+ 		.dev	= &rx51_display_device.dev,
+ 	},
+ #endif
+ };
+ 
  static struct regulator_init_data rx51_vaux1 = {
  	.constraints = {
  		.name			= "V28",
