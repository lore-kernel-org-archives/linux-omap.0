From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 6/6] ARM: OMAP3+: SmartReflex Class3: restrict CPU to run on
Date: Tue, 13 Mar 2012 16:04:13 +0530
Message-ID: <ef588847b5162cc1174c7cdeffc74ffd@mail.gmail.com>
References: <1331634381-31436-1-git-send-email-j-pihet@ti.com> <1331634381-31436-7-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:59264 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760153Ab2CMKeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 06:34:14 -0400
Received: by mail-gx0-f182.google.com with SMTP id k4so570007ggn.27
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 03:34:13 -0700 (PDT)
In-Reply-To: <1331634381-31436-7-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
> Sent: Tuesday, March 13, 2012 3:56 PM
> To: linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Kevin Hilman
> Cc: Nishanth Menon; Jean Pihet
> Subject: [PATCH 6/6] ARM: OMAP3+: SmartReflex Class3: restrict CPU
> to run on
>
> From: Nishanth Menon <nm@ti.com>
>
> Use SmartReflex AVS Class3 initialization only for OMAP343x family
> of
> processors.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex-class3.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex-class3.c
> b/arch/arm/mach-omap2/smartreflex-class3.c
> index 9dcda93..735937a 100644
> --- a/arch/arm/mach-omap2/smartreflex-class3.c
> +++ b/arch/arm/mach-omap2/smartreflex-class3.c
> @@ -11,6 +11,7 @@
>   * published by the Free Software Foundation.
>   */
>
> +#include <plat/cpu.h>
>  #include "smartreflex.h"
>
>  static int sr_class3_enable(struct voltagedomain *voltdm,
> @@ -58,6 +59,10 @@ static struct omap_sr_class_data class3_data = {
>  /* Smartreflex Class3 init API to be called from board file */
>  static int __init sr_class3_init(void)
>  {
> +	/* Enable this class only for OMAP343x */
> +	if (!cpu_is_omap343x())
> +		return -EINVAL;
Wouldn't this break SR on OMAP3630 and OMAP4? Shouldn't this be done once
you have SR1.5 support in mainline?

Vishwa
> +
>  	pr_info("SmartReflex Class3 initialized\n");
>  	return sr_register_class(&class3_data);
>  }
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
