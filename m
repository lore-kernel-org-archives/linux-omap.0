From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/3] mfd: tps65010: move header file out of I2C realm
Date: Mon, 22 May 2017 09:34:35 +0200
Message-ID: <CAJKOXPdsvHfz4m=UMzjakJ86iGotHFmGaPiKvhQzCaTswNAM3w@mail.gmail.com>
References: <20170521220212.1404-1-wsa@the-dreams.de> <20170521220212.1404-3-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170521220212.1404-3-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 22, 2017 at 12:02 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  arch/arm/mach-omap1/board-h2-mmc.c      | 2 +-
>  arch/arm/mach-omap1/board-h2.c          | 2 +-
>  arch/arm/mach-omap1/board-h3-mmc.c      | 2 +-
>  arch/arm/mach-omap1/board-h3.c          | 2 +-
>  arch/arm/mach-omap1/board-osk.c         | 2 +-
>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
>  arch/arm/mach-s3c24xx/mach-osiris.c     | 2 +-

For s3c24xx:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

>  drivers/mfd/tps65010.c                  | 2 +-
>  drivers/usb/host/ohci-omap.c            | 2 +-
>  drivers/usb/phy/phy-isp1301-omap.c      | 2 +-
>  drivers/video/fbdev/omap/lcd_h3.c       | 2 +-
>  include/linux/{i2c => mfd}/tps65010.h   | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>  rename include/linux/{i2c => mfd}/tps65010.h (99%)
