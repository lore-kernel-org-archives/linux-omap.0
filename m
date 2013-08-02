From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: dss-common: fix Panda's DVI DDC channel
Date: Fri, 2 Aug 2013 07:54:57 -0500
Message-ID: <51FBAC21.2040609@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com> <1374570405-8301-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38878 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680Ab3HBMzX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 08:55:23 -0400
In-Reply-To: <1374570405-8301-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/23/2013 04:06 AM, Tomi Valkeinen wrote:
> Panda's DVI connector's DDC pins are connected to OMAP's third i2c bus.
> With non-DT, the bus number was 3, and that is what is used in the
> dss-common.c which contains the platform data for Panda's DVI.
>
> However, with DT, the bus number is 2. As we now only have DT boot for
> Panda, we have to change the bus number to make DVI EDID read
> operational.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm/mach-omap2/dss-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
> index 393aeef..043e570 100644
> --- a/arch/arm/mach-omap2/dss-common.c
> +++ b/arch/arm/mach-omap2/dss-common.c
> @@ -42,7 +42,7 @@
>
>   /* Using generic display panel */
>   static struct tfp410_platform_data omap4_dvi_panel = {
> -	.i2c_bus_num		= 3,
> +	.i2c_bus_num		= 2,
>   	.power_down_gpio	= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
>   };
>
>
completely dumb question :) :
why cant we have dts support for this instead of having to renumber 
every time?

Example: if -EPROBEDEFER is incurred due to some unexpected dependency, 
we'd have to redo the numbering in the kernel yet again.

-- 
Regards,
Nishanth Menon
