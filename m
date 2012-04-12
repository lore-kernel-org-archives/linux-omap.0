From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Thu, 12 Apr 2012 11:08:09 -0700
Message-ID: <877gxk962e.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<4F859C5D.3090400@mlbassoc.com> <87hawqt6vt.fsf@ti.com>
	<4F86B227.90802@mlbassoc.com> <87aa2hjavi.fsf@ti.com>
	<4F86F4B2.3080101@mlbassoc.com> <87aa2ganwj.fsf@ti.com>
	<4F870C6D.3030203@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47610 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933248Ab2DLSIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 14:08:13 -0400
Received: by dajx4 with SMTP id x4so3128544daj.28
        for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 11:08:11 -0700 (PDT)
In-Reply-To: <4F870C6D.3030203@mlbassoc.com> (Gary Thomas's message of "Thu,
	12 Apr 2012 11:10:05 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

Gary Thomas <gary@mlbassoc.com> writes:

> On 2012-04-12 10:57, Kevin Hilman wrote:
>> +Felipe for EHCI question
>>
>> Gary Thomas<gary@mlbassoc.com>  writes:
>>
>> [...]
>>
>>> This worked a treat, thanks.  My network performance is better
>>> now, but still not what it was.  The same TFTP transfer now takes
>>> 71 seconds, so about 50% slower than on the 3.0 kernel.  Applying the
>>> second [unnamed] patch (arch/arm/mach-omap2/cpuidle34xx.c) made no difference.
>>
>> And does a CONFIG_PM=n kernel get you back to your v3.0 performance?
>
> Correct.
>

OK, I just tried your TFTP experiment on a 3530/Overo board with the
same smsc911x NIC that has GPIO interrupts, and I don't see much
difference between a PM-enabled v3.0 and a PM-enabled v3.3.

Are you TFTP'ing the file to an MMC filesystem?    Can you try to a
ramdisk[1]?  If you're using MMC, it could be MMC driver changes since
v3.0 that are actually causing your performance hit.

In my experiment, I TFTP'd a 24Mb file to a ramdisk, to make sure no
other drivers were invovled, and didn't see any major differences
between v3.0, v3.3, and v3.3 CONFIG_PM disabled.

Below are my results.  As you can see, all the results seem to be pretty
close to the same.  This test was not on a controlled, isolated network,
so the differences are probably explained by other network activity:

- v3.0 vanilla: PM enabled, CPUidle enabled
  - Received 25362406 bytes in 35.5 seconds
  - Received 25362406 bytes in 44.9 seconds
  - Received 25362406 bytes in 49.0 seconds
  - Received 25362406 bytes in 36.2 seconds
  - Received 25362406 bytes in 56.3 seconds
  - Received 25362406 bytes in 65.2 seconds
  - Received 25362406 bytes in 37.0 seconds

- v3.3: PM enabled, CPUidle enabled
 + GPIO fix (my for_3.4/fixes/gpio branch)
 + smsc911x regulator boot fix (Tony's omap/fix-smsc911x-regulator branch)
  - Received 25362406 bytes in 32.1 seconds
  - Received 25362406 bytes in 29.8 seconds
  - Received 25362406 bytes in 33.5 seconds
  - Received 25362406 bytes in 44.5 seconds
  - Received 25362406 bytes in 39.2 seconds
  - Received 25362406 bytes in 57.0 seconds
  - Received 25362406 bytes in 49.6 seconds

- v3.3: CONFIG_PM=n + branches above 
 + fix from Grazvydas for !CONFIG_PM case: [PATCH] ARM: OMAP: sram: fix BUG in dpll code for !PM case
 + disable CONFIG_OMAP_WATCHDOG which fails to boot when CONFIG_PM=y 
  - Received 25362406 bytes in 34.1 seconds
  - Received 25362406 bytes in 33.9 seconds
  - Received 25362406 bytes in 34.9 seconds
  - Received 25362406 bytes in 37.8 seconds
  - Received 25362406 bytes in 40.0 seconds
  - Received 25362406 bytes in 37.6 seconds
  - Received 25362406 bytes in 34.4 seconds


Kevin

[1] simple steps to make a ramdisk
mkfs.ext2 /dev/ram0
mkdir /tmp/rd
mount /dev/ram0 /tmp/rd
cd /tmp/rd
<then TFTP file here>
