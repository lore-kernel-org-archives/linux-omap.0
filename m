From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 08/13] ARM: OMAP5: Add the WakeupGen IP updates.
Date: Thu, 10 May 2012 17:22:28 +0530
Message-ID: <4FABABFC.4090903@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com> <1336029982-31898-9-git-send-email-r.sricharan@ti.com> <4FABA84A.9000507@ti.com> <CAMQu2gz4vw_jibsjSN_a-xAzp3Uthhvx2V=Y7KB5uO3q+N+WuQ@mail.gmail.com> <4FABAB05.4010906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47179 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757736Ab2EJLwg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 07:52:36 -0400
Received: by obbtb18 with SMTP id tb18so2334671obb.33
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 04:52:35 -0700 (PDT)
In-Reply-To: <4FABAB05.4010906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, b-cousson@ti.com

On Thursday 10 May 2012 05:18 PM, Roger Quadros wrote:
> On 05/10/2012 02:42 PM, Shilimkar, Santosh wrote:
>> On Thu, May 10, 2012 at 5:06 PM, Roger Quadros <rogerq@ti.com> wrote:
>>> Hi,
>>>
>>> On 05/03/2012 10:26 AM, R Sricharan wrote:
>>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>
>>>> OMAP4 and OMAP5 share same WakeupGen IP with below few udpates on OMAP5.
>>>> - Additional 32 interrupt support is added w.r.t OMAP4 design.
>>>> - The AUX CORE boot registers are now made accessible from non-secure SW.
>>>> - SAR offset are changed and PTMSYNC* registers are removed from SAR.
>>>>
>>>> Patch updates the WakeupGen code accordingly.
>>>>
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>>>> ---
>>>>  arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |    6 +
>>>>  arch/arm/mach-omap2/omap-hotplug.c                |   24 ++++-
>>>>  arch/arm/mach-omap2/omap-smp.c                    |   19 +++-
>>>>  arch/arm/mach-omap2/omap-wakeupgen.c              |  110 +++++++++++++++-----
>>>>  arch/arm/mach-omap2/omap4-sar-layout.h            |   12 ++-
>>>>  5 files changed, 135 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
>>>> index 548de90..4d700bc 100644
>>>> --- a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
>>>> +++ b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
>>>> @@ -11,15 +11,20 @@
>>>>  #ifndef OMAP_ARCH_WAKEUPGEN_H
>>>>  #define OMAP_ARCH_WAKEUPGEN_H
>>>>
>>>> +/* OMAP4 and OMAP5 has same base address */
>>>> +#define OMAP_WKUPGEN_BASE                    0x48281000
>>>
>>> unnecessary change, why don't you just use OMAP44XX_WKUPGEN_BASE or
>>> define this in the same header as OMAP44XX_WKUPGEN_BASE?
>>>
>> Just to avoid confusion about OMAP44XX and OMAP54XX. It's cleaner to
>> remove the OMAP44XX reference if the base is generic and not depend
>> on OMAP4/5.
>>
>> It's not un-necessary change as such.
>>
> 
> OK, is OMAP_WKUPGEN_BASE applicable for OMAPs prior to OMAP4? If not the
> naming scheme does not look appropriate.
> 
It's IP exist on OMAP4/5 and future OMAPs, no name is
fine. Btw, if you go on that route you will too many examples
of non appropriate names.

Regards
Santosh
