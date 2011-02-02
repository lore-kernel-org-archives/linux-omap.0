From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/6] omap4: prcm: Fix the CPUx clockdomain offsets
Date: Tue, 01 Feb 2011 17:20:36 -0800
Message-ID: <87ipx3mduj.fsf@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
	<1296212688-21951-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38593 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020Ab1BBBUj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 20:20:39 -0500
Received: by mail-yw0-f54.google.com with SMTP id 6so2929055ywp.13
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 17:20:39 -0800 (PST)
In-Reply-To: <1296212688-21951-3-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 28 Jan 2011 16:34:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> CPU0 and CPU1 clockdomain is at the offset of 0x18 from the LPRM base.
> The header file has set it wrongly to 0x0. Offset 0x0 is for CPUx power
> domain control register
>
> Fix the same.

Has this also been updated in the autogen scripts?  

Benoit?

Kevin

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/prcm_mpu44xx.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.h b/arch/arm/mach-omap2/prcm_mpu44xx.h
> index 729a644..3300ff6 100644
> --- a/arch/arm/mach-omap2/prcm_mpu44xx.h
> +++ b/arch/arm/mach-omap2/prcm_mpu44xx.h
> @@ -38,8 +38,8 @@
>  #define OMAP4430_PRCM_MPU_CPU1_INST		0x0800
>  
>  /* PRCM_MPU clockdomain register offsets (from instance start) */
> -#define OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS	0x0000
> -#define OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS	0x0000
> +#define OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS	0x0018
> +#define OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS	0x0018
>  
>  
>  /*
