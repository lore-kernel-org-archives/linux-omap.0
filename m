From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Get rid of section mismatch warnings
Date: Fri, 27 May 2011 13:54:15 +0300
Message-ID: <20110527105414.GE27962@atomide.com>
References: <1306414838-4330-1-git-send-email-silesh@ti.com>
 <4DDE4EEF.8070108@ti.com>
 <20110526133732.GD11352@atomide.com>
 <20110526135533.GA25841@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:60535 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750972Ab1E0KyX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 06:54:23 -0400
Content-Disposition: inline
In-Reply-To: <20110526135533.GA25841@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Silesh C V <silesh@ti.com>, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110526 16:51]:
> On Thu, May 26, 2011 at 06:37:32AM -0700, Tony Lindgren wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110526 05:56]:
> > > On 5/26/2011 6:30 PM, Silesh C V wrote:
> > > >Get rid of the following and 8 other similar section mismatch
> > > >warnings
> > > >
> > > I send this [1] patch a month back. It's still not considered
> > > though even after reminder.
> > > 
> > > [1] https://patchwork.kernel.org/patch/684831/
> > 
> > Applying now into devel-fixes with additional fixes from Silesh.
> > Updated patch below.
> 
> I also have this from a while back.  There's also some nastyness in
> twl4030-power.c which requires basically s/__init/__devinit/ to almost
> the entire file.

OK thanks. Kevin, can you queue this fix? Assuming the move of omap
gpio to drivers/gpio happens this merge window, this needs to be
updated for the path.

Regards,

Tony
 
> 8<--------
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Fix various section mismatch warnings:
> 
> WARNING: arch/arm/plat-omap/built-in.o(.devinit.text+0x46c): Section mismatch in reference from the function omap_gpio_probe() to the function .init.text:omap_gpio_chip_init()
> The function __devinit omap_gpio_probe() references
> a function __init omap_gpio_chip_init().
> If omap_gpio_chip_init is only used by omap_gpio_probe then
> annotate omap_gpio_chip_init with a matching annotation.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x423c): Section mismatch in reference from the function pm_dbg_regset_init() to the function .init.text:pm_dbg_init()
> The function pm_dbg_regset_init() references
> the function __init pm_dbg_init().
> This is often because pm_dbg_regset_init lacks a __init
> annotation or the annotation of pm_dbg_init is wrong.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --
>  arch/arm/mach-omap2/pm-debug.c |    4 ++--
>  arch/arm/plat-omap/gpio.c      |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 971d186..3800ee0 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -1629,7 +1629,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
>  	}
>  }
>  
> -static void __init omap_gpio_chip_init(struct gpio_bank *bank)
> +static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
>  {
>  	int j;
>  	static int gpio;
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 125f565..169e930 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -189,7 +189,7 @@ static struct dentry *pm_dbg_dir;
>  
>  static int pm_dbg_init_done;
>  
> -static int __init pm_dbg_init(void);
> +static int pm_dbg_init(void);
>  
>  enum {
>  	DEBUG_FILE_COUNTERS = 0,
> @@ -595,7 +595,7 @@ static int option_set(void *data, u64 val)
>  
>  DEFINE_SIMPLE_ATTRIBUTE(pm_dbg_option_fops, option_get, option_set, "%llu\n");
>  
> -static int __init pm_dbg_init(void)
> +static int pm_dbg_init(void)
>  {
>  	int i;
>  	struct dentry *d;
> 
