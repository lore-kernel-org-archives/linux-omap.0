From: "Pihet-XID, Jean" <j-pihet@ti.com>
Subject: Re: [PATCH 13/16] ARM: omap: move platform_data definitions
Date: Wed, 12 Sep 2012 09:16:46 +0200
Message-ID: <CAN5iSWqnyA0VNDkaCb7bcZOhQxOxJ8xUy4RXWgt+xukSUmHnAA@mail.gmail.com>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
	<1347368390-31252-1-git-send-email-arnd@arndb.de>
	<1347368390-31252-13-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347368390-31252-13-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ohad Ben-Cohen <ohad@wizery.com>, Grant Likely <grant.likely@secretlab.ca>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, J Keerthy <j-keerthy@ti.com>, linux-omap@vger.kerne
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On Tue, Sep 11, 2012 at 2:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
>
> This moves such data out of the omap include directories
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

...

> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 0ac2caf..7abf1c0 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -16,7 +16,7 @@
>
>  #include <linux/err.h>
>
> -#include <plat/voltage.h>
> +#include <linux/platform_data/smartreflex-omap.h>
>
>  #include "vc.h"
>  #include "vp.h"
...
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/include/linux/platform_data/smartreflex-omap.h
> similarity index 100%
> rename from arch/arm/plat-omap/include/plat/voltage.h
> rename to include/linux/platform_data/smartreflex-omap.h
The filename should be voltage-omap.h. The header file is for a
voltage layer which is used by other layers, one of them is the
smartreflex driver code (in drivers/power/avs).
The header file for the smartreflex driver is in
include/linux/power/smartreflex.h.

> diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
> index 3101e62..e376f94 100644
> --- a/include/linux/power/smartreflex.h
> +++ b/include/linux/power/smartreflex.h
> @@ -23,7 +23,7 @@
>  #include <linux/types.h>
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
> -#include <plat/voltage.h>
> +#include <linux/platform_data/smartreflex-omap.h>
>
>  /*
>   * Different Smartreflex IPs version. The v1 is the 65nm version used in

Thanks for the clean-up!

Regards,
Jean
