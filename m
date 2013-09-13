From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] arm: Fix build error with context tracking calls
Date: Fri, 13 Sep 2013 15:50:07 -0700
Message-ID: <87mwnggwv4.fsf@linaro.org>
References: <20130908090206.GK25647@n2100.arm.linux.org.uk>
	<522CB0DE.2010102@roeck-us.net>
	<20130909105115.GL25647@n2100.arm.linux.org.uk>
	<522DB86A.8010207@roeck-us.net>
	<alpine.LFD.2.03.1309091023440.20709@syhkavp.arg>
	<20130909160348.GB18975@roeck-us.net>
	<20130909203141.GM25647@n2100.arm.linux.org.uk>
	<20130909210203.GC28416@roeck-us.net>
	<alpine.LFD.2.03.1309091714420.20709@syhkavp.arg>
	<87y574g1fi.fsf@linaro.org> <20130913170331.GA8453@somewhere>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36428 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab3IMWuL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Sep 2013 18:50:11 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so3105679pab.29
        for <linux-omap@vger.kernel.org>; Fri, 13 Sep 2013 15:50:11 -0700 (PDT)
In-Reply-To: <20130913170331.GA8453@somewhere> (Frederic Weisbecker's message
	of "Fri, 13 Sep 2013 19:03:34 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>

Frederic Weisbecker <fweisbec@gmail.com> writes:

> On Tue, Sep 10, 2013 at 08:07:45AM -0700, Kevin Hilman wrote:
>> Nicolas Pitre <nicolas.pitre@linaro.org> writes:
>> 
>> > Adding Kevin Hilman to the CC as he might be interested as well.
>> 
>> Thanks, I'd already noticed this but was distracted getting arm-soc
>> changes ready for the merge window.  Looking into it now.
>
> Kevin, can you please try this patch? It built tested fine on ARM
> and live tested correctly on x86. There should be no problem but
> just in case.

Tested-by: Kevin Hilman <khilman@linaro.org>

Things are back to working again on ARM.  Thanks for the fix, and for
build testing on ARM.  

As you noticed to test on ARM, we still have to carry that patch to
drop that 'depends on 64BIT' in order to build/test this... any more
thoughts on what the remaining obstacles there are?

Kevin
