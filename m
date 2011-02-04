From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 04/13] OMAP: Introduce dependent voltage domain support
Date: Fri, 04 Feb 2011 07:37:23 -0800
Message-ID: <87wrlfvmj0.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-5-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:46785 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751539Ab1BDPh2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 10:37:28 -0500
Received: by gwaa20 with SMTP id a20so963286gwa.10
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 07:37:26 -0800 (PST)
In-Reply-To: <1295618465-15234-5-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Fri, 21 Jan 2011 19:30:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

Vishwanath BS <vishwanath.bs@ti.com> writes:

> There could be dependencies between various voltage domains for
> maintaining system performance or hardware limitation reasons
> like VDD<X> should be at voltage v1 when VDD<Y> is at voltage v2.
> This patch introduce dependent vdd information structures in the
> voltage layer which can be used to populate these dependencies
> for a voltage domain. This patch also adds support to scale
> the dependent vdd and the scalable devices belonging to it
> during the scaling of a main vdd through omap_voltage_scale.
>
> As part of this, some of the voltage layer structure definitions are moved from
> voltage.c to voltage.h as it needs to be used in the dvfs layer for dependency
> voltage handling.

IMO, it would be cleaner to keep this in the voltage layer, and create
and API for dependencies.  

> Based on original patch from Thara.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Cc: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/dvfs.c                |   87 +++++++++++++++++
>  arch/arm/mach-omap2/voltage.c             |  117 -----------------------
>  arch/arm/plat-omap/include/plat/voltage.h |  148 +++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+), 117 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/dvfs.c b/arch/arm/mach-omap2/dvfs.c
> index cefc2be..c9d3894 100755
> --- a/arch/arm/mach-omap2/dvfs.c
> +++ b/arch/arm/mach-omap2/dvfs.c
> @@ -85,6 +85,7 @@ struct omap_vdd_dvfs_info {
>  	struct mutex scaling_mutex; /* dvfs mutex */
>  	struct voltagedomain *voltdm;
>  	struct list_head dev_list;
> +	struct device vdd_device;

It's not clear what the usage of this device is for.

It is never initialized, but seems to be used as a dummy device when
calcluating dependencies.   Needs clarification.

Kevin
