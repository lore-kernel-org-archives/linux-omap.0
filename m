From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] OMAP2+ devices add mac address allocation register api
Date: Fri, 29 Jun 2012 02:40:55 -0700
Message-ID: <20120629094055.GB4202@atomide.com>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
 <20120629055516.11091.82899.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120629055516.11091.82899.stgit@build.warmcat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Green <andy.green@linaro.org>
Cc: nicolas.pitre@linaro.org, s-jan@ti.com, arnd@arndb.de, patches@linaro.org, rostedt@goodmis.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Andy Green <andy.green@linaro.org> [120628 22:59]:
> From: Andy Green <andy@warmcat.com>
> 
> This exposes a new API in devices.c that lets a board register
> a list of device paths representing network devices that have
> no arrangements for their MAC address to be set by the board.
> 
> It watches network device registrations via a notifier and
> gives the devices requiring them a synthetic - but constant for
> a given board - MAC address immediately.
...

> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -39,6 +42,9 @@
>  #define L3_MODULES_MAX_LEN 12
>  #define L3_MODULES 3
>  
> +static const char * const *mac_device_fixup_paths;
> +int count_mac_device_fixup_paths;

This too should be static it seems to me. Or just make the
paths array NULL terminated to get rid of the count.

>  static int __init omap3_l3_init(void)
>  {
>  	struct omap_hwmod *oh;
> @@ -627,6 +633,89 @@ static void omap_init_vout(void)
>  static inline void omap_init_vout(void) {}
>  #endif
>  
> +static int omap_device_path_need_mac(struct device *dev)
> +{
> +	const char **try = (const char **)mac_device_fixup_paths;

This cast you should be able to remove by setting the types right
to start with?

> +	const char *path;
> +	int count = count_mac_device_fixup_paths;
> +	const char *p;
> +	int len;
> +	struct device *devn;
> +
> +	while (count--) {
> +
> +		p = *try + strlen(*try);
> +		devn = dev;
> +
> +		while (devn) {
> +
> +			path = dev_name(devn);
> +			len = strlen(path);
> +
> +			if ((p - *try) < len) {
> +				devn = NULL;
> +				continue;
> +			}
> +
> +			p -= len;
> +
> +			if (strncmp(path, p, len)) {
> +				devn = NULL;
> +				continue;
> +			}
> +
> +			devn = devn->parent;
> +			if (p == *try)
> +				return count;
> +
> +			if (devn != NULL && (p - *try) < 2)
> +				devn = NULL;
> +
> +			p--;
> +			if (devn != NULL && *p != '/')
> +				devn = NULL;
> +		}
> +
> +		try++;
> +	}
> +
> +	return -ENOENT;
> +}

I don't quite like having this device parsing code here. This should
probably be a generic helper function somewhere under drivers. I would
assume other SoCs could use it too?

> +static int omap_panda_netdev_event(struct notifier_block *this,
> +						unsigned long event, void *ptr)
> +{
> +	struct net_device *dev = ptr;
> +	struct sockaddr sa;
> +	int n;
> +
> +	if (event != NETDEV_REGISTER)
> +		return NOTIFY_DONE;
> +
> +	n = omap_device_path_need_mac(dev->dev.parent);
> +	if (n < 0)
> +		return NOTIFY_DONE;
> +
> +	sa.sa_family = dev->type;
> +	omap2_die_id_to_ethernet_mac(sa.sa_data, n);
> +	dev->netdev_ops->ndo_set_mac_address(dev, &sa);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block omap_panda_netdev_notifier = {
> +	.notifier_call = omap_panda_netdev_event,
> +	.priority = 1,
> +};

This is a bit similar to platform data callback functions that we are
trying to get rid of. And as the question "how do we replace platform
data callback functions" is still open for things like this, few
questions come to mind that should be discussed:

1. How is this a better solution to passing the generated mac address in
   platform data to the driver?

2. Is this really how we want to pass the board generated mac addresses
   and other dynamically generated data to the drivers that are device
   tree based?

3. What about mac address in board-generic.c when booting panda with
   device tree?

Also, what happens if the user has set the mac address and you replugs the
cable or device? Do we now overwrite it? Might be worth checking that this
follows the standard behaviour..

Regards,

Tony
