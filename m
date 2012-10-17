From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial
 stuff)
Date: Wed, 17 Oct 2012 14:43:07 +0200
Message-ID: <507EA7DB.3070207@compulab.co.il>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk> <20121012162452.GD30339@atomide.com> <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com> <20121016181038.GC15569@atomide.com> <20121016182642.GF15569@atomide.com> <CAK=WgbaQ-0V2htnmyCAzBco-sZVWN3WR2mhABGZNaYU6uM1wgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:46086 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755981Ab2JQMnT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 08:43:19 -0400
In-Reply-To: <CAK=WgbaQ-0V2htnmyCAzBco-sZVWN3WR2mhABGZNaYU6uM1wgg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>

Hi Ohad,

On 10/17/12 11:10, Ohad Ben-Cohen wrote:
> On Tue, Oct 16, 2012 at 8:26 PM, Tony Lindgren <tony@atomide.com> wrote:
>> Hmm looking at it repeats the same code over again. Can you
>> rather add some wl12xx_board_init() helper function to mach-omap2/devices.c
>> to do it?
> 
> Nice, see below. Note that I can only compile test this now, which may
> be ok because it's pretty trivial. But do let me know if you want me
> to get it tested.

The patch looks good, though minor comment below.

> 
>>From b940fb88a97494ad3a0a093279a5f176c0b29e44 Mon Sep 17 00:00:00 2001
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
> ---
>  arch/arm/mach-davinci/board-da850-evm.c      |  8 ++------
>  arch/arm/mach-omap2/board-4430sdp.c          |  7 ++++---
>  arch/arm/mach-omap2/board-omap3evm.c         |  6 +++---
>  arch/arm/mach-omap2/board-omap3pandora.c     |  9 +++------
>  arch/arm/mach-omap2/board-omap4panda.c       | 20 ++++++++++++++------
>  arch/arm/mach-omap2/board-zoom-peripherals.c | 15 ++++++++++-----
>  arch/arm/mach-omap2/common-board-devices.h   |  2 ++
>  arch/arm/mach-omap2/devices.c                | 26 ++++++++++++++++++++++++++
>  8 files changed, 64 insertions(+), 29 deletions(-)

[...]

> diff --git a/arch/arm/mach-omap2/common-board-devices.h
> b/arch/arm/mach-omap2/common-board-devices.h
> index a0b4a428..52e91424 100644
> --- a/arch/arm/mach-omap2/common-board-devices.h
> +++ b/arch/arm/mach-omap2/common-board-devices.h
> @@ -7,9 +7,11 @@
> 
>  struct mtd_partition;
>  struct ads7846_platform_data;
> +struct wl12xx_platform_data;
> 
>  void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
>  		       struct ads7846_platform_data *board_pdata);
>  void omap_nand_flash_init(int opts, struct mtd_partition *parts, int n_parts);
> +int __init wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int gpio);

You are adding declarations inside the common-board-devices.h,
but the implementation inside the devices.c.
I can see that devices.c has only on-soc devices in it.
So, I would expect to have the wl12xx_board_init() function implementation
inside the common-board-devices.c file.

Another minor nit: I don't think you need to mark the declaration as __init,
only the implementation, or is it for documenting it so?

> 
>  #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index c8c2117..9e86bb9 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/pinctrl/machine.h>
>  #include <linux/platform_data/omap4-keypad.h>
> +#include <linux/wl12xx.h>
> 
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
> @@ -38,6 +39,31 @@
>  #define L3_MODULES_MAX_LEN 12
>  #define L3_MODULES 3
> 
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

Instead of the above, wouldn't it be better to have:
#if defined(CONFIG_WL12XX_PLATFORM_DATA)
int __init wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int irq_gpio)
{
...
}
#else
inline int wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int irq_gpio)
{
	return 0;
}
#endif

> +
> +	/* bail out verbosely on any other error */
> +	if (ret) {
> +		pr_err("error setting wl12xx data: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int __init omap3_l3_init(void)
>  {
>  	struct omap_hwmod *oh;

-- 
Regards,
Igor.
