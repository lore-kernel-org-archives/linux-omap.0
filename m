From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Build error in torvalds kernel 3.11 for omap2plus
Date: Tue, 10 Sep 2013 17:09:25 +0200
Message-ID: <20130910150923.GA30731@somewhere>
References: <20130908090206.GK25647@n2100.arm.linux.org.uk>
 <522CB0DE.2010102@roeck-us.net>
 <20130909105115.GL25647@n2100.arm.linux.org.uk>
 <522DB86A.8010207@roeck-us.net>
 <alpine.LFD.2.03.1309091023440.20709@syhkavp.arg>
 <20130909160348.GB18975@roeck-us.net>
 <20130909203141.GM25647@n2100.arm.linux.org.uk>
 <20130909210203.GC28416@roeck-us.net>
 <alpine.LFD.2.03.1309091714420.20709@syhkavp.arg>
 <87y574g1fi.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:36227 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab3IJPJ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Sep 2013 11:09:28 -0400
Received: by mail-ee0-f47.google.com with SMTP id d49so3902174eek.20
        for <linux-omap@vger.kernel.org>; Tue, 10 Sep 2013 08:09:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87y574g1fi.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>

On Tue, Sep 10, 2013 at 08:07:45AM -0700, Kevin Hilman wrote:
> Nicolas Pitre <nicolas.pitre@linaro.org> writes:
> 
> > Adding Kevin Hilman to the CC as he might be interested as well.
> 
> Thanks, I'd already noticed this but was distracted getting arm-soc
> changes ready for the merge window.  Looking into it now.

I have the fix pending. It passed the cross build so I'll send it soon.

Thanks.

> 
> Kevin
> 
> > On Mon, 9 Sep 2013, Guenter Roeck wrote:
> >
> >> On Mon, Sep 09, 2013 at 09:31:41PM +0100, Russell King - ARM Linux wrote:
> >> > On Mon, Sep 09, 2013 at 09:03:48AM -0700, Guenter Roeck wrote:
> >> > > Unfortunately, there are more problems.
> >> > > 
> >> > > arch/arm/kernel/built-in.o: In function `ret_fast_syscall':
> >> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:42:
> >> > > undefined reference to `user_enter'
> >> > > arch/arm/kernel/built-in.o: In function `no_work_pending':
> >> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:77:
> >> > > undefined reference to `user_enter'
> >> > > arch/arm/kernel/built-in.o: In function `vector_swi':
> >> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:376:
> >> > > undefined reference to `user_exit'
> >> > > arch/arm/kernel/built-in.o: In function `__dabt_usr':
> >> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:365: undefined reference to `user_exit'
> >> > > arch/arm/kernel/built-in.o: In function `__irq_usr':
> >> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:375: undefined reference to `user_exit'
> >> > > arch/arm/kernel/built-in.o: In function `__und_usr':
> >> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:388: undefined reference to `user_exit'
> >> > > arch/arm/kernel/built-in.o: In function `__pabt_usr':
> >> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:662: undefined reference to `user_exit'
> >> > 
> >> > These are due to ad65782fba50 (context_tracking: Optimize main APIs off case
> >> > with static key) converting these functions to be inline.
> >> > 
> >> > No idea what the fix for this is other than reverting the change.  Any
> >> > ideas Frederic?
> >> > 
> >> I am all for reverting unless this can be fixed quickly.
> >> AFAICS this breaks all arm builds if CONFIG_CONTEXT_TRACKING is enabled.
> >> 
> >> Guenter
> >> 
