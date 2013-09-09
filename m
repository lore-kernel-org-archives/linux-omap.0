From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Build error in torvalds kernel 3.11 for omap2plus
Date: Mon, 9 Sep 2013 21:31:41 +0100
Message-ID: <20130909203141.GM25647@n2100.arm.linux.org.uk>
References: <CABYxbz7m4GdHFNY3fP1Cpv3a_dNTSozdd7dX9yLG6vQ3zZxu9A@mail.gmail.com> <20130908090206.GK25647@n2100.arm.linux.org.uk> <522CB0DE.2010102@roeck-us.net> <20130909105115.GL25647@n2100.arm.linux.org.uk> <522DB86A.8010207@roeck-us.net> <alpine.LFD.2.03.1309091023440.20709@syhkavp.arg> <20130909160348.GB18975@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54167 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698Ab3IIUb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Sep 2013 16:31:57 -0400
Content-Disposition: inline
In-Reply-To: <20130909160348.GB18975@roeck-us.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>

On Mon, Sep 09, 2013 at 09:03:48AM -0700, Guenter Roeck wrote:
> Unfortunately, there are more problems.
> 
> arch/arm/kernel/built-in.o: In function `ret_fast_syscall':
> /home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:42: undefined reference to `user_enter'
> arch/arm/kernel/built-in.o: In function `no_work_pending':
> /home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:77: undefined reference to `user_enter'
> arch/arm/kernel/built-in.o: In function `vector_swi':
> /home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:376: undefined reference to `user_exit'
> arch/arm/kernel/built-in.o: In function `__dabt_usr':
> /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:365: undefined reference to `user_exit'
> arch/arm/kernel/built-in.o: In function `__irq_usr':
> /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:375: undefined reference to `user_exit'
> arch/arm/kernel/built-in.o: In function `__und_usr':
> /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:388: undefined reference to `user_exit'
> arch/arm/kernel/built-in.o: In function `__pabt_usr':
> /home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:662: undefined reference to `user_exit'

These are due to ad65782fba50 (context_tracking: Optimize main APIs off case
with static key) converting these functions to be inline.

No idea what the fix for this is other than reverting the change.  Any
ideas Frederic?
