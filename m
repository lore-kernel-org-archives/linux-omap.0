From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1
 CPU devices
Date: Tue, 24 Sep 2013 13:43:53 -0400
Message-ID: <5241CF59.3000006@ti.com>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com> <51FBC610.9030900@arm.com> <51FBCEC3.4030207@ti.com> <51FBD42A.9040901@arm.com> <20130802154857.GD5292@mudshark.cambridge.arm.com> <52092AA5.3090005@ti.com> <20130813111943.GE30280@mudshark.cambridge.arm.com> <520A3518.3030301@ti.com> <20130924170849.GC32220@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46744 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522Ab3IXRo1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Sep 2013 13:44:27 -0400
In-Reply-To: <20130924170849.GC32220@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On Tuesday 24 September 2013 01:08 PM, Will Deacon wrote:
> Hi Santosh,
> 
> On Tue, Aug 13, 2013 at 02:31:04PM +0100, Santosh Shilimkar wrote:
>> On Tuesday 13 August 2013 07:19 AM, Will Deacon wrote:
>>> On Mon, Aug 12, 2013 at 07:34:13PM +0100, Santosh Shilimkar wrote:
>>>> On Friday 02 August 2013 11:48 AM, Will Deacon wrote:
>>>>> I think this an A9-specific register, which reads as 0 on UP A9 and reads as
>>>>> some form of PERIPH_BASE for SMP parts. The issue I have is when PERIPH_BASE
>>>>> is zero.
>>>>>
>>>> What do we do here ? Should we document this in the code and proceed ?
>>>> Mostly there is no platform with PERIPH_BASE = 0, so its should be fine but
>>>> I am open for any other alternative.
>>>
>>> The only other alternative I can think of is forcing people to have
>>> CONFIG_SMP=n, but that blows away single zImage for your platform.
>>>
>> Yep which surely we don't want considering after so much effort we
>> have it working first place. How about going ahead with assumption
>> that PERIPH_BASE = 0 case doesn't work.
> 
> It's been over a month and I can't think of anything better than this
> without jeopardising the single zImage effort. However, it also doesn't seem
> fair if we rule out the possibility of single zImage for future SoCs which
> use 0x0 as their PERIPH_BASE (I don't know of any at the moment).
> 
> So how about we go ahead with this, but add a big fat comment to the code in
> head.S saying that, if a future SoC *does* use 0x0 as the PERIPH_BASE, then
> the check will need to be #ifdef'd or equivalent for the Aegis platform?
> 
I agree. Updated patch end of the email. If you are fine with this version,
will stick it into RMK's patch system.

Regards,
Santosh

>From 05b1b43324f3e8d10a38f78dbcbf7632d4c3530c Mon Sep 17 00:00:00 2001
From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Date: Thu, 18 Jul 2013 13:01:53 -0400
Subject: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1 CPU
 devices

The generic code is well equipped to differentiate between
SMP and UP configurations.However, there are some devices which
use Cortex-A9 MP core IP with 1 CPU as configuration. To let
these SOCs to co-exist in a CONFIG_SMP=y build by leveraging
the SMP_ON_UP support, we need to additionally check the
number the cores in Cortex-A9 MPCore configuration. Without
such a check in place, the startup code tries to execute
ALT_SMP() set of instructions which lead to CPU faults.

The issue was spotted on TI's Aegis device and this patch
makes now the device work with omap2plus_defconfig which
enables SMP by default. The change is kept limited to only
Cortex-A9 MPCore detection code.

Note that if any future SoC *does* use 0x0 as the PERIPH_BASE, then
the SCU address check code needs to be #ifdef'd for for the Aegis
platform.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/kernel/head.S |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 2c7cc1e..476de57 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -487,7 +487,26 @@ __fixup_smp:
 	mrc	p15, 0, r0, c0, c0, 5	@ read MPIDR
 	and	r0, r0, #0xc0000000	@ multiprocessing extensions and
 	teq	r0, #0x80000000		@ not part of a uniprocessor system?
-	moveq	pc, lr			@ yes, assume SMP
+	bne    __fixup_smp_on_up	@ no, assume UP
+
+	@ Core indicates it is SMP. Check for Aegis SOC where a single
+	@ Cortex-A9 CPU is present but SMP operations fault.
+	mov	r4, #0x41000000
+	orr	r4, r4, #0x0000c000
+	orr	r4, r4, #0x00000090
+	teq	r3, r4			@ Check for ARM Cortex-A9
+	movne	pc, lr			@ Not ARM Cortex-A9,
+
+	@ If a future SoC *does* use 0x0 as the PERIPH_BASE, then the
+	@ below address check will need to be #ifdef'd or equivalent
+	@ for the Aegis platform.
+	mrc	p15, 4, r0, c15, c0	@ get SCU base address
+	teq	r0, #0x0		@ '0' on actual UP A9 hardware
+	beq	__fixup_smp_on_up	@ So its an A9 UP
+	ldr	r0, [r0, #4]		@ read SCU Config
+	and	r0, r0, #0x3		@ number of CPUs
+	teq	r0, #0x0		@ is 1?
+	movne	pc, lr
 
 __fixup_smp_on_up:
 	adr	r0, 1f
-- 
1.7.9.5






