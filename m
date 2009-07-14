From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] OMAP3: PM: move context-loss counting into OMAP PM
Date: Tue, 14 Jul 2009 14:20:32 -0500
Message-ID: <005701ca04b8$27f39990$544ff780@am.dhcp.ti.com>
References: <1247078065-348-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42509 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181AbZGNTUl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jul 2009 15:20:41 -0400
In-Reply-To: <1247078065-348-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org
Cc: 'Rajendra Nayak' <rnayak@ti.com>, 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Wednesday, July 08, 2009 1:34 PM
> To: linux-omap@vger.kernel.org
> Cc: Rajendra Nayak; Peter 'p2' De Schrijver
> Subject: [PATCH] OMAP3: PM: move context-loss counting into OMAP PM
> 
> From: Rajendra Nayak <rnayak@ti.com>
> 
> Drop get_last_off_on_transaction_id() and move functionality
> into OMAP PM layer.
> 
> For SRF, use omapdev** to get powerdomain state counte
> for NOOP, use an increasing counter to ensure context is always restord.
> 
> **NOTE: in future PM branch, this omapdev functinality will be replaced
>         by omap_hwmod.  Thus, context loss counting will only exist
>         for modules with omap_hwmod implementations.
> 
> Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> Applies to current PM branch and pm-2.6.29
> 
>  arch/arm/mach-omap2/pm.c          |   16 ----------------
>  arch/arm/plat-omap/omap-pm-noop.c |    7 ++++++-
>  arch/arm/plat-omap/omap-pm-srf.c  |   11 +++++++++++
>  3 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 1192e01..fec7d00 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -31,7 +31,6 @@
>  #include <asm/atomic.h>
> 
>  #include <mach/powerdomain.h>
> -#include <mach/omapdev.h>
>  #include <mach/resource.h>
>  #include <mach/omap34xx.h>
> 
> @@ -221,21 +220,6 @@ void omap2_allow_sleep(void)
>  	BUG_ON(i < 0);
>  }
> 
> -unsigned get_last_off_on_transaction_id(struct device *dev)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct omapdev *odev = omapdev_find_pdev(pdev);
> -	struct powerdomain *pwrdm;
> -
> -	if (odev) {
> -		pwrdm = omapdev_get_pwrdm(odev);
> -		if (pwrdm)
> -			return pwrdm->state_counter[0];
> -	}
> -
> -	return 0;
> -}
> -
>  static int __init omap_pm_init(void)
>  {
>  	int error = -1;
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-
> pm-noop.c
> index 4ba261a..07b208b 100644
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/plat-omap/omap-pm-noop.c
> @@ -277,6 +277,8 @@ unsigned long omap_pm_cpu_get_freq(void)
> 
>  int omap_pm_get_dev_context_loss_count(struct device *dev)
>  {
> +	static u32 counter = 0;
> +
>  	if (!dev) {
>  		WARN_ON(1);
>  		return -EINVAL;
> @@ -290,7 +292,10 @@ int omap_pm_get_dev_context_loss_count(struct device
> *dev)
>  	 * off counter.
>  	 */
> 
> -	return 0;
> +	/* For the noop case, we cannot know the off counter, so
> +	 * return an increasing counter which will ensure that
> +	 * context is always restored. */
> +	return counter++;
>  }
> 
>  /*
> diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-
> pm-srf.c
> index 226662d..cac08e4 100644
> --- a/arch/arm/plat-omap/omap-pm-srf.c
> +++ b/arch/arm/plat-omap/omap-pm-srf.c
> @@ -276,6 +276,10 @@ EXPORT_SYMBOL(omap_pm_cpu_get_freq);
> 
>  int omap_pm_get_dev_context_loss_count(struct device *dev)
>  {
> +	struct platform_device *pdev;
> +	struct omapdev *odev;
> +	struct powerdomain *pwrdm;
> +
>  	if (!dev) {
>  		WARN_ON(1);
>  		return -EINVAL;
> @@ -288,7 +292,14 @@ int omap_pm_get_dev_context_loss_count(struct device
> *dev)
>  	 * Map the device to the powerdomain.  Return the powerdomain
>  	 * off counter.
>  	 */
> +	pdev = to_platform_device(dev);
> +	odev = omapdev_find_pdev(pdev);
> 
> +	if (odev) {
> +		pwrdm = omapdev_get_pwrdm(odev);
> +		if (pwrdm)
> +			return pwrdm->state_counter[0];
The state_counter is unsigned and the return type of this fn does not match.
How is the overflow handled for state_counter? Once the OFF mode count
increases to 65535 there could be a overflow here.
> +	}
>  	return 0;
>  }
> 
> --
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


