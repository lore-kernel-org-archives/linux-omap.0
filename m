From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: RX-51: change probe order of touchscreen
 and panel SPI devices
Date: Wed, 8 May 2013 15:23:21 -0700
Message-ID: <20130508222320.GL32546@atomide.com>
References: <1367427597-30060-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1367427597-30060-1-git-send-email-aaro.koskinen@iki.fi>
Sender: stable-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Joni Lapilainen <joni.lapilainen@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Felipe Balbi <balbi@ti.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130501 10:06]:
> Commit 9fdca9df (spi: omap2-mcspi: convert to module_platform_driver)
> broke the SPI display/panel driver probe on RX-51/N900. The exact cause is
> not fully understood, but it seems to be related to the probe order. SPI
> communication to the panel driver (spi1.2) fails unless the touchscreen
> (spi1.0) has been probed/initialized before. When the omap2-mcspi driver
> was converted to a platform driver, it resulted in that the devices are
> probed immediately after the board registers them in the order they are
> listed in the board file.
> 
> Fix the issue by moving the touchscreen before the panel in the SPI
> device list.
> 
> The patch fixes the following failure:
> 
> [    1.260955] acx565akm spi1.2: invalid display ID
> [    1.265899] panel-acx565akm display0: acx_panel_probe panel detect error
> [    1.273071] omapdss CORE error: driver probe failed: -19

Thanks for updating the description, applying into omap-for-v3.10/fixes.

Regards,

Tony
