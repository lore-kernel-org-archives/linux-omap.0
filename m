From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/6] omap4: prcm: Fix the CPUx clockdomain offsets
Date: Thu, 3 Feb 2011 13:51:26 +0100
Message-ID: <4D4AA4CE.2020306@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>	<1296212688-21951-3-git-send-email-santosh.shilimkar@ti.com> <87ipx3mduj.fsf@ti.com> <4D4922B9.30501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55727 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1BCMvd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 07:51:33 -0500
In-Reply-To: <4D4922B9.30501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Kevin,

On 2/2/2011 10:24 AM, Cousson, Benoit wrote:
> On 2/2/2011 2:20 AM, Hilman, Kevin wrote:
>> Santosh Shilimkar<santosh.shilimkar@ti.com>   writes:
>>
>>> CPU0 and CPU1 clockdomain is at the offset of 0x18 from the LPRM base.
>>> The header file has set it wrongly to 0x0. Offset 0x0 is for CPUx power
>>> domain control register
>>>
>>> Fix the same.
>>
>> Has this also been updated in the autogen scripts?
>>
>> Benoit?
> 
> No, I didn't see any patch to update that yet.
> 
> Santosh or Rajendra,
> Did you already fix it?

I updated the scripts with Santosh fixes and found a register name issue in this file.

The fix is inlined at the end. 
Santosh will include it in a new revision of the series.

Regards,
Benoit

---
>From ea148474504429fe5ae94406ea5e39c2847c5e31 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Thu, 3 Feb 2011 12:04:03 +0100
Subject: [PATCH] OMAP4: clockdomain: Fix the CPUx domain name

The register naming convention for module control inside clock domain is: OMAPXXXX_<partition>_<clock_domain>_<module>_CDOFFS

Both CPU0 and CPU1 use MPU as module name instead of CPU0 and CPU1.

Change the name to stick to the convention.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    4 ++--
 arch/arm/mach-omap2/prcm_mpu44xx.h          |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 51920fc..db1f442 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -152,7 +152,7 @@ static struct clockdomain mpu0_44xx_clkdm = {
 	.pwrdm		  = { .name = "cpu0_pwrdm" },
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU0_INST,
-	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS,
+	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU0_CPU0_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -162,7 +162,7 @@ static struct clockdomain mpu1_44xx_clkdm = {
 	.pwrdm		  = { .name = "cpu1_pwrdm" },
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU1_INST,
-	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS,
+	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU1_CPU1_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.h b/arch/arm/mach-omap2/prcm_mpu44xx.h
index 3300ff6..d22d1b4 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.h
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.h
@@ -38,8 +38,8 @@
 #define OMAP4430_PRCM_MPU_CPU1_INST		0x0800
 
 /* PRCM_MPU clockdomain register offsets (from instance start) */
-#define OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS	0x0018
-#define OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS	0x0018
+#define OMAP4430_PRCM_MPU_CPU0_CPU0_CDOFFS	0x0018
+#define OMAP4430_PRCM_MPU_CPU1_CPU1_CDOFFS	0x0018
 
 
 /*
-- 
1.7.0.4



