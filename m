From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 12/25] OMAP: Add support to allocate the memory for secure RAM
Date: Fri, 9 Sep 2011 19:39:59 +0530
Message-ID: <CAMQu2gwkUdVffz=RBGGjuaSsKKS7HC-GunGHuTOZE7PDwMW2wg@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-13-git-send-email-santosh.shilimkar@ti.com>
 <CAORVsuV8+zMzwT+PeWTo6TgWeEYfcSQdjY_kv4FcURohVoT=hw@mail.gmail.com>
 <4E69DFBB.9020803@ti.com> <CAORVsuWNgXqmpuir7kpRHf5T7-o2DE8OSkwR1Evfo3=wKgiTUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:50091 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759Ab1IIOKU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Sep 2011 10:10:20 -0400
Received: by yie12 with SMTP id 12so234795yie.3
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 07:10:19 -0700 (PDT)
In-Reply-To: <CAORVsuWNgXqmpuir7kpRHf5T7-o2DE8OSkwR1Evfo3=wKgiTUw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com

On Fri, Sep 9, 2011 at 6:24 PM, Jean Pihet <jean.pihet@newoldbits.com> =
wrote:
> Santosh,
>
> On Fri, Sep 9, 2011 at 11:43 AM, Santosh <santosh.shilimkar@ti.com> w=
rote:
>> On Friday 09 September 2011 12:49 AM, Jean Pihet wrote:
>>>
>>> On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
>>> <santosh.shilimkar@ti.com> =A0wrote:
>>>>
>>>> Allocate the memory to save secure ram context which needs
>>>> to be done when MPU is hitting off mode.
>>>>
>>>> The ROM code expects a physical address to this memory
>>>> and hence use memblock APIs to reserve this memory as part
>>>> of .reserve() callback.
>>>>
>>>> Maximum possible size is allocated and can cater to OMAP3XXX / OMA=
P4XXX
>>>> secure RAM size requirements.
>>>>
>>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>>> ---
>>>> =A0arch/arm/mach-omap2/include/mach/omap-secure.h | =A0 =A04 +++
>>>> =A0arch/arm/mach-omap2/omap-secure.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 29
>>>> ++++++++++++++++++++++++
>>>> =A0arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A03 ++
>>>> =A03 files changed, 36 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h
>>>> b/arch/arm/mach-omap2/include/mach/omap-secure.h
>>>> index 26e7bcc..e2f95a0 100644
>>>> --- a/arch/arm/mach-omap2/include/mach/omap-secure.h
>>>> +++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
>>>> @@ -26,6 +26,8 @@
>>>> =A0#define FLAG_FIQ_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x1
>>>> =A0#define NO_FLAG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A00x0
>>>>
>>>> +/* Maximum Secure memory storage size */
>>>> +#define OMAP_SECURE_RAM_STORAGE =A0 =A0 =A0 =A0(88 * SZ_1K)
>>>
>>> Is this valid for all supported devices? How to differentiate
>>> variations in the size for new chips variants in the future?
>>>
>> You don't have to. ROM code does that job. We should just ensure
>> that maximum needed memory is made available to secure code.
> The question was: what would be the code if tomorrow -for example- we
> have OMAP4460 with 88K of secure RAM, OMAP5432 with 128K and OMAP6667
> with 132K? How to code the differences?
>
The size doesn't depend on silicon but depends on Secure software
stack size. As I
said, we will allocate maximum needed as per security team recommendati=
on.
If on newer security stack, if we need more, we will just increase it
to maximum needed.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
