From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: Build error in torvalds kernel 3.11 for omap2plus
Date: Mon, 9 Sep 2013 17:16:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309091714420.20709@syhkavp.arg>
References: <CABYxbz7m4GdHFNY3fP1Cpv3a_dNTSozdd7dX9yLG6vQ3zZxu9A@mail.gmail.com> <20130908090206.GK25647@n2100.arm.linux.org.uk> <522CB0DE.2010102@roeck-us.net> <20130909105115.GL25647@n2100.arm.linux.org.uk> <522DB86A.8010207@roeck-us.net>
 <alpine.LFD.2.03.1309091023440.20709@syhkavp.arg> <20130909160348.GB18975@roeck-us.net> <20130909203141.GM25647@n2100.arm.linux.org.uk> <20130909210203.GC28416@roeck-us.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:63409 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab3IIVQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Sep 2013 17:16:59 -0400
Received: by mail-qe0-f52.google.com with SMTP id i11so3619782qej.25
        for <linux-omap@vger.kernel.org>; Mon, 09 Sep 2013 14:16:58 -0700 (PDT)
In-Reply-To: <20130909210203.GC28416@roeck-us.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Kevin Hilman <khilman@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Frederic Weisbecker <fweisbec@gmail.com>, Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>


Adding Kevin Hilman to the CC as he might be interested as well.

On Mon, 9 Sep 2013, Guenter Roeck wrote:

> On Mon, Sep 09, 2013 at 09:31:41PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 09, 2013 at 09:03:48AM -0700, Guenter Roeck wrote:
> > > Unfortunately, there are more problems.
> > > 
> > > arch/arm/kernel/built-in.o: In function `ret_fast_syscall':
> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:42: undefined reference to `user_enter'
> > > arch/arm/kernel/built-in.o: In function `no_work_pending':
> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:77: undefined reference to `user_enter'
> > > arch/arm/kernel/built-in.o: In function `vector_swi':
> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:376: undefined reference to `user_exit'
> > > arch/arm/kernel/built-in.o: In function `__dabt_usr':
> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:365: undefined reference to `user_exit'
> > > arch/arm/kernel/built-in.o: In function `__irq_usr':
> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:375: undefined reference to `user_exit'
> > > arch/arm/kernel/built-in.o: In function `__und_usr':
> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:388: undefined reference to `user_exit'
> > > arch/arm/kernel/built-in.o: In function `__pabt_usr':
> > > /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:662: undefined reference to `user_exit'
> > 
> > These are due to ad65782fba50 (context_tracking: Optimize main APIs off case
> > with static key) converting these functions to be inline.
> > 
> > No idea what the fix for this is other than reverting the change.  Any
> > ideas Frederic?
> > 
> I am all for reverting unless this can be fixed quickly.
> AFAICS this breaks all arm builds if CONFIG_CONTEXT_TRACKING is enabled.
> 
> Guenter
> 
