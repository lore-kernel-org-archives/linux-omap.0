From: Chris Hoffmann <chrmhoffmann@gmail.com>
Subject: Re: CPU_IDLE causes random reboots on custom 4430
Date: Sat, 22 Sep 2012 19:11:34 +0200
Message-ID: <505DF146.6050100@gmail.com>
References: <505CEEFD.1080507@gmail.com> <CAMQu2gwwU2QYAmn+WY19t5krOJeEUF7YT03FojLbQcfo3h4BmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45750 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab2IVRLk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Sep 2012 13:11:40 -0400
Received: by eaac11 with SMTP id c11so1387399eaa.19
        for <linux-omap@vger.kernel.org>; Sat, 22 Sep 2012 10:11:39 -0700 (PDT)
In-Reply-To: <CAMQu2gwwU2QYAmn+WY19t5krOJeEUF7YT03FojLbQcfo3h4BmQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Chris Hoffmann <chrmhoffmann@gmail.com>, linux-omap@vger.kernel.org

On 09/22/2012 07:45 AM, Shilimkar, Santosh wrote:
> On Sat, Sep 22, 2012 at 4:19 AM, Chris Hoffmann <chrmhoffmann@gmail.com> wrote:
>> Hi,
>>
>> We're trying to get a custom 4430 board (aka. nook tablet with OMAP4430
>> ES2.3 HS TWL6030 ES2.1) working with p-android-omap-3.0 on android jelly
>> bean. The board works quite well, but we experience random hangs and the
>> watchdog kicks the board to reboot.
>>
> On the same kernel, you should have support for the persistent log. You might
> want to check the output. That should give you pointers on what CPU was
> doing before the freeze which resulted in reboot.

Hi,

I have some problems to provide logs. If I add -DDEBUG to cpuidle44xx.o 
the problem doesn't seem to occur. It could be that printk-ing 
alleviates the issue.

Also the watchdog seems to shutdown the device rather than rebooting it 
(or it hangs?) and then I can't provide /proc/last_kmsg.

How could I provide more info?

Rgds,
Chris



