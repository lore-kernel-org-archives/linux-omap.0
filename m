From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH] ARM: omap2plus_defconfig: Switch over to using 8250
 driver
Date: Sat, 11 Apr 2015 15:40:34 -0400
Message-ID: <552978B2.6000604@hurleysoftware.com>
References: <1428689893-14605-1-git-send-email-nm@ti.com> <55282737.8060407@hurleysoftware.com> <552967A0.9080804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33358 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313AbbDKTki (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Apr 2015 15:40:38 -0400
Received: by qkx62 with SMTP id 62so92679540qkx.0
        for <linux-omap@vger.kernel.org>; Sat, 11 Apr 2015 12:40:38 -0700 (PDT)
In-Reply-To: <552967A0.9080804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>
Cc: linux-omap@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>

On 04/11/2015 02:27 PM, Nishanth Menon wrote:
> On 04/10/2015 02:40 PM, Peter Hurley wrote:
>> [ +Sebastian, +Tony ]
>>
>> On 04/10/2015 02:18 PM, Nishanth Menon wrote:
>>> 8250 driver should be relatively feature complete. It can co-exist
>>> with omap-serial driver
>>
>> Not really; if the omap_8250 is selected then it is probed first
>> and will be the only driver claiming omap UART ports.
>>
>> omap-serial would just be dead-weight.
> 
> true.. my bad..
> 
>>
>>> , so just enable 8250 OMAP layer driver and
>>> route all ttyOx references to ttySx through the standard 8250 driver
>>> to ensure no breakage of userspace occurs.
>>
>> Not quite; the only automatic handling is for console only, not for
>> userspace. Expect lots of userspace breakage.
>>
> 
> 
> Yep - overall, looking through individual logs, in my testing, it seems
> to work at least for console for all platforms - even though the
> filesystems are mostly going bonkers -> older fs did not have the udev
> redirection to take care of this - mostly to do with the getty hooked on
> to static consoles.
> 
> 
> There are infact two issues:
> a) bootloader change for cmdline -> O2 to S2 -> in many cases we are
> lesser inclined to change the bootloader, hence the fixup configuration

Just an FYI - support for handling of _any_ console command line
string by _any_ driver was accepted for 4.01; the console can
declare a match() function which will be called at registration time
for every console command line, and can opt to perform console setup
using any criteria.

This provides a migration path for _any_ driver (and also allow any
earlycon-to-console handoff for non-8250 drivers by using a defined
match() function to match the appropriate earlycon= command line; the
particulars are in the univ8250_console_match() kernel-doc header in
-next).


> b) fs changes - these are sometimes more realistic to do, but is a clear
> breakage risk.
>
> Overall, keeping two equally functional drivers in the system sounds a
> bunch of maintenance burden for all of us and not to mention confusion
> for the future.

I think for the moment we should just freeze omap-serial and let
most of userspace catch up first; a lot of the official and
unofficial vender support is still stuck in 3.14. By the time,
3.19+ is de rigueur we'll hopefully have figured out the ttyS
sharing and how to migrate without breaking userspace.

> Btw, I am not exactly proposing this for 4.1 kernel..

:) I knew that.

> instead, we should
> probably discuss how to best introduce this in and throw out the older
> omap_serial driver - just reuse 8250 and co-exist with the rest of the
> good world folks ;)..

I agree -- thanks for bringing the topic up.

Regards,
Peter Hurley

