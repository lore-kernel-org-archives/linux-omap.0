From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Update correct ONLP/RET values
Date: Tue, 03 Mar 2009 08:41:58 -0800
Message-ID: <87iqmq7e3t.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAD03A7B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:51858 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZCCQmF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 11:42:05 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1868011ywh.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2009 08:42:03 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAD03A7B@dbde02.ent.ti.com> (Rajendra Nayak's message of "Mon\, 2 Mar 2009 13\:01\:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> Populates the correct ONLP/RET cmd values for VDD1 and VDD2.
> Also removes the unneccesary bitshift logic.
> Applies on the latest pm branch, validated on a 3430SDP.
>
> 0x30 = 1.2V
> 0x1E = .975V
> 0x2C = 1.15V
>
> Formula used to calulate the hex values
> Value(in decimals)*12.5 + 600 mV.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, I will merge this with your previous patch and push a new pm branch.

Kevin

>  arch/arm/mach-omap2/pm34xx.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2009-03-02 11:42:13.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2009-03-02 12:07:19.653034656 +0530
> @@ -1036,16 +1036,16 @@ err2:
>  }
>  
>  /* PRM_VC_CMD_VAL_0 specific bits */
> -#define OMAP3430_VC_CMD_VAL0_ON				(0x3 << 4)
> -#define OMAP3430_VC_CMD_VAL0_ONLP			(0xf << 3)
> -#define OMAP3430_VC_CMD_VAL0_RET			(0xf << 3)
> -#define OMAP3430_VC_CMD_VAL0_OFF			(0x3 << 4)
> +#define OMAP3430_VC_CMD_VAL0_ON		0x30
> +#define OMAP3430_VC_CMD_VAL0_ONLP	0x1E
> +#define OMAP3430_VC_CMD_VAL0_RET	0x1E
> +#define OMAP3430_VC_CMD_VAL0_OFF	0x30
>  
>  /* PRM_VC_CMD_VAL_1 specific bits */
> -#define OMAP3430_VC_CMD_VAL1_ON				(0xB << 2)
> -#define OMAP3430_VC_CMD_VAL1_ONLP			(0xf << 3)
> -#define OMAP3430_VC_CMD_VAL1_RET			(0xf << 3)
> -#define OMAP3430_VC_CMD_VAL1_OFF			(0xB << 2)
> +#define OMAP3430_VC_CMD_VAL1_ON		0x2C
> +#define OMAP3430_VC_CMD_VAL1_ONLP	0x1E
> +#define OMAP3430_VC_CMD_VAL1_RET	0x1E
> +#define OMAP3430_VC_CMD_VAL1_OFF	0x2C
>  
>  static void __init configure_vc(void)
>  {--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
