From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 12/25] OMAP: Add support to allocate the memory for secure
 RAM
Date: Fri, 09 Sep 2011 15:13:23 +0530
Message-ID: <4E69DFBB.9020803@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-13-git-send-email-santosh.shilimkar@ti.com> <CAORVsuV8+zMzwT+PeWTo6TgWeEYfcSQdjY_kv4FcURohVoT=hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33533 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753406Ab1IIJnb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 05:43:31 -0400
Received: by mail-gx0-f176.google.com with SMTP id 7so1051002gxk.21
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 02:43:30 -0700 (PDT)
In-Reply-To: <CAORVsuV8+zMzwT+PeWTo6TgWeEYfcSQdjY_kv4FcURohVoT=hw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com

On Friday 09 September 2011 12:49 AM, Jean Pihet wrote:
> On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> Allocate the memory to save secure ram context which needs
>> to be done when MPU is hitting off mode.
>>
>> The ROM code expects a physical address to this memory
>> and hence use memblock APIs to reserve this memory as part
>> of .reserve() callback.
>>
>> Maximum possible size is allocated and can cater to OMAP3XXX / OMAP4XXX
>> secure RAM size requirements.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> ---
>>   arch/arm/mach-omap2/include/mach/omap-secure.h |    4 +++
>>   arch/arm/mach-omap2/omap-secure.c              |   29 ++++++++++++++++++++++++
>>   arch/arm/plat-omap/common.c                    |    3 ++
>>   3 files changed, 36 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h b/arch/arm/mach-omap2/include/mach/omap-secure.h
>> index 26e7bcc..e2f95a0 100644
>> --- a/arch/arm/mach-omap2/include/mach/omap-secure.h
>> +++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
>> @@ -26,6 +26,8 @@
>>   #define FLAG_FIQ_ENABLE                        0x1
>>   #define NO_FLAG                                0x0
>>
>> +/* Maximum Secure memory storage size */
>> +#define OMAP_SECURE_RAM_STORAGE        (88 * SZ_1K)
> Is this valid for all supported devices? How to differentiate
> variations in the size for new chips variants in the future?
>
You don't have to. ROM code does that job. We should just ensure
that maximum needed memory is made available to secure code.

Regards
Santosh
