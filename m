From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] omap3: sr: improve errors handling
Date: Fri, 9 Jul 2010 10:02:58 -0500
Message-ID: <4C373A22.10300@ti.com>
References: <1278681612-10521-1-git-send-email-dedekind1@gmail.com> <1278681612-10521-2-git-send-email-dedekind1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52293 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367Ab0GIPDG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 11:03:06 -0400
In-Reply-To: <1278681612-10521-2-git-send-email-dedekind1@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>, Peter p2 De Schrijver <peter.de-schrijver@nokia.com>

Artem Bityutskiy had written, on 07/09/2010 08:20 AM, the following:
> From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> 
> Do not forget to check the 'platform_device_add_data()' error code
> in 'omap_device_build_ss()'.
> 
> Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Acked-by: Nishanth Menon <nm@ti.com>

> ---
>  arch/arm/plat-omap/omap_device.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index f2bd2e2..e8da192 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -414,7 +414,9 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>  	od->pdev.num_resources = res_count;
>  	od->pdev.resource = res;
>  
> -	platform_device_add_data(&od->pdev, pdata, pdata_len);
> +	ret = platform_device_add_data(&od->pdev, pdata, pdata_len);
> +	if (ret)
> +		goto odbs_exit4;
>  
>  	od->pm_lats = pm_lats;
>  	od->pm_lats_cnt = pm_lats_cnt;


-- 
Regards,
Nishanth Menon
