From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: omap 0sk and mistral touchscreen..
Date: Tue, 27 May 2008 19:12:20 +0530
Message-ID: <a1d91fa0805270642i66744055oe2f3f72863065995@mail.gmail.com>
References: <a1d91fa0805252349w266c2f8x11377f2dce066b93@mail.gmail.com>
	 <cb8016980805260842m2f06e9e8yb39fd91f1384d921@mail.gmail.com>
	 <a1d91fa0805262126v65745282k4ac45d3e71c1894f@mail.gmail.com>
	 <001101c8bfb7$01e58ac0$310da8c0@mistral.in>
	 <a1d91fa0805262232g4a441f5fwdb62a7015b1f0e84@mail.gmail.com>
	 <cb8016980805262237q54980f33y6a58d7fdf25328f5@mail.gmail.com>
	 <a1d91fa0805262239m10ae2836p776c94207852e19f@mail.gmail.com>
	 <a1d91fa0805262330h5e3990b9u1ce4577d3fc269fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:7491 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757502AbYE0NmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2008 09:42:24 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1791542tic.23
        for <linux-omap@vger.kernel.org>; Tue, 27 May 2008 06:42:20 -0700 (PDT)
In-Reply-To: <a1d91fa0805262330h5e3990b9u1ce4577d3fc269fa@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abraham Arce <abraham.arce.moreno@gmail.com>
Cc: "S. Rajeev" <srajeev@mistralsolutions.com>, omap <linux-omap@vger.kernel.org>

Hi,
everything looks fine from the kernel side. I think the problem might
be in the file system. i have used the following options to get the
touchscreen files compiled from tslib:

./autogen.sh

./configure --prefix=/tslib --host=arm-linux-gnu

make

make install

is it right?

regards,
Shareef

On Tue, May 27, 2008 at 12:00 PM, mohammed shareef <mdshareef@gmail.com> wrote:
> hi,
>
> i currently dont have any GUI on it. But the display is turned on as
> am able to see the linux logo and also able to write characters to the
> lcd.
>
> i would like to add here that i DID NOT get
> [*] Touchscreens
>  <*> OMAP touchscreen input driver "
>
> but instead i enabled the ADS7846 touchscreen. Actually i couldnt find
> omap touchscreen on linux2.6.18.
>
> regards,
> Shareef
>
>
> On Tue, May 27, 2008 at 11:09 AM, mohammed shareef <mdshareef@gmail.com> wrote:
>> hi,
>>
>> i currently dont have any GUI on it. But the display is turned on as
>> am able to see the linux logo and also able to write characters to the
>> lcd.
>>
>> regards,
>> Shareef
>>
>> On Tue, May 27, 2008 at 11:07 AM, Abraham Arce
>> <abraham.arce.moreno@gmail.com> wrote:
>>> Shareef,
>>>
>>> Any feature that turns off the display some time after boot up?
>>>
>>> If you execute Xfbdev, are you able to see the X cursor?
>>>
>>> If you execute Xfbdev in background and then start ts_calibrate, what
>>> do you get in display and serial port?
>>>
>>> Best Regards
>>> Abraham
>>>
>>>
>>> On Tue, May 27, 2008 at 12:32 AM, mohammed shareef <mdshareef@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> i tried the following environment variables:
>>>>
>>>> # export TSLIB_TSDEVICE=/dev/input/event1
>>>> # export TSLIB_CONFFILE=/etc/ts.conf
>>>> # export TSLIB_FBDEVICE=/dev/fb0
>>>> # export TSLIB_PLUGINDIR=/usr/lib/ts
>>>> # export TSLIB_CALIBFILE=/etc/pointercal
>>>> # export TSLIB_CONSOLEDEVICE=none
>>>> # /usr/X11/bin/ts_calibrate
>>>>
>>>> also int the "ts.conf"  file "module_raw input" is uncommented .
>>>>
>>>> but again nothing comes up on the LCD screen.
>>>>
>>>> thanx and regards,
>>>> Shareef
>>>>
>>>> On Tue, May 27, 2008 at 10:33 AM, S.Rajeev <srajeev@mistralsolutions.com> wrote:
>>>>> Hi ,
>>>>>
>>>>>
>>>>> Make the following change :
>>>>>
>>>>> 1) In the "ts.conf"  file make sure "module_raw input" is uncommented .
>>>>> 2) export TSLIB_CONSOLEDEVICE=none
>>>>>
>>>>>
>>>>> Thanks and Regards
>>>>> rajeev
>>>>>
>>>>> ----- Original Message ----- From: "mohammed shareef" <mdshareef@gmail.com>
>>>>> To: "Abraham Arce" <abraham.arce.moreno@gmail.com>
>>>>> Cc: "omap" <linux-omap@vger.kernel.org>
>>>>> Sent: Tuesday, May 27, 2008 9:56 AM
>>>>> Subject: Re: omap 0sk and mistral touchscreen..
>>>>>
>>>>>
>>>>>> Dear Abraham,
>>>>>>
>>>>>> I am not receiving any error nor any messages on the LCD.. i have
>>>>>> added the following environment variables:
>>>>>>
>>>>>> export TSLIB_TSDEVICE=/dev/input/event1
>>>>>> export TSLIB_CONFFILE=/etc/ts.conf
>>>>>> export TSLIB_CONSOLEDEVICE=/dev/ttyS0
>>>>>> export TSLIB_FBDEVICE=/dev/fb0
>>>>>> export TSLIB_PLUGINDIR=/usr/lib/ts
>>>>>> export TSLIB_CALIBFILE=/etc/pointercal
>>>>>>
>>>>>> everything seems fine.. except that i dont get any calibration
>>>>>> messages on the lcd.
>>>>>>
>>>>>> regards,
>>>>>> Shareef
>>>>>>
>>>>>> On Mon, May 26, 2008 at 9:12 PM, Abraham Arce
>>>>>> <abraham.arce.moreno@gmail.com> wrote:
>>>>>>>
>>>>>>> On 5/26/08, mohammed shareef <mdshareef@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Dear All,
>>>>>>>>
>>>>>>>> i cross-compiled the tslib for my filesystem as mentioned in:
>>>>>>>>
>>>>>>>> http://linux.omap.com/pipermail/linux-omap-open-source/2005-March/003174.html
>>>>>>>>
>>>>>>>> and i have put the executables in the filesystem.
>>>>>>>> when i do
>>>>>>>> /usr/X11/bin/ts_calibrate
>>>>>>>>
>>>>>>>> i dont get any "calibration request" on the LCD.
>>>>>>>
>>>>>>> when you run ts_calibrate what are the messages you are getting?
>>>>>>>
>>>>>>> are you receiving the following?
>>>>>>>  Couldnt load module input
>>>>>>> if so, add a third exported variable:
>>>>>>>  export TSLIB_PLUGINDIR=/lib/ts
>>>>>>>
>>>>>>>> But when i do:
>>>>>>>>
>>>>>>>> cat /dev/input/event1
>>>>>>>>
>>>>>>>> i could see that i get stuff on my host computer when i touch the
>>>>>>>> screen. which means that my toucscreen is associated with event1. i
>>>>>>>> have even set up the proper environment variables.
>>>>>>>>
>>>>>>>> doing:
>>>>>>>> cat /proc/interrupts
>>>>>>>> also shows that spi interrupts incrementing on touching the screen.
>>>>>>>>
>>>>>>>> cat /proc/bus/input/devices
>>>>>>>> I: Bus=0000 Vendor=0000 Product=0000 Version=0000
>>>>>>>> N: Name="ADS784x Touchscreen"
>>>>>>>> P: Phys=spi2.0/input0
>>>>>>>> S: Sysfs=/class/input/input1
>>>>>>>> H: Handlers=mouse0 event1 ts0
>>>>>>>> B: EV=b
>>>>>>>> B: KEY=400 0 0 0 0 0 0 0 0 0 0
>>>>>>>> B: ABS=1000003
>>>>>>>>
>>>>>>>> but running
>>>>>>>> ts_calibrate doesnt show any cross-hairs on the LCD.
>>>>>>>>
>>>>>>>> could you tell me if am missing something?
>>>>>>>>
>>>>>>>> thank you,
>>>>>>>> warm regards,
>>>>>>>> Shareef
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>
>>>>>
>>>>> Please do not print this email unless it is absolutely necessary. Spread
>>>>> environmental awareness.
>>>>>
>>>>> -------------------------------------------------------DISCLAIMER------------------------------------------------------
>>>>> The information transmitted herewith is confidential and proprietary
>>>>> information intended only for use by the individual or entity to which it is
>>>>> addressed. If the reader of this message is not the intended recipient, you
>>>>> are hereby notified that any review, retransmission, dissemination,
>>>>> distribution, copying or other use of, or taking of any action in reliance
>>>>> upon this information is strictly prohibited. If you have received this
>>>>> communication in error, please contact the sender and delete the material
>>>>> from your computer.
>>>>> --------------------------------------------------------------------------------------------------------------------------------
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>
>
