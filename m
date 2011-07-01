From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 11:25:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107011123590.1988-100000@iolanthe.rowland.org>
References: <87d3hu6oxo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54664 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752456Ab1GAPZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 11:25:57 -0400
In-Reply-To: <87d3hu6oxo.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 1 Jul 2011, Kevin Hilman wrote:

> OK, so the ->probe() part has been explained and makes sense, but I
> would expect ->remove() to be similarily protected (as the documentation
> states.)  But that is not the case.  Is that a bug?  If so, patch below
> makes the code match the documentation.

I suspect it is a bug, but it's hard to be sure.  It's so _blatantly_ 
wrong that it looks like it was done deliberately.

> Kevin
> 
> From eef73ab2feb203bacb57dc35862f2a9969b61593 Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@ti.com>
> Date: Fri, 1 Jul 2011 07:37:47 -0700
> Subject: [PATCH] driver core: prevent runtime PM races with ->remove()
> 
> Runtime PM Documentation states that the runtime PM usage count is
> incremented during driver ->probe() and ->remove().  This is designed
> to prevent driver runtime PM races with subsystems which may initiate
> runtime PM transitions before during and after drivers are loaded.
> 
> Current code increments the usage_count during ->probe() but not
> during ->remove().  This patch fixes the ->remove() part and makes the
> code match the documentation.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  drivers/base/dd.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 6658da7..47e079d 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -329,13 +329,13 @@ static void __device_release_driver(struct device *dev)
>  			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>  						     BUS_NOTIFY_UNBIND_DRIVER,
>  						     dev);
> -
> -		pm_runtime_put_sync(dev);
> -
>  		if (dev->bus && dev->bus->remove)
>  			dev->bus->remove(dev);
>  		else if (drv->remove)
>  			drv->remove(dev);
> +
> +		pm_runtime_put_sync(dev);
> +
>  		devres_release_all(dev);
>  		dev->driver = NULL;
>  		klist_remove(&dev->p->knode_driver);

To be safer, the put_sync() call should be moved down here.  Or maybe 
even after the blocking_notifier_call_chain() that occurs here.

Alan Stern

