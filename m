From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod
 required for am33xx
Date: Fri, 17 Feb 2012 14:21:35 +0100
Message-ID: <4F3E545F.8070802@ti.com>
References: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39697 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab2BQNVq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 08:21:46 -0500
In-Reply-To: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, paul@pwsan.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Hi Vaibhav,

On 2/17/2012 1:24 PM, Vaibhav Hiremath wrote:
> In case of AM33xx family of devices (like cpsw) have different sysc
> bit field offsets defined,

It is really used by several IPs, or it is just an unique exception?

For an exception, you can just define the omap_hwmod_sysc_fields for 
that IP.
This is what SmartReflex is using for example.

Regards,
Benoit


> sysc_type3:
> |  3     2  |  1    0  |
> | STDBYMODE | IDLEMODE |
>
> So introduce new sysc_type3 in omap_hwmod common data.
>
> Signed-off-by: Vaibhav Hiremath<hvaibhav@ti.com>
> Signed-off-by: Vaibhav Bedia<vaibhav.bedia@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_common_data.c |    9 +++++++++
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |   10 ++++++++++
>   2 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
> index 51e5418..6dd922e 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
> @@ -49,6 +49,15 @@ struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2 = {
>   	.srst_shift	= SYSC_TYPE2_SOFTRESET_SHIFT,
>   };
>
> +/**
> + * struct omap_hwmod_sysc_type3 - TYPE3 sysconfig scheme.
> + * Used by some IPs on AM33xx
> + */
> +struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3 = {
> +	.midle_shift	= SYSC_TYPE3_MIDLEMODE_SHIFT,
> +	.sidle_shift	= SYSC_TYPE3_SIDLEMODE_SHIFT,
> +};
> +
>   struct omap_dss_dispc_dev_attr omap2_3_dss_dispc_dev_attr = {
>   	.manager_count		= 2,
>   	.has_framedonetv_irq	= 0
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 9db27aa..3128364 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -41,6 +41,7 @@ struct omap_device;
>
>   extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type1;
>   extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
> +extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
>
>   /*
>    * OCP SYSCONFIG bit shifts/masks TYPE1. These are for IPs compliant
> @@ -70,6 +71,15 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
>   #define SYSC_TYPE2_MIDLEMODE_SHIFT	4
>   #define SYSC_TYPE2_MIDLEMODE_MASK	(0x3<<  SYSC_TYPE2_MIDLEMODE_SHIFT)
>
> +/*
> + * OCP SYSCONFIG bit shifts/masks TYPE3.
> + * This is applicable for some IPs present in AM33XX
> + */
> +#define SYSC_TYPE3_SIDLEMODE_SHIFT	0
> +#define SYSC_TYPE3_SIDLEMODE_MASK	(0x3<<  SYSC_TYPE3_SIDLEMODE_SHIFT)
> +#define SYSC_TYPE3_MIDLEMODE_SHIFT	2
> +#define SYSC_TYPE3_MIDLEMODE_MASK	(0x3<<  SYSC_TYPE3_MIDLEMODE_SHIFT)
> +
>   /* OCP SYSSTATUS bit shifts/masks */
>   #define SYSS_RESETDONE_SHIFT		0
>   #define SYSS_RESETDONE_MASK		(1<<  SYSS_RESETDONE_SHIFT)

