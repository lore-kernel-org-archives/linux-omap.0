From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/8] OMAP2+: omap_hwmod: manage the omap_devices the wake-up
 latency constraints
Date: Thu, 31 Mar 2011 15:20:06 +0400
Message-ID: <4D946366.4000805@ru.mvista.com>
References: <1301498364-726-1-git-send-email-j-pihet@ti.com> <1301498364-726-5-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43268 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab1CaLVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Mar 2011 07:21:41 -0400
Received: by wya21 with SMTP id 21so1917070wya.19
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 04:21:40 -0700 (PDT)
In-Reply-To: <1301498364-726-5-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com, Jean Pihet <j-pihet@ti.com>

Hello.

On 30-03-2011 19:19, jean.pihet@newoldbits.com wrote:

> From: Jean Pihet<j-pihet@ti.com>

> Hwmod is queried from the omap device layer to manage the power domains
> wake-up latency constraints. Hwmod retrieves the correct power domain
> and if it exists it calls the corresponding power domain function.

> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
> on MPU, CORE and PER.

> Signed-off-by: Jean Pihet<j-pihet@ti.com>
[...]

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e034294..62de888 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
[...]
> @@ -2322,11 +2323,34 @@ ohsps_unlock:
>   	return ret;
>   }
>
> +/*
> + * omap_hwmod_set_wkup_constraint- set/release a wake-up latency constraint
> + *
> + * @oh: struct omap_hwmod* to which the target device belongs to.
> + * @cookie: identifier of the constraints list for @oh.
> + * @min_latency: the minimum allowed wake-up latency for @oh.
> + *
> + * Returns 0 upon success.
> + */
> +int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh,
> +				       void *cookie, long min_latency)
> +{
> +	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
> +
> +	if (!PTR_ERR(pwrdm)) {

    What's the point of calling PTR_ERR() at all, if just '!pwrdm' will give 
the same result?

WBR, Sergei
