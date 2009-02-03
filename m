From: Remith Ravi <remithmailinglist@gmail.com>
Subject: Re: USB and SD performance issue
Date: Tue, 3 Feb 2009 18:35:05 +0530
Message-ID: <814dfab70902030505q399bfd7u20503a44594e9a2c@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F542051E@dbde02.ent.ti.com>
	 <C48F0EBA-DB90-4CF9-AADF-6DCCB3F30A4D@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:62391 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbZBCNFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 08:05:08 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1047733tic.23
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 05:05:05 -0800 (PST)
In-Reply-To: <C48F0EBA-DB90-4CF9-AADF-6DCCB3F30A4D@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Feb 3, 2009 at 5:17 PM, Koen Kooi <k.kooi@student.utwente.nl> wrote:
>
> Op 3 feb 2009, om 12:37 heeft Gadiyar, Anand het volgende geschreven:
>
>>
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org
>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
>>> Sent: Tuesday, February 03, 2009 5:05 PM
>>> To: Remith Ravi
>>> Cc: linux-omap@vger.kernel.org
>>> Subject: Re: USB and SD performance issue
>>>
>>>
>>> Op 3 feb 2009, om 12:16 heeft Remith Ravi het volgende geschreven:
>>>
>>>> Hello,
>>>>
>>>> Recently I have done a performance comparison of OMAP3 'USB
>>>
>>> OTG Host'
>>>>
>>>> and 'SD' drivers on different Linux Kernels.
>>>> The performance of latest git kernel is less comparing to
>>>
>>> 2.6.22 TI
>>>>
>>>> kernel.
>>>> Could some one please explain me what cause this performance
>>>> difference?
>>>>
>>>> The performance is calculated by doing data transfer between RAM and
>>>> the storage device (using 'time' command).
>>>>
>>>> The performance details are given below.
>>>>
>>>> 1) 2.6.29-rc2 kernel
>>>> USB OTG (Host)         Read (4.2 MB/s)          Write
>>>
>>> (2.6 MB/s)
>>>>
>>>> SD Card                     Read (3.88 MB/s)
>>>
>>> Write (3.1 MB/s)
>>>>
>>>> 2) 2.6.28 kernel
>>>> USB OTG (Host)         error                            error
>>>> SD Card                     Read  (4.2 MB/s)
>>>
>>> Write (3.27 MB/s)
>>>>
>>>> 3) 2.6.22 TI kernel
>>>> USB OTG (Host)         Read (5.4MB/s)           Write
>>>
>>> (6.14MB/s)
>>>>
>>>> SD Card                      Read (6.7MB/s)             Write (6.43MB/s)
>>>
>>> I get this with 2.6.28:
>>>
>>> root@omap3evm:~# hdparm -t /dev/mmcblk0
>>> /dev/mmcblk0:
>>>  Timing buffered disk reads:   42 MB in  3.10 seconds =  13.53 MB/sec
>>>
>>> root@beagleboard:~# hdparm -t /dev/mmcblk0
>>> /dev/mmcblk0:
>>>  Timing buffered disk reads:   44 MB in  3.13 seconds =  14.04 MB/sec
>>>
>>> regards,
>>>
>>> Koen
>>>
>>
>> What does `hdparm -tT /dev/mmcblk0` give?
>
> root@beagleboard:~# hdparm -tT /dev/mmcblk0
> /dev/mmcblk0:
>  Timing cached reads:   240 MB in  2.01 seconds = 119.32 MB/sec
>  Timing buffered disk reads:   42 MB in  3.01 seconds =  13.97 MB/sec
>
> root@omap3evm:~# hdparm -tT /dev/mmcblk0
> /dev/mmcblk0:
>  Timing cached reads:   300 MB in  2.00 seconds = 149.83 MB/sec
>  Timing buffered disk reads:   42 MB in  3.17 seconds =  13.23 MB/sec
>
> Which is misleading, since -T tests the bandwidth or your RAM, which in my
> case is limited since both machines are displaying a stream from a webcam
> attached to USB in X11, so the overlays and framebuffers are stealing a
> large part of the bw. Killing the screensaver on the EVM gave me 35MB/s
> 'back' :)
>
> regards,
>
> Koen
>
>
>>
>>
>> - Anand
>>
>
>
With "hdparm" kernel 2.6.29 gives better result.

What I tried was booting with ramdisk and transfer a 30MB file between
the file system and storage device.
[root@OMAP3530EVM ~]# time cp data1 /mnt/mmc/
[root@OMAP3530EVM ~]# time cp /mnt/mmc/data2 .

Any guess why the contradiction?

Regards,
Remith
