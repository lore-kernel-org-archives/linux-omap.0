From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH 05/10] ARM: OMAP1: Make 770 LCD work
Date: Fri, 29 May 2009 01:29:52 +0100
Message-ID: <20090529012952.104144iws1glmow0@lidskialf.net>
References: <20090519232905.12760.15490.stgit@localhost>
	<20090519233732.12760.34595.stgit@localhost>
	<20090525092911.GC28195@n2100.arm.linux.org.uk>
	<20090525142128.17675cl0tvdr0y1k@lidskialf.net>
	<20090525174055.127744136qxu9vk0@lidskialf.net>
	<20090528182047.GF32453@atomide.com>
	<20090528195046.GW20736@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:52608 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbZE2A3w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 20:29:52 -0400
In-Reply-To: <20090528195046.GW20736@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Quoting Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Thu, May 28, 2009 at 11:20:48AM -0700, Tony Lindgren wrote:
>> * Andrew de Quincey <adq_dvb@lidskialf.net> [090525 09:41]:
>> > Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:
>> >
>> >> Quoting Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> >>
>> >>> On Tue, May 19, 2009 at 04:37:32PM -0700, Tony Lindgren wrote:
>> >>>> Make 770 LCD work by passing the clock from platform data.
>> >>>> Also remove the old unused functions.
>> >>>
>> >>> I don't like this - because its passing struct clk's through platform
>> >>> data.  That's not how things are supposed to work.
>> >>>
>> >>> The way PXA solves this problem is to have clock aliases - see
>> >>> clk_add_alias().
>> >>
>> >> Interesting idea - I now have a prototype patch implementing this,
>> >> which I'll send when I get home (otherwise it would be an "it
>> >> compiles" "test" :)
>> >>
>> >> There isn't a common definition of clk_add_alias() though - that
>> >> symbol is defined in arch/arm/mach-pxa/clock.c, so I had to copy it
>> >> into arch/arm/plat-omap/clock.c
>> >
>> > Attached is a patch implementing this method. I don't like the
>> > duplication of the clk_alias code, but I imagine that could be resolved
>> > if this method was chosen....
>>
>> Andrew, can you please reply with your Signed-off-by?
>
> Actually, I'm very tempted to suggest that clk_add_alias() should go
> into arch/arm/common/clkdev.c if we're going to have more people use it.

Cool!

Out of interest, what is the best practice way to pass platform  
specific GPIOs around? There are a number of other n770 related  
drivers I'm intending on cleaning up, several of which have GPIO  
numbers hardcoded in them. Should these be passed in platform  
structures, or is there something analogous to the clk_alias for GPIOs?

