From: dfoley <dfoley@telus.net>
Subject: Re: omap3evm mmc problem
Date: Wed, 25 Mar 2009 13:17:26 -0700
Message-ID: <49CA9156.6080805@telus.net>
References: <gq1s6e$ssu$1@ger.gmane.org> <200903210234.03670.david-b@pacbell.net> <20090325172254.GO8057@atomide.com> <200903251040.36300.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:57249 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409AbZCYURw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Mar 2009 16:17:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LmZXm-0007ti-6f
	for linux-omap@vger.kernel.org; Wed, 25 Mar 2009 20:17:46 +0000
Received: from d75-157-52-64.bchsia.telus.net ([75.157.52.64])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 20:17:46 +0000
Received: from dfoley by d75-157-52-64.bchsia.telus.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 20:17:46 +0000
In-Reply-To: <200903251040.36300.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

David Brownell wrote:
> On Wednesday 25 March 2009, Tony Lindgren wrote:
>> * David Brownell <david-b@pacbell.net> [090321 02:34]:
>>> On Friday 20 March 2009, dfoley wrote:
>>>> Does anyone else get these mmc errors or know why on the OMAP 3530 Development board ?
>>> Which dev board?  LDP?  EVM?
>>>
>>>
>>>> mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
>>>> regulator: Unable to get requested regulator: vmmc
>>> Needs patches to setup whichever regulator is used
>>> with the MMC1 controller.  Look at Beagle, Overo,
>>> or SDP for examples...
>>>
>>>
>>>> mmci-omap-hs mmci-omap-hs.0: err -19 configuring card detect
>> Is this again the CONFIG_REGULATOR missing in .config?
> 
> Maybe.  Do all the boards set up their regulators now?
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

SD seems to work now with patch below and REGULATOR_TWL4030 [=y].
For the patch, I just copied from other boards in mach-omap2, so
I really have no idea if it's correct.

git tree:
5a824e035b9ab16aa81c021c34c557b90d10c7e6                branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6

output:
root@tsi-omap3evm:~# dmesg | grep mmc
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
mmc0: new high speed SD card at address 0007
mmcblk0: mmc0:0007 SD01G 972 MiB
  mmcblk0: p1
VFS: Can't find a valid FAT filesystem on dev mmcblk0.
EXT3 FS on mmcblk0p1, internal journal


diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 024d7c4..527d58e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -24,6 +24,7 @@
  #include <linux/spi/spi.h>
  #include <linux/spi/ads7846.h>
  #include <linux/i2c/twl4030.h>
+#include <linux/regulator/machine.h>

  #include <mach/hardware.h>
  #include <asm/mach-types.h>
@@ -99,6 +100,14 @@ static struct twl4030_hsmmc_info mmc[] = {
  	{}	/* Terminator */
  };

+static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
+	.supply			= "vmmc",
+};
+
+static struct regulator_consumer_supply omap3evm_vsim_supply = {
+	.supply			= "vmmc_aux",
+};
+
  static struct gpio_led gpio_leds[] = {
  	{
  		.name			= "omap3evm::ledb",
@@ -122,7 +131,6 @@ static struct platform_device leds_gpio = {
  	},
  };

-
  static int omap3evm_twl_gpio_setup(struct device *dev,
  		unsigned gpio, unsigned ngpio)
  {
@@ -131,6 +139,9 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
  	mmc[0].gpio_cd = gpio + 0;
  	twl4030_mmc_init(mmc);

+	omap3evm_vmmc1_supply.dev = mmc[0].dev;
+	omap3evm_vsim_supply.dev = mmc[0].dev;
+
  	/* Most GPIOs are for USB OTG.  Some are mostly sent to
  	 * the P2 connector; notably LEDA for the LCD backlight.
  	 */
@@ -186,6 +197,37 @@ static struct twl4030_madc_platform_data omap3evm_madc_data = {
  	.irq_line	= 1,
  };

+/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
+static struct regulator_init_data omap3evm_vmmc1 = {
+	.constraints = {
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &omap3evm_vmmc1_supply,
+};
+
+/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
+static struct regulator_init_data omap3evm_vsim = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 3000000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &omap3evm_vsim_supply,
+};
+
+
  static struct twl4030_platform_data omap3evm_twldata = {
  	.irq_base	= TWL4030_IRQ_BASE,
  	.irq_end	= TWL4030_IRQ_END,
@@ -196,6 +238,8 @@ static struct twl4030_platform_data omap3evm_twldata = {
  	.usb		= &omap3evm_usb_data,
  	.power		= GENERIC3430_T2SCRIPTS_DATA,
  	.gpio		= &omap3evm_gpio_data,
+	.vmmc1		= &omap3evm_vmmc1,
+	.vsim		= &omap3evm_vsim,
  };

  static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {


