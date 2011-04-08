From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: 2.6.38 not booting on sbc8100 (aka devkit8000)
Date: Fri, 08 Apr 2011 09:25:35 +0200
Message-ID: <4D9EB86F.1020601@gmail.com>
References: <AANLkTikAO+FA+0fCNiVj=9wVZ3t+vfx9tJX_SnJ7FGSd@mail.gmail.com>	<20110324151844.GT2811@atomide.com>	<AANLkTik8PW4ad2_4=UxzvL-V7HcpH0=dg-Un5NLkj6Yi@mail.gmail.com>	<20110324190030.GW2811@atomide.com>	<20110325091316.8a39d71a.jhnikula@gmail.com>	<AANLkTi=BwAOJkHRK=AxBdUHSf3vq8MM+i55TOGuuqeHs@mail.gmail.com>	<4D9EB292.9050206@gmail.com> <BANLkTimUOyAWtgfoOSgQxXWdQehST5PDaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49637 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab1DHI0d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2011 04:26:33 -0400
Received: by wwa36 with SMTP id 36so3960174wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 08 Apr 2011 01:26:32 -0700 (PDT)
In-Reply-To: <BANLkTimUOyAWtgfoOSgQxXWdQehST5PDaA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Thomas Weber <thomas.weber.linux@googlemail.com>, Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Am 08.04.2011 10:03, schrieb Belisko Marek:
> On Fri, Apr 8, 2011 at 9:00 AM, Thomas Weber
> <thomas.weber.linux@googlemail.com> wrote:
>> Am 25.03.2011 08:53, schrieb Belisko Marek:
>>> On Fri, Mar 25, 2011 at 8:13 AM, Jarkko Nikula <jhnikula@gmail.com> wrote:
>>>> On Thu, 24 Mar 2011 12:00:30 -0700
>>>> Tony Lindgren <tony@atomide.com> wrote:
>>>>
>>>>> * Belisko Marek <marek.belisko@gmail.com> [110324 08:18]:
>>>>>> On Thu, Mar 24, 2011 at 4:18 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>>>>
>>>>>>> * Belisko Marek <marek.belisko@gmail.com> [110324 02:50]:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Try to run 2.6.38 on my sbc8100
>>>>>>>> (use mach-type for devkit8000 because boards are similar) board but
>>>>>>>> when u-boot load it to ram I see just:
>>>> ...
>>>>>>> Can you enable DEBUG_LL and EARLY_PRINTK in your .config
>>>>>>> and add earlyprintk to your cmdline? Then you should see
>>>>>>> what goes wrong.
>>>>>>>
>>>>>> Forgot to mention. I already test this options but result is same like I
>>>>>> report in
>>>>>> first email.
>>>>>
>>>>> Maybe add some printk statements to start_kernel function in
>>>>> init/main.c and see if you get any output?
>>>>>
>>>> For earlyprintk worth to check also
>>>> arch/arm/plat-omap/include/plat/uncompress.h that there is entry for
>>>> sbc8100 (double check with devkit8000 as there is entry for it and if
>>>> you are re-using the mach-type).
>>> Thanks for hint. It was missing there so I add line:
>>> DEBUG_LL_OMAP3(3, devkit8000); (I'm convince linux to use mach-type
>>> for devkit8000)
>>> But still same result.
>>> Bytes transferred = 2898680 (2c3af8 hex)
>>> ## Booting kernel from Legacy Image at 80300000 ...
>>>    Image Name:   Linux-2.6.37-00001-g88870c9-dirt
>>>    Image Type:   ARM Linux Kernel Image (uncompressed)
>>>    Data Size:    2898616 Bytes =  2.8 MB
>>>    Load Address: 80008000
>>>    Entry Point:  80008000
>>>    Verifying Checksum ... OK
>>>    Loading Kernel Image ... OK
>>> OK
>>>
>>> Starting kernel ...
>>>
>>> Anybody with devkit8000 have success to run 2.6.37 kernel on board?

I run actually 2.6.38.
/ # uname -a
Linux 192.168.250.2 2.6.38-09676-ge63e9ed #8 Tue Mar 22 13:07:44 CET
2011 armv7l GNU/Linux

>>>>
>>>> --
>>>> Jarkko
>>>>
>>>
>>> regards,
>>>
>>> marek
>>>
>>
>> Hello Marek,
>>
>> yes, it is running. But your mach-type is wrong. Thats not the mach-type
>> from devkit8000, it is spark. What version of u-boot are you running?
> Well my u-boot return different mach-type but I always override it when
> kernel start (in arch/arm/kernel/head.S ldr r1,=0x.. mach-type).
> But still no luck.

What machine-id are you passing in? devkit8000 is 2330
Thomas
>>
>> Thomas
>>
>>
> 
> thanks,
> 
> marek
> 

