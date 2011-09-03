From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 08/11] ARM: pm: no need to save/restore context ID register
Date: Sat, 03 Sep 2011 22:03:00 +0530
Message-ID: <4E6256BC.3080604@ti.com>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk> <E1Qz6jT-00078d-LC@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:35944 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752573Ab1ICQdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Sep 2011 12:33:10 -0400
Received: by yxi11 with SMTP id 11so2976294yxi.25
        for <linux-omap@vger.kernel.org>; Sat, 03 Sep 2011 09:33:08 -0700 (PDT)
In-Reply-To: <E1Qz6jT-00078d-LC@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 01 September 2011 06:20 PM, Russell King - ARM Linux wrote:
> There is no need to save and restore the context ID register on ARMv6
> and ARMv7 with a temporary page table as we write the context ID
> register when we switch back to the real page tables for the thread.
>
> Moreover, the temporary page tables do not contain any non-global
> mappings, so the context ID value should not be used.  To be safe,
> initialize the register to a reserved context ID value.
>
> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/mm/proc-v6.S |   33 ++++++++++++++++-----------------
>   arch/arm/mm/proc-v7.S |   13 ++++++-------
>   2 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
> index 2e27b46..a92c3c3 100644
> --- a/arch/arm/mm/proc-v6.S
> +++ b/arch/arm/mm/proc-v6.S
> @@ -128,19 +128,18 @@ ENTRY(cpu_v6_set_pte_ext)
>
>   /* Suspend/resume support: taken from arch/arm/mach-s3c64xx/sleep.S */
>   .globl	cpu_v6_suspend_size
> -.equ	cpu_v6_suspend_size, 4 * 7
> +.equ	cpu_v6_suspend_size, 4 * 6
>   #ifdef CONFIG_PM_SLEEP
>   ENTRY(cpu_v6_do_suspend)
> -	stmfd	sp!, {r4 - r10, lr}
> +	stmfd	sp!, {r4 - r9, lr}
>   	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
> -	mrc	p15, 0, r5, c13, c0, 1	@ Context ID
> -	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
> -	mrc	p15, 0, r7, c2, c0, 1	@ Translation table base 1
> -	mrc	p15, 0, r8, c1, c0, 1	@ auxiliary control register
> -	mrc	p15, 0, r9, c1, c0, 2	@ co-processor access control
> -	mrc	p15, 0, r10, c1, c0, 0	@ control register
> -	stmia	r0, {r4 - r10}
> -	ldmfd	sp!, {r4- r10, pc}
> +	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
> +	mrc	p15, 0, r6, c2, c0, 1	@ Translation table base 1
> +	mrc	p15, 0, r7, c1, c0, 1	@ auxiliary control register
> +	mrc	p15, 0, r8, c1, c0, 2	@ co-processor access control
> +	mrc	p15, 0, r9, c1, c0, 0	@ control register
> +	stmia	r0, {r4 - r9}
> +	ldmfd	sp!, {r4- r9, pc}
>   ENDPROC(cpu_v6_do_suspend)
>
>   ENTRY(cpu_v6_do_resume)
> @@ -149,19 +148,19 @@ ENTRY(cpu_v6_do_resume)
>   	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
>   	mcr	p15, 0, ip, c7, c15, 0	@ clean+invalidate cache
>   	mcr	p15, 0, ip, c7, c10, 4	@ drain write buffer
> -	ldmia	r0, {r4 - r10}
> +	mcr	p15, 0, ip, c13, 0, 1	@ set reserved context ID
Typo which results in build error.
Error: co-processor register expected -- `mcr p15,0,ip,c13,0,1'

You can fold below fix.

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 53bba9d..b3455c1 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -148,7 +148,7 @@ ENTRY(cpu_v6_do_resume)
  	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
  	mcr	p15, 0, ip, c7, c15, 0	@ clean+invalidate cache
  	mcr	p15, 0, ip, c7, c10, 4	@ drain write buffer
-	mcr	p15, 0, ip, c13, 0, 1	@ set reserved context ID
+	mcr	p15, 0, ip, c13, c0, 1	@ set reserved context ID
  	ldmia	r0, {r4 - r9}
  	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
  	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
-- 
1.7.4.1

Regards
Santosh
