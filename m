From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Re: [help] 2.6.30 can't booting
Date: Tue, 18 Aug 2009 04:55:56 -0700
Message-ID: <d9ca78710908180455o5e67a483j6ffdb41fa552a276@mail.gmail.com>
References: <d9ca78710908160948y246fa71epd564903d7fbbddbb@mail.gmail.com>
	 <d9ca78710908161019o32902715y9f6af58ad41dab66@mail.gmail.com>
	 <d9ca78710908161031s7f19ea94j61cb6ae849664168@mail.gmail.com>
	 <4A884705.1060905@holografika.com>
	 <d9ca78710908161055t548d0964l92b9e47d5bd693f7@mail.gmail.com>
	 <d9ca78710908161101n4e2420b6xba6665e5c5d8cc21@mail.gmail.com>
	 <4A886017.1040004@holografika.com>
	 <d9ca78710908161512i324875e1md13a69da68edab73@mail.gmail.com>
	 <4A890921.2080201@holografika.com>
	 <d9ca78710908180447p3a90792ag374d244b1bf328cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:54080 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758623AbZHRLz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 07:55:56 -0400
Received: by yxe5 with SMTP id 5so4419075yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2009 04:55:57 -0700 (PDT)
In-Reply-To: <d9ca78710908180447p3a90792ag374d244b1bf328cc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kovacs Peter Tamas <p.kovacs@holografika.com>, linux-omap <linux-omap@vger.kernel.org>

if i not using nfs...how to mount the another partition in mmc?

On 8/18/09, Tar Gz <bsdraisefromhell@gmail.com> wrote:
> On 8/17/09, Kovacs Peter Tamas <p.kovacs@holografika.com> wrote:
>> Hi,
>>
>> we use these parameters for NFS booting:
>> setenv bootargs console=ttyS2,115200n8 noinitrd root=/dev/nfs rw
>> nfsroot=10.95.102.32:/home/filesystems/tifs,nolock,vers=3,rsize=2048,wsize=2048,
>> tcp dyntick=e ip=dhcp nohz=off
>>
>> or without DHCP:
>> setenv bootargs console=ttyS2,115200n8 noinitrd,rw root=/dev/nfs
>> nfsroot=10.95.102.32:/home/filesystems/tifs,nolock, mem=112M nohz=off
>> ip=10.95.102.33:10.95.96.1:10.95.96.1:255.255.240.0:infba00798::off
>> devfs=mount
>>
>
> oke i try it....
>
> in the another mailing list, the problem about different speed
> bootloader and linux kernel..if that's my problem..how i can fix
> that?....thanks before
>
> Regards,
> Aldyth M
>> and it works.
>> Try it!
>>
>> Peter
>>> hmm,,i boot again and kernel panic cannot sync VFS
>>>
>>> because no respond from my nfs server...
>>>
>>> but i'm try to mount y nfs directory in the another computer, it's
>>> work..i don't know whre is the problem?
>>>
>>> On 8/16/09, Kovacs Peter Tamas <p.kovacs@holografika.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> I don't think that it's a problem with the filesystem, if you followed
>>>> the tutorial then you have the filesystem on the second partition, and
>>>> your bootargs are pointing there too.
>>>> Do you have a DHCP server running somewhere?
>>>> If you have DHCP, but the OMAP cannot use it for some reason, you can
>>>> still try forcing a static IP instead of DHCPing, like discussed here:
>>>> http://focus.ti.com/lit/an/spraaq0/spraaq0.pdf
>>>>
>>>> That is, add something like
>>>> ip=clientIP:serverIP:gatewayIP:netMask:::off
>>>> to your bootargs.
>>>> More info about the meaning of the above here:
>>>> http://www.kernel.org/pub/linux/kernel/people/marcelo/linux-2.4/Documentation/nfsroot.txt
>>>>
>>>> Peter
>>>>
>>>>> thanks peter, i can boot but the kernel stop in the
>>>>> Sending DHCP Requests . <7>hub 1-0:1.0 hub_suspend
>>>>> .......
>>>>>
>>>>> how to boot filesystems has installed from mmc?...thanks
>>>>>
>>>>> On 8/16/09, Tar Gz <bsdraisefromhell@gmail.com> wrote:
>>>>>
>>>>>
>>>>>> thanks mr.peter
>>>>>>
>>>>>> i should try the command like that
>>>>>>
>>>>>> #nand unlock
>>>>>> #nand ecc sw
>>>>>> #setenv bootargs 'console=ttyS3,115200n8 root=/dev/mmcblk0p2 rw
>>>>>> rootdelay=1 mem=256M init=/init'
>>>>>> #setenv bootcmd 'mmcinit; fatload mmc 0 0x80c00000 uImage; bootm
>>>>>> 0x80c00000'
>>>>>> #saveenv
>>>>>> #boot
>>>>>>
>>>>>> it is stop(like hang) and i must restart again
>>>>>>
>>>>>> On 8/16/09, Kovacs Peter Tamas <p.kovacs@holografika.com> wrote:
>>>>>>
>>>>>>
>>>>>>> Dear Aldyth,
>>>>>>>
>>>>>>> u-boot stops and waits for your command to load and start the
>>>>>>> kernel,
>>>>>>> as
>>>>>>> the bootcmd is not doing it automatically with your setup (setting
>>>>>>> bootargs is not enough alone, you need to load the kernel image from
>>>>>>> the
>>>>>>> card and run it).
>>>>>>> You should try:
>>>>>>> mmcinit
>>>>>>> fatload mmc 0 80300000 uImage
>>>>>>> bootm 80300000
>>>>>>>
>>>>>>> As described at eg:
>>>>>>> http://www.codeshogun.com/blog/2009/04/15/porting-android-to-beagle-board/
>>>>>>>
>>>>>>> Hope this helps,
>>>>>>> Peter
>>>>>>>
>>>>>>>
>>>>>>>> it is my step to build u-boot, x-loader and kernel
>>>>>>>>
>>>>>>>> i'm try linux 2.6.30 and using the omap3430sdp_defconfig to build
>>>>>>>> the
>>>>>>>> uImage
>>>>>>>>
>>>>>>>> my u-boot and x-loader using omap3430zoom2_config
>>>>>>>>
>>>>>>>> any idea to solve that problem?...
>>>>>>>>
>>>>>>>> regards,
>>>>>>>> Aldyth M
>>>>>>>>
>>>>>>>> On 8/16/09, Tar Gz <bsdraisefromhell@gmail.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>> i'm format mmc in the fat win95...
>>>>>>>>>
>>>>>>>>> i following step by step in the
>>>>>>>>> https://omapzoom.org/gf/project/omapkernel/wiki/?pagename=Getting+Stated+with+Linux+OMAP+Kernel
>>>>>>>>>
>>>>>>>>> why can't read?
>>>>>>>>>
>>>>>>>>> On 8/16/09, Tar Gz <bsdraisefromhell@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> i'm format mmc in the fat win95...
>>>>>>>>>>
>>>>>>>>>> i following step by step in the
>>>>>>>>>> https://omapzoom.org/gf/project/omapkernel/wiki/?pagename=Getting+Stated+with+Linux+OMAP+Kernel
>>>>>>>>>>
>>>>>>>>>> why can't read?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> On 8/16/09, Felipe Balbi <me@felipebalbi.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> On Sun, Aug 16, 2009 at 12:48:52PM -0400, Tar Gz wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> Hi all,,i'm sorry if my english too bad
>>>>>>>>>>>>>
>>>>>>>>>>>>> i try to porting linux kernel 2.6.30 from kernel.org into omap
>>>>>>>>>>>>> 3430
>>>>>>>>>>>>>
>>>>>>>>>>>>> i have the problem linux kernel can't booting
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> i'm following step by step in the omapzoom.org
>>>>>>>>>>>>> $ setenv bootargs console=ttyS3,115200n8 root=/dev/mmcblk0p2
>>>>>>>>>>>>> rw
>>>>>>>>>>>>> rootdelay=1 mem=256M init=/sbin/init
>>>>>>>>>>>>> $ saveenv
>>>>>>>>>>>>> $ bootd
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> OMAP34XX LAB # print
>>>>>>>>>>>>> bootdelay=3
>>>>>>>>>>>>> baudrate=115200
>>>>>>>>>>>>> bootargs=console=ttyS3,115200n8 root=/dev/mmcblk0p2
>>>>>>>>>>>>> rootdelay=1
>>>>>>>>>>>>> mem=256M init=/sbin/init
>>>>>>>>>>>>> bootcmd=mmcinit
>>>>>>>>>>>>> bootfile="uImage"
>>>>>>>>>>>>>
>>>>>>>>>>>>> if i'm type bootd i'm still in the konsole like this,
>>>>>>>>>>>>> OMAP34XX LAB # bootd
>>>>>>>>>>>>> OMAP34XX LAB #
>>>>>>>>>>>>>
>>>>>>>>>>>>> any idea?
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>> you're not reading the kernel image to memory.
>>>>>>>>>>>>
>>>>>>>>>>>> is your mmc formated with FAT32 or what ?
>>>>>>>>>>>>
>>>>>>>>>>>> You need to read kernel from mmc to memory and boot from there.
>>>>>>>>>>>>
>>>>>>>>>>>> --
>>>>>>>>>>>> balbi
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>> linux-omap"
>>>>>>>> in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap"
>>>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>
>>
>>
>
