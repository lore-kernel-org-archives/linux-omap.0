From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/13] PM: add a per-device wake-up latency constraints plist
Date: Fri, 29 Jul 2011 23:58:45 +0200
Message-ID: <201107292358.45511.rjw@sisk.pl>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com> <1311841821-10252-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34866 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135Ab1G2V5T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 17:57:19 -0400
In-Reply-To: <1311841821-10252-3-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

On Thursday, July 28, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Add the field latency_constraints in the struct dev_pm_info
> and the initialization of the plist in device_pm_init.
> 
> This enables the implementation of per-device constraints in
> PM QoS.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

This one looks good to me.

Thanks,
Rafael


> ---
>  drivers/base/power/main.c |    1 +
>  include/linux/pm.h        |    2 ++
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 06f09bf..dad2eb9 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -97,6 +97,7 @@ void device_pm_add(struct device *dev)
>  			dev_name(dev->parent));
>  	list_add_tail(&dev->power.entry, &dpm_list);
>  	mutex_unlock(&dpm_list_mtx);
> +	plist_head_init(&dev->power.latency_constraints, &dev->power.lock);
>  }
>  
>  /**
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 411e4f4..23c85f1 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -22,6 +22,7 @@
>  #define _LINUX_PM_H
>  
>  #include <linux/list.h>
> +#include <linux/plist.h>
>  #include <linux/workqueue.h>
>  #include <linux/spinlock.h>
>  #include <linux/wait.h>
> @@ -463,6 +464,7 @@ struct dev_pm_info {
>  	unsigned long		accounting_timestamp;
>  	void			*subsys_data;  /* Owned by the subsystem. */
>  #endif
> +	struct plist_head	latency_constraints;
>  };
>  
>  extern void update_pm_runtime_accounting(struct device *dev);
> 

