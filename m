From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH RFC] OMAP2PLUS: Enable HIGHMEM
Date: Thu, 02 Jun 2011 18:51:15 +0530
Message-ID: <4DE78E4B.7030009@ti.com>
References: <1307016381-21878-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:37516 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753116Ab1FBNVZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 09:21:25 -0400
Received: by mail-yi0-f44.google.com with SMTP id 13so342338yic.3
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 06:21:19 -0700 (PDT)
In-Reply-To: <1307016381-21878-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Fixing the change log ...

On 6/2/2011 5:36 PM, Santosh Shilimkar wrote:
> HIGMEM support is kernel is quite mature now and we have boards
HIGMEM support in kernel is quite mature now and we have boards
> like ZOOM, PANDA, SDP where 1 GB memories are installed.
>
> Enable HIGMEM to make use of the additional memory.
>
> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> ---
> This won't boards which doesn't have excess memory. Tested
This won't affect boards which doesn't have excess memory. Tested
> on OMAP4430 SDP
>
>   arch/arm/mach-omap2/Kconfig |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 19d5891..25e819e 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -19,6 +19,7 @@ config ARCH_OMAP2PLUS_TYPICAL
>   	select MENELAUS if ARCH_OMAP2
>   	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
>   	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
> +	select HIGHMEM
>   	help
>   	  Compile a kernel suitable for booting most boards
>

