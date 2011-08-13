From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 03/15] PM QoS: code re-organization
Date: Fri, 12 Aug 2011 19:50:39 -0700
Message-ID: <20110813025039.GC639@gvim.org>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
 <1313075212-8366-4-git-send-email-j-pihet@ti.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:39674 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab1HMCuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 22:50:46 -0400
Received: by yie30 with SMTP id 30so2371548yie.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Aug 2011 19:50:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313075212-8366-4-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Thu, Aug 11, 2011 at 05:06:40PM +0200, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Move around the PM QoS misc devices management code
> for better readability.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  kernel/power/qos.c |   45 +++++++++++++++++++++++----------------------
>  1 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 61275f2..fa9a090 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -190,28 +190,6 @@ static void update_target(struct pm_qos_object *o, struct plist_node *node,
>  					     NULL);
>  }
>  
> -static int register_pm_qos_misc(struct pm_qos_object *qos)
> -{
> -	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
> -	qos->pm_qos_power_miscdev.name = qos->name;
> -	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
> -
> -	return misc_register(&qos->pm_qos_power_miscdev);
> -}
> -
> -static int find_pm_qos_object_by_minor(int minor)
> -{
> -	int pm_qos_class;
> -
> -	for (pm_qos_class = 0;
> -		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
> -		if (minor ==
> -			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
> -			return pm_qos_class;
> -	}
> -	return -1;
> -}
> -
>  /**
>   * pm_qos_request - returns current system wide qos expectation
>   * @pm_qos_class: identification of which qos value is requested
> @@ -364,6 +342,29 @@ int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
>  
> +/* User space interface to PM QoS classes via misc devices */
> +static int register_pm_qos_misc(struct pm_qos_object *qos)
> +{
> +	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
> +	qos->pm_qos_power_miscdev.name = qos->name;
> +	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
> +
> +	return misc_register(&qos->pm_qos_power_miscdev);
> +}
> +
> +static int find_pm_qos_object_by_minor(int minor)
> +{
> +	int pm_qos_class;
> +
> +	for (pm_qos_class = 0;
> +		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
> +		if (minor ==
> +			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
> +			return pm_qos_class;
> +	}
> +	return -1;
> +}
> +
>  static int pm_qos_power_open(struct inode *inode, struct file *filp)
>  {
>  	long pm_qos_class;
> -- 
> 1.7.2.5
>
I don't see the point of this but its ok.

Acked-by:markgross <markgross@thegnar.org>

