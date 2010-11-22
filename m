From: <ext-madhusudhan.1.gowda@nokia.com>
Subject: RE: [PATCH v2] OMAP3: PM: PRCM interrupt: Fix warning "MPU wakeup
 but no wakeup sources"
Date: Mon, 22 Nov 2010 11:26:25 +0100
Message-ID: <090FE800A758CA439B2752C082AC3DEF0666E2AB0C@NOK-EUMSG-06.mgdnok.nokia.com>
References: <1290175355-32444-1-git-send-email-ext-madhusudhan.1.gowda@nokia.com>,<8739qxe0dz.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:16563 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911Ab0KVK1B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 05:27:01 -0500
In-Reply-To: <8739qxe0dz.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, t-petazzoni@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Hi Thomas / Kevin,

I did verify Thomas Petazzoni's patch -   [PATCH] omap: prcm: switch to a chained IRQ handler mechanism, and I have below questions or comments.

1. I see for each WKUP_ST or IO_ST interrupt the _prcm_int_handle_wakeup handler is getting called 2 times which impacts on performance.
printk("irq:%d,%d\n",irq,c); just before returning from the handler shows. 
[  221.966308] irq wkst:377,2 
[  221.968597] irq wkst:377,0

I see, the code checking the below warning  is removed, won't it be good to retain this check ?
 WARN(c == 0, "prcm: WARNING: PRCM indicated "
               "MPU wakeup but no wakeup sources "
               "are marked\n");

Also need to address the corner case issue,  for which I submitted the patch fix.
[  222.002563] irq wkst:368,3 
[  222.004913] irq iost:377,0 

Regards
Gowda

________________________________________
From: ext Kevin Hilman [khilman@deeprootsystems.com]
Sent: Friday, November 19, 2010 6:36 PM
To: Gowda Madhusudhan.1 (EXT-Elektrobit/Helsinki)
Cc: linux-omap@vger.kernel.org; paul@pwsan.com
Subject: Re: [PATCH v2] OMAP3: PM: PRCM interrupt: Fix warning "MPU wakeup but no wakeup sources"

Madhusudhan Gowda <ext-madhusudhan.1.gowda@nokia.com> writes:

> A corner case where prcm_interrupt handler is handling the WKST_WKUP and
> before acknowledging the wakeup sources if an IO Pad wakeup ST_IO is
> indicated then hits the below warning since the wakeup sources are already
> cleared.
>       WARN(c == 0, "prcm: WARNING: PRCM indicated "
>               "MPU wakeup but no wakeup sources "
>               "are marked\n");
>
> Since the above warning condition is only valid if the prcm_interrupt
> handler is called but no wakeup sources are marked in first iteration.
>
> The patch fixes this corner case.
>
> Updated after Paul Walmsley's "only handle selected PRCM interrupts" patch.

Can you have a look at the recent work by Thomas Petazzoni:

    [PATCH] omap: prcm: switch to a chained IRQ handler mechanism

where the PRCM IRQ handler is broken up to see if this problem still
exists?  I suspect the problem is gone as each type of interrupt is
separated out, but should be verified.

Kevin

>
> Signed-off-by: Madhusudhan Gowda <ext-madhusudhan.1.gowda@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 75c0cd1..2ed3662 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -266,6 +266,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  {
>       u32 irqenable_mpu, irqstatus_mpu;
>       int c = 0;
> +     int ct = 0;
>
>       irqenable_mpu = prm_read_mod_reg(OCP_MOD,
>                                        OMAP3_PRM_IRQENABLE_MPU_OFFSET);
> @@ -277,13 +278,15 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>               if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
>                                    OMAP3430_IO_ST_MASK)) {
>                       c = _prcm_int_handle_wakeup();
> +                     ct++;
>
>                       /*
>                        * Is the MPU PRCM interrupt handler racing with the
>                        * IVA2 PRCM interrupt handler ?
>                        */
> -                     WARN(c == 0, "prcm: WARNING: PRCM indicated MPU wakeup "
> -                          "but no wakeup sources are marked\n");
> +                     WARN(!c && (ct == 1), "prcm: WARNING: PRCM indicated "
> +                                     "MPU wakeup but no wakeup sources "
> +                                     "are marked\n");
>               } else {
>                       /* XXX we need to expand our PRCM interrupt handler */
>                       WARN(1, "prcm: WARNING: PRCM interrupt received, but "
