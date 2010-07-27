From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-OPP][PATCH] OMAP: Add check for omap_device pointer before
 adding an opp
Date: Mon, 26 Jul 2010 19:09:45 -0500
Message-ID: <4C4E23C9.6080608@ti.com>
References: <1279953753-1377-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50261 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345Ab0G0AJs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Jul 2010 20:09:48 -0400
In-Reply-To: <1279953753-1377-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

Gopinath, Thara had written, on 07/24/2010 01:42 AM, the following:
> This patch adds the check for whether a omap_device and in turn
> platform_device and device pointers exist for the device before
> adding it's opp table into the global table. This is because all
> the later accesses to the opp entries are based on dev pointer and
> hence there is no point in adding a opp if the dev pointer does
> not exist.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/plat-omap/opp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> index 0273497..e81bb95 100644
> --- a/arch/arm/plat-omap/opp.c
> +++ b/arch/arm/plat-omap/opp.c
> @@ -333,7 +333,7 @@ int opp_add(const struct omap_opp_def *opp_def)
>  		return -EINVAL;
>  	}
>  	oh = omap_hwmod_lookup(opp_def->hwmod_name);
> -	if (!oh) {
> +	if (!oh || !oh->od) {
>  		pr_warn("%s: no hwmod for %s, cannot add OPPs.\n",
just to continue to have sane warnings,

minor nitpick -> s/no hwmod/no hwmod or odev/

>  			__func__, opp_def->hwmod_name);
>  		return -EINVAL;
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
