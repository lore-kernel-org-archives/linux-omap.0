From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH 4/6] omap4: hwmod_data: Add l3 errorlog data to hwmod
 database.
Date: Fri, 4 Mar 2011 22:34:21 +0100
Message-ID: <74583B8642AB8841B30447520659FCA901F9F3BB72@dnce01.ent.ti.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
 <1298295990-1070-5-git-send-email-santosh.shilimkar@ti.com>
 <4D627937.8030309@ti.com> 43067ab756e2e48efb745dee3ecc67eb@mail.gmail.com
 <29f3552dea661223dcb96d51aa38fbb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34796 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760195Ab1CDVeS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 16:34:18 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p24LYImV011721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Mar 2011 15:34:18 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p24LYIMA020295
	for <linux-omap@vger.kernel.org>; Fri, 4 Mar 2011 15:34:18 -0600 (CST)
Content-Class: urn:content-classes:message
In-Reply-To: <29f3552dea661223dcb96d51aa38fbb5@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Sricharan" <r.sricharan@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>

Hi Sricharan,

I think you missed some of my feedbacks.

>From: R, Sricharan
>Sent: Wednesday, February 23, 2011 9:04 AM
>
>Hi Benoit,
>>From: Sricharan R [mailto:r.sricharan@ti.com]
>>Sent: Wednesday, February 23, 2011 11:09 AM
>>To: Benoit Cousson; Santosh Shilimkar
>>Cc: 'linux-omap@vger.kernel.org'; Felipe Balbi
>>Subject: RE: [PATCH 4/6] omap4: hwmod_data: Add l3 errorlog
>data to hwmod
>>database.
>>
>>Hi Benoit,
>>>
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----

>>>From: Cousson, Benoit [mailto:b-cousson@ti.com]
>>>Sent: Monday, February 21, 2011 8:10 PM
>>>To: Shilimkar, Santosh
>>>Cc: linux-omap@vger.kernel.org; Balbi, Felipe; R, Sricharan
>>>Subject: Re: [PATCH 4/6] omap4: hwmod_data: Add l3 errorlog data to
>hwmod
>>>database.
>>>
>>>Hi Sricharan,
>>>
>>>On 2/21/2011 2:46 PM, Shilimkar, Santosh wrote:
>>>> From: sricharan<r.sricharan@ti.com>
>>>>
>>>> Add the error log registers, irqs of the l3 interconnect to the
>>>> hwmod data. The hwmod change is aligned with Benoit Cousson.
>>>
>>>The change is almost aligned with Benoit Cousson :-)
>>>
>>>The subject should be something like: omap4: hwmod data: Add address
>>>space and irq in L3 hwmod
>>>
>>>There is no errolog data in that patch. The changelog should
>be updated
>>>too.
>>Ok. I will change the subject and the change log as well.
>
>Here is the updated patch as per your suggestion.
>---------------
>[PATCH v2 4/6] omap4: hwmod_data: Add address space and irq in
>L3 hwmod.
>
>Add the address spaces, irqs of the l3 interconnect to the
>hwmod data. The
>hwmod change is aligned with Benoit Cousson.
>
>Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>Signed-off-by: sricharan <r.sricharan@ti.com>
>Tested-by: sricharan <r.sricharan@ti.com>
>Cc: Benoit Cousson <b-cousson@ti.com>
>---
>changed the subject line and the changelog
>
> arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28
>++++++++++++++++++++++++++++
> 1 files changed, 28 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>index c2806bd..95001d4 100644
>--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>@@ -229,11 +229,37 @@ static struct omap_hwmod_ocp_if
>omap44xx_l4_cfg__l3_main_1 = {
>       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> };
>
>+/* L3 target configuration and error log registers */ static struct
>+omap_hwmod_irq_info omap44xx_l3_targ_irqs[] = {
>+      { .irq = 9  + OMAP44XX_IRQ_GIC_START },
>+      { .irq = 10 + OMAP44XX_IRQ_GIC_START }, };
>+
>+static struct omap_hwmod_addr_space omap44xx_l3_targ_addrs[] = {

should be named:
+static struct omap_hwmod_addr_space omap44xx_l3_main_1_addrs[] = {
+       {
+               .pa_start       = 0x44000000,
+               .pa_end         = 0x44100000,
+               .flags          = ADDR_TYPE_RT,
+       },
+};
+

And that one should be separated because it belongs to l3_main_2

+static struct omap_hwmod_addr_space omap44xx_l3_main_2_addrs[] = {
+       {
+               .pa_start       = 0x44800000,
+               .pa_end         = 0x44900000,
+               .flags          = ADDR_TYPE_RT,
+       },
+};
+

And that one should be separated as well because it belongs to l3_main_3

static struct omap_hwmod_addr_space omap44xx_l3_main_3_addrs[] = {
+       {
+               .pa_start       = 0x45000000,
+               .pa_end         = 0x45100000,
+               .flags          = ADDR_TYPE_RT,
+       },
+};
+

You should thus update omap44xx_l3_main_1__l3_main_2 and omap44xx_l3_main_1__l3_main_3 as well with the proper address space.

Regards,
Benoit

