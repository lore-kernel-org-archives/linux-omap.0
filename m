From: Mandeep Sandhu <mandeepsandhu.chd@gmail.com>
Subject: Re: test jiffies on ARM SMP board
Date: Thu, 21 Feb 2013 10:36:32 +0530
Message-ID: <CAC+QLdTxEng6o2QM5Rc+WGFkT1eSUhj4m4WCioZGisKSK=Vs3A@mail.gmail.com>
References: <BLU002-W18453B5FE6CB5CDDA18C8DBCF60@phx.gbl>
	<1361381081.16206.45.camel@anish-Inspiron-N5050>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43281 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab3BUFGd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 00:06:33 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so4508916pab.36
        for <linux-omap@vger.kernel.org>; Wed, 20 Feb 2013 21:06:33 -0800 (PST)
In-Reply-To: <1361381081.16206.45.camel@anish-Inspiron-N5050>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: anish kumar <anish198519851985@gmail.com>
Cc: buyitian <buyit@live.cn>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, "kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>

On Wed, Feb 20, 2013 at 10:54 PM, anish kumar
<anish198519851985@gmail.com> wrote:
> On Thu, 2013-02-21 at 00:39 +0800, buyitian wrote:
>> i am confused about my test. in one device driver,
>> i put below code:
>>
>>     printk("start to test test jiffies\n");
>>
>>     local_irq_save(flags);
>>
>>     jf1 = jiffies; // read jiffies first time
>>
>>     // hold cpu for about 2 seconds(do some calculation)
>>
>>     jf2 = jiffies; // read jiffies after 2 seconds
>>
>>     local_irq_restore(flags);
>>
>>     printk("jf1:%lu, jf2:%lu\n", jf1, jf2);
>>
>> and the output is as below:
>>
>>     <4>[  108.551124]start to test test jiffies
>>     <4>[  110.367604]jf1:4294948151, jf2:4294948151
>>
>> the jf1 and jf2 are the same value, although they are
>> read between 2 seconds interval, i think this is because
>> i disabled local interrupt.
>> but the printk timestamp is from 108.551124 to 110.367604,
>> which is about 2 seconds. and on my platform, printk timestamp
>> is got from the function read_sched_clock:
>>    static u32 __read_mostly (*read_sched_clock)(void) = jiffy_sched_clock_read;
>>
>> and function jiffy_sched_clock_read() is to read from jiffies.
>>
>> it seems that the jiffies is frozen when local irq is disabled,
>> but after local_irq_restore(), the jiffies not only start
>> to run, but also recover the lost 2 seconds.
>>
>> is the jiffies updated from another cpu when irq is disabled on
>> local cpu?
>>
>> is there some internel processor interrupt between cpu1 and cpu0
>> after local irq is re-enabled so that jiffies recover the lost 2 seconds?
> I think it is because of the fact that some RTC registers keep the

RTC (real time clock) chips are not very common in embedded SoCs. So
I'm not sure if they are involved here. Eg: we work on multi-core
media SoC and it doesn't have a RTC attached (if its needed it will
have to be added as an external peripheral). The SoC does however have
a couple of different clock sources for driving CPU, media decoder
cores etc.

HTH,
-mandeep

> elapsed time and when the irq is re-enabled the kernel reads these
> registers to be in sync with time.
> However I am not that sure which registers as I think that depends on
> the RTC chip and chip changes based on different boards.
> I hope some expert on these matters can pitch in here.
>> _______________________________________________
>> Kernelnewbies mailing list
>> Kernelnewbies@kernelnewbies.org
>> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>
>
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
