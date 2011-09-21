From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 8/8] OMAP4: Fix the emif and dmm virtual mapping
Date: Wed, 21 Sep 2011 20:58:18 +0530
Message-ID: <4E7A0292.4020408@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>	<1315459327-3285-9-git-send-email-santosh.shilimkar@ti.com> <87r53gnzfh.fsf@ti.com> <4E78AAD5.6010906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:48634 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485Ab1IUP2Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Sep 2011 11:28:24 -0400
Received: by mail-gy0-f179.google.com with SMTP id 4so1603937gyg.24
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 08:28:22 -0700 (PDT)
In-Reply-To: <4E78AAD5.6010906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Girish S G <girishsg@ti.com>

On Tuesday 20 September 2011 08:31 PM, Santosh Shilimkar wrote:
> On Friday 16 September 2011 11:26 PM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>

[...]

> 
>>>  #define OMAP44XX_EMIF2_SIZE	SZ_1M
>>>  
>>>  #define OMAP44XX_DMM_PHYS	OMAP44XX_DMM_BASE
>>>  						/* 0x4e000000 --> 0xfd300000 */
>>> -#define OMAP44XX_DMM_VIRT	(OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
>>> +#define OMAP44XX_DMM_VIRT	(OMAP44XX_EMIF2_VIRT + SZ_1M)
>>
>> and '+ OMAP44XX_EMIF2_SIZE' here.
>>
> Will add OMAP44XX_EMIF_SIZE since 2 EMIFs instaces are and
> suppose to be identical.Almost missed this email in other traffic.

OPPs. It was already there. Dumb of me not using it. Below
is the update what I will do.

diff --git a/arch/arm/plat-omap/include/plat/io.h
b/arch/arm/plat-omap/include/plat/io.h
index d72ec85..db36292 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -228,13 +228,13 @@

 #define OMAP44XX_EMIF2_PHYS	OMAP44XX_EMIF2_BASE
 						/* 0x4d000000 --> 0xfd200000 */
-#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF2_PHYS + OMAP4_L3_PER_IO_OFFSET)
 #define OMAP44XX_EMIF2_SIZE	SZ_1M
+#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF1_VIRT + OMAP44XX_EMIF2_SIZE)

 #define OMAP44XX_DMM_PHYS	OMAP44XX_DMM_BASE
 						/* 0x4e000000 --> 0xfd300000 */
-#define OMAP44XX_DMM_VIRT	(OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
 #define OMAP44XX_DMM_SIZE	SZ_1M
+#define OMAP44XX_DMM_VIRT	(OMAP44XX_EMIF2_VIRT + OMAP44XX_DMM_SIZE)
 /*
  *
----------------------------------------------------------------------------
  * Omap specific register access
-- 
1.7.4.1

