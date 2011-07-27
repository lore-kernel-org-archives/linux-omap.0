From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2] OMAP: ctrl: Fix CONTROL_DSIPHY register fields
Date: Wed, 27 Jul 2011 15:57:07 +0530
Message-ID: <4E2FE7FB.2020005@ti.com>
References: <1311762839-31663-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60473 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751231Ab1G0K1P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jul 2011 06:27:15 -0400
Received: by mail-gx0-f174.google.com with SMTP id 21so1218811gxk.33
        for <linux-omap@vger.kernel.org>; Wed, 27 Jul 2011 03:27:14 -0700 (PDT)
In-Reply-To: <1311762839-31663-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, paul@pwsan.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 7/27/2011 4:03 PM, Archit Taneja wrote:
> Fix the shift and mask macros for DSIx_PPID fields in CONTROL_DSIPHY. The
> OMAP4430 Public TRM vV has these fields mentioned correctly.
>
> Signed-off-by: Archit Taneja<archit@ti.com>
> Acked-by: Benoit Cousson<b-cousson@ti.com>
> ---
> v2:
> - Improve commit description.
> - Define fields in decreasing order of the field's end bit.
>
Thanks for the update.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

>   .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
> index c88420d..1e2d332 100644
> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
> +++ b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
> @@ -941,10 +941,10 @@
>   #define OMAP4_DSI2_LANEENABLE_MASK				(0x7<<  29)
>   #define OMAP4_DSI1_LANEENABLE_SHIFT				24
>   #define OMAP4_DSI1_LANEENABLE_MASK				(0x1f<<  24)
> -#define OMAP4_DSI1_PIPD_SHIFT					19
> -#define OMAP4_DSI1_PIPD_MASK					(0x1f<<  19)
> -#define OMAP4_DSI2_PIPD_SHIFT					14
> -#define OMAP4_DSI2_PIPD_MASK					(0x1f<<  14)
> +#define OMAP4_DSI2_PIPD_SHIFT					19
> +#define OMAP4_DSI2_PIPD_MASK					(0x1f<<  19)
> +#define OMAP4_DSI1_PIPD_SHIFT					14
> +#define OMAP4_DSI1_PIPD_MASK					(0x1f<<  14)
>
>   /* CONTROL_MCBSPLP */
>   #define OMAP4_ALBCTRLRX_FSX_SHIFT				31

