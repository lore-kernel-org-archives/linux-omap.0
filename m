From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/16] ARM: omap: move platform_data definitions
Date: Tue, 11 Sep 2012 19:36:30 +0530
Message-ID: <CAMQu2gwLoccyjGwjjgndiW2aR--_S=UhCCTdcav6LicvYWe5SQ@mail.gmail.com>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de> <1347368559-31329-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347368559-31329-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ohad Ben-Cohen <ohad@wizery.com>, Grant Likely <grant.likely@secretlab.ca>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@t>
List-Id: linux-omap@vger.kernel.org

Arnd,

On Tue, Sep 11, 2012 at 6:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
>
> This moves such data out of the omap include directories
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[...]

>  81 files changed, 87 insertions(+), 87 deletions(-)
>  rename arch/arm/plat-omap/include/plat/mcbsp.h => include/linux/platform_data/dsp-mcbsp.h (100%)
>  rename arch/arm/plat-omap/include/plat/dsp.h => include/linux/platform_data/dsp-omap.h (100%)
>  rename arch/arm/plat-omap/include/plat/keypad.h => include/linux/platform_data/keypad-omap.h (100%)
>  rename arch/arm/plat-omap/include/plat/lcd_mipid.h => include/linux/platform_data/lcd-mipid.h (100%)
>  rename arch/arm/plat-omap/include/plat/nand.h => include/linux/platform_data/mtd-nand-omap2.h (100%)
>  rename arch/arm/plat-omap/include/plat/onenand.h => include/linux/platform_data/mtd-onenand-omap2.h (100%)
>  rename arch/arm/plat-omap/include/plat/remoteproc.h => include/linux/platform_data/remoteproc-omap.h (100%)
>  rename arch/arm/plat-omap/include/plat/voltage.h => include/linux/platform_data/smartreflex-omap.h (100%)
>  rename arch/arm/plat-omap/include/plat/mcspi.h => include/linux/platform_data/spi-omap2-mcspi.h (100%)
>
Just curious to know how you came with some of the above header names ?

plat/mcbsp ---> dsp-mcbsp.h
There is no connection of DSP with McBSP. "omap-mcbsp.h" would been a
better name.

plat/nand.h --> /mtd-nand-omap2.h
plat/onenand.h --> /mtd-onenand-omap2.h
May be "omap-nand.h" and "omap-onenand.h"

plat/mcspi.h-->spi-omap2-mcspi.h
May be "omap-spi.h"

Regards,
Santosh
