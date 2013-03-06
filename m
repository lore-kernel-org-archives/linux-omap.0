From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Wed, 6 Mar 2013 12:01:28 -0600
Message-ID: <51378478.4050504@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com> <1361899842-30303-12-git-send-email-jon-hunter@ti.com> <51360271.1030302@mimc.co.uk> <51360562.20309@ti.com> <51361B46.507@mimc.co.uk> <51362BAB.10403@ti.com> <513664EC.2050508@ti.com> <5137192E.1010101@mimc.co.uk> <513744F4.7050503@mimc.co.uk> <5137726D.10702@ti.com> <5137736B.9050501@mimc.co.uk> <5137762C.6090300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55593 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab3CFSBn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Mar 2013 13:01:43 -0500
In-Reply-To: <5137762C.6090300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 03/06/2013 11:00 AM, Jon Hunter wrote:
> 
> On 03/06/2013 10:48 AM, Mark Jackson wrote:
>> On 06/03/13 16:44, Jon Hunter wrote:
>>>
>>> On 03/06/2013 07:30 AM, Mark Jackson wrote:
>>>> On 06/03/13 10:23, Mark Jackson wrote:
>>
>> <snip>
>>
>>>>> [    1.541884] gpmc_probe_nor_child 1
>>>>> [    1.545483] GPMC_CS_CONFIG7_0 : 00000f48
>>>>> [    1.549621] GPMC_CS_CONFIG7_1 : 00000f58
>>>>> [    1.553812] GPMC_CS_CONFIG7_2 : 00000f00
>>>>> [    1.557951] GPMC_CS_CONFIG7_3 : 00000c5a
>>>>
>>>> 0x00000c5a is an invalid mode !!
>>>>
>>>> I'm trying to use a 64MB address space but not on a 64MB boundary ... oops.
>>>
>>> Good catch. So this is now working for you then?
>>
>> Not yet ... I got distracted by something else !?!
>>
>> I'll take another look tomorrow.
>>
>> Do you think it might be worth adding some sanity checking to the cs config
>> routines to trap similar errors ?
> 
> Yes, I see what you mean. We should check to ensure that the the base is
> aligned on a boundary that matches the size being configured.
> 
> I can add some checking for this case.

How about something like ...

Cheers
Jon

>From 4d6396ef49e34b06085a4036b795ab6faf29509c Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Wed, 6 Mar 2013 12:00:10 -0600
Subject: [PATCH] ARM: OMAP2+: Detect incorrectly aligned GPMC base address

---
 arch/arm/mach-omap2/gpmc.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 8e6f019..aeef0a2 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -410,11 +410,18 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	return 0;
 }
 
-static void gpmc_cs_enable_mem(int cs, u32 base, u32 size)
+static int gpmc_cs_enable_mem(int cs, u32 base, u32 size)
 {
 	u32 l;
 	u32 mask;
 
+	/*
+	 * Ensure that base address is aligned
+	 * on a boundary greater than size.
+	 */
+	if (base & (size - 1))
+		return -EINVAL;
+
 	mask = (1 << GPMC_SECTION_SHIFT) - size;
 	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
 	l &= ~0x3f;
@@ -423,6 +430,8 @@ static void gpmc_cs_enable_mem(int cs, u32 base, u32 size)
 	l |= ((mask >> GPMC_CHUNK_SHIFT) & 0x0f) << 8;
 	l |= GPMC_CONFIG7_CSVALID;
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG7, l);
+
+	return 0;
 }
 
 static void gpmc_cs_disable_mem(int cs)
@@ -541,7 +550,9 @@ static int gpmc_cs_remap(int cs, u32 base)
 	ret = gpmc_cs_insert_mem(cs, base, size);
 	if (IS_ERR_VALUE(ret))
 		return ret;
-	gpmc_cs_enable_mem(cs, base, size);
+	ret = gpmc_cs_enable_mem(cs, base, size);
+	if (IS_ERR_VALUE(ret))
+		return ret;
 
 	return 0;
 }
@@ -571,7 +582,12 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	if (r < 0)
 		goto out;
 
-	gpmc_cs_enable_mem(cs, res->start, resource_size(res));
+	r = gpmc_cs_enable_mem(cs, res->start, resource_size(res));
+	if (IS_ERR_VALUE(r)) {
+		release_resource(res);
+		goto out;
+	}
+
 	*base = res->start;
 	gpmc_cs_set_reserved(cs, 1);
 out:
-- 
1.7.10.4

