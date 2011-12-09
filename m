From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] arm: tools: mach-types: add nokia_rm696
Date: Fri, 9 Dec 2011 10:07:55 -0800
Message-ID: <20111209180755.GT31337@atomide.com>
References: <1323443211-3648-1-git-send-email-aaro.koskinen@nokia.com>
 <1323443211-3648-2-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60046 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab1LISH5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 13:07:57 -0500
Content-Disposition: inline
In-Reply-To: <1323443211-3648-2-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@nokia.com>

Russell,

* Aaro Koskinen <aaro.koskinen@nokia.com> [111209 06:33]:
> Add the mach-type number for RM-696.

Care to ack this one or apply into your devel-stable with the
other pending mach-types updates?

This allows board-rm680.c to support Nokia N9 with minimal changes.

Regards,

Tony
 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/tools/mach-types |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index ccbe16f..63f20da 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -1123,6 +1123,7 @@ blissc			MACH_BLISSC		BLISSC			3491
>  thales_adc		MACH_THALES_ADC		THALES_ADC		3492
>  ubisys_p9d_evp		MACH_UBISYS_P9D_EVP	UBISYS_P9D_EVP		3493
>  atdgp318		MACH_ATDGP318		ATDGP318		3494
> +nokia_rm696		MACH_NOKIA_RM696	NOKIA_RM696		3522
>  m28evk			MACH_M28EVK		M28EVK			3613
>  smdk4212		MACH_SMDK4212		SMDK4212		3638
>  smdk4412		MACH_SMDK4412		SMDK4412		3765
> -- 
> 1.7.2.5
> 
