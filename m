From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [ANNOUNCE] updated PM branch
Date: Wed, 17 Dec 2008 15:53:00 -0800
Message-ID: <494990DC.5080407@deeprootsystems.com>
References: <87k5a098zd.fsf@deeprootsystems.com> <87myeu1whz.fsf@deeprootsystems.com> <764864D8-4A22-44B9-ABF2-42664AC6583D@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:6388 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbYLQXxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2008 18:53:04 -0500
Received: by yx-out-2324.google.com with SMTP id 8so73174yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 17 Dec 2008 15:53:03 -0800 (PST)
In-Reply-To: <764864D8-4A22-44B9-ABF2-42664AC6583D@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Koen Kooi wrote:
> 
> Op 17 dec 2008, om 19:34 heeft Kevin Hilman het volgende geschreven:
> 
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>>
>>> The PM branch has been consolidated and rebased against today's
>>> linux-omap HEAD.  I've also included a few patches that were posted to
>>> the list that had fallen through the cracks.
>>
>> I did a couple minor updates to to the pm branch, and rebased it to
>> current HEAD.  The updates include
>>
>> - more patch consolidation
>> - VDD2 patch from Rajendra
>> - updated IVA2 reset patch which actually works :)
>> - included the GPTIMER12 fixes for Beagle
>>
>> I also tested on Beagle.  Here are some results when using a minimal
>> defconfig (attached) and using an initramfs.  I had to disable MMC and
>> USB as they are currently preventing the low-level chip retention:
>>
>> I tested this on the latest PM branch of linux-omap:
>>
>> - boot idle: 342 mA
>>
>> - screen blank: 238 mA
>>  # echo 3 > /sys/class/graphics/fb0/blank
>>
>> - suspend: 85 mA
>>  # echo 1 > /sys/power/clocks_off_while_idle
>>  # echo mem > /sys/power/state
>>
>> - sleep-while-idle: 85 mA
>>  - this same state as suspend, but happens in idle
>>  # echo 1 > /sys/power/sleep_while_idle
>>
>> This is with current PM branch of linux-omap.  I understand that
>> Tomi's new DSS tree has support to turn off the DVI framer which
>> should save even more power, but I have not tested that.
> 
> Try toggling GPIO 170 manually, current consumption should drop with 
> 60-80mA.
> 

That didn't seem to change anything for me.

Looking closer, drivers/video/omap/lcd_omap3beagle.c is already toggling
GPIO 170 in current linux-omap.  So the ~80mA drop above between 'boot 
idle' and 'screen blank' is probably already counting the DVI framer.

Kevin
