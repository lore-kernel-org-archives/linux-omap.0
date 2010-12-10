From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 2/4] omap1: Add initcall checks for omap1 and booted board
Date: Fri, 10 Dec 2010 17:02:33 +0100
Message-ID: <201012101702.34825.jkrzyszt@tis.icnet.pl>
References: <20101204213358.32208.4195.stgit@baageli.muru.com> <20101204213655.32208.23030.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:57168 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259Ab0LJQDr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 11:03:47 -0500
In-Reply-To: <20101204213655.32208.23030.stgit@baageli.muru.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Saturday 04 December 2010 22:36:55 Tony Lindgren napisa=C5=82(a):
> Otherwise multi-omap1 configurations will fail.

Tested on Amstrad Delta with omap1_defconfig.

> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

> ---
>  arch/arm/mach-omap1/board-ams-delta.c |    3 +++
>  arch/arm/mach-omap1/board-voiceblue.c |    6 ++++++
>  arch/arm/mach-omap1/devices.c         |    3 +++
>  arch/arm/mach-omap1/lcd_dma.c         |    3 +++
>  arch/arm/mach-omap1/leds.c            |    3 +++
>  arch/arm/mach-omap1/mcbsp.c           |    3 +++
>  arch/arm/mach-omap1/pm.c              |    3 +++
>  arch/arm/mach-omap1/pm_bus.c          |    3 +++
>  arch/arm/mach-omap1/serial.c          |    3 +++
>  9 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c
> b/arch/arm/mach-omap1/board-ams-delta.c index ce4d69c..e143950 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -338,6 +338,9 @@ static int __init ams_delta_modem_init(void)
>  {
>  	int err;
>
> +	if (!machine_is_ams_delta())
> +		return -ENODEV;
> +
>  	omap_cfg_reg(M14_1510_GPIO2);
>  	ams_delta_modem_ports[0].irq =3D
>  			gpio_to_irq(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
> diff --git a/arch/arm/mach-omap1/board-voiceblue.c
> b/arch/arm/mach-omap1/board-voiceblue.c index 789f5ba..815a69c 100644
> --- a/arch/arm/mach-omap1/board-voiceblue.c
> +++ b/arch/arm/mach-omap1/board-voiceblue.c
> @@ -83,6 +83,9 @@ static struct platform_device serial_device =3D {
>
>  static int __init ext_uart_init(void)
>  {
> +	if (!machine_is_voiceblue())
> +		return -ENODEV;
> +
>  	return platform_device_register(&serial_device);
>  }
>  arch_initcall(ext_uart_init);
> @@ -235,6 +238,9 @@ static struct notifier_block panic_block =3D {
>
>  static int __init voiceblue_setup(void)
>  {
> +	if (!machine_is_voiceblue())
> +		return -ENODEV;
> +
>  	/* Setup panic notifier */
>  	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
>
> diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devi=
ces.c
> index 86ad38a..b0f4c23 100644
> --- a/arch/arm/mach-omap1/devices.c
> +++ b/arch/arm/mach-omap1/devices.c
> @@ -288,6 +288,9 @@ static inline void omap_init_audio(void) {}
>   */
>  static int __init omap1_init_devices(void)
>  {
> +	if (!cpu_class_is_omap1())
> +		return -ENODEV;
> +
>  	/* please keep these calls, and their implementations above,
>  	 * in alphabetical order so they're easier to sort through.
>  	 */
> diff --git a/arch/arm/mach-omap1/lcd_dma.c b/arch/arm/mach-omap1/lcd_=
dma.c
> index 3be11af..c9088d8 100644
> --- a/arch/arm/mach-omap1/lcd_dma.c
> +++ b/arch/arm/mach-omap1/lcd_dma.c
> @@ -424,6 +424,9 @@ static int __init omap_init_lcd_dma(void)
>  {
>  	int r;
>
> +	if (!cpu_class_is_omap1())
> +		return -ENODEV;
> +
>  	if (cpu_is_omap16xx()) {
>  		u16 w;
>
> diff --git a/arch/arm/mach-omap1/leds.c b/arch/arm/mach-omap1/leds.c
> index 277f356..22eb11d 100644
> --- a/arch/arm/mach-omap1/leds.c
> +++ b/arch/arm/mach-omap1/leds.c
> @@ -17,6 +17,9 @@
>  static int __init
>  omap_leds_init(void)
>  {
> +	if (!cpu_class_is_omap1())
> +		return -ENODEV;
> +
>  	if (machine_is_omap_innovator())
>  		leds_event =3D innovator_leds_event;
>
> diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.=
c
> index 372ea71..8209736 100644
> --- a/arch/arm/mach-omap1/mcbsp.c
> +++ b/arch/arm/mach-omap1/mcbsp.c
> @@ -176,6 +176,9 @@ static struct omap_mcbsp_platform_data
> omap16xx_mcbsp_pdata[] =3D {
>
>  static int __init omap1_mcbsp_init(void)
>  {
> +	if (!cpu_class_is_omap1())
> +		return -ENODEV;
> +
>  	if (cpu_is_omap7xx()) {
>  		omap_mcbsp_count =3D OMAP7XX_MCBSP_PDATA_SZ;
>  		omap_mcbsp_cache_size =3D OMAP7XX_MCBSP_REG_NUM * sizeof(u16);
> diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> index b1d3f9f..0cca23a 100644
> --- a/arch/arm/mach-omap1/pm.c
> +++ b/arch/arm/mach-omap1/pm.c
> @@ -661,6 +661,9 @@ static int __init omap_pm_init(void)
>  	int error;
>  #endif
>
> +	if (!cpu_class_is_omap1())
> +		return -ENODEV;
> +
>  	printk("Power Management for TI OMAP.\n");
>
>  	/*
> diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bu=
s.c
> index 8b66392..3266447 100644
> --- a/arch/arm/mach-omap1/pm_bus.c
> +++ b/arch/arm/mach-omap1/pm_bus.c
> @@ -73,6 +73,9 @@ static int __init omap1_pm_runtime_init(void)
>  	const struct dev_pm_ops *pm;
>  	struct dev_pm_ops *omap_pm;
>
> +	if (!cpu_class_is_omap1())
> +		return -ENODEV;
> +
>  	pm =3D platform_bus_get_pm_ops();
>  	if (!pm) {
>  		pr_err("%s: unable to get dev_pm_ops from platform_bus\n",
> diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/seria=
l.c
> index 9e1c4d4..550ca9d 100644
> --- a/arch/arm/mach-omap1/serial.c
> +++ b/arch/arm/mach-omap1/serial.c
> @@ -258,6 +258,9 @@ late_initcall(omap_serial_wakeup_init);
>
>  static int __init omap_init(void)
>  {
> +	if (!cpu_class_is_omap1())
> +		return -ENODEV;
> +
>  	return platform_device_register(&serial_device);
>  }
>  arch_initcall(omap_init);
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
