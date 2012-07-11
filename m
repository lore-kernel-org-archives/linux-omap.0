From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: suspend broken on 3.5-rc1?
Date: Wed, 11 Jul 2012 16:06:06 -0500
Message-ID: <CALLhW=5HUJuUbEoz7GXJ3h75iqB_9_bNrofBU45zKQejkKExAQ@mail.gmail.com>
References: <4FD1D570.1010508@ti.com>
	<20120608105611.GO12766@atomide.com>
	<4FD1EF25.3060906@ti.com>
	<1339160732.2091.47.camel@sokoban>
	<4FD1FB47.8040007@ti.com>
	<4FD72FB7.60905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54004 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab2GKVGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 17:06:07 -0400
Received: by vcbf11 with SMTP id f11so1068760vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 14:06:06 -0700 (PDT)
In-Reply-To: <4FD72FB7.60905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: t-kristo@ti.com, Tony Lindgren <tony@atomide.com>, loml <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>

On 12 June 2012 07:01, Rajendra Nayak <rnayak@ti.com> wrote:
> On Friday 08 June 2012 06:46 PM, Rajendra Nayak wrote:
>>
>> On Friday 08 June 2012 06:35 PM, Tero Kristo wrote:
>>>
>>> On Fri, 2012-06-08 at 17:55 +0530, Rajendra Nayak wrote:
>>>>
>>>> On Friday 08 June 2012 04:26 PM, Tony Lindgren wrote:
>>>>>
>>>>> * Rajendra Nayak<rnayak@ti.com> [120608 03:40]:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I don;t seem to be able to get suspend to work on 3.5-rc1 on
>>>>>> my 4430 panda. I am not sure if its UART wakeups that are
>>>>>> an issue or suspend itself is broken.
>>>>>> Is there anything more than setting
>>>>>> '/sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup'
>>>>>> to 'enabled' that I need to do to get UART to be wakeup capable?
>>>>>>
>>>>>> 3.4 major works just fine for me.
>>>>>
>>>>>
>>>>> Can you try with the fixes branch that Olof just merged?
>>>>
>>>>
>>>> I tried merging the fixes branch on 3.5-rc1 as well as latest
>>>> mainline and both didn't work.
>>>>
>>>>> If it's the UART wake-up events, there's a patch that should
>>>>> help.
>>>>>
>>>>> Tony
>>>>
>>>>
>>>
>>> The patch referenced here helps:
>>>
>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69596.html
>>>
>>> DSS crashes during wakeup from suspend.
>>
>>
>> great, thats what I found too with no_console_suspend, didn't know
>> a fix already exists. Thanks.
>
>
> The patch above seems to fix suspend on 4430, but on my 4460 ES1.1 panda, I
> still see its broken..
>
> # echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup
> # echo mem > /sys/power/state
> [    6.549285] PM: Syncing filesystems ... done.
> [    6.581695] Freezing user space processes ... (elapsed 0.02 seconds)
> done.
> [    6.612823] Freezing remaining freezable tasks ... (elapsed 0.02 seconds)
> done.
> [    6.674102] PM: suspend of devices complete after 51.391 msecs
> [    6.682006] PM: late suspend of devices complete after 1.739 msecs
> [    6.691650] PM: noirq suspend of devices complete after 3.143 msecs
> [    6.698272] Disabling non-boot CPUs ...
> [    6.705993] CPU1: shutdown
> [    7.298797] Successfully put all powerdomains to target state
> [    7.304992] Enabling non-boot CPUs ... *<---- hang*
>
> ..anyone knows of any more fixes going around?

I'm seeing the same thing, it gets stuck trying to enable CPU1, tried
this with pm-20120710 from linux-omap-pm and current LO master (based
on 3.5-rc6), also using a Panda 4460.

Would appreciate patches if any.

Regards,

Omar
