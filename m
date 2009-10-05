From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on
 OMAP3430
Date: Mon, 5 Oct 2009 17:21:50 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BAEE97D2@dbde02.ent.ti.com>
References: <1254741761-31546-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43229 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932360AbZJELwc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 07:52:32 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n95Bpr5s020030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 5 Oct 2009 06:51:55 -0500
In-Reply-To: <1254741761-31546-1-git-send-email-y>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "y@india.ti.com" <y@india.ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gulati, Shweta" <shweta.gulati@ti.com>

Shweta,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of y@india.ti.com
> Sent: Monday, October 05, 2009 4:53 PM
> To: linux-omap@vger.kernel.org
> Cc: Gulati, Shweta
> Subject: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on
> OMAP3430
> 
> From: Shweta Gulati <shweta.gulati@ti.com>

Please add change-log / description about this patch here.

> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index a9eda25..38f4781 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -140,6 +140,12 @@ static void omap3_core_save_context(void)
>  	omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
>  	control_padconf_off |= START_PADCONF_SAVE;
>  	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
> +	/* Due to Silicon Bug on context restore it is found
> +	 * that the CONTROL_PAD_CONF_ETK14 register is not saved into
> +	 * scratch pad memory sometimes. To rectify it delay acess by Mpu
> +	 * for 300us for scm to finish saving task
> +	 */
> +	udelay(300);
>  	/* wait for the save to complete */
>  	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
>  			& PADCONF_SAVE_DONE)
> --
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
Santosh
