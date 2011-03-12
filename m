From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Sat, 12 Mar 2011 12:21:01 +0530
Message-ID: <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>
 <1299827578.2567.1.camel@deskari> <4D79E0A0.9040900@openelec.tv>
 <1299849774.2479.3.camel@deskari> <4D7A4B44.2030801@openelec.tv>
 <1299868049.2479.33.camel@deskari> <4D7A6D0F.40906@openelec.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:53996 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751299Ab1CLGvX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Mar 2011 01:51:23 -0500
Received: by iyi12 with SMTP id 12so157429iyi.9
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 22:51:21 -0800 (PST)
In-Reply-To: <4D7A6D0F.40906@openelec.tv>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephan Raue <mailinglists@openelec.tv>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,


On Sat, Mar 12, 2011 at 12:12 AM, Stephan Raue <mailinglists@openelec.t=
v> wrote:
> Am 11.03.2011 19:27, schrieb Tomi Valkeinen:
>>
>> On Fri, 2011-03-11 at 10:18 -0600, Stephan Raue wrote:
>>>
>>> Am 11.03.2011 14:22, schrieb Tomi Valkeinen:
>>>>
>>>> On Fri, 2011-03-11 at 02:43 -0600, Stephan Raue wrote:
>>>>>
>>>>> Am 11.03.2011 08:12, schrieb Tomi Valkeinen:
>>>>>>
>>>>>> On Thu, 2011-03-10 at 08:45 -0600, Stephan Raue wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> if i try this patch series the boot stops after (seeing via ser=
ial
>>>>>>> console):
>>>>>>>
>>>>>>> =A0 =A0 =A0Starting kernel ...
>>>>>>>
>>>>>>> =A0 =A0 =A0Uncompressing Linux... done, booting the kernel.
>>>>>>>
>>>>>>> without this patch series i can see the boot to th OS. I am usi=
ng
>>>>>>> this
>>>>>>> patches on top of
>>>>>>>
>>>>>>> =A0 =A0 =A0http://gitorious.org/linux-omap-dss2/linux/commits/m=
aster
>>>>>>>
>>>>>>> Do i anything wrong or do i use a wrong git repo (the patches a=
pply
>>>>>>> cleanly)? Her my kernel config: http://fpaste.org/9Esw/
>>>>>>
>>>>>> Hmm, I cannot even compile the kernel with that config:
>>>>>>
>>>>>> =A0 =A0 CC =A0 =A0 =A0arch/arm/mach-omap2/io.o
>>>>>> In file included from arch/arm/mm/init.c:27:0:
>>>>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h: In function
>>>>>> 'tlb_flush_mmu':
>>>>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h:104:3: error:
>>>>>> implicit declaration of function 'release_pages'
>>>>>> In file included from arch/arm/mm/init.c:27:0:
>>>>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h: In function
>>>>>> 'tlb_remove_page':
>>>>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h:168:3: error:
>>>>>> implicit declaration of function 'page_cache_release'
>>>>>> make[1]: *** [arch/arm/mm/init.o] Error 1
>>>>>> make: *** [arch/arm/mm] Error 2
>>>>>> make: *** Waiting for unfinished jobs....
>>>>>>
>>>>>> =A0 =A0Tomi
>>>>>>
>>>>> please enable swap support or try:
>>>>>
>>>>> http://ftp.arm.linux.org.uk/git/?p=3Dlinux-2.6-arm.git;a=3Dcommit=
;h=3D97594b0f35c0708cb9551c070b9693a52ec24ebf
>>>>> which is fixed in 2.6.38-rc8
>>>>
>>>> Ok. So you didn't have just my master branch and the HDMI patch se=
t? I
>>>> see that the config you gave is for rc8, and mine is rc7, so I gue=
ss you
>>>> also merged rc8 into your tree?
>>>>
>>>> =A0 Tomi
>>>>
>>> yes, you are right, i have tested this with different kernel config=
s and
>>> both rc7 and rc8 with the same results.
>>
>> Ok. I need to dig out my panda and try to get it running. Blaze boar=
d
>> seems to work fine, at least for me.
>>
>> Does the crash happen every time?
>>
>> =A0Tomi
>>
>> omap2plus_defconfig
>
> yes, with all configs i tried. will try a "make omap2plus_defconfig" =
too and
> let you know.
>
I have tried booting on Panda board and it works fine , I am using
OMAP2PLUS defconfig.
I have disabled VENC though( without that i see that kernel hangs , ie
because reading VENC register in hwmod probe is resulting in a crash.

> thanks much
>
> Stephan
>
Vaibhav,
You see a crash even without this patch set right ? so should we take
that in a different thread?

Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
