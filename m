From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 04/15] OMAP: Add support for VRFB rotation engine
Date: Fri, 07 Aug 2009 11:33:53 +0300
Message-ID: <4A7BE6F1.6070308@nokia.com>
References: <1249481741-14008-1-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-2-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-3-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-4-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-5-git-send-email-tomi.valkeinen@nokia.com> <20090805143141.GI7374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57410 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757260AbZHGIfD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 04:35:03 -0400
In-Reply-To: <20090805143141.GI7374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [090805 17:19]:
>> VRFB rotation engine is a block in OMAP2/3 that offers 12 independent
>> contexts that can be used for framebuffer rotation.
>>
>> Each context has a backend area of real memory, where it stores the
>> pixels in undisclosed format. This memory is offered to users via 4
>> virtual memory areas, which see the same memory area in different
>> rotation angles (0, 90, 180 and 270 degrees).
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>> ---
>>  arch/arm/plat-omap/Kconfig             |    3 +
>>  arch/arm/plat-omap/Makefile            |    1 +
>>  arch/arm/plat-omap/include/mach/vrfb.h |   46 +++++
>>  arch/arm/plat-omap/vrfb.c              |  281 ++++++++++++++++++++++++++++++++
>>  4 files changed, 331 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/plat-omap/include/mach/vrfb.h
>>  create mode 100644 arch/arm/plat-omap/vrfb.c
>>
>> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
>> index ca06037..2d6ae55 100644
>> --- a/arch/arm/plat-omap/Kconfig
>> +++ b/arch/arm/plat-omap/Kconfig
>> @@ -186,6 +186,9 @@ config OMAP_SERIAL_WAKE
>>  config OMAP2_VRAM
>>       bool
>>
>> +config OMAP2_VRFB
>> +     bool
>> +
>>  endmenu
>>
>>  endif
>> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
>> index 0472bbe..462edf3 100644
>> --- a/arch/arm/plat-omap/Makefile
>> +++ b/arch/arm/plat-omap/Makefile
>> @@ -26,3 +26,4 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
>>  obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
>>
>>  obj-$(CONFIG_OMAP2_VRAM) += vram.o
>> +obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
> 
> Can you please place this file under drivers/video?

Ok. I still feel a common place, like plat-omap is better place for vrfb 
and vram, but I don't feel too strongly about it =). drivers/video works 
fine also.

> 
> 
>> diff --git a/arch/arm/plat-omap/include/mach/vrfb.h b/arch/arm/plat-omap/include/mach/vrfb.h
>> new file mode 100644

<snip>

>> +
>> +static inline void restore_hw_context(int ctx)
>> +{
>> +     omap_writel(vrfb_hw_context[ctx].control, SMS_ROT_CONTROL(ctx));
>> +     omap_writel(vrfb_hw_context[ctx].size, SMS_ROT_SIZE(ctx));
>> +     omap_writel(vrfb_hw_context[ctx].physical_ba, SMS_ROT_PHYSICAL_BA(ctx));
>> +}
> 
> Please use ioremap + and readl/writel instead of omap_read/write for all new code.
> 
> Otherwise we'll have harder time to reclaim more address space for kernel
> as discussed earlier on linux-omap list.

True. But I noticed that SMS registers are already mapped by sdrc.c. I 
sent a patch adding functions for manipulating SMS_ROT_* registers. I 
think that's a cleaner way than remapping them again in VRFB.

  Tomi
