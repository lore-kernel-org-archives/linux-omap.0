From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] arm: arm: fiq: fix build breakage with CONFIG_FIQ
Date: Wed, 17 Sep 2014 16:29:03 -0700
Message-ID: <541A193F.2060503@linaro.org>
References: <1410984101-16762-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37968 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbaIQX3H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 19:29:07 -0400
Received: by mail-pd0-f171.google.com with SMTP id p10so110267pdj.2
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2014 16:29:06 -0700 (PDT)
In-Reply-To: <1410984101-16762-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Russell King <linux@arm.linux.org.uk>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Nicolas Pitre <nico@linaro.org>

On 17/09/14 13:01, Felipe Balbi wrote:
> commit e1add97 (ARM: 8150/2: fiq: Replace default FIQ handler)
> has a typo which causes build breakage whenever CONFIG_FIQ is
> set.
> 
> The bug is very clear as can be noted that a new struct pt_regs
> def_fiq_regs was defined but code uses dfl_fiq_regs.

Quite so. My fault.

This error was picked up by Olof's autobuilder and I have offered
a fix as 8150/3 (posted to mailing list in this thread
http://thread.gmane.org/gmane.linux.kernel/1789554 ).

Your fix and mine are slightly different (I standardised on
dfl_fiq_regs) but both approaches should be functionally identical.


Daniel.


> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Fixes: e1add97 (ARM: 8150/2: fiq: Replace default FIQ handler)
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> KernelVersion: next-20140917
> 
> Russell, let me know if this is the correct KernelVersion tag you want/need
> 
>  arch/arm/kernel/fiq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
> index 1743049..b6ab4c7 100644
> --- a/arch/arm/kernel/fiq.c
> +++ b/arch/arm/kernel/fiq.c
> @@ -64,7 +64,7 @@ static int fiq_def_op(void *ref, int relinquish)
>  	if (!relinquish) {
>  		/* Restore default handler and registers */
>  		local_fiq_disable();
> -		set_fiq_regs(&dfl_fiq_regs);
> +		set_fiq_regs(&def_fiq_regs);
>  		set_fiq_handler(&no_fiq_insn, sizeof(no_fiq_insn));
>  		local_fiq_enable();
>  
> @@ -159,6 +159,6 @@ void __init init_FIQ(int start)
>  {
>  	unsigned offset = FIQ_OFFSET;
>  	no_fiq_insn = *(unsigned long *)(0xffff0000 + offset);
> -	get_fiq_regs(&dfl_fiq_regs);
> +	get_fiq_regs(&def_fiq_regs);
>  	fiq_start = start;
>  }
> 

