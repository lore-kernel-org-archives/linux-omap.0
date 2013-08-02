From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1
 CPU devices
Date: Fri, 02 Aug 2013 15:45:36 +0100
Message-ID: <51FBC610.9030900@arm.com>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54567 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab3HBOpk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Aug 2013 10:45:40 -0400
In-Reply-To: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Sudeep.KarkadaNagesha@arm.com

On 01/08/13 19:17, Santosh Shilimkar wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> The generic code is well equipped to differentiate between
> SMP and UP configurations.However, there are some devices which
> use Cortex-A9 MP core IP with 1 CPU as configuration. To let
> these SOCs to co-exist in a CONFIG_SMP=y build by leveraging
> the SMP_ON_UP support, we need to additionally check the
> number the cores in Cortex-A9 MPCore configuration. Without
> such a check in place, the startup code tries to execute
> ALT_SMP() set of instructions which lead to CPU faults.
> 
> The issue was spotted on TI's Aegis device and this patch
> makes now the device work with omap2plus_defconfig which
> enables SMP by default. The change is kept limited to only
> Cortex-A9 MPCore detection code.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> 
> Acked-by: Sricharan R <r.sricharan@ti.com>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/kernel/head.S |   18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 9cf6063..4924b11 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -486,7 +486,23 @@ __fixup_smp:
>  	mrc	p15, 0, r0, c0, c0, 5	@ read MPIDR
>  	and	r0, r0, #0xc0000000	@ multiprocessing extensions and
>  	teq	r0, #0x80000000		@ not part of a uniprocessor system?
> -	moveq	pc, lr			@ yes, assume SMP
> +	bne    __fixup_smp_on_up	@ no, assume UP
> +
> +	@ Core indicates it is SMP.  Check for Aegis SOC where a single
> +	@ Cortex-A9 CPU is present but SMP operations fault.
> +	mov	r4, #0x41000000
> +	orr	r4, r4, #0x0000c000
> +	orr	r4, r4, #0x00000090
> +	teq	r3, r4			@ Check for ARM Cortex-A9
> +	movne	pc, lr			@ Not ARM Cortex-A9,
> +
> +	mrc	p15, 4, r0, c15, c0	@ get SCU base address
Correct me if I am interpreting this wrong, but CRn=15 here which is
IMPLEMENTATION DEFINED registers.

If not, then I wonder why few platform have to read SCU base from DT or
some header, why not this way ?

Regards,
Sudeep


