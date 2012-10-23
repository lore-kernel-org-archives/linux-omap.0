From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial
 stuff)
Date: Tue, 23 Oct 2012 09:37:49 +0200
Message-ID: <5086494D.4080205@compulab.co.il>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk> <20121012162452.GD30339@atomide.com> <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com> <20121016181038.GC15569@atomide.com> <20121016182642.GF15569@atomide.com> <CAK=WgbaQ-0V2htnmyCAzBco-sZVWN3WR2mhABGZNaYU6uM1wgg@mail.gmail.com> <507EA7DB.3070207@compulab.co.il> <CAK=Wgba_-k0kCHah6t6L4=qt838j30ZRVRbgAdJ1yzHDyA8frw@mail.gmail.com> <20121019170759.GK4730@atomide.com> <CAK=WgbbPmuOgssRRSinsV3rXg7TUa9fpOP-Zg+VatZgqgVYixw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:34627 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756707Ab2JWHh5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Oct 2012 03:37:57 -0400
In-Reply-To: <CAK=WgbbPmuOgssRRSinsV3rXg7TUa9fpOP-Zg+VatZgqgVYixw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>

On 10/21/12 16:54, Ohad Ben-Cohen wrote:
> On Fri, Oct 19, 2012 at 7:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> ...
>> We could optimize away a minimal amount of code for many configurations
>> with the ifdef? :)
> 
> Sure, here goes (compile tested only):
> 
>>From 6b82365da2c04986e647d06c285197efece7cb34 Mon Sep 17 00:00:00 2001
> From: Ohad Ben-Cohen <ohad@wizery.com>
> Date: Sun, 14 Oct 2012 20:16:01 +0200
> Subject: [PATCH] ARM: OMAP: don't print any error when wl12xx isn't
>  configured
> 
> Stop intimidating users with scary wlan error messages in case wl12xx
> support wasn't even built.
> 
> In addition, when wl12xx_set_platform_data() fails, don't bother
> registering wl12xx's fixed regulator device (on the relevant
> boards).
> 
> While we're at it, extract the wlan init code to a dedicated function to
> make (the relevant boards') init code look a bit nicer.
> 
> Compile tested only.
> 
> Reported-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Apart, from the minor comment below,
Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
>  arch/arm/mach-davinci/board-da850-evm.c      |  8 ++-----
>  arch/arm/mach-omap2/board-4430sdp.c          |  7 +++---
>  arch/arm/mach-omap2/board-omap3evm.c         |  6 ++---
>  arch/arm/mach-omap2/board-omap3pandora.c     |  9 +++-----
>  arch/arm/mach-omap2/board-omap4panda.c       | 20 ++++++++++++-----
>  arch/arm/mach-omap2/board-zoom-peripherals.c | 15 ++++++++-----
>  arch/arm/mach-omap2/common-board-devices.c   | 33 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/common-board-devices.h   |  2 ++
>  8 files changed, 71 insertions(+), 29 deletions(-)

[...]

> diff --git a/arch/arm/mach-omap2/common-board-devices.c
> b/arch/arm/mach-omap2/common-board-devices.c
> index 48daac2..02351e9 100644
> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -23,6 +23,7 @@
>  #include <linux/gpio.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
> +#include <linux/wl12xx.h>
> 
>  #include <linux/platform_data/spi-omap2-mcspi.h>
>  #include <linux/platform_data/mtd-nand-omap2.h>
> @@ -141,3 +142,35 @@ void __init omap_nand_flash_init(int options,
> struct mtd_partition *parts,
>  {
>  }
>  #endif
> +
> +#ifdef CONFIG_WL12XX_PLATFORM_DATA
> +int __init wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int gpio)
> +{
> +	int ret;
> +
> +	wlan_data->irq = gpio_to_irq(gpio);
> +	if (wlan_data->irq < 0) {
> +		ret = wlan_data->irq;
> +		pr_err("wl12xx: gpio_to_irq(%d) failed: %d\n", gpio, ret);
> +		return ret;
> +	}
> +
> +	ret = wl12xx_set_platform_data(wlan_data);
> +	/* bail out silently in case wl12xx isn't configured */
> +	if (ret == -ENOSYS)
> +		return ret;

Since we have the function ifdef'ed, I don't think we need
the ENOSYS check, do we?

> +
> +	/* bail out verbosely on any other error */
> +	if (ret) {
> +		pr_err("error setting wl12xx data: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +#else /* !CONFIG_WL12XX_PLATFORM_DATA */
> +int __init wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int gpio)
> +{
> +	return 0;
> +}
> +#endif

[...]


-- 
Regards,
Igor.
