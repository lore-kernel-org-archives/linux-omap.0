From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: sys_clkout2
Date: Tue, 13 Dec 2011 16:26:02 -0700
Message-ID: <4EE7DF0A.50706@mlbassoc.com>
References: <4EE7C38D.8020501@mlbassoc.com> <alpine.DEB.2.00.1112131447230.12046@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:45616 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529Ab1LMX0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 18:26:05 -0500
In-Reply-To: <alpine.DEB.2.00.1112131447230.12046@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On 2011-12-13 14:56, Paul Walmsley wrote:
> On Tue, 13 Dec 2011, Gary Thomas wrote:
>
>> What's the best way to enable sys_clkout2 (DM3730, latest kernel)?
>> I've managed to set it up properly and it runs in U-Boot, but the
>> kernel is disabling it.  It's a bit of a tangle trying to figure out
>> not only what piece of code is undoing my work, but how to get the
>> clock to keep running.
>
> It's probably getting disabled by omap2_clk_disable_unused() in
> mach-omap2/clock.c, which runs at the end of kernel init.
>
>> I want the clkout_cntrl register set to 0x8a,
>> so any guidance on how to make this happen would be greatly appreciated.
>
> I presume you have some external device that relies on sys_clkout2 for its
> clock input?

Precisely.  Do I need to do anything special to control how the clock is
configured, e.g. div & src settings?

>
> If the device has a Linux driver associated with it, the clean way to fix
> it would be to add a clkdev line for it into mach-omap2/clock3xxx_data.c.
> Something like
>
> 	CLK("devname",	"fck",	&sys_clkout2,	CK_3XXX),
>
> where "devname" is the name of your device.  Then add some code into that
> driver to enable and disable the clock as needed.  Something like
>
> ...
>
> struct clk *c;
>
> c = clk_get(dev_name(dev), "fck");
> WARN(IS_ERR(c), "cannot clk_get() device functional clock");
> clk_enable(c);
>
> ...
>
> and then clk_disable() it later in your driver when you don't need it.
>
> If you don't have a driver, you can hack a quick one up that just deals
> with the clock, and add it to your board file.
>
> Or if you just want a dirty hack, you can probably get away with just
> adding the ENABLE_ON_INIT flag to the sys_clkout2 .flags field in
> mach-omap2/clock3xxx_data.c.

Thanks, I'll give this a try when I have eyes on the hardware (Wednesday)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
