From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
Date: Fri, 15 Jul 2011 03:59:20 -0700
Message-ID: <20110715105920.GU5783@atomide.com>
References: <1310554738.18446.12.camel@lws-weitzel>
 <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
 <4E1D8BCD.5060901@ru.mvista.com>
 <1310561772.18446.14.camel@lws-weitzel>
 <20110714073445.GL5783@atomide.com>
 <1310632792.4008.3.camel@lws-weitzel>
 <20110715075024.GO5783@atomide.com>
 <20110715075825.GB2611@legolas.emea.dhcp.ti.com>
 <20110715082012.GR5783@atomide.com>
 <20110715083103.GF2611@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23275 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964787Ab1GOK70 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 06:59:26 -0400
Content-Disposition: inline
In-Reply-To: <20110715083103.GF2611@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jan Weitzel <J.Weitzel@phytec.de>, linux-omap@vger.kernel.org, Sergei Shtylyov <sshtylyov@mvista.com>, linux-arm-kernel@lists.infradead.org

* Felipe Balbi <balbi@ti.com> [110715 01:25]:
> 
> possibly something like this (still missing MACHINE_START a few more
> things):

Yes and it would be better to initialize data in the .init_machine
to avoid adding machine_is tests in multiple places.
 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 0cfe200..dff174c 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -681,20 +681,44 @@ void omap4_panda_display_init(void)
>         omap_display_init(&omap4_panda_dss_data);
>  }
>  
> +static struct omap_smsc911x_platform_data board_smsc911x_data __initdata = {
> +       .cs             = OMAP4_SMSC911X_ETH_CS,
> +       .gpio_irq       = OMAP4_SMSC911X_ETH_GPIO_IRQ,
> +       .gpio_reset     = -EINVAL,
> +       .flags          = SMSC911X_USE_16BIT,
> +};
> +
> +static void __init omap4_panda_smsc91xx_init(void)
> +{
> +       if (!machine_is_pcm049())
> +               return;
> +
> +       omap_mux_init_gpio(OMAP4_PCM049_ETH_GPIO_IRQ, OMAP_PIN_INPUT);
> +       gpmc_smsc911x_init(&board_smsc911x_data);
> +}
> +
>  static void __init omap4_panda_init(void)
>  {
>         int package = OMAP_PACKAGE_CBS;
>  
>         if (omap_rev() == OMAP4430_REV_ES1_0)
>                 package = OMAP_PACKAGE_CBL;
> +
>         omap4_mux_init(board_mux, NULL, package);
>  
> -       if (wl12xx_set_platform_data(&omap_panda_wlan_data))
> -               pr_err("error setting wl12xx data\n");
> +       if (machine_is_omap4panda()) {
> +               int             ret;
> +
> +               ret = wl12xx_set_platform_data(&omap_panda_wlan_data);
> +               if (ret)
> +                       pr_err("error setting wl12xx data\n");
> +
> +               platform_device_register(&omap_vwlan_device);
> +       }
>  
> +       omap4_panda_smsc91xx_init();
>         omap4_panda_i2c_init();
>         platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
> -       platform_device_register(&omap_vwlan_device);
>         board_serial_init();
>         omap4_twl6030_hsmmc_init(mmc);

So we sould have panda_common_init() and then omap4_panda_init()
and omap4_phycore_init() or something like that. No need for machine_is
tests then as the .machine_init already takes care of that test.

Regards,

Tony
