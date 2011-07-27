From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP: ctrl: Fix CONTROL_DSIPHY register fields
Date: Wed, 27 Jul 2011 11:51:24 +0530
Message-ID: <4E2FAE64.7020806@ti.com>
References: <1311747632-26899-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:41347 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752115Ab1G0GVb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jul 2011 02:21:31 -0400
Received: by mail-gx0-f180.google.com with SMTP id 10so1227652gxk.39
        for <linux-omap@vger.kernel.org>; Tue, 26 Jul 2011 23:21:30 -0700 (PDT)
In-Reply-To: <1311747632-26899-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

+ Benoit

On 7/27/2011 11:50 AM, Archit Taneja wrote:
> Fix the shift and mask macros for DSIx_PPID fields in CONTROL_DSIPHY. The Latest
> TRM mentions the correct fields in the register.
You can mention the TRM version instead of 'latest'
Latest is very much relative :)

>
> Signed-off-by: Archit Taneja<archit@ti.com>
Change looks good to me.
Autogen scripts needs to be checked as well.

> ---
>   .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
> index c88420d..8321add 100644
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
> +#define OMAP4_DSI1_PIPD_SHIFT					14
> +#define OMAP4_DSI1_PIPD_MASK					(0x1f<<  14)
> +#define OMAP4_DSI2_PIPD_SHIFT					19
> +#define OMAP4_DSI2_PIPD_MASK					(0x1f<<  19)
>
>   /* CONTROL_MCBSPLP */
>   #define OMAP4_ALBCTRLRX_FSX_SHIFT				31

