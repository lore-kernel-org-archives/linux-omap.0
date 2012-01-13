From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 14:37:01 -0800
Message-ID: <87lipbp6uq.fsf@ti.com>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	<87hazzquhb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:36905 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754127Ab2AMWhG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 17:37:06 -0500
Received: by mail-yx0-f173.google.com with SMTP id l8so529942yen.32
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 14:37:04 -0800 (PST)
In-Reply-To: <87hazzquhb.fsf@ti.com> (Kevin Hilman's message of "Fri, 13 Jan
	2012 11:21:20 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

Kevin Hilman <khilman@ti.com> writes:

[...]

>> From: Paul Walmsley <paul@pwsan.com>
>> Date: Fri, 13 Jan 2012 02:10:30 -0700
>> Subject: [PATCH] ARM: OMAP3: PM: allow MPU to enter low-power states even
>>  when the UART is active
>>
>> For some reason, both the existing OMAP3 PM code and the OMAP3 CPUIdle
>> driver prevent the MPU powerdomain from entering low-power modes when
>> any UART isn't asleep.  Possibly it is intended to minimize the ARM
>> wakeup latency when UART activity arrives, but the UART has a FIFO
>> that should handle this for most cases, with no dropped characters.  I
>> may be forgetting something important, though.  And CORE/PER low-power
>> states are a different matter entirely.
>
> Just FYI... the UART can_sleep hackery was removed for v3.3 and replaced
> by using a PM QoS constraint:

However, looking closer I see now that the constraint being used in the
mailine driver uses the CPU_DMA_LATENCY QoS constraint, which is preventing 
deeper C states as well just like the current code (before your patch),
so an similar fix will still be needed for mainline.

Kevin
