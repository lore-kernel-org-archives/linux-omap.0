From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 3/7] OMAP: PM CONSTRAINTS: implement wake-up latency constraints
Date: Thu, 17 Mar 2011 13:18:41 -0700
Message-ID: <87r5a5zeji.fsf@ti.com>
References: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
	<1299779247-20511-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44897 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755499Ab1CQUSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 16:18:47 -0400
Received: by yia25 with SMTP id 25so1883526yia.40
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 13:18:45 -0700 (PDT)
In-Reply-To: <1299779247-20511-4-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Thu, 10 Mar 2011 18:47:23 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Implement the wake-up latency constraints using an internal
> unified function _set_dev_constraint at OMAP PM level,
> which calls the corresponding function at omap device level.
>
> The actual constraints management code is at the omap device level.
>
> Note: the bus throughput function is implemented but currently is
> a no-op.
>
> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
> on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/plat-omap/omap-pm-constraints.c |  174 ++++++++++++++++--------------
>  1 files changed, 91 insertions(+), 83 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap-pm-constraints.c b/arch/arm/plat-omap/omap-pm-constraints.c
> index c8b4e4c..c6735da 100644
> --- a/arch/arm/plat-omap/omap-pm-constraints.c
> +++ b/arch/arm/plat-omap/omap-pm-constraints.c
> @@ -24,6 +24,7 @@
>  /* Interface documentation is in mach/omap-pm.h */
>  #include <plat/omap-pm.h>
>  #include <plat/omap_device.h>
> +#include <plat/common.h>
>  
>  static bool off_mode_enabled;
>  static u32 dummy_context_loss_counter;
> @@ -32,119 +33,126 @@ static u32 dummy_context_loss_counter;
>   * Device-driver-originated constraints (via board-*.c files)
>   */
>  
> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> +/*
> + * Generic function to omap_device layer for the constraints API.
> + */
> +static int _set_dev_constraint(enum omap_pm_constraint_class class,
> +			       struct device *req_dev, struct device *dev,
> +			       long t)
>  {
> -	if (!dev || t < -1) {
> +	int ret = 0;
> +
> +	if (!req_dev || !dev || t < -1) {
>  		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
>  		return -EINVAL;
> -	};
> -
> -	if (t == -1)
> -		pr_debug("OMAP PM: remove max MPU wakeup latency constraint: "
> -			 "dev %s\n", dev_name(dev));
> -	else
> -		pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
> -			 "dev %s, t = %ld usec\n", dev_name(dev), t);
> +	}
>  
> -	/*
> -	 * For current Linux, this needs to map the MPU to a
> -	 * powerdomain, then go through the list of current max lat
> -	 * constraints on the MPU and find the smallest.  If
> -	 * the latency constraint has changed, the code should
> -	 * recompute the state to enter for the next powerdomain
> -	 * state.
> -	 *
> -	 * TI CDP code can call constraint_set here.
> -	 */
> +	/* Try to catch non omap_device for dev */

comment should be 'only valid for omap_devices'

> +	if (dev->parent == &omap_device_parent) {
> +		if (t == -1)
> +			pr_debug("OMAP PM: remove constraint of class %d "
> +				 "from req_dev %s on dev %s\n",
> +				 class, dev_name(req_dev), dev_name(dev));
> +		else
> +			pr_debug("OMAP PM: add constraint of class %d "
> +				 "from req_dev %s on dev %s, t = %ld\n",
> +				 class, dev_name(req_dev), dev_name(dev), t);
> +
> +		/* Call the omap_device API */

comment not needed

> +		ret = omap_device_set_dev_constraint(class, req_dev, dev, t);

Calling a function which doesn't yet exist. 

Patches should be ordered such that the kernel still compiles after each patch.

> +	} else {
> +		pr_err("OMAP-PM set_wakeup_lat: Error: platform device "
> +		       "not valid\n");

comment should be 'Error: not an omap_device'.

> +		return -EINVAL;
> +	}
>  
> -	return 0;
> +	return ret;
>  }

Kevin
