From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
Date: Fri, 30 Apr 2010 17:10:32 -0700
Message-ID: <87sk6c8osn.fsf@deeprootsystems.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	<20100430203349.25812.64659.stgit@baageli.muru.com>
	<87sk6cirt0.fsf@deeprootsystems.com>
	<20100430210216.GI29604@atomide.com>
	<87vdb8hc2d.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC3560870304E80F5F@dbde02.ent.ti.com>
	<87y6g4d2ic.fsf@deeprootsystems.com>
	<20100430233002.GJ29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:43060 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833Ab0EAAKg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 20:10:36 -0400
Received: by pxi17 with SMTP id 17so450905pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 17:10:35 -0700 (PDT)
In-Reply-To: <20100430233002.GJ29604@atomide.com> (Tony Lindgren's message of "Fri\, 30 Apr 2010 16\:30\:02 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100430 14:56]:
>> "Pandita, Vikram" <vikram.pandita@ti.com> writes:
>> 
>> [...]
>> 
>> >>>> > --- a/arch/arm/kernel/head.S
>> >>>> > +++ b/arch/arm/kernel/head.S
>> >>>> > @@ -328,6 +328,16 @@ __create_page_tables:
>> >>>> >  	add	r0, r4, #0xd8000000 >> 18
>> >>>> >  	str	r3, [r0]
>> >>>> >  #endif
>> >>>> > +#if defined(CONFIG_MACH_OMAP_ZOOM2) ||
>> >>defined(CONFIG_MACH_OMAP_ZOOM3)
>> >>>> > +	/*
>> >>>> > +	 * Zoom2 and Zoom3 have UARTs only on the debug board.
>> >>>> > +	 * The debug board is connected to the GPMC.
>> >>>> > +	 */
>> >>>> > +	add	r0, r4, #0xfa000000 >> 18
>> >>>> > +	orr	r0, r0, #0x00400000 >> 18	@ ZOOM_UART_VIRT
>> >>>> > +	orr	r3, r7, #0x10000000		@ ZOOM_UART_BASE
>> >>>> > +	str	r3, [r0]
>> >>>> > +#endif
>> >>>>
>> >>>> I don't see why this part is needed.  The same mapping is done using
>> >>>> the .io_pg_offset in the machine description which is done just before
>> >>>> this in head.S
>> >>>
>> >>> That mapping does not cover the GPMC area where this UART is.
>> >>
>> >>Hmm, then shouldn't that be fixed?  I understood the .phys_io and and
>> >>.io_pg_offset fields of the mach_desc to be specifically for mapping
>> >>the early UART, and nothing else.
>> >
>> > Here is the problem - with current approach we need two mappings to
>> > happen and the MACHINE_START() code allows for only one via
>> > .io_pg_offset and .phys_io
>> >
>> > Why:
>> 
>> > Tony's approach is to pass the information about the debug uart
>> > number from the UART1 Scratchpad register.
>> >
>> > this introduces a dependency that 
>> > UART1 registers also be mapped (virt<->phy).
>> >
>> > So for Tony's approach to work, .phys_io/.io_pg_offset continued to
>> > have 0x4800000 based mapping and for external uart zoom3 port,
>> > create this extra mapping.
>> >
>> > So find a better way from compressed.S to pass the uart number to
>> > kernel, and we can solve the problem.
>> 
>> Ah, yet another reason to use a memory location instead of UART1 SCR
>> to pass the UART info (c.f. [1])
>
> That should work if we don't need to access any L4 registers
> early on before .map_io.

I'd say if we're accessing L4 regs before .map_io, it's a bug that
needs to be fixed, but I don't think we are.  If we were, we'd notice
a hang when !CONFIG_DEBUG_LL since the .phys_io and .io_pg_offst are
only mapped in when CONFIG_DEBUG_LL=y.

I think we've been using .phys_io/.io_pg_offset incorrectly in OMAP as
an early mapping of all the IO space, when it is intended just for use
as early UART access, indicated by the comments in head.S and the
fact that it's only used when CONFIG_DEBUG_LL=y

Kevin
