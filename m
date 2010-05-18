From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Add OMAP4 Panda support
Date: Mon, 17 May 2010 20:36:36 -0700
Message-ID: <20100518033636.GL5818@atomide.com>
References: <7B4574D56E4ADF438756313E9A172A8799C0D3C6@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64623 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0ERDgm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 23:36:42 -0400
Content-Disposition: inline
In-Reply-To: <7B4574D56E4ADF438756313E9A172A8799C0D3C6@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anders, David" <x0132446@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Anders, David <x0132446@ti.com> [100517 13:13]:
> Add initial support for the OMAP4430 based Panda board.
> 
> Signed-off-by: David Anders <x0132446@ti.com>

<snip>

> +
> +static void __init omap4_panda_init_irq(void)
> +{
> +       omap2_init_common_hw(NULL, NULL);
> +#ifdef CONFIG_OMAP_32K_TIMER
> +       omap2_gp_clockevent_set_gptimer(1);
> +#endif
> +       gic_init_irq();
> +       omap_gpio_init();
> +}
> +
> +static struct omap_musb_board_data musb_board_data = {
> +       .interface_type         = MUSB_INTERFACE_UTMI,
> +       .mode                   = MUSB_PERIPHERAL,
> +       .power                  = 100,
> +};
> +
> +static void __init omap4_panda_init(void)
> +{
> +       omap_serial_init();
> +       /* OMAP4 SDP uses internal transceiver so register nop transceiver */
> +       usb_nop_xceiv_register();
> +       /* FIXME: allow multi-omap to boot until musb is updated for omap4 */
> +       if (!cpu_is_omap44xx())
> +               usb_musb_init(&musb_board_data);
> +
> +}
> +
> +static void __init omap4_panda_map_io(void)
> +{
> +       omap2_set_globals_443x();
> +       omap44xx_map_common_io();
> +}
> +
> +MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
> +       /* Maintainer: David Anders - Texas Instruments Inc */
> +       .phys_io        = 0x48000000,
> +       .io_pg_offst    = ((0xfa000000) >> 18) & 0xfffc,
> +       .boot_params    = 0x80000100,
> +       .map_io         = omap4_panda_map_io,
> +       .init_irq       = omap4_panda_init_irq,
> +       .init_machine   = omap4_panda_init,
> +       .timer          = &omap_timer,
> +MACHINE_END

Cool, good to see this posted early.

However, looks like this can wait until the next merge window
though as it was posted so late.

Regards,

Tony
