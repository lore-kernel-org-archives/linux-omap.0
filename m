From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC] DSS:  Movement of base addr, silicon specific data from
 driver to platform_device
Date: Thu, 10 Jun 2010 11:07:52 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E852E04@dbde02.ent.ti.com>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703042888D6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53528 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab0FJFiF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 01:38:05 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703042888D6@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@nokia.com" <tomi.valkein>


> -----Original Message-----
> From: Guruswamy, Senthilvadivu
> Sent: Thursday, June 10, 2010 10:49 AM
> To: linux-omap@vger.kernel.org; tony@atomide.com; tomi.valkeinen@nokia.com;
> Hiremath, Vaibhav
> Subject: [RFC] DSS: Movement of base addr, silicon specific data from driver
> to platform_device
> 
> Hi,
> 
> This RFC is for making DSS drivers not aware of omap versions and
> omap2,3 specific data like base addr, and irqs.
> DSS base address, irqs, and silicon specific data could be placed in
> platform_device.
> This avoids the base address changes in the dss specific drivers like rfbi,
> dsi, sdi.
> Board specific data shall be continued to be maintained in platform_data.
> More details are inlined in the patch with signature [RFC].
> Please provide your comments on this.
> 
[Hiremath, Vaibhav] Ideally, this is correct way of sharing the resource. I do agree that we should take all the platform/device specific resources from platform_data.


> Files tentatively to be modified are:
>  arch/arm/mach-omap2/board-3430sdp.c and all omap board files.
>  arch/arm/mach-omap2/devices.c
>  arch/arm/plat-omap/include/plat/display.h
>  drivers/video/omap2/dss/core.c
>  drivers/video/omap2/dss/dispc.c
>  drivers/video/omap2/dss/dsi.c and all other dss driver files.
>  drivers/video/omap2/dss/dss.c
>  drivers/video/omap2/dss/dss.h
> 
> Regards,
> Senthil
> 
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-
> omap2/board-3430sdp.c
> index 540d28f..bfdc5f0
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -536,16 +536,7 @@ static struct omap_dss_board_info sdp3430_dss_data = {
>  	.default_device	=	&sdp3430_lcd_device,
>  };
> 
> -static struct platform_device sdp3430_dss_device = {
> -	.name	=	"omapdss",
> -	.id	=	-1,
> -	.dev	= {
> -		.platform_data = &sdp4430_dss_data,
> -	},
> -};
> -
>  static struct platform_device *sdp3430_devices[] __initdata = {
> -	&sdp3430_dss_device,
>  	&sdp3430_keypad_device,
>  };
> @@ -905,6 +896,7 @@ static void __init omap_3430sdp_init(void)
>  	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
>  	omap_serial_init();
> +	display_init(&sdp3430_dss_data);
> 
> [RFC]  Platform device shall be moved to devices.c for definition and
> registration
> of the dss device in the platform bus.
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 83bd3d6..e481f63
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -26,6 +26,7 @@
>  #include <plat/mux.h>
>  #include <mach/gpio.h>
>  #include <plat/mmc.h>
> +#include <plat/display.h>
> 
>  #include "mux.h"
> 
> @@ -790,7 +791,103 @@ static inline void omap_hdq_init(void)
>  #else
>  static inline void omap_hdq_init(void) {}
>  #endif
> +/*-------------------------------------------------------------------------
> --*/
> +#ifdef CONFIG_OMAP2_DSS
> +
> +#define OMAP4_DISPC_BASE		0x58001000
> +#define OMAP2_DISPC_BASE		0x48050400
> +#define OMAP3_DSI_BASE			0x4804FC00
> +#define OMAP4_DSI_BASE			0x58004000
> +#define OMAP4_DSI2_BASE		0x58005000
> +#define OMAP2_DSS_BASE			0x48050000
> +#define OMAP4_DSS_BASE			0x58000000
> +
> +
> [RFC]  Move the Base Address macros from the dss driver files to devices.c
> where
> the platform_device is defined.  These macros get into resource structure.
> The
> resource strucutre would be a part of platform_device.
> 
[Hiremath, Vaibhav] Don't you think this should be part of either omap24xx.h, omap34xx.h or omap44xx.h.

> 
> +
> +static struct platform_device omap_display_dev = {
> +	.name		= "omapdss",
> +	.id		= 1,
> +	.dev		= {
> +		.platform_data = NULL, // rename as omapboard_dss_data
> +	},
> +	.num_resources	= 0,
> +	.resource	= NULL,
> +};
> +
> +
> +static struct resource omap2_dss_resources[] = {
> +	{
> +		.start		= OMAP2_DISPC_BASE,
> +		.name			= "dispc",
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= OMAP2_DSS_BASE,
> +		.name			= "dss",
> +		.flags		= IORESOURCE_MEM,
> +	},
> +};
> +static struct resource omap3_dss_resources[] = {
> +	{
> +		.start		= OMAP2_DISPC_BASE,
> +		.name			= "dispc",
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= OMAP2_DSS_BASE,
> +		.name			= "dss",
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= OMAP2_DSI_BASE,
> +		.name			= "dsi",
> +		.flags		= IORESOURCE_MEM,
> +	},
> +};
> +static struct resource omap4_dss_resources[] = {
> +	{
> +		.start		= OMAP4_DISPC_BASE,
> +		.name			= "dispc",
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= OMAP4_DSS_BASE,
> +		.name			= "dss",
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= OMAP4_DSI_BASE,
> +		.name			= "dsi",
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= OMAP4_DSI2_BASE,
> +		.name			= "dsi2",
> +		.flags		= IORESOURCE_MEM,
> +	},
> +};
> +
> 
[Hiremath, Vaibhav] Specify .end to all of these resources so that we do not need to hardcode the size while mapping.

> +void __init display_init(struct omap_dss_board_info *board_data)
> +{
> +	if (cpu_is_omap24xx()) {
> +		omap_display_dev.resource = omap2_dss_resources;
> +		omap_display_dev.num_resources =
> ARRAY_SIZE(omap2_dss_resources);
> +	} else if (cpu_is_omap34xx()) {
> +		omap_display_dev.resource = omap3_dss_resources;
> +		omap_display_dev.num_resources =
> ARRAY_SIZE(omap3_dss_resources);
> +	} else if (cpu_is_omap44xx()) {
> +		omap_display_dev.resource = omap4_dss_resources;
> +		omap_display_dev.num_resources =
> ARRAY_SIZE(omap4_dss_resources);
> +	}
> +	omap_display_dev.dev.platform_data = board_data;
> +	if (platform_device_register(&omap_display_dev) < 0)
> +		printk(KERN_ERR "Unable to register Display device\n");
> +}
> +
> +#else
> +void __init display_init(struct omap_dss_board_info *board_data)
> +{
> +}
> +#endif
>  /*-------------------------------------------------------------------------
> --*/
> 
>  #if defined(CONFIG_VIDEO_OMAP2_VOUT) || \
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-
> omap/include/plat/display.h
> index 5ea4229..80bb135 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -24,6 +24,7 @@
>  #include <linux/kobject.h>
>  #include <linux/device.h>
>  #include <asm/atomic.h>
> +#include <linux/platform_device.h>
> 
>  #define DISPC_IRQ_FRAMEDONE		(1 << 0)
>  #define DISPC_IRQ_VSYNC			(1 << 1)
> @@ -334,6 +335,7 @@ struct omap_dss_board_info {
>  	struct omap_dss_device **devices;
>  	struct omap_dss_device *default_device;
>  };
> +extern void display_init(struct omap_dss_board_info *board_data);
> 
[Hiremath, Vaibhav] Why extern?

I suggest you to submit the actual patches to the list for review.

Thanks,
Vaibhav
>  struct omap_video_timings {
>  	/* Unit: pixels */
> [RFC]  Inclusion of platform_device.h in display.h so that all the display
> drivers
> could access it.
> 
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index ed9f769..10bb592 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> 
> @@ -526,14 +526,14 @@ static int omap_dss_probe(struct platform_device
> *pdev)
>  		skip_init = 1;
>  #endif
> 
> -	r = dss_init(skip_init);
> +	r = dss_init(pdev,skip_init);
>  	if (r) {
>  		DSSERR("Failed to initialize DSS\n");
>  		goto fail0;
>  	}
> 
>  #ifdef CONFIG_OMAP2_DSS_RFBI
> -	r = rfbi_init();
> +	r = rfbi_init(pdev);
>  	if (r) {
>  		DSSERR("Failed to initialize rfbi\n");
>  		goto fail0;
> @@ -548,7 +548,7 @@ static int omap_dss_probe(struct platform_device *pdev)
>  	}
>  #endif
> 
> -	r = dispc_init();
> +	r = dispc_init(pdev);
>  	if (r) {
>  		DSSERR("Failed to initialize dispc\n");
>  		goto fail0;
> @@ -562,7 +562,7 @@ static int omap_dss_probe(struct platform_device *pdev)
>  #endif
>  	if (cpu_is_omap34xx()) {
>  #ifdef CONFIG_OMAP2_DSS_SDI
> -		r = sdi_init(skip_init);
> +		r = sdi_init(pdev,skip_init);
>  		if (r) {
>  			DSSERR("Failed to initialize SDI\n");
> 
>  			goto fail0;
> [RFC]  Each of the driver initialisation take the platform device structure
> in it.
> The corresponding base address, irq info could be extracted based on the
> module name
> from the platform_device structure.
> 
> diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c
> index fc35ffb..35fab95 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -40,12 +40,6 @@
>  #include "dss.h"
> 
> 
> -#define DISPC_BASE		0x48050400
> 
>  #define DISPC_SZ_REGS			SZ_1K
> 
>  struct dispc_reg { u16 idx; };
> @@ -4038,9 +4032,12 @@ static void _omap_dispc_initial_config(void)
>  	dispc_read_plane_fifo_sizes();
>  }
> 
> -int dispc_init(void)
> +int dispc_init(struct platform_device *pdev)
>  {
>  	u32 rev;
> +	struct resource *dispc_res;
> +
> +	dispc_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "dispc");
> 
>  	spin_lock_init(&dispc.irq_lock);
> 
> @@ -4051,7 +4048,7 @@ int dispc_init(void)
> 
>  	INIT_WORK(&dispc.error_work, dispc_error_worker);
> 
> -	dispc_base = dispc.base = ioremap(DISPC_BASE, DISPC_SZ_REGS);
> +	dispc_base = dispc.base = ioremap(dispc_res->start, DISPC_SZ_REGS);
>  	if (!dispc.base) {
>  		DSSERR("can't ioremap DISPC\n");
>  		return -ENOMEM;
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 178f0fd..95a49c7 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -42,19 +42,13 @@
>  /*#define VERBOSE_IRQ*/
>  #define DSI_CATCH_MISSING_TE
> 
> -#define DSI_BASE		0x58004000
> 
> #define DSI_SZ_REGS			SZ_1K
> 
>  struct dsi_reg { u16 idx; };
> 
>  #define DSI_REG(idx)		((const struct dsi_reg) { idx })
> 
> -#define DSI_SZ_REGS		SZ_1K
> +
>  /* DSI Protocol Engine */
> 
>  #define DSI_REVISION			DSI_REG(0x0000)
> @@ -3701,6 +3695,9 @@ int dsi_init(struct platform_device *pdev)
>  	u32 rev;
>  	int r;
>  	enum omap_dsi_index ix = DSI1;
> +	struct resource *dsi_res;
> +
> +	dsi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dsi");
> 
>  	spin_lock_init(&dsi.errors_lock);
>  	dsi.errors = 0;
> @@ -3730,7 +3727,7 @@ int dsi_init(struct platform_device *pdev)
>  	dsi.te_timer.function = dsi_te_timeout;
>  	dsi.te_timer.data = 0;
>  #endif
> -	dsi.base = ioremap(DSI_BASE, DSI_SZ_REGS);
> +	dsi.base = ioremap(dsi_res->start, DSI_SZ_REGS);
>  	if (!dsi.base) {
>  		DSSERR("can't ioremap DSI\n");
>  		r = -ENOMEM;
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index db8bc71..958e96b 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -33,12 +33,6 @@
>  #include <plat/display.h>
>  #include "dss.h"
> 
> -#define DSS_BASE			0x48050000
>  #define DSS_SZ_REGS			SZ_512
> 
>  struct dss_reg {
> 
> -int dss_init(bool skip_init)
> +int dss_init(struct platform_device *pdev, bool skip_init)
>  {
>  	int r;
>  	u32 rev;
> +	struct resource *dss_res;
> +
> +	dss_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dss");
> 
> -	dss.base = ioremap(DSS_BASE, DSS_SZ_REGS);
> +	dss.base = ioremap(dss_res->start, DSS_SZ_REGS);
>  	if (!dss.base) {
>  		DSSERR("can't ioremap DSS\n");
>  		r = -ENOMEM;
> [RFC]  Example of how the base address could be applied on dispc, dsi, sdi.
> 
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 02cd5ae..636c08a 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> 
>  /* DSS */
> -int dss_init(bool skip_init);
> +int dss_init(struct platform_device *pdev, bool skip_init);
>  void dss_exit(void);
> 
>  /* SDI */
> -int sdi_init(bool skip_init);
> +int sdi_init(struct platform_device *pdev, bool skip_init);
>  void sdi_exit(void);
>  int sdi_init_display(struct omap_dss_device *display);
> 
>  /* DISPC */
> -int dispc_init(void);
> +int dispc_init(struct platform_device *pdev);
>  void dispc_exit(void);
>  void dispc_dump_clocks(struct seq_file *s);
>  void dispc_dump_irqs(struct seq_file *s);
> 
>  /* RFBI */
> -int rfbi_init(void);
> +int rfbi_init(struct platform_device *pdev);
>  void rfbi_exit(void);
>  void rfbi_dump_regs(struct seq_file *s);
> 
