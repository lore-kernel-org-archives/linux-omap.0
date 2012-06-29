From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] OMAP2+ devices add mac address allocation register api
Date: Fri, 29 Jun 2012 08:51:46 +0000
Message-ID: <201206290851.47054.arnd@arndb.de>
References: <20120629054404.11091.31289.stgit@build.warmcat.com> <20120629055516.11091.82899.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55997 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab2F2Ivu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 04:51:50 -0400
In-Reply-To: <20120629055516.11091.82899.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.pitre@linaro.org, s-jan@ti.com, patches@linaro.org, tony@atomide.com, rostedt@goodmis.org

On Friday 29 June 2012, Andy Green wrote:
> +static int omap_panda_netdev_event(struct notifier_block *this,
> +                                               unsigned long event, void *ptr)
> +{
> +       struct net_device *dev = ptr;
> +       struct sockaddr sa;
> +       int n;
> +
> +       if (event != NETDEV_REGISTER)
> +               return NOTIFY_DONE;
> +
> +       n = omap_device_path_need_mac(dev->dev.parent);
> +       if (n < 0)
> +               return NOTIFY_DONE;
> +
> +       sa.sa_family = dev->type;
> +       omap2_die_id_to_ethernet_mac(sa.sa_data, n);
> +       dev->netdev_ops->ndo_set_mac_address(dev, &sa);
> +
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block omap_panda_netdev_notifier = {
> +       .notifier_call = omap_panda_netdev_event,
> +       .priority = 1,
> +};
> +
> +int omap_register_mac_device_fixup_paths(const char * const *paths, int count)
> +{
> +       mac_device_fixup_paths = paths;
> +       count_mac_device_fixup_paths = count;
> +
> +       return register_netdevice_notifier(&omap_panda_netdev_notifier);
> +}

The omap_panda_netdev_event and omap_panda_netdev_notifier symbols should probably
lose the "panda_" part of their names, because they are now located in a common
file and are not panda specific any more.

	Arnd
