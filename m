From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 11:21:20 -0800
Message-ID: <87hazzquhb.fsf@ti.com>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:54194 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753346Ab2AMTVW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 14:21:22 -0500
Received: by mail-iy0-f172.google.com with SMTP id e16so4345179iaa.3
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 11:21:21 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com> (Paul
	Walmsley's message of "Fri, 13 Jan 2012 03:05:03 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> cc Tero, Govindraj
>
> On Thu, 12 Jan 2012, NeilBrown wrote:
>
>> On Wed, 11 Jan 2012 06:43:04 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
>> 
>> I spent some time exploring why cpuidle never drops below state 0 and found
>> out that the code explicitly disables other states when uart is active - for
>> a fairly broad definition of 'active'.
>> 
>> I found the "sleep_timeout" setting and set them all to 1 second.  This meant
>> that cpuidle started working, but I got a lot of garbage characters.
>> 
>
> ...
>
>> Does this really mean CPU_IDLE cannot be used when you might expect chars
>> from a serial port - e.g. GPS or Bluetooth?
>
> Hmmm.  Looking at mach-omap2/pm34xx.c and mach-omap2/cpuidle34xx.c, it 
> indeed prevents even the MPU from entering a low-power state when the UART 
> is active, as you write.  That doesn't seem correct.
>
> Please try the following patch.  It works fine for me on v3.2 with 
> omap2plus_defconfig on a 35xx BeagleBoard.  No dropped or garbled 
> characters with console use.  Not too surprising, since the UART has a 
> receive FIFO to withstand interrupt servicing delays.
>
>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Fri, 13 Jan 2012 02:10:30 -0700
> Subject: [PATCH] ARM: OMAP3: PM: allow MPU to enter low-power states even
>  when the UART is active
>
> For some reason, both the existing OMAP3 PM code and the OMAP3 CPUIdle
> driver prevent the MPU powerdomain from entering low-power modes when
> any UART isn't asleep.  Possibly it is intended to minimize the ARM
> wakeup latency when UART activity arrives, but the UART has a FIFO
> that should handle this for most cases, with no dropped characters.  I
> may be forgetting something important, though.  And CORE/PER low-power
> states are a different matter entirely.

Just FYI... the UART can_sleep hackery was removed for v3.3 and replaced
by using a PM QoS constraint:

commit 2fd149645eb46d26130d7070c6de037dddf34880
Author: Govindraj.R <govindraj.raja@ti.com>
Date:   Wed Nov 9 17:41:21 2011 +0530

    ARM: OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos
    
Kevin
