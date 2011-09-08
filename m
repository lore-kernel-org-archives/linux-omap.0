From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/8] OMAP: hwmod: Fix the addr spaces count API.
Date: Thu, 8 Sep 2011 09:47:55 +0200
Message-ID: <4E68732B.60209@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com> <1315459327-3285-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42999 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932218Ab1IHHsF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Sep 2011 03:48:05 -0400
In-Reply-To: <1315459327-3285-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "R, Sricharan" <r.sricharan@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>

Hi Sricharan,

On 9/8/2011 7:22 AM, Shilimkar, Santosh wrote:
> From: sricharan<r.sricharan@ti.com>
>
> The address space count API returns the number of address space
> entries for a hwmod including a additional null value present in the
> address space structure introduced recently.

That's a minor nit, but you might give the commit you are referencing here.

> The devices which
> have multiple hwmods and use device_build_ss are broken with this,
> as their address resources are populated with a extra null value,
> subsequently the probe fails. So fix the API not to add the null value.

It seems that in every cases, we are adding an extra null resource for 
nothing. But it is true that will not crash if the driver is just 
expecting an unique entry.
What is happening with multiple hwmods is probably the introduction of 
that extra null resource in the middle of the real ones, hence shifting 
the resource index?
You might give more details here.

> Signed-off-by: sricharan<r.sricharan@ti.com>
> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |    8 +++++---
>   1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 84cc0bd..32a0f48a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -791,9 +791,11 @@ static int _count_ocp_if_addr_spaces(struct omap_hwmod_ocp_if *os)
>   	if (!os || !os->addr)
>   		return 0;
>
> -	do {
> -		mem =&os->addr[i++];
> -	} while (mem->pa_start != mem->pa_end);
> +	mem =&os->addr[i];
> +
> +	while (mem->pa_start != mem->pa_end) {
> +		mem =&os->addr[++i];
> +	};
>
>   	return i;

Cannot you just do "return i - 1"?

Regards,
Benoit
