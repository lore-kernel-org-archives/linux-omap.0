From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP4: SRAM: Fix warning: format '%08lx' expects type
 'long unsigned int'
Date: Mon, 04 Apr 2011 15:17:25 +0530
Message-ID: <4D9993AD.3080401@ti.com>
References: <1301907896-30954-1-git-send-email-santosh.shilimkar@ti.com> <20110404091223.GA19854@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000508000703040405000507"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:40973 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751286Ab1DDJrm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 05:47:42 -0400
Received: by mail-yx0-f182.google.com with SMTP id 31so2778964yxl.41
        for <linux-omap@vger.kernel.org>; Mon, 04 Apr 2011 02:47:40 -0700 (PDT)
In-Reply-To: <20110404091223.GA19854@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is a multi-part message in MIME format.
--------------000508000703040405000507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/2011 2:42 PM, Russell King - ARM Linux wrote:
> On Mon, Apr 04, 2011 at 02:34:56PM +0530, Santosh Shilimkar wrote:
>> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
>> index a3f50b3..7857146 100644
>> --- a/arch/arm/plat-omap/sram.c
>> +++ b/arch/arm/plat-omap/sram.c
>> @@ -166,7 +166,7 @@ static void __init omap_detect_sram(void)
>>   		else if (cpu_is_omap1611())
>>   			omap_sram_size = SZ_256K;
>>   		else {
>> -			printk(KERN_ERR "Could not detect SRAM size\n");
>> +			pr_err("Could not detect SRAM size\n");
>>   			omap_sram_size = 0x4000;
>>   		}
>>   	}
>> @@ -221,7 +221,7 @@ static void __init omap_map_sram(void)
>>   	omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
>>   	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
>>
>> -	printk(KERN_INFO "SRAM: Mapped pa 0x%08lx to va 0x%08lx size: 0x%lx\n",
>> +	pr_info("SRAM: Mapped pa 0x%08x to va 0x%08lx size: 0x%lx\n",
>>   	__pfn_to_phys(omap_sram_io_desc[0].pfn),
>>   	omap_sram_io_desc[0].virtual,
>>   	       omap_sram_io_desc[0].length);
>
> This is wrong.
>
> I guess this is a consequence of using phys_addr_t rather than explicitly
> 'unsigned long' for physical addresses, which ends up as u32, which in
> turn is 'unsigned int' not 'unsigned long'.
>
> In any case, these warnings are telling us what needs to be fixed for
> large physical addresses.  The way that we've sorted this in the generic
> ARM code is to use 0x%08llx, and casting the physical address to
> 'unsigned long long'.  That gives consistent arguments without printing
> excessive zeros at the start of an address.
Thanks for pointing out this. I see Will's commit on this
one "29a38193"
Here is the updated patch as you suggested.

 From 4d8d4e5c99c1477a8cb04b525ff5a2d93bbdacfd Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 4 Apr 2011 14:20:08 +0530
Subject: [PATCH] OMAP: SRAM: Fix warning: format '%08lx' expects type 
'long unsigned int'

Fix below build warning.

  CC	arch/arm/plat-omap/sram.o
	arch/arm/plat-omap/sram.c: In function 'omap_map_sram':
	arch/arm/plat-omap/sram.c:224: warning: format '%08lx' expects
	type 'long unsigned int', but argument 2 has type 'unsigned int'

While at this, convert SRAM printk(* "") to pr_*("").

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
  arch/arm/plat-omap/sram.c |   12 ++++++------
  1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a3f50b3..6af3d0b 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -166,7 +166,7 @@ static void __init omap_detect_sram(void)
  		else if (cpu_is_omap1611())
  			omap_sram_size = SZ_256K;
  		else {
-			printk(KERN_ERR "Could not detect SRAM size\n");
+			pr_err("Could not detect SRAM size\n");
  			omap_sram_size = 0x4000;
  		}
  	}
@@ -221,10 +221,10 @@ static void __init omap_map_sram(void)
  	omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
  	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));

-	printk(KERN_INFO "SRAM: Mapped pa 0x%08lx to va 0x%08lx size: 0x%lx\n",
-	__pfn_to_phys(omap_sram_io_desc[0].pfn),
-	omap_sram_io_desc[0].virtual,
-	       omap_sram_io_desc[0].length);
+	pr_info("SRAM: Mapped pa 0x%08llx to va 0x%08lx size: 0x%lx\n",
+		(long long) __pfn_to_phys(omap_sram_io_desc[0].pfn),
+		omap_sram_io_desc[0].virtual,
+		omap_sram_io_desc[0].length);

  	/*
  	 * Normally devicemaps_init() would flush caches and tlb after
@@ -252,7 +252,7 @@ static void __init omap_map_sram(void)
  void *omap_sram_push_address(unsigned long size)
  {
  	if (size > (omap_sram_ceil - (omap_sram_base + SRAM_BOOTLOADER_SZ))) {
-		printk(KERN_ERR "Not enough space in SRAM\n");
+		pr_err("Not enough space in SRAM\n");
  		return NULL;
  	}

-- 
1.6.0.4


--------------000508000703040405000507
Content-Type: text/plain;
 name="0001-OMAP-SRAM-Fix-warning-format-08lx-expects-type.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-OMAP-SRAM-Fix-warning-format-08lx-expects-type.patch"

>From 4d8d4e5c99c1477a8cb04b525ff5a2d93bbdacfd Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 4 Apr 2011 14:20:08 +0530
Subject: [PATCH] OMAP: SRAM: Fix warning: format '%08lx' expects type 'long unsigned int'

Fix below build warning.

 CC	arch/arm/plat-omap/sram.o
	arch/arm/plat-omap/sram.c: In function 'omap_map_sram':
	arch/arm/plat-omap/sram.c:224: warning: format '%08lx' expects
	type 'long unsigned int', but argument 2 has type 'unsigned int'

While at this, convert SRAM printk(* "") to pr_*("").

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/sram.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a3f50b3..6af3d0b 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -166,7 +166,7 @@ static void __init omap_detect_sram(void)
 		else if (cpu_is_omap1611())
 			omap_sram_size = SZ_256K;
 		else {
-			printk(KERN_ERR "Could not detect SRAM size\n");
+			pr_err("Could not detect SRAM size\n");
 			omap_sram_size = 0x4000;
 		}
 	}
@@ -221,10 +221,10 @@ static void __init omap_map_sram(void)
 	omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
 	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
 
-	printk(KERN_INFO "SRAM: Mapped pa 0x%08lx to va 0x%08lx size: 0x%lx\n",
-	__pfn_to_phys(omap_sram_io_desc[0].pfn),
-	omap_sram_io_desc[0].virtual,
-	       omap_sram_io_desc[0].length);
+	pr_info("SRAM: Mapped pa 0x%08llx to va 0x%08lx size: 0x%lx\n",
+		(long long) __pfn_to_phys(omap_sram_io_desc[0].pfn),
+		omap_sram_io_desc[0].virtual,
+		omap_sram_io_desc[0].length);
 
 	/*
 	 * Normally devicemaps_init() would flush caches and tlb after
@@ -252,7 +252,7 @@ static void __init omap_map_sram(void)
 void *omap_sram_push_address(unsigned long size)
 {
 	if (size > (omap_sram_ceil - (omap_sram_base + SRAM_BOOTLOADER_SZ))) {
-		printk(KERN_ERR "Not enough space in SRAM\n");
+		pr_err("Not enough space in SRAM\n");
 		return NULL;
 	}
 
-- 
1.6.0.4


--------------000508000703040405000507--
