From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 11:07:18 -0400
Message-ID: <a0580c510809030807q5b11ff8bmad5a20094209dd8f@mail.gmail.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk>
	 <200808311447.20312.david-b@pacbell.net>
	 <20080902221501.GD23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:61240 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbYICPHU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 11:07:20 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1641590yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Sep 2008 08:07:19 -0700 (PDT)
In-Reply-To: <20080902221501.GD23085@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, Russell King <rmk@arm.linux.org.uk>, linux-omap@vger.kernel.org

Hi Tony,

On Tue, Sep 2, 2008 at 6:15 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * David Brownell <david-b@pacbell.net> [080831 14:47]:
>> On Wednesday 27 August 2008, Russell King wrote:
>> > I sent a similar patch to the one below against mainline to Tony today.
>>
>> And I'm glad to see those updates.  I used to constantly trip over
>> code doing strange stuff in those areas, and it would be nice to
>> see "sparse" approve a lot more driver code...
>
> Back online now. These changes look ggood to me in general, except
> I suggest that we use the following standard:
>
> - Keep OMAP1_IO_ADDRESS() and OMAP2_IO_ADDRESS() as I have some
>  experimental patches to compile in both omap1 and omap2 into the
>  same binary. Booting the kernel currently still requires some
>  Makefile.boot patching, but at least compiling everything in makes
>  things easier to maintain in the long run.
>
> - Use io_p2v() for initializing dynamic stuff as it can be a function
>  for non-optimized multiboot binaries.
>
>>
>> > I've marked some changes with certain tags:
>> >
>> > - FIXME: where I think the code is just plain wrong -
>> >   - such as putting a physical address through a macro which converts
>> >     virtual to physical addresses (1510 and 1610 mcbsp).
>> >   - or passing virtual addresses to DMA functions (mcbsp).
>> >   - or passing physical addresses when what's required is a virtual address
>> >     (omap_udc).
>>
>> Yeah, the omap_udc one looks like the __REG() conversion patch
>> just did the wrong thing.  Fix looks trivial, and once I verify
>> it then I'll send it through mainline.
>>
>>
>> > - CHECKME: where I've changed something to make it build but I don't
>> >   know if this is right.
>> >
>> > - WBNI: more a preference to see something changed than a bug.
>> >
>> > Comments on the FIXMEs are what I'm really interested in, and preferably
>> > having them actually fixed would be a good idea.
>>
>> I verified that the OMAP tree boots on my OMAP5912 OSK, at least
>> once things like cpufreq, PM, and MTD are disabled.  The MTD thing
>> is a known/solved issue in mainline.  (Block queue changes broke
>> MTD...)  The oopses in cpufreq and pm_idle are more cryptic.
>>
>> So I can try my patch for the omap_udc thing ... even though for
>> OSK the mainline kernel ** DOES NOT BOOT ** and dies even before
>> the kernel "hello, I'm RC5!" banner prints.  Someone with a JTAG
>> to throw at this might be able to fix that regression quickly.
>
> I'll take a look at the OSK boot problem unless somebody else is
> already working on it.
>
> Looks like the FIXME mcbsp phys vs virt addresses are wrong for some
> board-*.c files. Eduardo, can you please take a look at them?

Sorry, but I didn't get your point here. At least, for board-*.c files there
are only register values definitions. Those are used basically by old alsa
driver. No io address are defined there.

Anyway, I'll review the virtual address use for the mcbsp code.

>
> Tony
>

Cheers,

-- 
Eduardo Bezerra Valentin
