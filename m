From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC PATCH v2] ARM: OMAP4/highbank: Flush L2 cache before disabling
Date: Fri, 04 Oct 2013 16:47:28 -0500
Message-ID: <524F3770.1050609@gmail.com>
References: <1380920277-31622-1-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36400 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab3JDVrc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Oct 2013 17:47:32 -0400
Received: by mail-ie0-f179.google.com with SMTP id e14so10549323iej.38
        for <linux-omap@vger.kernel.org>; Fri, 04 Oct 2013 14:47:31 -0700 (PDT)
In-Reply-To: <1380920277-31622-1-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>

On 10/04/2013 03:57 PM, Taras Kondratiuk wrote:
> Kexec disables outer cache before jumping to reboot code, but it doesn't
> flush it explicitly. Flush is done implicitly inside of l2x0_disable().
> But some SoC's override default .disable handler and don't flush cache.
> This may lead to a corrupted memory during Kexec reboot on these platforms.
> 
> This patch adds cache flush inside of OMAP4 and Highbank outer_cache.disable()
> handlers to make it consistent with default l2x0_disable().
> Also it removes redundant outer_flush_all() call just before outer_disable().
> 
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
> v2: Make the fix specific to platforms that don't use l2x0_disable().
> v1: https://patchwork.kernel.org/patch/2974431/
> ---
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: linaro-kernel@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> ---
> arch/arm/mach-highbank/highbank.c  |    1 +
> arch/arm/mach-highbank/pm.c        |    1 -
> arch/arm/mach-omap2/omap4-common.c |    1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index 8e63ccd..22e6f34 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -63,6 +63,7 @@ void highbank_set_cpu_jump(int cpu, void *jump_addr)
>  
>  static void highbank_l2x0_disable(void)
>  {
> +	outer_flush_all();
>  	/* Disable PL310 L2 Cache controller */
>  	highbank_smc1(0x102, 0x0);
>  }
> diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/mach-highbank/pm.c
> index 04eddb4..9a5b8a7 100644
> --- a/arch/arm/mach-highbank/pm.c
> +++ b/arch/arm/mach-highbank/pm.c
> @@ -28,7 +28,6 @@
>  
>  static int highbank_suspend_finish(unsigned long val)
>  {
> -	outer_flush_all();
>  	outer_disable();
>  
>  	highbank_set_pwr_suspend();
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 5791143..3f44b16 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -163,6 +163,7 @@ void __iomem *omap4_get_l2cache_base(void)
>  
>  static void omap4_l2x0_disable(void)
>  {
> +	outer_flush_all();
>  	/* Disable PL310 L2 Cache controller */
>  	omap_smc1(0x102, 0x0);
>  }
> 

