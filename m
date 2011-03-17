From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/2] arm: mach-omap2: devices: fix omap3_l3_init() return value
Date: Thu, 17 Mar 2011 11:22:00 +0530
Message-ID: <324bffcaf53be55bd6f392af3f86fa10@mail.gmail.com>
References: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:40865 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751494Ab1CQFwD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 01:52:03 -0400
Received: by mail-yw0-f47.google.com with SMTP id 8so979240ywg.6
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 22:52:01 -0700 (PDT)
In-Reply-To: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-
> arm-kernel-bounces@lists.infradead.org] On Behalf Of Aaro Koskinen
> Sent: Wednesday, March 16, 2011 10:46 PM
> To: linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; tony@atomide.com
> Cc: Aaro Koskinen
> Subject: [PATCH 1/2] arm: mach-omap2: devices: fix omap3_l3_init()
> return value
>
> Fix the return value for the successful case.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/mach-omap2/devices.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
> omap2/devices.c
> index 0d2d6a9..d478f53 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -65,7 +65,7 @@ static int __init omap3_l3_init(void)
>
>  	WARN(IS_ERR(od), "could not build omap_device for %s\n",
> oh_name);
>
> -	return PTR_ERR(od);
> +	return IS_ERR(od) ? PTR_ERR(od) : 0;
>  }
>  postcore_initcall(omap3_l3_init);
>
Looks good.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
