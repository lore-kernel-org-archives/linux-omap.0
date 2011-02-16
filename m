From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [3/4] OMAP: DSS2: Adding macro for DISPC_DIVISOR register
Date: Wed, 16 Feb 2011 17:43:05 +0200
Message-ID: <1297870985.14556.14.camel@deskari>
References: <1296742161-9395-4-git-send-email-raghuveer.murthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34873 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755Ab1BPPnI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 10:43:08 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1GFh7u9027666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 09:43:07 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1GFh7X5019343
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 09:43:07 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1GFh7FJ019940
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 09:43:07 -0600 (CST)
In-Reply-To: <1296742161-9395-4-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raghuveer Murthy <raghuveer.murthy@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 2011-02-03 at 14:09 +0000, Raghuveer Murthy wrote:
> Added macro for DISPC_DIVISOR. This is different from DISPC_DIVISOR1 and
> DISPC_DIVISOR2. OMAP4 supports all the above 3 registers.
> 
> DISPC_DIVISOR1 and DISPC_DIVISOR2 registers are accessed through
> DISPC_DIVISORo(ch) macro
> 
> Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
> 
> ---
> drivers/video/omap2/dss/dispc.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index e52a413..6225d12 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -132,6 +132,17 @@ struct dispc_reg { u16 idx; };
>  
>  #define DISPC_VID_PRELOAD(n)		DISPC_REG(0x230 + (n)*0x04)
>  
> +/*
> + * The OMAP4 DISPC_DIVISOR1 is backward compatible to OMAP3xxx DISPC_DIVISOR.
> + * However DISPC_DIVISOR is also provided in OMAP4, to control DISPC_CORE_CLK.
> + * This allows DISPC_CORE_CLK to be independent of logical clock dividers (lcd)
> + * of LCD1 (primary) and LCD2 (secondary) displays.
> + *
> + * To derive pixel clocks for Primary and Secondary LCD channels, configure the
> + * lcd and pcd in DISPC_DIVISOR1 and DISPC_DIVISOR2 respectively, using the
> + * DISPC_DIVISORo(ch).
> + */
> +#define DISPC_DIVISOR			DISPC_REG(0x0804)
>  
>  #define DISPC_IRQ_MASK_ERROR            (DISPC_IRQ_GFX_FIFO_UNDERFLOW | \
>  					 DISPC_IRQ_OCP_ERR | \

See my comment about comments in previous mail.

I think you should merge this and the next patch. There's not much point
in adding a single line define, which is not used (yet).

How about the debug output from debug/omapdss/clk file? Does it print
sensible things on OMAP4 after these patches?

 Tomi


