From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2 2/4] net ethernet introduce mac_la_ap helper
Date: Mon, 2 Jul 2012 16:12:56 +0000
Message-ID: <201207021612.57028.arnd@arndb.de>
References: <20120702063545.26782.98908.stgit@build.warmcat.com> <20120702064054.26782.79849.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60814 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab2GBQNC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 12:13:02 -0400
In-Reply-To: <20120702064054.26782.79849.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: linux-omap@vger.kernel.org, s-jan@ti.com, patches@linaro.org, tony@atomide.com, rostedt@goodmis.org, linux-arm-kernel@lists.infradead.org

On Monday 02 July 2012, Andy Green wrote:
> From: Andy Green <andy@warmcat.com>
> 
> This introduces a small helper in net/ethernet, which registers a
> network notifier on init, and accepts registrations of expected asynchronously-
> probed network device paths (like, "usb1/1-1/1-1.1/1-1.1:1.0") and the MAC
> that is needed to be assigned to the device when it appears.
> 
> This allows platform code to enforce valid, consistent MAC addresses on to
> devices that have not been probed at boot-time, but due to being wired on the
> board are always present at the same interface.  It has been tested with USB
> and SDIO probed devices.
> 
> To make use of this safely you also need to make sure that any drivers that
> may compete for the bus ordinal you are using (eg, mUSB and ehci in Panda
> case) are loaded in a deterministic order.
> 
> At registration it makes a copy of the incoming data, so the data may be
> __initdata or otherwise transitory.  Registration can be called multiple times
> so registrations from Device Tree and platform may be mixed.
> 
> Since it needs to be called quite early in boot and there is no lifecycle for
> what it does, it could not be modular and is not a driver.
> 
> Via suggestions from Arnd Bergmann and Tony Lindgren.
> 
> Signed-off-by: Andy Green <andy.green@linaro.org>

Yes, looks good to me in principle. It needs to get sent to the linux-kernel
and netdev mailing lists for review though. A few small comments.

>  include/net/mac-la-ap.h  |   28 ++++++++
>  net/Kconfig              |   14 ++++
>  net/ethernet/Makefile    |    2 +
>  net/ethernet/mac-la-ap.c |  165 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 209 insertions(+)
>  create mode 100644 include/net/mac-la-ap.h
>  create mode 100644 net/ethernet/mac-la-ap.c
> diff --git a/include/net/mac-la-ap.h b/include/net/mac-la-ap.h
> new file mode 100644
> index 0000000..d5189b5
> --- /dev/null
> +++ b/include/net/mac-la-ap.h
> @@ -0,0 +1,28 @@
> +/*
> + * mac-la-ap.h:  Locally Administered MAC address for Async probed devices
> + */

I find the name a bit non-obvious, not sure if we can come up with the
perfect one.

How about mac-platform?

> +/**
> + * mac_la_ap_register_device_macs - add an array of device path to monitor
> + *                                  and MAC to apply when the network device
> + *                                  at the device path appears
> + * @macs: array of struct mac_la_ap terminated by entry with NULL device_path
> + */
> +int mac_la_ap_register_device_macs(const struct mac_la_ap *macs);
> +
> diff --git a/net/Kconfig b/net/Kconfig
> index 245831b..76ba70e 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -335,6 +335,20 @@ source "net/caif/Kconfig"
>  source "net/ceph/Kconfig"
>  source "net/nfc/Kconfig"
>  
> +config MAC_LA_AP
> +	bool "Locally Administered MAC for Aysnchronously Probed devices"
> +	---help---
> +	This helper allows platforms to mandate a locally-administered
> +	sythesized MAC address for network devices that are on asynchronously-
> +	probed buses like USB or SDIO.  This is necessary when the board has
> +	these network assets but no arrangements for storing or setting the
> +	MAC address of the network asset (nor any official MAC address
> +	reserved for the device).  In that case, seen in Panda and other
> +	boards, the platform can synthesize a constant locally-administered
> +	MAC address from SoC UID bits that has a good probability of differing
> +	between boards but will be constant on any give board.  This helper
> +	will take care of watching for the network devices to appear and
> +	force the MAC to the synthesized one when they do.
>  
>  endif   # if NET

This one needs to be either a silent option (only selected by the
platforms that want it) or the header file has to provide a
static-inline fallback that does nothing, so we don't get
a build failure on platforms that need it if the option gets
disabled.

I'd prefer making it a silent option because then we don't bloat
the kernel if someone accidentally enables it on a platform that
does not use it.

> +static struct mac_la_ap mac_la_ap_list;

The normal way to do this is to have just a list head that the
entries get added to:

static LIST_HEAD(mac_la_ap_list);

That also takes care of the initialization.

> +DEFINE_MUTEX(mac_la_ap_mutex);
> +bool mac_la_ap_started;

These should all be static.


> +static int mac_la_ap_init(void)
> +{
> +	int ret;
> +
> +	INIT_LIST_HEAD(&mac_la_ap_list.list);
> +	mutex_init(&mac_la_ap_mutex);
> +	ret = register_netdevice_notifier(&mac_la_ap_netdev_notifier);
> +	if (!ret)
> +		mac_la_ap_started = 1;
> +	else
> +		pr_err("mac_la_ap_init: Notifier registration failed\n");
> +
> +	return ret;
> +}

The mutex is already initialized, and the list head too if you do the
change above.

I think it would be simpler to register the notifier from an
initcall and drop the mac_la_ap_started variable.

> +int mac_la_ap_register_device_macs(const struct mac_la_ap *macs)
> +{

> +}
> +EXPORT_SYMBOL_GPL(mac_la_ap_register_device_macs);


I'm not sure if there is any point in exporting this function, my feeling
is that it would only ever be called from built-in code. If we can call it
from a module, we should probably also allow this file to be a loadable
module as well.

	Arnd
