From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/2] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
Date: Fri, 10 Dec 2010 11:17:09 +0530
Message-ID: <2bccf49434b4a89a3f5493bdf83d728c@mail.gmail.com>
References: <1291895982-4775-1-git-send-email-dave.martin@linaro.org> <1291895982-4775-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:34282 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751016Ab0LJFrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 00:47:11 -0500
Received: by pwi4 with SMTP id 4so994816pwi.37
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 21:47:10 -0800 (PST)
In-Reply-To: <1291895982-4775-2-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin@linaro.org]
> Sent: Thursday, December 09, 2010 5:30 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Dave Martin; Santosh Shilimkar; linux-omap@vger.kernel.org
> Subject: [PATCH 1/2] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend
> on !CPU_V6
>
> This makes sense, because Thumb-2 code can't execute on plain
> ARMv6 processors.
>
> This will avoid accidentally configuring a broken kernel where the
> config otherwise would allow multiple architecture versions to
> coexist in the same kernel.
>
> Not adding !CPU_V5 etc., because the chance of anyone trying to
> put v5 and v7 in the same kernel is low, and I'm not aware of
> any mach which can do this.  These could be added later if it
> matters.
>
> Note that the rules may need to be refined if support for the
> ARM1156J(F)-S processor is later added to the kernel, since this
> processor supports the rare ARMv6T2 extensions, which add support
> for Thumb-2 and a few other ARMv7 features.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
If you like,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index db524e7..f9ca7f3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1311,7 +1311,7 @@ config HZ
>
>  config THUMB2_KERNEL
>  	bool "Compile the kernel in Thumb-2 mode"
> -	depends on CPU_V7 && EXPERIMENTAL
> +	depends on CPU_V7 && !CPU_V6 && EXPERIMENTAL
>  	select AEABI
>  	select ARM_ASM_UNIFIED
>  	help
> --
> 1.7.1
