From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP: Revert "ARM: OMAP: ctrl: Fix CONTROL_DSIPHY
 register fields"
Date: Mon, 7 May 2012 16:31:29 +0530
Message-ID: <4FA7AB89.5010904@ti.com>
References: <1334837356-2440-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57707 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755880Ab2EGLCR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 07:02:17 -0400
In-Reply-To: <1334837356-2440-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com
Cc: tomi.valkeinen@ti.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, b-cousson@ti.com, stable@vger.kernel.org

Hi Tony, Paul,

Could you please consider this patch for the next -rc cycle, it fixes 
contention errors seen on the DSI panel on OMAP4 SDP.

Thanks,
Archit

On Thursday 19 April 2012 05:39 PM, Archit Taneja wrote:
> This reverts commit 46f8c3c7e95c0d30d95911e7975ddc4f93b3e237.
>
> The commit above swapped the DSI1_PPID and DSI2_PPID register fields in
> CONTROL_DSIPHY to be in sync with the newer public OMAP TRMs(after version V).
>
> With this commit, contention errors were reported on DSI lanes some OMAP4 SDPs.
> After probing the DSI lanes on OMAP4 SDP, it was seen that setting bits in the
> DSI2_PPID field was pulling up voltage on DSI1 lanes, and DSI1_PPID field was
> pulling up voltage on DSI2 lanes.
>
> This proves that the current version of OMAP4 TRM is incorrect, swap the
> position of register fields according to the older TRM versions as they were
> correct.
>
> Cc: stable@vger.kernel.org # v3.2+
> Acked-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> Signed-off-by: Archit Taneja<archit@ti.com>
> ---
> Note: Resend with stable kernel list added in cc
>
>   .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
> index 1e2d332..c88420d 100644
> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
> +++ b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
> @@ -941,10 +941,10 @@
>   #define OMAP4_DSI2_LANEENABLE_MASK				(0x7<<  29)
>   #define OMAP4_DSI1_LANEENABLE_SHIFT				24
>   #define OMAP4_DSI1_LANEENABLE_MASK				(0x1f<<  24)
> -#define OMAP4_DSI2_PIPD_SHIFT					19
> -#define OMAP4_DSI2_PIPD_MASK					(0x1f<<  19)
> -#define OMAP4_DSI1_PIPD_SHIFT					14
> -#define OMAP4_DSI1_PIPD_MASK					(0x1f<<  14)
> +#define OMAP4_DSI1_PIPD_SHIFT					19
> +#define OMAP4_DSI1_PIPD_MASK					(0x1f<<  19)
> +#define OMAP4_DSI2_PIPD_SHIFT					14
> +#define OMAP4_DSI2_PIPD_MASK					(0x1f<<  14)
>
>   /* CONTROL_MCBSPLP */
>   #define OMAP4_ALBCTRLRX_FSX_SHIFT				31

