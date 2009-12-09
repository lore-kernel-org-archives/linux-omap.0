From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Smartreflex: Avoid unnecessary spam
Date: Wed, 09 Dec 2009 15:51:24 -0800
Message-ID: <87d42nso3n.fsf@deeprootsystems.com>
References: <1260281775-30361-1-git-send-email-tero.kristo@nokia.com>
	<87y6lbsprl.fsf@deeprootsystems.com> <20091209232309.GA9514@nokia.com>
	<4B2036F8.1090301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:60920 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758801AbZLIXvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 18:51:21 -0500
Received: by gxk4 with SMTP id 4so11729858gxk.8
        for <linux-omap@vger.kernel.org>; Wed, 09 Dec 2009 15:51:27 -0800 (PST)
In-Reply-To: <4B2036F8.1090301@ti.com> (Nishanth Menon's message of "Wed\, 9 Dec 2009 17\:47\:04 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Felipe Balbi had written, on 12/09/2009 05:23 PM, the following:
>> On Thu, Dec 10, 2009 at 12:15:26AM +0100, ext Kevin Hilman wrote:
>>> Tero Kristo <tero.kristo@nokia.com> writes:
>>>
>>>> From: Tero Kristo <tero.kristo@nokia.com>
>>>>
>>>> Current warning messages will be constantly printed out during normal operation
>>>> if smartreflex autocompensation is disabled.
>>>>
>>>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>>> Agreed that these warnings are spam, but I think they should be
>>> replaced by some one-time warning so at least there's a hint someplace
>>> that SR is not actually being done on a platfrom.
>>
>> well, there's printk_once()
>>
>> include/linux/kernel.h:
>>
>> 250 /*       251  * Print a one-time message (analogous to
>> WARN_ONCE() et al):
>> 252  */                  253 #define printk_once(x...) ({
>> \
>> 254         static bool __print_once = true;        \
>> 255                                                 \
>> 256         if (__print_once) {                     \
>> 257                 __print_once = false;           \
>> 258                 printk(x);                      \
>> 259         }                                       \
>> 260 })
>>
>> and WARN_ONCE()
>>
>> include/asm-generic/bug.h:
>>
>> 125 #define WARN_ONCE(condition, format...) ({                      \
>> 126         static int __warned;                                    \
>> 127         int __ret_warn_once = !!(condition);                    \
>> 128                                                                 \
>> 129         if (unlikely(__ret_warn_once))                          \
>> 130                 if (WARN(!__warned, format))                    \
>> 131                         __warned = 1;                           \
>> 132         unlikely(__ret_warn_once);                              \
>> 133 })
>>
>> I guess printk_once() is better.
>>
> But what is the point in having it?
> situation 1:
> sr_start_vddautocomap() gets called for starting AVS while dvfs. The
> spam message just warns user that autocomp is not set when OPP change
> happens.
>
> case 1 against printing it:
> If the user had disabled vddautocomp, then the warnings have no
> rational in warning the user which he/she already knows about.
>
> case 2 against printing it using printk_once:
> situation x:
> step 1: autocomp disabled, dvfs transitions -> printk_once will print
> only once.
> step 2: autocomp enabled, dvfs transitions - no prints.
> step 3: autocomp disabled, dvfs - we wont see prints :(
> Agreed, we could have an equivalent implementation using a static bool
> instead of using printk_once .. still a nuisance message which does
> not provide additional info.. other than adding a latency overhead.
>
> situation 2:
> when attempting to enable SR when nvalues are not present (e.g. on
> 3530/3430 es3.0).. here the return value should be used and is more
> informative and usable from a application perspective..
>
> just my 2 cents..

OK, I'm sold.  

Applying Tero's original patch.

Kevin


