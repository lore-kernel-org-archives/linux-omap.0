From: "S.Rajeev" <srajeev@mistralsolutions.com>
Subject: Re: omap 0sk and mistral touchscreen..
Date: Tue, 27 May 2008 10:33:30 +0530
Message-ID: <001101c8bfb7$01e58ac0$310da8c0@mistral.in>
References: <a1d91fa0805252349w266c2f8x11377f2dce066b93@mail.gmail.com> <cb8016980805260842m2f06e9e8yb39fd91f1384d921@mail.gmail.com> <a1d91fa0805262126v65745282k4ac45d3e71c1894f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from blrmail.mistralsolutions.com ([220.227.112.130]:1983 "EHLO
	Mistralsoftware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752147AbYE0E6N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2008 00:58:13 -0400
Received: from Rajeev0402 by mistralsolutions.com (MDaemon PRO v9.6.4)
	with ESMTP id 27-md50000012574.msg
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2008 10:33:35 +0530
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>, Abraham Arce <abraham.arce.moreno@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>

Hi ,


Make the following change :

1) In the "ts.conf"  file make sure "module_raw input" is uncommented .
2) export TSLIB_CONSOLEDEVICE=none


Thanks and Regards
rajeev

----- Original Message ----- 
From: "mohammed shareef" <mdshareef@gmail.com>
To: "Abraham Arce" <abraham.arce.moreno@gmail.com>
Cc: "omap" <linux-omap@vger.kernel.org>
Sent: Tuesday, May 27, 2008 9:56 AM
Subject: Re: omap 0sk and mistral touchscreen..


> Dear Abraham,
>
> I am not receiving any error nor any messages on the LCD.. i have
> added the following environment variables:
>
> export TSLIB_TSDEVICE=/dev/input/event1
> export TSLIB_CONFFILE=/etc/ts.conf
> export TSLIB_CONSOLEDEVICE=/dev/ttyS0
> export TSLIB_FBDEVICE=/dev/fb0
> export TSLIB_PLUGINDIR=/usr/lib/ts
> export TSLIB_CALIBFILE=/etc/pointercal
>
> everything seems fine.. except that i dont get any calibration
> messages on the lcd.
>
> regards,
> Shareef
>
> On Mon, May 26, 2008 at 9:12 PM, Abraham Arce
> <abraham.arce.moreno@gmail.com> wrote:
>> On 5/26/08, mohammed shareef <mdshareef@gmail.com> wrote:
>>> Dear All,
>>>
>>> i cross-compiled the tslib for my filesystem as mentioned in:
>>> http://linux.omap.com/pipermail/linux-omap-open-source/2005-March/003174.html
>>>
>>> and i have put the executables in the filesystem.
>>> when i do
>>> /usr/X11/bin/ts_calibrate
>>>
>>> i dont get any "calibration request" on the LCD.
>>
>> when you run ts_calibrate what are the messages you are getting?
>>
>> are you receiving the following?
>>  Couldnt load module input
>> if so, add a third exported variable:
>>  export TSLIB_PLUGINDIR=/lib/ts
>>
>>> But when i do:
>>>
>>> cat /dev/input/event1
>>>
>>> i could see that i get stuff on my host computer when i touch the
>>> screen. which means that my toucscreen is associated with event1. i
>>> have even set up the proper environment variables.
>>>
>>> doing:
>>> cat /proc/interrupts
>>> also shows that spi interrupts incrementing on touching the screen.
>>>
>>> cat /proc/bus/input/devices
>>> I: Bus=0000 Vendor=0000 Product=0000 Version=0000
>>> N: Name="ADS784x Touchscreen"
>>> P: Phys=spi2.0/input0
>>> S: Sysfs=/class/input/input1
>>> H: Handlers=mouse0 event1 ts0
>>> B: EV=b
>>> B: KEY=400 0 0 0 0 0 0 0 0 0 0
>>> B: ABS=1000003
>>>
>>> but running
>>> ts_calibrate doesnt show any cross-hairs on the LCD.
>>>
>>> could you tell me if am missing something?
>>>
>>> thank you,
>>> warm regards,
>>> Shareef
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Please do not print this email unless it is absolutely necessary. Spread environmental awareness.

-------------------------------------------------------DISCLAIMER------------------------------------------------------
The information transmitted herewith is confidential and proprietary information intended only for use by the individual or entity to which it is addressed. If the reader of this message is not the intended recipient, you are hereby notified that any review, retransmission, dissemination, distribution, copying or other use of, or taking of any action in reliance upon this information is strictly prohibited. If you have received this communication in error, please contact the sender and delete the material from your computer.
--------------------------------------------------------------------------------------------------------------------------------



