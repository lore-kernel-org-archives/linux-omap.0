From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 00/11] OMAP: DMA: HWMOD and DMA as platform driver
Date: Fri, 03 Sep 2010 18:39:54 +0200
Message-ID: <4C8124DA.3030700@ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402781CE908@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40186 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755511Ab0ICQkA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Sep 2010 12:40:00 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402781CE908@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Sawant, Anand" <sawant@ti.com>

Hi Manjunath,

On 9/3/2010 6:21 PM, G, Manjunath Kondaiah wrote:
> Kevin,
> If there are no further comments, can you please stage this patch
> series on hwmods-omap4 branch?

I just have few minor comments:
Could you please keep the original credit for this patch:
OMAP4: DMA: HWMOD: Add hwmod data structures

You can change as well the subject as suggested by Kevin for all the 
hwmod data patches with: OMAPX: hwmod data: Add system DMA

And quoting Kevin again "hwmod should not be capitalized, as it's not an 
acronym."

Thanks,
Benoit


> It applies cleanly on current commit(669d24d412380528158ba5d15522c9858f4b81a2).
>
> -Manjunath
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of G,
>> Manjunath Kondaiah
>> Sent: Tuesday, August 24, 2010 4:34 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Cousson, Benoit; Kevin Hilman; Shilimkar, Santosh
>> Subject: [PATCH v2 00/11] OMAP: DMA: HWMOD and DMA as platform driver
>>
>> This patch series has review comments incorporated which are received
>> for v1 version.
>> The review comments can be found at:
>> http://www.spinics.net/lists/linux-omap/msg34291.html
>> http://www.spinics.net/lists/linux-omap/msg34292.html
>> http://www.spinics.net/lists/linux-omap/msg34078.html
>> http://www.spinics.net/lists/linux-omap/msg34083.html
>>
>> These changes are tested on following boards:
>> - Zoom3     (OMAP3630)
>> - Beagle    (OMAP3530)
>> - OMAP4 SDP (OMAP4430)
>> I don't have omap1 and omap2 boards and appreciate if
>> some one can test these boards and provides feedback.
>>
>> Build tested for both omap1 and omap2 plus boards.
>>
>> This patch series applies on top of:
>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-om
>> ap-pm.git
>> Branch: pm-wip/hwmods-omap4
>> commit f6f7f1103b80b4dc0ace8a0314d95d1b1ebca726
>> Merge: 79d0b02 597e89c
>> Author: Kevin Hilman<khilman@ti.com>
>>
>>      Merge branch 'pm-wip/hwmods' into pm-wip/hwmods-omap4-base
>>
>> The earlier version of the patches can be found at:
>> RFC patches:
>> http://www.spinics.net/lists/linux-omap/index.html#33393
>>
>> v1 patches:
>> http://www.spinics.net/lists/linux-omap/msg34066.html
>>
>> Patch series summary:
>> =====================
>> Manjunatha GK (10):
>>    OMAP: DMA: Introduce DMA device attributes
>>    OMAP2420: DMA: HWMOD: Add hwmod data structures
>>    OMAP2430: DMA: HWMOD: Add hwmod data structures
>>    OMAP3: DMA: HWMOD: Add hwmod data structures
>>    OMAP4: DMA: HWMOD: Add hwmod data structures
>>    OMAP1: DMA: Introduce DMA driver as platform driver
>>    OMAP2/3/4: DMA: HWMOD: Device registration
>>    OMAP: DMA: Convert DMA library into DMA platform Driver
>>    OMAP: DMA: Implement generic errata handling
>>    OMAP: DMA: Use DMA device attributes
>>
>> Venkatraman S (1):
>>    sDMA: descriptor autoloading feature
>>
>>   arch/arm/mach-omap1/Makefile               |    2 +-
>>   arch/arm/mach-omap1/dma.c                  |  451 ++++++++
>>   arch/arm/mach-omap1/include/mach/dma.h     |  148 +++
>>   arch/arm/mach-omap2/Makefile               |    2 +-
>>   arch/arm/mach-omap2/dma.c                  | 1380
>> +++++++++++++++++++++++++
>>   arch/arm/mach-omap2/include/mach/dma.h     |  378 +++++++
>>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |   85 ++
>>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |   85 ++
>>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   85 ++
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   99 ++
>>   arch/arm/plat-omap/dma.c                   | 1539
>> ++++------------------------
>>   arch/arm/plat-omap/include/plat/dma.h      |  222 +---
>>   12 files changed, 2945 insertions(+), 1531 deletions(-)
>>   create mode 100644 arch/arm/mach-omap1/dma.c
>>   create mode 100644 arch/arm/mach-omap1/include/mach/dma.h
>>   create mode 100644 arch/arm/mach-omap2/dma.c
>>   create mode 100644 arch/arm/mach-omap2/include/mach/dma.h
>>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

