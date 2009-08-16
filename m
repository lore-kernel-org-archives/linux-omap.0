From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Re: [help] 2.6.30 can't booting
Date: Sun, 16 Aug 2009 13:55:06 -0400
Message-ID: <d9ca78710908161055t548d0964l92b9e47d5bd693f7@mail.gmail.com>
References: <d9ca78710908160948y246fa71epd564903d7fbbddbb@mail.gmail.com>
	 <20090816171236.GC9923@gandalf>
	 <d9ca78710908161016n5789f08cvd313c596e6cb290f@mail.gmail.com>
	 <d9ca78710908161018i4c3e54ebifd173c40dea81935@mail.gmail.com>
	 <d9ca78710908161019o32902715y9f6af58ad41dab66@mail.gmail.com>
	 <d9ca78710908161031s7f19ea94j61cb6ae849664168@mail.gmail.com>
	 <4A884705.1060905@holografika.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f205.google.com ([209.85.217.205]:45256 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbZHPRzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 13:55:06 -0400
Received: by gxk1 with SMTP id 1so3440329gxk.17
        for <linux-omap@vger.kernel.org>; Sun, 16 Aug 2009 10:55:07 -0700 (PDT)
In-Reply-To: <4A884705.1060905@holografika.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kovacs Peter Tamas <p.kovacs@holografika.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

thanks mr.peter

i should try the command like that

#nand unlock
#nand ecc sw
#setenv bootargs 'console=ttyS3,115200n8 root=/dev/mmcblk0p2 rw
rootdelay=1 mem=256M init=/init'
#setenv bootcmd 'mmcinit; fatload mmc 0 0x80c00000 uImage; bootm 0x80c00000'
#saveenv
#boot

it is stop(like hang) and i must restart again

On 8/16/09, Kovacs Peter Tamas <p.kovacs@holografika.com> wrote:
> Dear Aldyth,
>
> u-boot stops and waits for your command to load and start the kernel, as
> the bootcmd is not doing it automatically with your setup (setting
> bootargs is not enough alone, you need to load the kernel image from the
> card and run it).
> You should try:
> mmcinit
> fatload mmc 0 80300000 uImage
> bootm 80300000
>
> As described at eg:
> http://www.codeshogun.com/blog/2009/04/15/porting-android-to-beagle-board/
>
> Hope this helps,
> Peter
>> it is my step to build u-boot, x-loader and kernel
>>
>> i'm try linux 2.6.30 and using the omap3430sdp_defconfig to build the
>> uImage
>>
>> my u-boot and x-loader using omap3430zoom2_config
>>
>> any idea to solve that problem?...
>>
>> regards,
>> Aldyth M
>>
>> On 8/16/09, Tar Gz <bsdraisefromhell@gmail.com> wrote:
>>
>>> i'm format mmc in the fat win95...
>>>
>>> i following step by step in the
>>> https://omapzoom.org/gf/project/omapkernel/wiki/?pagename=Getting+Stated+with+Linux+OMAP+Kernel
>>>
>>> why can't read?
>>>
>>> On 8/16/09, Tar Gz <bsdraisefromhell@gmail.com> wrote:
>>>
>>>> i'm format mmc in the fat win95...
>>>>
>>>> i following step by step in the
>>>> https://omapzoom.org/gf/project/omapkernel/wiki/?pagename=Getting+Stated+with+Linux+OMAP+Kernel
>>>>
>>>> why can't read?
>>>>
>>>>
>>>>> On 8/16/09, Felipe Balbi <me@felipebalbi.com> wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Sun, Aug 16, 2009 at 12:48:52PM -0400, Tar Gz wrote:
>>>>>>
>>>>>>> Hi all,,i'm sorry if my english too bad
>>>>>>>
>>>>>>> i try to porting linux kernel 2.6.30 from kernel.org into omap 3430
>>>>>>>
>>>>>>> i have the problem linux kernel can't booting
>>>>>>>
>>>>>>>
>>>>>>> i'm following step by step in the omapzoom.org
>>>>>>> $ setenv bootargs console=ttyS3,115200n8 root=/dev/mmcblk0p2 rw
>>>>>>> rootdelay=1 mem=256M init=/sbin/init
>>>>>>> $ saveenv
>>>>>>> $ bootd
>>>>>>>
>>>>>>>
>>>>>>> OMAP34XX LAB # print
>>>>>>> bootdelay=3
>>>>>>> baudrate=115200
>>>>>>> bootargs=console=ttyS3,115200n8 root=/dev/mmcblk0p2 rootdelay=1
>>>>>>> mem=256M init=/sbin/init
>>>>>>> bootcmd=mmcinit
>>>>>>> bootfile="uImage"
>>>>>>>
>>>>>>> if i'm type bootd i'm still in the konsole like this,
>>>>>>> OMAP34XX LAB # bootd
>>>>>>> OMAP34XX LAB #
>>>>>>>
>>>>>>> any idea?
>>>>>>>
>>>>>> you're not reading the kernel image to memory.
>>>>>>
>>>>>> is your mmc formated with FAT32 or what ?
>>>>>>
>>>>>> You need to read kernel from mmc to memory and boot from there.
>>>>>>
>>>>>> --
>>>>>> balbi
>>>>>>
>>>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
