From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PRCM interrupt: only check for enabled PRCM IRQs
Date: Tue, 27 Apr 2010 08:04:23 -0700
Message-ID: <878w89rl6w.fsf@deeprootsystems.com>
References: <1272320584-14244-1-git-send-email-khilman@deeprootsystems.com>
	<4BD631D3.4000800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49955 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab0D0PE1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 11:04:27 -0400
Received: by pvg2 with SMTP id 2so1333731pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 08:04:26 -0700 (PDT)
In-Reply-To: <4BD631D3.4000800@ti.com> (Mike Turquette's message of "Mon\, 26 Apr 2010 19\:37\:39 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>, Thara Gopinath <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Mike Turquette <mturquette@ti.com> writes:

> Kevin Hilman wrote:
>> While handling PRCM IRQs, mask out interrupts that are not enabled in
>> PRM_IRQENABLE_MPU.  If these are not masked out,  non-enabled
>> interrupts are caught and a WARN() is dumped.
>>
>> This was noticed using SmartReflex transitions which cause the VPx_*
>> interrupts to be handled since they are set in PRM_IRQSTATUS_MPU even
>> but not enabled in PRM_IRQENABLE_MPU.
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> For review here, will be queued with other PM updates for 2.6.35.
>>
>>  arch/arm/mach-omap2/pm34xx.c |   15 ++++++++++-----
>>  1 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index fee2efb..63d1843 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -266,13 +266,15 @@ static int _prcm_int_handle_wakeup(void)
>>   */
>>  static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>>  {
>> -	u32 irqstatus_mpu;
>> +	u32 irqenable_mpu, irqstatus_mpu;
>>  	int c = 0;
>>  -	do {
>> -		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
>> -					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
>> +	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
>> +					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
>> +	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
>> +					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
>>  +	do {
>>  		if (irqstatus_mpu & (OMAP3430_WKUP_ST | OMAP3430_IO_ST)) {
>>  			c = _prcm_int_handle_wakeup();
>>  @@ -291,7 +293,10 @@ static irqreturn_t prcm_interrupt_handler (int
>> irq, void *dev_id)
>>  		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
>>  					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
>
> I think that this is partially correct.  Only iterating for status
> bits that correspond to enabled interrupts is correct.  However I
> think clearing all of the status bits indiscriminately is bad.
>
> The root of the problem is that status bits get set regardless of
> whether the IRQ is enabled (which defies common assumptions).  I have
> seen the exact same issue on Android after introducing ABB and I just
> stopped clearing the register altogether:
>
> http://review.omapzoom.org/#patch,sidebyside,2675,2,arch/arm/mach-omap2/pm34xx.c
>
> This turned about to be a bad idea; for instance VP1_TRANXDONE_ST and
> ABB_TRANXDONE_ST are currently polled (no interrupt is enabled).  With
> the above code it is possible to have a vpforceupdate voltage change
> or an ABB OPP change, then get interrupted, and then have the timeouts
> for the polled code fail after the interrupt is served since those
> status bits got cleared resulting in wasted poll loops and
> false-positive WARNs.  This has been observed.
>
> I think a better solution for both code bases might be,
>
> prm_write_mod_reg((irqstatus_mpu | irqenable_mpu), OCP_MOD,
> 			OMAP3_PRM_MPU_OFFSET);

Good, thanks for the review.  I was wondering about that and decided
to keep the existing behavior.  I actually meant to add an RFC for
that in the changelog, so thanks for catching that.

Looking closer at the new SmartReflex code, it's also checking that
register and polling for transaction done, so clearing the bits in the
ISR would likely cause SmartReflex to miss some of those events.

Good catch, below is an updated version.

Thara, could you try this out with your v3 smartreflex series?  You
can just test current pm-wip-sr branch which is based on a PM branch
with this change.

Kevin


commit cfabe8a950e252d26cdeb4a9bb11e2cabb2a50c6
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Mon Apr 26 14:59:09 2010 -0700

    OMAP3: PRCM interrupt: only check and clear enabled PRCM IRQs
    
    While handling PRCM IRQs, mask out interrupts that are not enabled in
    PRM_IRQENABLE_MPU.  If these are not masked out, non-enabled
    interrupts are caught, a WARN() is printed due to no 'handler' and the
    events are cleared.  In addition to being noisy, this can also
    interfere with independent polling of this register by SR/VP code.
    
    This was noticed using SmartReflex transitions which cause the VPx_*
    interrupts to be handled since they are set in PRM_IRQSTATUS_MPU even
    but not enabled in PRM_IRQENABLE_MPU.
    
    Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fee2efb..c38016b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -266,13 +266,16 @@ static int _prcm_int_handle_wakeup(void)
  */
 static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 {
-	u32 irqstatus_mpu;
+	u32 irqenable_mpu, irqstatus_mpu;
 	int c = 0;
 
-	do {
-		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
-					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
+					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
+	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	irqstatus_mpu &= irqenable_mpu;
 
+	do {
 		if (irqstatus_mpu & (OMAP3430_WKUP_ST | OMAP3430_IO_ST)) {
 			c = _prcm_int_handle_wakeup();
 
@@ -291,7 +294,11 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-	} while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET));
+		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+		irqstatus_mpu &= irqenable_mpu;
+
+	} while (irqstatus_mpu);
 
 	return IRQ_HANDLED;
 }
