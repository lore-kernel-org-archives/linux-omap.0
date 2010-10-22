From: Anand Gadiyar <gadiyar@ti.com>
Subject: Re: linux-next - multi-omap image fails to boot on omap3/4
Date: Fri, 22 Oct 2010 16:15:59 -0400
Message-ID: <4CC1F0FF.4000701@ti.com>
References: <4CBDAFFF.2030409@ti.com> <20101019182149.GC3038@atomide.com> <AANLkTikYGwH-kQV3b+gqDYOKVvuiXOU=kBDVLy3ryNjR@mail.gmail.com> <20101019225726.GE3038@atomide.com> <20101019233204.GA30991@atomide.com> <AANLkTikrVJ3bw3aKE6V7uH9DmheVDihedNOP+wypYunC@mail.gmail.com> <AANLkTimqymuGdD3_SX2RVj=6a9j+ODKy8ipYZ-6hqw+S@mail.gmail.com> <20101021161545.GC3616@atomide.com> <8fb818d83ad3cb8e8e979e9b4ac52736@mail.gmail.com> <20101022185254.GG17595@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33334 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759380Ab0JVUQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Oct 2010 16:16:09 -0400
Received: by mail-gx0-f176.google.com with SMTP id 24so1082910gxk.35
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 13:16:08 -0700 (PDT)
In-Reply-To: <20101022185254.GG17595@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 10/22/2010 2:52 PM, Tony Lindgren wrote:
> * Anand Gadiyar<gadiyar@ti.com>  [101022 06:59]:
>> Tony Lindgren wrote:
>>> * Gadiyar, Anand<gadiyar@ti.com>  [101019 23:21]:
>>
>> ...
>>
>>>>>>>>>> linux-next, as of 20101019, built with the
>> omap2plus_defconfig fails
>>>>>>>>>> to boot on omap3 and omap4. (I've disabled CONFIG_ARCH_OMAP2
>> or
>>>>>>>>>> CONFIG_SWP_EMULATE to get the image to build). Building with
>> only
>>>>>>>>>> ARCH_OMAP3 allows the resultant image to boot up on OMAP3.
>> Likewise,
>>>>>>>>>> an image built with only ARCH_OMAP4 boots up on OMAP4 boards.
>>>>>>>>>>
>>>>>>>>>> earlyprintk does not provide any additional prints after
>>>>>>>>>> "Uncompressing Linux... done, booting the kernel."
>>>>>>>>>>
>>>>>>>>>> Any ideas where to look?
>>>>>>>>>
>>
>> ...
>>
>>>>
>>>> I tried disabling CONFIG_SMP and CONFIG_SMP_ON_UP, and the resulting
>>>> image booted up just fine.
>>>
>>> Looks like it's caused by this patch:
>>>
>>> "ARM: hotplug cpu: Keep processor information, startup code&
>>> __lookup_processor_type"
>>>
>>> It's probably trashing registers it shouldn't. Will take a look and post
>>> something to linux-arm-kernel.
>>>
>>
>> I'm not sure what's going on, but looks like linux-next as of
>> 20101022 boots up fine on panda. I can't explain it, as I couldn't
>> find anything related to the patch you mentioned.
>
> Yeah, it's an alignment issue that's why it sometimes works depending
> on the Kconfig options selected..
>
> For rererence, posted a fix for that at:
>
> https://patchwork.kernel.org/patch/276161/
>
> Tony

The patch seems to work - thanks! Just curious, how do you go about 
debugging an issue like this?

- Anand

