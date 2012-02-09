From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: clean up init data section
	assignments
Date: Thu, 9 Feb 2012 14:48:53 +0000
Message-ID: <20120209144853.GU1275@n2100.arm.linux.org.uk>
References: <1328696173-17226-1-git-send-email-grinberg@compulab.co.il> <1328786302-25131-1-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1328786302-25131-1-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-input-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mtd@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 09, 2012 at 12:18:22PM +0100, Janusz Krzysztofik wrote:
> The main purpose of this patch is to fix several section mismatch
> warnings from the board file and a few board specific drivers,
> introduced mostly with recent Amstrad Delta patch series, some of them
> rising up only when building with CONFIG_MODULES not set.
> 
> While being at it, section assignments of all init data found in the
> board file have been revised and hopefully optimised.

There is no optimisation to adding __refdata to stuff.  That's screaming
that you have lots of bugs here.

> 
> Created and tested on top of current linux-omap/omap1, commit
> 967809bd7faf71ddc29c8081e0f21db8b201a0f4.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c |   35 +++++++++++++++++----------------
>  drivers/input/serio/ams_delta_serio.c |    2 +-
>  drivers/mtd/nand/ams-delta.c          |    2 +-
>  drivers/video/omap/lcd_ams_delta.c    |    2 +-
>  4 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 87b1303..dc2455f 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -126,7 +126,7 @@ static const unsigned int ams_delta_keymap[] = {
>  #define LATCH2_PHYS	0x08000000
>  #define LATCH2_VIRT	0xEC000000
>  
> -static struct map_desc ams_delta_io_desc[] __initdata = {
> +static struct map_desc ams_delta_io_desc[] __initconst = {

You're not making this comst so don't change it to __initconst.

>  	/* AMS_DELTA_LATCH1 */
>  	{
>  		.virtual	= LATCH1_VIRT,
> @@ -150,17 +150,17 @@ static struct map_desc ams_delta_io_desc[] __initdata = {
>  	}
>  };
>  
> -static struct omap_lcd_config ams_delta_lcd_config = {
> +static struct omap_lcd_config ams_delta_lcd_config __initconst = {

This change probably adds a bug.  Are you sure this will never be used
outside init context?

>  	.ctrl_name	= "internal",
>  };
>  
> -static struct omap_usb_config ams_delta_usb_config __initdata = {
> +static struct omap_usb_config ams_delta_usb_config __initdata_or_module = {

Even if you don't have modules enabled, have you checked whether the
driver can be bound and unbound via
/sys/bus/platform/driver/<name>/{bind,unbind} ?

I suspect this is a bug.

>  	.register_host	= 1,
>  	.hmc_mode	= 16,
>  	.pins[0]	= 2,
>  };
>  
> -static struct omap_board_config_kernel ams_delta_config[] __initdata = {
> +static struct omap_board_config_kernel ams_delta_config[] __initconst = {
>  	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
>  };
>  
> @@ -181,7 +181,7 @@ static struct bgpio_pdata latch1_pdata __initconst = {
>  	.ngpio	= LATCH1_NGPIO,
>  };
>  
> -static struct platform_device latch1_gpio_device = {
> +static struct platform_device latch1_gpio_device __refdata = {
>  	.name		= "basic-mmio-gpio",
>  	.id		= 0,
>  	.resource	= latch1_resources,
> @@ -205,7 +205,7 @@ static struct bgpio_pdata latch2_pdata __initconst = {
>  	.ngpio	= AMS_DELTA_LATCH2_NGPIO,
>  };
>  
> -static struct platform_device latch2_gpio_device = {
> +static struct platform_device latch2_gpio_device __refdata = {
>  	.name		= "basic-mmio-gpio",
>  	.id		= 1,
>  	.resource	= latch2_resources,
> @@ -271,7 +271,7 @@ void ams_delta_latch_write(int base, int ngpio, u16 mask, u16 value)
>  }
>  EXPORT_SYMBOL(ams_delta_latch_write);
>  
> -static struct resource ams_delta_nand_resources[] = {
> +static struct resource ams_delta_nand_resources[] __initconst_or_module = {

This change definitely adds a bug.  The resources are _used_ _all_ _the_
_time_ _the_ _device_ _is_ _registered_.  Try catting /proc/iomem after
boot.

>  	[0] = {
>  		.start	= OMAP1_MPUIO_BASE,
>  		.end	= OMAP1_MPUIO_BASE +
> @@ -280,14 +280,14 @@ static struct resource ams_delta_nand_resources[] = {
>  	},
>  };
>  
> -static struct platform_device ams_delta_nand_device = {
> +static struct platform_device ams_delta_nand_device __refdata = {

Therefore, bug.

>  	.name	= "ams-delta-nand",
>  	.id	= -1,
>  	.num_resources	= ARRAY_SIZE(ams_delta_nand_resources),
>  	.resource	= ams_delta_nand_resources,
>  };
>  
> -static struct resource ams_delta_kp_resources[] = {
> +static struct resource ams_delta_kp_resources[] __initconst_or_module = {

Bug.

>  	[0] = {
>  		.start	= INT_KEYBOARD,
>  		.end	= INT_KEYBOARD,
> @@ -300,14 +300,14 @@ static const struct matrix_keymap_data ams_delta_keymap_data = {
>  	.keymap_size	= ARRAY_SIZE(ams_delta_keymap),
>  };
>  
> -static struct omap_kp_platform_data ams_delta_kp_data __initdata = {
> +static struct omap_kp_platform_data ams_delta_kp_data __initconst_or_module = {

Probably a bug if you unbind/rebind the associated driver with modules
disabled.

>  	.rows		= 8,
>  	.cols		= 8,
>  	.keymap_data	= &ams_delta_keymap_data,
>  	.delay		= 9,
>  };
>  
> -static struct platform_device ams_delta_kp_device = {
> +static struct platform_device ams_delta_kp_device __refdata = {
>  	.name		= "omap-keypad",
>  	.id		= -1,
>  	.dev		= {
> @@ -363,7 +363,8 @@ static struct gpio_led_platform_data leds_pdata __initconst = {
>  	.num_leds	= ARRAY_SIZE(gpio_leds),
>  };
>  
> -static struct i2c_board_info ams_delta_camera_board_info[] = {
> +static struct i2c_board_info __initconst_or_module
> +ams_delta_camera_board_info[] = {

No.  It's

static struct foo blah[] __whatever_init_attribute

not

static struct foo __whatever_init_attribute blah[]

I've no idea where this fucked idea came from but it's something that's
wasting a lot of review time with complaints like this about it.

>  	{
>  		I2C_BOARD_INFO("ov6650", 0x60),
>  	},
> @@ -387,7 +388,7 @@ static int ams_delta_camera_power(struct device *dev, int power)
>  #define ams_delta_camera_power	NULL
>  #endif
>  
> -static struct soc_camera_link ams_delta_iclink = {
> +static struct soc_camera_link ams_delta_iclink __initconst_or_module = {

Probably buggy.

>  	.bus_id         = 0,	/* OMAP1 SoC camera bus */
>  	.i2c_adapter_id = 1,
>  	.board_info     = &ams_delta_camera_board_info[0],
> @@ -395,7 +396,7 @@ static struct soc_camera_link ams_delta_iclink = {
>  	.power		= ams_delta_camera_power,
>  };
>  
> -static struct platform_device ams_delta_camera_device = {
> +static struct platform_device ams_delta_camera_device __refdata = {
>  	.name   = "soc-camera-pdrv",
>  	.id     = 0,
>  	.dev    = {
> @@ -408,7 +409,7 @@ static struct omap1_cam_platform_data ams_delta_camera_platform_data = {
>  	.lclk_khz_max	= 1334,		/* results in 5fps CIF, 10fps QCIF */
>  };
>  
> -static struct platform_device *ams_delta_devices[] __initdata = {
> +static struct platform_device *ams_delta_devices[] __initconst = {

Missing const.  If you can't const it, don't put it in __initconst.

>  	&latch1_gpio_device,
>  	&latch2_gpio_device,
>  	&ams_delta_kp_device,
> @@ -459,7 +460,7 @@ static void __init ams_delta_init(void)
>  	omap_writew(omap_readw(ARM_RSTCT1) | 0x0004, ARM_RSTCT1);
>  }
>  
> -static struct plat_serial8250_port ams_delta_modem_ports[] = {
> +static struct plat_serial8250_port ams_delta_modem_ports[] __initdata = {

Buggy.

>  	{
>  		.membase	= IOMEM(MODEM_VIRT),
>  		.mapbase	= MODEM_PHYS,
> @@ -473,7 +474,7 @@ static struct plat_serial8250_port ams_delta_modem_ports[] = {
>  	{ },
>  };
>  
> -static struct platform_device ams_delta_modem_device = {
> +static struct platform_device ams_delta_modem_device __refdata = {
>  	.name	= "serial8250",
>  	.id	= PLAT8250_DEV_PLATFORM1,
>  	.dev		= {
