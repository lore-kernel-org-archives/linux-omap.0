From: Marc Murphy <marcmltd@marcm.co.uk>
Subject: Initialising omapfb on AM3517 issues
Date: Tue, 18 Sep 2012 16:41:49 +0000
Message-ID: <F690310232FDDF4AB457E8B3EF90DDE05D7B4BDE@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm19-vm0.bullet.mail.ukl.yahoo.com ([217.146.183.113]:42655
	"HELO nm19-vm0.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751616Ab2IRQsO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Sep 2012 12:48:14 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'linux-omap@vger.kernel.org'" <linux-omap@vger.kernel.org>

Hello all,
I have been moving from the ti 2.6.37 BSP to the 3.x kernel with quite a bit of success, the main issue I have at the moment is trying to get the frame buffer and any displays I have initialised.

[    2.805358] omapfb omapfb: no driver for display: lcd
[    2.810729] omapfb omapfb: no displays
[    2.814666] omapfb omapfb: failed to setup omapfb

I have tried a few versions of release and none of them will initialise;

Currently on
[    0.000000] Linux version 3.6.0-rc3

I have started with board-am3517evm display config and even that doesn't initialise.  Is there something I am missing with the configs or is there a patch required to get the feature to work.

My current config options use;
#
# Graphics support
#
CONFIG_DRM=y
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y

#
# Frame buffer hardware drivers
#
CONFIG_OMAP2_VRAM=y
CONFIG_OMAP2_VRFB=y
CONFIG_OMAP2_DSS=y
CONFIG_OMAP2_VRAM_SIZE=12
CONFIG_OMAP2_DSS_DPI=y
CONFIG_OMAP2_DSS_VENC=y
CONFIG_OMAP2_DSS_DSI=y
CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=1
CONFIG_OMAP2_DSS_SLEEP_AFTER_VENC_RESET=y
CONFIG_FB_OMAP2=y
CONFIG_FB_OMAP2_NUM_FBS=3

#
# OMAP2/3 Display Device Drivers
#
CONFIG_PANEL_GENERIC_DPI=y
CONFIG_PANEL_SHARP_LS037V7DW01=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y

And the init structs are
static int am3517_evm_panel_enable_lcd(struct omap_dss_device *dssdev)
{
    gpio_set_value(TAM3517_DVI_PON_GPIO, 0);
    gpio_set_value(TAM3517_LCD_ENVDD_GPIO, 0);
    gpio_set_value(TAM3517_LCD_PON_GPIO, 1);
        printk("LCD voltage on\n");
	return 0;
}

static void am3517_evm_panel_disable_lcd(struct omap_dss_device *dssdev)
{
    gpio_set_value(TAM3517_LCD_ENVDD_GPIO, 1);
    gpio_set_value(TAM3517_LCD_PON_GPIO, 0);
}

static struct panel_generic_dpi_data lcd_panel = {
//    .name			= "generic_dpi_panel",
	.platform_enable	= am3517_evm_panel_enable_lcd,
	.platform_disable	= am3517_evm_panel_disable_lcd,
};

static struct omap_dss_device am3517_evm_lcd_device = {
    .type                   = OMAP_DISPLAY_TYPE_DPI,
    .name			= "lcd",
    .driver_name		= "generic_dpi_panel",
	.data			= &lcd_panel,
	.phy.dpi.data_lines 	= 16,
};

static int am3517_evm_panel_enable_tv(struct omap_dss_device *dssdev)
{
	return 0;
}

static void am3517_evm_panel_disable_tv(struct omap_dss_device *dssdev)
{
}

static struct omap_dss_device am3517_evm_tv_device = {
	.type 			= OMAP_DISPLAY_TYPE_VENC,
	.name 			= "tv",
	.driver_name		= "venc",
	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
	.platform_enable	= am3517_evm_panel_enable_tv,
	.platform_disable	= am3517_evm_panel_disable_tv,
};

static struct tfp410_platform_data dvi_panel = {
	.power_down_gpio	= -1,
};

static struct omap_dss_device am3517_evm_dvi_device = {
	.type			= OMAP_DISPLAY_TYPE_DPI,
	.name			= "dvi",
	.driver_name		= "tfp410",
	.data			= &dvi_panel,
	.phy.dpi.data_lines	= 24,
};     

static struct omap_dss_device *am3517_evm_dss_devices[] = {
	&am3517_evm_lcd_device,
//	&am3517_evm_tv_device,
//	&am3517_evm_dvi_device,
};

static struct omap_dss_board_info am3517_evm_dss_data = {
	.num_devices	= ARRAY_SIZE(am3517_evm_dss_devices),
	.devices	= am3517_evm_dss_devices,
  	.default_device	= &am3517_evm_lcd_device,
};

And the device initialised with 
    omap_display_init(&am3517_evm_dss_data);


Any help feedback appreciated.

Thanks
Marc
