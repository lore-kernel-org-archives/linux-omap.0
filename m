From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP4: hwmod data: remove duplicated #include
Date: Thu, 28 Jul 2011 17:05:49 +0200
Message-ID: <4E317ACD.50006@ti.com>
References: <1311860109-5816-1-git-send-email-weiyi.huang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52855 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab1G1PF6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 11:05:58 -0400
In-Reply-To: <1311860109-5816-1-git-send-email-weiyi.huang@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, tony Lindgren <tony@atomide.com>

On 7/28/2011 3:35 PM, Huang Weiyi wrote:
> Remove duplicated #include('s) in
>    arch/arm/mach-omap2/omap_hwmod_44xx_data.c

Thanks Huang, good catch.
The second one was added by the 6d3c55f commit.

It might not go in the current merge window since Tony is in vacation.

> Signed-off-by: Huang Weiyi<weiyi.huang@gmail.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit


> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 6201422..374edcf 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -28,7 +28,6 @@
>   #include<plat/mcspi.h>
>   #include<plat/mcbsp.h>
>   #include<plat/mmc.h>
> -#include<plat/i2c.h>
>
>   #include "omap_hwmod_common_data.h"
>

