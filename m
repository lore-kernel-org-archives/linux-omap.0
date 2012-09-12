From: Cyril Chemparathy <cyril@ti.com>
Subject: Re: [RFC PATCH] ARM: mm: ADD descriptor string to CONFIG_DMA_ADDR_64BIT_T
Date: Wed, 12 Sep 2012 08:46:18 -0400
Message-ID: <5050841A.7030203@ti.com>
References: <1347429006-10879-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34231 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757883Ab2ILMqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 08:46:25 -0400
In-Reply-To: <1347429006-10879-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, Catalin Marinas <catalin.marinas@arm.com>

On 9/12/2012 1:50 AM, R Sricharan wrote:
> Even if CONFIG_DMA_ADDR_64BIT_T is enabled by the defconfig,
> the feature is not getting selected.
> Adding a string description in the Kconfig resolves this.
>
> But not sure if this is the right way to fix this.
>

Shouldn't you be selecting this in your 64-bit dma address capable arch 
instead?

> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>   arch/arm/mm/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 101b968..90c5ea4 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -601,7 +601,7 @@ config ARCH_PHYS_ADDR_T_64BIT
>   	def_bool ARM_LPAE
>
>   config ARCH_DMA_ADDR_T_64BIT
> -	bool
> +	bool "64bit capable DMA device"
>
>   config ARM_THUMB
>   	bool "Support Thumb user binaries"
>

-- 
Thanks
- Cyril
