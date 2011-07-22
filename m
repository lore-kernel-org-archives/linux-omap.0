From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [RFC/PATCH 3/7] OMAP: McBSP: use existing macros for converting
 between devices
Date: Fri, 22 Jul 2011 16:32:59 +0400
Message-ID: <4E296DFB.3010205@ru.mvista.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com> <1311292338-11830-5-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44434 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab1GVMdY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jul 2011 08:33:24 -0400
Received: by wyg8 with SMTP id 8so1465248wyg.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 05:33:23 -0700 (PDT)
In-Reply-To: <1311292338-11830-5-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello.

On 22-07-2011 3:52, Kevin Hilman wrote:

> For converting from struct device to platform_device, and from
> platform_device to struct device,

    You mean from platform_device to omap_device?

> there are existing macros.  Use
> them instead of manual use of container_of().

> Signed-off-by: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/plat-omap/mcbsp.c |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)

> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 6c62af1..02199e8 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -260,9 +260,9 @@ EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
>   #ifdef CONFIG_ARCH_OMAP3
>   static struct omap_device *find_omap_device_by_dev(struct device *dev)
>   {
> -	struct platform_device *pdev = container_of(dev,
> -					struct platform_device, dev);
> -	return container_of(pdev, struct omap_device, pdev);
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	return to_omap_device(pdev);
>   }
>
>   static void omap_st_on(struct omap_mcbsp *mcbsp)

WBR, Sergei
