From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC][PATCH 4/8] OMAP: DSS2: OMAP4 Secondary LCD Channel DISPC
 Registers
Date: Thu, 01 Jul 2010 14:30:37 +0300
Message-ID: <1277983837.2474.317.camel@tubuntu.research.nokia.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com>
	 <1277980285-20996-2-git-send-email-archit@ti.com>
	 <1277980285-20996-3-git-send-email-archit@ti.com>
	 <1277980285-20996-4-git-send-email-archit@ti.com>
	 <1277980285-20996-5-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50772 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab0GALat (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 07:30:49 -0400
In-Reply-To: <1277980285-20996-5-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

On Thu, 2010-07-01 at 12:31 +0200, ext Archit Taneja wrote:
> From: Semwal, Sumit <sumit.semwal@ti.com>
> 
> Introduce OMAP4 DISPC base address and Secondary LCD Channel registers, use them
> in register dumps.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> Signed-off-by: Samreen <samreen@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   42 ++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 41 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 5ecdc00..08b36d6
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -41,9 +41,13 @@
>  #include "dss.h"
>  
>  /* DISPC */
> +#ifdef CONFIG_ARCH_OMAP4
> +#define DISPC_BASE			0x58001000
> +#define DISPC_SZ_REGS			SZ_16K
> +#else
>  #define DISPC_BASE			0x48050400
> -
>  #define DISPC_SZ_REGS			SZ_1K
> +#endif
>  
>  struct dispc_reg { u16 idx; };
>  
> @@ -68,6 +72,7 @@ struct dispc_reg { u16 idx; };
>  #define DISPC_TIMING_V			DISPC_REG(0x0068)
>  #define DISPC_POL_FREQ			DISPC_REG(0x006C)
>  #define DISPC_DIVISOR			DISPC_REG(0x0070)
> +#define DISPC_DIVISOR1			DISPC_REG(0x0804)

What is this?

>  #define DISPC_GLOBAL_ALPHA		DISPC_REG(0x0074)
>  #define DISPC_SIZE_DIG			DISPC_REG(0x0078)
>  #define DISPC_SIZE_LCD			DISPC_REG(0x007C)
> @@ -131,6 +136,23 @@ struct dispc_reg { u16 idx; };
>  					 DISPC_IRQ_SYNC_LOST | \
>  					 DISPC_IRQ_SYNC_LOST_DIGIT)
>  
> +/* OMAP4 new global registers */
> +#define DISPC_CONTROL2		DISPC_REG(0x0238)
> +#define DISPC_DEFAULT_COLOR2		DISPC_REG(0x03AC)
> +#define DISPC_TRANS_COLOR2		DISPC_REG(0x03B0)
> +#define DISPC_CPR2_COEF_B		DISPC_REG(0x03B4)
> +#define DISPC_CPR2_COEF_G		DISPC_REG(0x03B8)
> +#define DISPC_CPR2_COEF_R		DISPC_REG(0x03BC)
> +#define DISPC_DATA2_CYCLE1		DISPC_REG(0x03C0)
> +#define DISPC_DATA2_CYCLE2		DISPC_REG(0x03C4)
> +#define DISPC_DATA2_CYCLE3		DISPC_REG(0x03C8)
> +#define DISPC_SIZE_LCD2		DISPC_REG(0x03CC)
> +#define DISPC_TIMING_H2		DISPC_REG(0x0400)
> +#define DISPC_TIMING_V2		DISPC_REG(0x0404)
> +#define DISPC_POL_FREQ2		DISPC_REG(0x0408)
> +#define DISPC_DIVISOR2		DISPC_REG(0x040C)
> +#define DISPC_CONFIG2		DISPC_REG(0x0620)
> +
>  #define DISPC_MAX_NR_ISRS		8

Would it be possible to have similar system to these registers as with
for example the VID registers:

DISPC_SIZE_LCD(n) where n is 0 or 1, or possibly the channel.

This would reduce ifs quite a bit in the following patches.

 Tomi


