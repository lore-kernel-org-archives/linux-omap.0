From: "Jacob Tanenbaum" <Jacob.Tanenbaum@logicpd.com>
Subject: RE: [PATCH 1/4] initial support for LogicPD's OMAP3 SOM and TORPEDO development kits
Date: Wed, 11 Aug 2010 13:45:22 -0500
Message-ID: <77A0A4DB5BF2A44283E5522C27234AC6021C82B4@EDPRSRV011.logicpd.com>
References: <20100811172232.GA21391@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20100811172232.GA21391@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, tony@atomide.com
List-Id: linux-omap@vger.kernel.org



-----Original Message-----
From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
Sent: Wednesday, August 11, 2010 1:23 PM
To: Jacob Tanenbaum
Cc: linux@arm.linux.org.uk; linux-omap@vger.kernel.org;
linux-kernel@vger.kernel.org; rmk@arm.linux.org.uk; tony@atomide.com
Subject: Re: [PATCH 1/4] initial support for LogicPD's OMAP3 SOM and
TORPEDO development kits

Hi Jacob,

few style comments only

On Wed, Aug 11, 2010 at 06:31:34PM +0200, ext Jacob Tanenbaum wrote:
>
>	Adding LogicPD OMAP3 board support
>
>         Adding support for LogicPD's OMAP 3530 LV SOM and
>         OMAP 35x Torpedo board.
>	
>	 Tested against: linux-next
81e09f50c93edff607259cbe374a3006c9c5fa74
>         Signed-off-by: Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>

don't tab here. Please remove.
Will fix

>+static int omap3logic_twl_gpio_setup(struct device *dev,
>+				unsigned gpio, unsigned ngpio)
>+{
>+	return 0;
>+}

no gpio setup ?? If you truly don't need, you don't have to add this 
stub function.
Will fix 

>+static struct twl4030_gpio_platform_data omap3logic_gpio_data = {
>+	.gpio_base	= OMAP_MAX_GPIO_LINES,
>+	.irq_base	= TWL4030_GPIO_IRQ_BASE,
>+	.irq_end	= TWL4030_GPIO_IRQ_END,
>+	.use_leds	= true,
>+	.pullups	= BIT(1),
>+	.pulldowns	= BIT(2)  | BIT(6)  | BIT(7)  | BIT(8)
>+			| BIT(13) | BIT(15) | BIT(16) | BIT(17),
>+	.setup		= omap3logic_twl_gpio_setup,
>+};
>+
>+static struct twl4030_platform_data omap3logic_twldata = {
>+	.irq_base	= TWL4030_IRQ_BASE,
>+	.irq_end	= TWL4030_IRQ_END,
>+
>+	/* platform_data for children goes here */
>+	.gpio		= &omap3logic_gpio_data,

no USB on this board ?


there is USB support it will be added in later 

>+static struct omap_board_config_kernel omap3logic_config[] __initdata
= {
>+};

just don't assign anything ?


will fix

>+static void __init omap3logic_init_irq(void)
>+{
>+	omap_board_config = omap3logic_config;
>+	omap_board_config_size = ARRAY_SIZE(omap3logic_config);
>+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
>+				mt46h32m32lf6_sdrc_params);
>+	omap_init_irq();
>+#ifdef CONFIG_OMAP_32K_TIMER
>+	omap2_gp_clockevent_set_gptimer(12);
>+#endif
>+	omap_gpio_init();
>+}
>+
>+
>+

one blank line only

will fix

>+static void __init omap3logic_init(void)
>+{
>+	omap3logic_i2c_init();
>+	omap_serial_init();
>+
>+	/* Ensure SDRC pins are mux'd for self-refresh */
>+/*	omap_cfg_reg(H16_34XX_SDRC_CKE0);
>+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
>+	omap_cfg_reg(SDRC_CKE0);
>+	omap_cfg_reg(SDRC_CKE1); */

remove this commented code if it's not used yet.

I made a mistake rebasing this code gets removed in patch 4, will fix 

>+#ifdef CONFIG_MACH_OMAP3_TORPEDO

no need to wrap on this ifdef, please remove.

>+#ifdef CONFIG_MACH_OMAP3530_LV_SOM

neither this.

No one else uses the ifdef but we were told from an earlier submission
we should because if both boards are disabled in the .config it would
inform the user on bootup 

-- 
balbi

DefectiveByDesign.org
