From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Re: [help] 2.6.30 can't booting
Date: Sun, 16 Aug 2009 13:18:08 -0400
Message-ID: <d9ca78710908161018i4c3e54ebifd173c40dea81935@mail.gmail.com>
References: <d9ca78710908160948y246fa71epd564903d7fbbddbb@mail.gmail.com>
	 <20090816171236.GC9923@gandalf>
	 <d9ca78710908161016n5789f08cvd313c596e6cb290f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f205.google.com ([209.85.217.205]:55460 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbZHPRSK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 13:18:10 -0400
Received: by gxk1 with SMTP id 1so3424597gxk.17
        for <linux-omap@vger.kernel.org>; Sun, 16 Aug 2009 10:18:11 -0700 (PDT)
In-Reply-To: <d9ca78710908161016n5789f08cvd313c596e6cb290f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me <me@felipebalbi.com>, linux-omap <linux-omap@vger.kernel.org>

i'm format mmc in the fat win95...

i following step by step in the
https://omapzoom.org/gf/project/omapkernel/wiki/?pagename=Getting+Stated+with+Linux+OMAP+Kernel

why can't read?

>
> On 8/16/09, Felipe Balbi <me@felipebalbi.com> wrote:
>> Hi,
>>
>> On Sun, Aug 16, 2009 at 12:48:52PM -0400, Tar Gz wrote:
>>> Hi all,,i'm sorry if my english too bad
>>>
>>> i try to porting linux kernel 2.6.30 from kernel.org into omap 3430
>>>
>>> i have the problem linux kernel can't booting
>>>
>>>
>>> i'm following step by step in the omapzoom.org
>>> $ setenv bootargs console=ttyS3,115200n8 root=/dev/mmcblk0p2 rw
>>> rootdelay=1 mem=256M init=/sbin/init
>>> $ saveenv
>>> $ bootd
>>>
>>>
>>> OMAP34XX LAB # print
>>> bootdelay=3
>>> baudrate=115200
>>> bootargs=console=ttyS3,115200n8 root=/dev/mmcblk0p2 rootdelay=1
>>> mem=256M init=/sbin/init
>>> bootcmd=mmcinit
>>> bootfile="uImage"
>>>
>>> if i'm type bootd i'm still in the konsole like this,
>>> OMAP34XX LAB # bootd
>>> OMAP34XX LAB #
>>>
>>> any idea?
>>
>> you're not reading the kernel image to memory.
>>
>> is your mmc formated with FAT32 or what ?
>>
>> You need to read kernel from mmc to memory and boot from there.
>>
>> --
>> balbi
>>
>
