From: Christian Hoffmann <email@christianhoffmann.info>
Subject: Re: CPU_IDLE causes random reboots on custom 4430
Date: Tue, 25 Sep 2012 23:10:08 +0200
Message-ID: <50621DB0.9090607@christianhoffmann.info>
References: <505CEEFD.1080507@gmail.com> <CAMQu2gwwU2QYAmn+WY19t5krOJeEUF7YT03FojLbQcfo3h4BmQ@mail.gmail.com> <505DF146.6050100@gmail.com> <CAMQu2gw=Tki8uk_65w9iu645LY798Fr_GMHydF5XfZf8Xch5Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [88.175.101.52] ([88.175.101.52]:42798 "EHLO
	christianhoffmann.info" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1757997Ab2IYVKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 17:10:37 -0400
In-Reply-To: <CAMQu2gw=Tki8uk_65w9iu645LY798Fr_GMHydF5XfZf8Xch5Yg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Chris Hoffmann <chrmhoffmann@gmail.com>, linux-omap@vger.kernel.org

On 09/23/2012 06:11 PM, Shilimkar, Santosh wrote:
> On Sat, Sep 22, 2012 at 10:41 PM, Chris Hoffmann <chrmhoffmann@gmail.com> wrote:
>> On 09/22/2012 07:45 AM, Shilimkar, Santosh wrote:
>>>
>>> On Sat, Sep 22, 2012 at 4:19 AM, Chris Hoffmann <chrmhoffmann@gmail.com>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> We're trying to get a custom 4430 board (aka. nook tablet with OMAP4430
>>>> ES2.3 HS TWL6030 ES2.1) working with p-android-omap-3.0 on android jelly
>>>> bean. The board works quite well, but we experience random hangs and the
>>>> watchdog kicks the board to reboot.
>>>>
>>> On the same kernel, you should have support for the persistent log. You
>>> might
>>> want to check the output. That should give you pointers on what CPU was
>>> doing before the freeze which resulted in reboot.
>>
>>
>> Hi,
>>
>> I have some problems to provide logs. If I add -DDEBUG to cpuidle44xx.o the
>> problem doesn't seem to occur. It could be that printk-ing alleviates the
>> issue.
>>
>> Also the watchdog seems to shutdown the device rather than rebooting it (or
>> it hangs?) and then I can't provide /proc/last_kmsg.
>>
>> How could I provide more info?
>>
> Check if you have "/sys/kernel/debug/persistent_trace" available on
> your kernel. This generally helps whenever there are hangs, the last
> call stack is stored on memory and on the reboot it can be cat'ed to
> see if some useful information about hang is available.

Hi Santosh, all,

the p-android-omap-3.0 doesn't have the persistent_trace but I was able 
to backport it from 3.4 without major issues (only tricky part is that 
in p-android-3.4 there's no apparent user of that device in omapzoom 
kernel).

The problem is now that the omap-watchdog doesn't kick the device to 
reboot but rather to shutdown, so I still have no trace. Soft-rebooting 
shows that I can get persistent_trace.

Switching the persistent tracer to ecc=true does not help as it seems to 
overload the device completely when activating the tracing.

Rgds,
Chris



