From: Archit Taneja <a0393947@ti.com>
Subject: Re: [DSS2] kernel freeze with panel driver
Date: Tue, 31 Jan 2012 16:50:35 +0530
Message-ID: <4F27CE83.3070608@ti.com>
References: <1328007381.86237.YahooMailNeo@web29017.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55196 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635Ab2AaLUn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 06:20:43 -0500
In-Reply-To: <1328007381.86237.YahooMailNeo@web29017.mail.ird.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Patrick <kpa_info@yahoo.fr>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tuesday 31 January 2012 04:26 PM, Patrick wrote:
> Dear mailing-list,
>
>
> I am working with a vanilla 3.0.17 kernel with some patch for my Omap4430 based board.
>
> I am using the driver video/omap2/panel-lgphilips-lb025q02.c with a very similar screen.
> I have added on my board init file the init code for both the SPI and the panel, like below.
>
> static struct omap_dss_device sb_dpi_device = {
>          .type               = OMAP_DISPLAY_TYPE_DPI,
>      .name                   = "lcd35",
>      .driver_name            = "lgphilips_lb035q02_panel",
>      .phy.dpi.data_lines     = 24,
>      .platform_enable        = sb_panel_enable_lcd,
>      .platform_disable       = sb_panel_disable_lcd,
> };
>

You have to add a channel field in this, like:

	.channel = OMAP_DSS_CHANNEL_LCD2,

On OMAP4, the DPI interface is connected to LCD2 interface and not LCD 
interface. That's why you get the error 'display 'lcd35' does not 
support manager 'lcd''

Can you try with this change and see what happens?

Archit

>
> ...
>
>
> static struct spi_board_info sb_spi_board_info[] __initdata = {
>          {
>                  .modalias               = "lgphilips_lb035q02_panel-spi",
>                  .bus_num                = 1,
>                  .chip_select            = 0,
>                  .max_speed_hz           = 500000,
>                  .mode                   = SPI_MODE_3,
>          },
> };
>
> The init of the SPI is done before the one of the panel.
>
>
> When my kernel boot he freeze (without error message) at the moment where it should do the :
> "Console: switching to colour frame buffer device..."
> But in my case it freeze somewhere just before this print.
>
> Earlier in the boot process I have the following error message:
>      OMAP DSS rev 4.0
>      omapdss MANAGER error: display 'lcd35' does not support manager 'lcd'
>
> Lcd35 is the name of the screen declared in the board config file.
> I use the followings bootargs: omapdss.def_disp=lcd35 omapdss.debug=y vram=10M
>
>
> I have tried with the video/omap2/panel-generic-display.c driver with the correct timming.
>
> The kernel boot but the screen doesn't work correctly (Only one vertical line is colored).
>
> I have tried with panel-lgphilips-lb025q02.c but with initialising only the SPI from the board config file (without calling the display init). The kernel boot but of course the screen doesn't work at all. So it seems that the problem is not from the SPI side.
>
>
> Do you have any idea why I have this problems ?
>
> Thanks in advance for your help.
>
> Patrick
>
>
>
>
>
>
>
> static struct spi_board_info sb_spi_board_info[] __initdata = {
>          {
>                  .modalias               = "lgphilips_lb035q02_panel-spi",
>                  .bus_num                = 1,
>                  .chip_select            = 0,
>                  .max_speed_hz           = 500000,
>                  .mode                   = SPI_MODE_3,
>          },
> };
>
> I init the SPI before the panel as in your overo board file.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

