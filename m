From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Runtime: add new helper function: pm_runtime_status_suspended()
Date: Tue, 12 Jul 2011 11:33:48 +0200
Message-ID: <201107121133.48591.rjw@sisk.pl>
References: <1310424682-21255-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48236 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241Ab1GLJdc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 05:33:32 -0400
In-Reply-To: <1310424682-21255-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Tuesday, July 12, 2011, Kevin Hilman wrote:
> This boolean function simply returns whether or not the runtime status
> of the device is 'suspended'.  Unlike pm_runtime_suspended(), this
> function returns the runtime status whether or not runtime PM for the
> device has been disabled or not.
> 
> Also add entry to Documentation/power/runtime.txt
> 
> Suggested-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Applied to suspend-2.6/pm-runtime, thanks!

Rafael


> ---
>  Documentation/power/runtime_pm.txt |    3 +++
>  include/linux/pm_runtime.h         |    6 ++++++
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index 4b011b1..feca92f 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -400,6 +400,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>      - return true if the device's runtime PM status is 'suspended' and its
>        'power.disable_depth' field is equal to zero, or false otherwise
>  
> +  bool pm_runtime_status_suspended(struct device *dev);
> +    - return true if the device's runtime PM status is 'suspended'
> +
>    void pm_runtime_allow(struct device *dev);
>      - set the power.runtime_auto flag for the device and decrease its usage
>        counter (used by the /sys/devices/.../power/control interface to
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index dfb8539..daac05d 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -82,6 +82,11 @@ static inline bool pm_runtime_suspended(struct device *dev)
>  		&& !dev->power.disable_depth;
>  }
>  
> +static inline bool pm_runtime_status_suspended(struct device *dev)
> +{
> +	return dev->power.runtime_status == RPM_SUSPENDED;
> +}
> +
>  static inline bool pm_runtime_enabled(struct device *dev)
>  {
>  	return !dev->power.disable_depth;
> @@ -130,6 +135,7 @@ static inline void pm_runtime_put_noidle(struct device *dev) {}
>  static inline bool device_run_wake(struct device *dev) { return false; }
>  static inline void device_set_run_wake(struct device *dev, bool enable) {}
>  static inline bool pm_runtime_suspended(struct device *dev) { return false; }
> +static inline bool pm_runtime_status_suspended(struct device *dev) { return false; }
>  static inline bool pm_runtime_enabled(struct device *dev) { return false; }
>  
>  static inline int pm_generic_runtime_idle(struct device *dev) { return 0; }
> 

