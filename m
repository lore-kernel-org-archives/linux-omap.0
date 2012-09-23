From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: CPU_IDLE causes random reboots on custom 4430
Date: Sun, 23 Sep 2012 21:41:34 +0530
Message-ID: <CAMQu2gw=Tki8uk_65w9iu645LY798Fr_GMHydF5XfZf8Xch5Yg@mail.gmail.com>
References: <505CEEFD.1080507@gmail.com> <CAMQu2gwwU2QYAmn+WY19t5krOJeEUF7YT03FojLbQcfo3h4BmQ@mail.gmail.com>
 <505DF146.6050100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:42120 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754027Ab2IWQL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Sep 2012 12:11:57 -0400
Received: by vcbfo13 with SMTP id fo13so5514413vcb.19
        for <linux-omap@vger.kernel.org>; Sun, 23 Sep 2012 09:11:55 -0700 (PDT)
In-Reply-To: <505DF146.6050100@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Hoffmann <chrmhoffmann@gmail.com>
Cc: linux-omap@vger.kernel.org

On Sat, Sep 22, 2012 at 10:41 PM, Chris Hoffmann <chrmhoffmann@gmail.com> wrote:
> On 09/22/2012 07:45 AM, Shilimkar, Santosh wrote:
>>
>> On Sat, Sep 22, 2012 at 4:19 AM, Chris Hoffmann <chrmhoffmann@gmail.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> We're trying to get a custom 4430 board (aka. nook tablet with OMAP4430
>>> ES2.3 HS TWL6030 ES2.1) working with p-android-omap-3.0 on android jelly
>>> bean. The board works quite well, but we experience random hangs and the
>>> watchdog kicks the board to reboot.
>>>
>> On the same kernel, you should have support for the persistent log. You
>> might
>> want to check the output. That should give you pointers on what CPU was
>> doing before the freeze which resulted in reboot.
>
>
> Hi,
>
> I have some problems to provide logs. If I add -DDEBUG to cpuidle44xx.o the
> problem doesn't seem to occur. It could be that printk-ing alleviates the
> issue.
>
> Also the watchdog seems to shutdown the device rather than rebooting it (or
> it hangs?) and then I can't provide /proc/last_kmsg.
>
> How could I provide more info?
>
Check if you have "/sys/kernel/debug/persistent_trace" available on
your kernel. This generally helps whenever there are hangs, the last
call stack is stored on memory and on the reboot it can be cat'ed to
see if some useful information about hang is available.

Regards
Santosh
