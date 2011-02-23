From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 4/6] omap4: hwmod_data: Add l3 errorlog data to hwmod database.
Date: Wed, 23 Feb 2011 13:44:49 +0530
Message-ID: <1c7b14958aa88b52095ab07456f96318@mail.gmail.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
 <1298295990-1070-5-git-send-email-santosh.shilimkar@ti.com>
 <4D627937.8030309@ti.com> 43067ab756e2e48efb745dee3ecc67eb@mail.gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:32938 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754619Ab1BWIPA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 03:15:00 -0500
Received: by eyf5 with SMTP id 5so1376946eyf.29
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 00:14:52 -0800 (PST)
In-Reply-To: 43067ab756e2e48efb745dee3ecc67eb@mail.gmail.com
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi Benoit,
>-----Original Message-----
>From: Sricharan R [mailto:r.sricharan@ti.com]
>Sent: Wednesday, February 23, 2011 11:09 AM
>To: Benoit Cousson; Santosh Shilimkar
>Cc: 'linux-omap@vger.kernel.org'; Felipe Balbi
>Subject: RE: [PATCH 4/6] omap4: hwmod_data: Add l3 errorlog data to hwmod
>database.
>
>Hi Benoit,
>>-----Original Message-----
>>From: Cousson, Benoit [mailto:b-cousson@ti.com]
>>Sent: Monday, February 21, 2011 8:10 PM
>>To: Shilimkar, Santosh
>>Cc: linux-omap@vger.kernel.org; Balbi, Felipe; R, Sricharan
>>Subject: Re: [PATCH 4/6] omap4: hwmod_data: Add l3 errorlog data to
hwmod
>>database.
>>
>>Hi Sricharan,
>>
>>On 2/21/2011 2:46 PM, Shilimkar, Santosh wrote:
>>> From: sricharan<r.sricharan@ti.com>
>>>
>>> Add the error log registers, irqs of the l3 interconnect to the
>>> hwmod data. The hwmod change is aligned with Benoit Cousson.
Hi Benoit,
>>
>>The change is almost aligned with Benoit Cousson :-)
>>
>>The subject should be something like: omap4: hwmod data: Add address
>>space and irq in L3 hwmod
>>
>>There is no errolog data in that patch. The changelog should be updated
>>too.
>Ok. I will change the subject and the change log as well.
>>
Here is the updated patch as per your suggestions.

---------------------
[PATCH v2 4/6] omap4: hwmod_data: Add address space and irq in L3 hwmod.

Add the address spaces, irqs of the l3 interconnect to the
hwmod data. The hwmod change is aligned with Benoit Cousson.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: sricharan <r.sricharan@ti.com>
Tested-by: sricharan <r.sricharan@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
changed the subject line and the changelog

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28
++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index c2806bd..95001d4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -229,11 +229,37 @@ static struct omap_hwmod_ocp_if
omap44xx_l4_cfg__l3_main_1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };

+/* L3 target configuration and error log registers */
+static struct omap_hwmod_irq_info omap44xx_l3_targ_irqs[] = {
+	{ .irq = 9  + OMAP44XX_IRQ_GIC_START },
+	{ .irq = 10 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_l3_targ_addrs[] = {
+	{
+		.pa_start	= 0x44000000,
+		.pa_end 	= 0x44100000,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{
+		.pa_start	= 0x44800000,
+		.pa_end		= 0x44900000,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{
+		.pa_start	= 0x45000000,
+		.pa_end		= 0x45100000,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
 /* mpu -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {
 	.master		= &omap44xx_mpu_hwmod,
 	.slave		= &omap44xx_l3_main_1_hwmod,
 	.clk		= "l3_div_ck",
+	.addr		= omap44xx_l3_targ_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_l3_targ_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };

@@ -248,6 +274,8 @@ static struct omap_hwmod_ocp_if
*omap44xx_l3_main_1_slaves[] = {
 static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.name		= "l3_main_1",
 	.class		= &omap44xx_l3_hwmod_class,
+	.mpu_irqs	= omap44xx_l3_targ_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_l3_targ_irqs),
 	.slaves		= omap44xx_l3_main_1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-- 
1.7.0.4
