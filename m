From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Patches for enabling display on Zoom2/3 & 3630 SDP
Date: Fri, 14 May 2010 10:06:23 +0300
Message-ID: <1273820783.2814.55.camel@tubuntu.research.nokia.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C54549BC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-cuEV+7ZI2ieIO01rHj8R"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41014 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab0ENHGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 03:06:42 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C54549BC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Mittal, Mukund" <mmittal@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--=-cuEV+7ZI2ieIO01rHj8R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 2010-05-10 at 08:41 +0200, ext Mittal, Mukund wrote:
> Tomi,
> Would you please check if there are no further comments and can you 
> please pull the following patches in?
> 
> https://patchwork.kernel.org/patch/95067/
> https://patchwork.kernel.org/patch/95068/
> https://patchwork.kernel.org/patch/94937/
> https://patchwork.kernel.org/patch/94934/
> https://patchwork.kernel.org/patch/94893/


This one is already applied:
OMAP:DSS: Add missing line for update bg color

This patch affects also 3630SDP, should be mentioned in patch title. And
I think the title should not be "OMAP: DSS", as it's not about DSS but
the board files. It should be something like OMAP3630SDP: or similar.
OMAP: DSS: Add display board file for zoom boards

Same comment as above:
OMAP: DSS: Enable display on ZOOM2/3 & 3630SDP

TRM speaks of pre-multiplied alpha, as does your patch title. But in the
code your variables are pre-alpha multiplied:
OMAP3630:DSS2:Enable Pre-Multiplied Alpha Support

For this one I have already sent comments, they have not been answered.
There were some problems with emails to linux-omap at that time, so I've
also attached the email. Also, this patch should go in before the board
file patches above, so put them into same patch set with this one before
the board file changes:
OMAP: DSS: Add NEC NL8048HL11-01B display panel

Also, many of the patch comments contained typos. Could you check them
also?

Tomi


--=-cuEV+7ZI2ieIO01rHj8R
Content-Disposition: inline
Content-Description: Attached message - Re: [PATCH V5] OMAP: DSS: Add NEC
 NL8048HL11-01B display panel
Content-Type: message/rfc822

From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
To: "ext Y, Kishore" <kishore.y@ti.com>
CC: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Date: Thu, 29 Apr 2010 13:28:18 +0200
Subject: Re: [PATCH V5] OMAP: DSS: Add NEC NL8048HL11-01B display panel
Thread-Topic: [PATCH V5] OMAP: DSS: Add NEC NL8048HL11-01B display panel
Message-ID: <1272540496.2488.13.camel@tubuntu.research.nokia.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E2B82@dbde02.ent.ti.com>
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E2B82@dbde02.ent.ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-evolution-format: text/plain
x-evolution-account: 1260877939.1953.26@tubuntu
x-evolution-transport: smtp://@smtp.nokia.com/;use_ssl=never
x-evolution-fcc: imap://valkeine@mail.nokia.com/Sent%20Items
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi,

On Sun, 2010-04-25 at 10:21 +0200, ext Y, Kishore wrote:
> From: Erik Gilling <konkers@android.com>
> 
> NEC WVGA LCD NL8048HL11-01B support has been added.

Few comments inline.

> 
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Kishore Y <kishore.y@ti.com>
> Reviewed-by: Gadiyar, Anand <gadiyar@ti.com>
> ---
>  drivers/video/omap2/displays/Kconfig               |    6 +
>  drivers/video/omap2/displays/Makefile              |    1 +
>  .../omap2/displays/panel-nec-nl8048hl11-01b.c      |  287 ++++++++++++++++++++
>  3 files changed, 294 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
> 
> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
> index dfb57ee..5fb4dfe 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -37,4 +37,10 @@ config PANEL_TPO_TD043MTEA1
>          help
>            LCD Panel used in OMAP3 Pandora
>  
> +config PANEL_NEC_NL8048HL11_01B
> +        tristate "NEC NL8048HL11-01B Panel support"
> +        depends on OMAP2_DSS
> +        help
> +          LCD Panel from NEC.
> +
>  endmenu
> diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
> index e2bb321..03eb9c2 100644
> --- a/drivers/video/omap2/displays/Makefile
> +++ b/drivers/video/omap2/displays/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) += panel-sharp-lq043t1dg01.o
>  obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
>  obj-$(CONFIG_PANEL_TOPPOLY_TDO35S) += panel-toppoly-tdo35s.o
>  obj-$(CONFIG_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
> +obj-$(CONFIG_PANEL_NEC_NL8048HL11_01B) += panel-nec-nl8048hl11-01b.o
> diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
> new file mode 100644
> index 0000000..ae47ade
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
> @@ -0,0 +1,287 @@
> +/*
> + * NEC panel support
> + *
> + * Copyright (C) 2010 Texas Instruments Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/spi/spi.h>
> +
> +#include <plat/display.h>
> +
> +#define LCD_XRES		800
> +#define LCD_YRES		480
> +/* NEC PIX Clock Ratings
> + * MIN:21.8MHz TYP:23.8MHz MAX:25.7MHz
> + */
> +#define LCD_PIXEL_CLOCK		23800
> +
> +/* NEC NL8048HL11-01B  Manual
> + * defines HFB, HSW, HBP, VFP, VSW, VBP as shown below
> + */
> +
> +static struct omap_video_timings nec_8048_panel_timings = {
> +	/* 800 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
> +	.x_res          = LCD_XRES,
> +	.y_res          = LCD_YRES,
> +	.pixel_clock    = LCD_PIXEL_CLOCK,
> +	.hfp            = 6,
> +	.hsw            = 1,
> +	.hbp            = 4,
> +	.vfp            = 3,
> +	.vsw            = 1,
> +	.vbp            = 4,
> +};
> +
> +static int nec_8048_panel_probe(struct omap_dss_device *dssdev)
> +{
> +	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +				OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_RF |
> +				OMAP_DSS_LCD_ONOFF;
> +	dssdev->panel.timings = nec_8048_panel_timings;
> +
> +	return 0;
> +}
> +
> +static void nec_8048_panel_remove(struct omap_dss_device *dssdev)
> +{
> +}
> +
> +static int nec_8048_panel_enable(struct omap_dss_device *dssdev)
> +{
> +	int r = 0;
> +
> +	/* Delay recommended by panel DATASHEET */
> +	mdelay(4);
> +	if (dssdev->platform_enable)
> +		r = dssdev->platform_enable(dssdev);
> +	omapdss_dpi_display_enable(dssdev);
> +
> +	return r;
> +}

Why is there a delay at the beginning of enable? It should be sleep, I
think. And generally sleep should be between two actions. Here the other
action is platform_enable or DPI enable, but what is the action before
enable?

> +
> +static void nec_8048_panel_disable(struct omap_dss_device *dssdev)
> +{
> +	omapdss_dpi_display_disable(dssdev);
> +	if (dssdev->platform_disable)
> +		dssdev->platform_disable(dssdev);
> +	/* Delay recommended by panel DATASHEET */
> +	mdelay(4);
> +}

Same comments here.

> +
> +static int nec_8048_panel_suspend(struct omap_dss_device *dssdev)
> +{
> +	nec_8048_panel_disable(dssdev);
> +	return 0;
> +}
> +
> +static int nec_8048_panel_resume(struct omap_dss_device *dssdev)
> +{
> +	return nec_8048_panel_enable(dssdev);
> +}
> +
> +static int nec_8048_recommended_bpp(struct omap_dss_device *dssdev)
> +{
> +	return 16;
> +}
> +
> +static struct omap_dss_driver nec_8048_driver = {
> +	.probe          = nec_8048_panel_probe,
> +	.remove         = nec_8048_panel_remove,
> +	.enable         = nec_8048_panel_enable,
> +	.disable        = nec_8048_panel_disable,
> +	.suspend        = nec_8048_panel_suspend,
> +	.resume         = nec_8048_panel_resume,
> +	.get_recommended_bpp = nec_8048_recommended_bpp,
> +	.driver		= {
> +		.name	= "NEC_8048_panel",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int
> +spi_send(struct spi_device *spi, unsigned char reg_addr, unsigned char reg_data)
> +{
> +	int ret = 0;
> +	unsigned int cmd = 0, data = 0;
> +
> +	cmd = 0x0000 | reg_addr; /* register address write */
> +	data = 0x0100 | reg_data; /* register data write */
> +	data = (cmd << 16) | data;
> +	ret = spi_write(spi, (unsigned char *)&data, 4);
> +	if (ret) {
> +		printk(KERN_ERR "error in spi_write %x\n", data);
> +		return ret;
> +	}
> +
> +	/* Delay, part of init seqence recommended by panel DATASHEET */
> +	udelay(10);
> +	return 0;
> +}

And here.

> +
> +static int init_nec_8048_wvga_lcd(struct spi_device *spi)
> +{
> +	/* Initialization Sequence */
> +	/* spi_send(spi, REG, VAL) */
> +	spi_send(spi, 3, 0x01);
> +	spi_send(spi, 0, 0x00);
> +	spi_send(spi, 1, 0x01);    /* R1 = 0x01 (normal), 0x03 (reversed) */
> +	spi_send(spi, 4, 0x00);
> +	spi_send(spi, 5, 0x14);
> +	spi_send(spi, 6, 0x24);
> +	spi_send(spi, 16, 0xD7);
> +	spi_send(spi, 17, 0x00);
> +	spi_send(spi, 18, 0x00);
> +	spi_send(spi, 19, 0x55);
> +	spi_send(spi, 20, 0x01);
> +	spi_send(spi, 21, 0x70);
> +	spi_send(spi, 22, 0x1E);
> +	spi_send(spi, 23, 0x25);
> +	spi_send(spi, 24, 0x25);
> +	spi_send(spi, 25, 0x02);
> +	spi_send(spi, 26, 0x02);
> +	spi_send(spi, 27, 0xA0);
> +	spi_send(spi, 32, 0x2F);
> +	spi_send(spi, 33, 0x0F);
> +	spi_send(spi, 34, 0x0F);
> +	spi_send(spi, 35, 0x0F);
> +	spi_send(spi, 36, 0x0F);
> +	spi_send(spi, 37, 0x0F);
> +	spi_send(spi, 38, 0x0F);
> +	spi_send(spi, 39, 0x00);
> +	spi_send(spi, 40, 0x02);
> +	spi_send(spi, 41, 0x02);
> +	spi_send(spi, 42, 0x02);
> +	spi_send(spi, 43, 0x0F);
> +	spi_send(spi, 44, 0x0F);
> +	spi_send(spi, 45, 0x0F);
> +	spi_send(spi, 46, 0x0F);
> +	spi_send(spi, 47, 0x0F);
> +	spi_send(spi, 48, 0x0F);
> +	spi_send(spi, 49, 0x0F);
> +	spi_send(spi, 50, 0x00);
> +	spi_send(spi, 51, 0x02);
> +	spi_send(spi, 52, 0x02);
> +	spi_send(spi, 53, 0x02);
> +	spi_send(spi, 80, 0x0C);
> +	spi_send(spi, 83, 0x42);
> +	spi_send(spi, 84, 0x42);
> +	spi_send(spi, 85, 0x41);
> +	spi_send(spi, 86, 0x14);
> +	spi_send(spi, 89, 0x88);
> +	spi_send(spi, 90, 0x01);
> +	spi_send(spi, 91, 0x00);
> +	spi_send(spi, 92, 0x02);
> +	spi_send(spi, 93, 0x0C);
> +	spi_send(spi, 94, 0x1C);
> +	spi_send(spi, 95, 0x27);
> +	spi_send(spi, 98, 0x49);
> +	spi_send(spi, 99, 0x27);
> +	spi_send(spi, 102, 0x76);
> +	spi_send(spi, 103, 0x27);
> +	spi_send(spi, 112, 0x01);
> +	spi_send(spi, 113, 0x0E);
> +	spi_send(spi, 114, 0x02);
> +	spi_send(spi, 115, 0x0C);
> +	spi_send(spi, 118, 0x0C);
> +	spi_send(spi, 121, 0x30); /* R121 = 0x30 (normal), 0x10 (reversed) */
> +	spi_send(spi, 130, 0x00);
> +	spi_send(spi, 131, 0x00);
> +	spi_send(spi, 132, 0xFC);
> +	spi_send(spi, 134, 0x00);
> +	spi_send(spi, 136, 0x00);
> +	spi_send(spi, 138, 0x00);
> +	spi_send(spi, 139, 0x00);
> +	spi_send(spi, 140, 0x00);
> +	spi_send(spi, 141, 0xFC);
> +	spi_send(spi, 143, 0x00);
> +	spi_send(spi, 145, 0x00);
> +	spi_send(spi, 147, 0x00);
> +	spi_send(spi, 148, 0x00);
> +	spi_send(spi, 149, 0x00);
> +	spi_send(spi, 150, 0xFC);
> +	spi_send(spi, 152, 0x00);
> +	spi_send(spi, 154, 0x00);
> +	spi_send(spi, 156, 0x00);
> +	spi_send(spi, 157, 0x00);
> +	udelay(20);
> +	spi_send(spi, 2, 0x00);
> +
> +	return 0;
> +}
> +
> +static int nec_8048_spi_probe(struct spi_device *spi)
> +{
> +	spi->mode = SPI_MODE_0;
> +	spi->bits_per_word = 32;
> +	spi_setup(spi);
> +
> +	init_nec_8048_wvga_lcd(spi);
> +
> +	return omap_dss_register_driver(&nec_8048_driver);
> +}
> +
> +static int nec_8048_spi_remove(struct spi_device *spi)
> +{
> +	omap_dss_unregister_driver(&nec_8048_driver);
> +
> +	return 0;
> +}
> +
> +static int nec_8048_spi_suspend(struct spi_device *spi, pm_message_t mesg)
> +{
> +	spi_send(spi, 2, 0x01);
> +	mdelay(40);
> +
> +	return 0;
> +}

And here.

> +
> +static int nec_8048_spi_resume(struct spi_device *spi)
> +{
> +	/* reinitialize the panel */
> +	spi_setup(spi);
> +	spi_send(spi, 2, 0x00);
> +	init_nec_8048_wvga_lcd(spi);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver nec_8048_spi_driver = {
> +	.probe           = nec_8048_spi_probe,
> +	.remove	= __devexit_p(nec_8048_spi_remove),
> +	.suspend         = nec_8048_spi_suspend,
> +	.resume          = nec_8048_spi_resume,
> +	.driver         = {
> +		.name   = "nec_8048_spi",
> +		.bus    = &spi_bus_type,
> +		.owner  = THIS_MODULE,
> +	},
> +};
> +
> +static int __init nec_8048_lcd_init(void)
> +{
> +	return spi_register_driver(&nec_8048_spi_driver);
> +}
> +
> +static void __exit nec_8048_lcd_exit(void)
> +{
> +	return spi_unregister_driver(&nec_8048_spi_driver);
> +}
> +
> +module_init(nec_8048_lcd_init);
> +module_exit(nec_8048_lcd_exit);
> +MODULE_LICENSE("GPL");
> +


--=-cuEV+7ZI2ieIO01rHj8R--

