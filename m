From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 3/4] omap device tree changes for v3.15
Date: Sun, 2 Mar 2014 16:10:49 -0800
Message-ID: <20140303001045.GC5000@atomide.com>
References: <pull-1393802089-910509>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49117 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753755AbaCCAKz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Mar 2014 19:10:55 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [140302 15:55]:
> The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:
> 
>   Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/dt-signed
> 
> for you to fetch changes up to f777ba1780584b100ab9664cc06d04f3bb273a84:
> 
>   Merge tag 'for_3.15/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.15/dt (2014-03-02 14:22:03 -0800)
> 
> ----------------------------------------------------------------
> 
> Device tree related changes for omaps with minor code
> changes also to platform data quirks that are still needed
> for some features.

FYI, this probably causes a minor overlapping additions conflict
with the recently merged fixes. My resolve below for reference.

Regards,

Tony


--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@@ -172,21 -194,42 +196,58 @@@ static void __init am35xx_emac_reset(vo
  	omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET); /* OCP barrier */
  }
  
 +static void __init nokia_n900_legacy_init(void)
 +{
 +	hsmmc2_internal_input_clk();
 +
 +	if (omap_type() == OMAP2_DEVICE_TYPE_SEC) {
 +		if (IS_ENABLED(CONFIG_ARM_ERRATA_430973)) {
 +			pr_info("RX-51: Enabling ARM errata 430973 workaround\n");
 +			/* set IBE to 1 */
 +			rx51_secure_update_aux_cr(BIT(6), 0);
 +		} else {
 +			pr_warning("RX-51: Not enabling ARM errata 430973 workaround\n");
 +			pr_warning("Thumb binaries may crash randomly without this workaround\n");
 +		}
 +	}
 +}
++
+ static struct gpio cm_t3517_wlan_gpios[] __initdata = {
+ 	{ 56,	GPIOF_OUT_INIT_HIGH,	"wlan pwr" },
+ 	{ 4,	GPIOF_OUT_INIT_HIGH,	"xcvr noe" },
+ };
+ 
+ static void __init omap3_sbc_t3517_wifi_init(void)
+ {
+ 	int err = gpio_request_array(cm_t3517_wlan_gpios,
+ 				ARRAY_SIZE(cm_t3517_wlan_gpios));
+ 	if (err) {
+ 		pr_err("SBC-T3517: wl12xx gpios request failed: %d\n", err);
+ 		return;
+ 	}
+ 
+ 	gpio_export(cm_t3517_wlan_gpios[0].gpio, 0);
+ 	gpio_export(cm_t3517_wlan_gpios[1].gpio, 0);
+ 
+ 	msleep(100);
+ 	gpio_set_value(cm_t3517_wlan_gpios[1].gpio, 0);
+ }
+ 
+ static void __init omap3_sbc_t3517_legacy_init(void)
+ {
+ 	omap3_sbc_t3x_usb_hub_init(152, "cm-t3517 usb hub");
+ 	omap3_sbc_t3x_usb_hub_init(98, "sb-t35 usb hub");
+ 	am35xx_emac_reset();
+ 	hsmmc2_internal_input_clk();
+ 	omap3_sbc_t3517_wifi_init();
+ 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 145);
+ 	omap_ads7846_init(1, 57, 0, NULL);
+ }
+ 
+ static void __init am3517_evm_legacy_init(void)
+ {
+ 	am35xx_emac_reset();
+ }
  #endif /* CONFIG_ARCH_OMAP3 */
  
  #ifdef CONFIG_ARCH_OMAP4
@@@ -277,8 -319,10 +338,10 @@@ struct of_dev_auxdata omap_auxdata_look
   */
  static struct pdata_init pdata_quirks[] __initdata = {
  #ifdef CONFIG_ARCH_OMAP3
+ 	{ "compulab,omap3-sbc-t3517", omap3_sbc_t3517_legacy_init, },
+ 	{ "compulab,omap3-sbc-t3530", omap3_sbc_t3530_legacy_init, },
  	{ "compulab,omap3-sbc-t3730", omap3_sbc_t3730_legacy_init, },
 -	{ "nokia,omap3-n900", hsmmc2_internal_input_clk, },
 +	{ "nokia,omap3-n900", nokia_n900_legacy_init, },
  	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
  	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
  	{ "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
