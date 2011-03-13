From: Stephan Raue <mailinglists@openelec.tv>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Sun, 13 Mar 2011 15:32:40 +0100
Message-ID: <4D7CD588.3080100@openelec.tv>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com> <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv> <1299827578.2567.1.camel@deskari> <4D79E0A0.9040900@openelec.tv> <1299849774.2479.3.camel@deskari> <4D7A4B44.2030801@openelec.tv> <1299868049.2479.33.camel@deskari> <4D7A6D0F.40906@openelec.tv> <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail05.solnet.ch ([212.101.4.139]:50356 "EHLO mail05.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756357Ab1CMOcn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 13 Mar 2011 10:32:43 -0400
In-Reply-To: <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Am 12.03.2011 07:51, schrieb K, Mythri P:
> Hi,
>
>
> On Sat, Mar 12, 2011 at 12:12 AM, Stephan Raue<mailinglists@openelec.tv>  wrote:
>> Am 11.03.2011 19:27, schrieb Tomi Valkeinen:
>>> On Fri, 2011-03-11 at 10:18 -0600, Stephan Raue wrote:
>>>> Am 11.03.2011 14:22, schrieb Tomi Valkeinen:
>>>>> On Fri, 2011-03-11 at 02:43 -0600, Stephan Raue wrote:
>>>>>> Am 11.03.2011 08:12, schrieb Tomi Valkeinen:
>>>>>>> On Thu, 2011-03-10 at 08:45 -0600, Stephan Raue wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> if i try this patch series the boot stops after (seeing via serial
>>>>>>>> console):
>>>>>>>>
>>>>>>>>       Starting kernel ...
>>>>>>>>
>>>>>>>>       Uncompressing Linux... done, booting the kernel.
>>>>>>>>
>>>>>>>> without this patch series i can see the boot to th OS. I am using
>>>>>>>> this
>>>>>>>> patches on top of
>>>>>>>>
>>>>>>>>       http://gitorious.org/linux-omap-dss2/linux/commits/master
>>>>>>>>
>>>>>>>> Do i anything wrong or do i use a wrong git repo (the patches apply
>>>>>>>> cleanly)? Her my kernel config: http://fpaste.org/9Esw/
>>>>>>> Hmm, I cannot even compile the kernel with that config:
>>>>>>>
>>>>>>>      CC      arch/arm/mach-omap2/io.o
>>>>>>> In file included from arch/arm/mm/init.c:27:0:
>>>>>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h: In function
>>>>>>> 'tlb_flush_mmu':
>>>>>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h:104:3: error:
>>>>>>> implicit declaration of function 'release_pages'
>>>>>>> In file included from arch/arm/mm/init.c:27:0:
>>>>>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h: In function
>>>>>>> 'tlb_remove_page':
>>>>>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h:168:3: error:
>>>>>>> implicit declaration of function 'page_cache_release'
>>>>>>> make[1]: *** [arch/arm/mm/init.o] Error 1
>>>>>>> make: *** [arch/arm/mm] Error 2
>>>>>>> make: *** Waiting for unfinished jobs....
>>>>>>>
>>>>>>>     Tomi
>>>>>>>
>>>>>> please enable swap support or try:
>>>>>>
>>>>>> http://ftp.arm.linux.org.uk/git/?p=linux-2.6-arm.git;a=commit;h=97594b0f35c0708cb9551c070b9693a52ec24ebf
>>>>>> which is fixed in 2.6.38-rc8
>>>>> Ok. So you didn't have just my master branch and the HDMI patch set? I
>>>>> see that the config you gave is for rc8, and mine is rc7, so I guess you
>>>>> also merged rc8 into your tree?
>>>>>
>>>>>    Tomi
>>>>>
>>>> yes, you are right, i have tested this with different kernel configs and
>>>> both rc7 and rc8 with the same results.
>>> Ok. I need to dig out my panda and try to get it running. Blaze board
>>> seems to work fine, at least for me.
>>>
>>> Does the crash happen every time?
>>>
>>>   Tomi
>>>
>>> omap2plus_defconfig
>> yes, with all configs i tried. will try a "make omap2plus_defconfig" too and
>> let you know.
>>
> I have tried booting on Panda board and it works fine , I am using
> OMAP2PLUS defconfig.
> I have disabled VENC though( without that i see that kernel hangs , ie
> because reading VENC register in hwmod probe is resulting in a crash.
>
i have tried this omap2plus defconfig now too, with some little changes 
needed to boot my system (config: http://paste.pocoo.org/show/352917/). 
Now i get this error (see also: http://paste.pocoo.org/show/352915/)

[    3.255065] omapdss HDMI: fallback to VGA
[    3.271636] omapdss HDMI error: Failed to set PHY_PWR_STATUS
[    3.277587] omapdss HDMI error: failed to power on device
[    3.283325] omapdss error: failed to power on
[    3.287902] omapfb omapfb: Failed to enable display 'hdmi'
[    3.293853] Console: switching to colour dummy device 80x30
[    3.304595] omapfb omapfb: failed to setup omapfb
[    3.309539] omapfb: probe of omapfb failed with error -5

thanks

Stephan
