From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv6 9/9] OMAP3: PM: Added support for suspending to INACTIVE state
Date: Mon, 01 Mar 2010 15:43:18 -0800
Message-ID: <873a0j8v6x.fsf@deeprootsystems.com>
References: <1265999265-4363-1-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-2-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-3-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-4-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-5-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-6-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-7-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-8-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-9-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-10-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f197.google.com ([209.85.211.197]:62888 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab0CAXnW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 18:43:22 -0500
Received: by ywh35 with SMTP id 35so1461140ywh.4
        for <linux-omap@vger.kernel.org>; Mon, 01 Mar 2010 15:43:21 -0800 (PST)
In-Reply-To: <1265999265-4363-10-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 12 Feb 2010 20\:27\:45 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> With the new support functions this is now possible. Suspending to INACTIVE
> is useful for testing purposes.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index cdbedcf..41d6cc3 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -633,11 +633,12 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  	if (pwrdm == NULL || IS_ERR(pwrdm))
>  		return -EINVAL;
>  
> -	while (!(pwrdm->pwrsts & (1 << state))) {
> -		if (state == PWRDM_POWER_OFF)
> -			return ret;
> -		state--;
> -	}

The comment above set_pwrdm_state() says only ON & RET are supported.
Please update that comment as well.


> +	if (state != PWRDM_POWER_INACTIVE)
> +		while (!(pwrdm->pwrsts & (1 << state))) {
> +			if (state == PWRDM_POWER_OFF)
> +				return ret;
> +			state--;
> +		}

I think all powerdomains can be inactive right?

I think it would be cleaner to just have all the pwrdm->pwrsts fields
include intactive as a valid option.

Something like the patch below.  IIRC, you did something like this in
one of the earlier versions of the patch.

Kevin

diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index a1ecd47..c692472 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -31,17 +31,17 @@
 #define PWRDM_MAX_PWRSTS	4
 
 /* Powerdomain allowable state bitfields */
-#define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) | \
+#define PWRSTS_ON		((1 << PWRDM_POWER_INACTIVE) | \
 				 (1 << PWRDM_POWER_ON))
 
+#define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) | PWRSTS_ON)
+
 #define PWRSTS_OFF_RET		((1 << PWRDM_POWER_OFF) | \
 				 (1 << PWRDM_POWER_RET))
 
-#define PWRSTS_RET_ON		((1 << PWRDM_POWER_RET) | \
-				 (1 << PWRDM_POWER_ON))
-
-#define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 << PWRDM_POWER_ON))
+#define PWRSTS_RET_ON		((1 << PWRDM_POWER_RET) | PWRSTS_ON)
 
+#define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | PWRSTS_ON)
 
 /* Powerdomain flags */
 #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
