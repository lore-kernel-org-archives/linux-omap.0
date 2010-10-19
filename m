From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] omap: add hwspinlock device
Date: Tue, 19 Oct 2010 10:03:01 -0700
Message-ID: <87r5fmxghm.fsf@deeprootsystems.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-4-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1287387875-14168-4-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Mon, 18 Oct 2010 09:44:35 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Simon Que <sque@ti.com>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Ohad Ben-Cohen <ohad@wizery.com> writes:

> From: Simon Que <sque@ti.com>
>
> Build and register an hwspinlock platform device.
>
> Although only OMAP4 supports the hardware spinlock module (for now),
> it is still safe to run this initcall on all omaps, because hwmod lookup
> will simply fail on hwspinlock-less platforms.
>
> Signed-off-by: Simon Que <sque@ti.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile     |    1 +
>  arch/arm/mach-omap2/hwspinlock.c |   67 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/hwspinlock.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 7352412..e55d1c5 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -190,3 +190,4 @@ obj-y					+= $(smc91x-m) $(smc91x-y)
>  
>  smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
>  obj-y					+= $(smsc911x-m) $(smsc911x-y)
> +obj-$(CONFIG_ARCH_OMAP4)		+= hwspinlock.o
> diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
> new file mode 100644
> index 0000000..641a6d4
> --- /dev/null
> +++ b/arch/arm/mach-omap2/hwspinlock.c
> @@ -0,0 +1,67 @@
> +/*
> + * OMAP hardware spinlock device initialization
> + *
> + * Copyright (C) 2010 Texas Instruments. All rights reserved.
> + *
> + * Contact: Simon Que <sque@ti.com>
> + *          Hari Kanigeri <h-kanigeri2@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> +
> +struct omap_device_pm_latency omap_spinlock_latency[] = {
> +	{
> +		.deactivate_func = omap_device_idle_hwmods,
> +		.activate_func   = omap_device_enable_hwmods,
> +		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +	}
> +};
> +
> +int __init hwspinlocks_init(void)
> +{
> +	int retval = 0;
> +	struct omap_hwmod *oh;
> +	struct omap_device *od;
> +	const char *oh_name = "spinlock";
> +	const char *dev_name = "omap_hwspinlock";
> +
> +	/*
> +	 * Hwmod lookup will fail in case our platform doesn't support the
> +	 * hardware spinlock module, so it is safe to run this initcall
> +	 * on all omaps
> +	 */
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (oh == NULL)
> +		return -EINVAL;
> +
> +	od = omap_device_build(dev_name, 0, oh, NULL, 0,
> +				omap_spinlock_latency,
> +				ARRAY_SIZE(omap_spinlock_latency), false);
> +	if (IS_ERR(od)) {
> +		pr_err("Can't build omap_device for %s:%s\n", dev_name,
> +								oh_name);
> +		retval = PTR_ERR(od);
> +	}
> +
> +	return retval;
> +}
> +postcore_initcall(hwspinlocks_init);

Any reason this needs to be a postcore_initcall?  Are there users of
hwspinlocks this early in boot?  Probaly subsys or even device_initcall
is more appropriate here.

I would've suspected that any users of hwspinlocks will be dependent on
drivers for the other cores (e.g. syslink) which would likely be
initialized much later.

Kevin
