From: Kim Kyuwon <q1.kim@samsung.com>
Subject: Re: [PATCH 01/13] Revert
 "ARM: OMAP: Mask interrupts when disabling interrupts, v2"
Date: Fri, 22 May 2009 08:38:01 +0900
Message-ID: <4A15E5D9.7090704@samsung.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49484 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbZEUXiC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2009 19:38:02 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KK000NHBPND0I@mailout1.samsung.com> for
 linux-omap@vger.kernel.org; Fri, 22 May 2009 08:38:02 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KK000EQXPNDJ5@mmp1.samsung.com> for
 linux-omap@vger.kernel.org; Fri, 22 May 2009 08:38:01 +0900 (KST)
In-reply-to: <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Kevin Hilman wrote:
> This reverts commit 5461af5af5c6a7fee78978aafe720541bf3a2f55.
> 
> Adding a disable hook to the irq_chip is not the way to fix the
> problem being addressed by this patch.  Instead, we need to fix
> support for [enable|disable]_irq_wake().

Agree with you if we can use disable_irq_wake for MPU Interrupt with not 
masking the IRQ. Can you explain how we can fix support for 
disable_irq_wake() for omap_irq_chip?

> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/irq.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 998c5c4..08a3b99 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -134,7 +134,6 @@ static struct irq_chip omap_irq_chip = {
>  	.ack	= omap_mask_ack_irq,
>  	.mask	= omap_mask_irq,
>  	.unmask	= omap_unmask_irq,
> -	.disable = omap_mask_irq,
>  };
>  
>  static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
