From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 02/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
Date: Sat, 1 May 2010 03:07:06 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304E80F5F@dbde02.ent.ti.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	<20100430203349.25812.64659.stgit@baageli.muru.com>
	<87sk6cirt0.fsf@deeprootsystems.com>	<20100430210216.GI29604@atomide.com>
 <87vdb8hc2d.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55825 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758650Ab0D3VhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 17:37:19 -0400
In-Reply-To: <87vdb8hc2d.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>



>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>Sent: Friday, April 30, 2010 4:21 PM
>To: Tony Lindgren
>Cc: linux-arm-kernel@lists.infradead.org; Pandita, Vikram; linux-
>omap@vger.kernel.org; Pais, Allen
>Subject: Re: [PATCH 02/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
>
>Tony Lindgren <tony@atomide.com> writes:
>
>> * Kevin Hilman <khilman@deeprootsystems.com> [100430 13:50]:
>>> Tony Lindgren <tony@atomide.com> writes:
>>>
>>> > Zoom2 and 3 have UARTs only on the external debug board.
>>> > GPMC needs to be mapped early to use it for DEBUG_LL.
>>> >
>>> > Additionally, 0xfb000000 overlaps with other areas, so
>>> > use 0xfa400000 for the virtual address instead.
>>> >
>>> > Note that with the pending serial.c patches you need to
>>> > set console=ttyS0,115200n8 as it will be the only UART
>>> > mapped. To use DEBUG_LL, you need to pass also earlyprintk
>>> > in cmdline.
>>> >
>>> > Cc: Allen Pais <allen.pais@ti.com>
>>> > Cc: Vikram Pandita <vikram.pandita@ti.com>
>>> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>>> > ---
>>> >  arch/arm/kernel/head.S                         |   10 ++++++++++
>>> >  arch/arm/mach-omap2/board-zoom-debugboard.c    |    2 +-
>>> >  arch/arm/mach-omap2/include/mach/debug-macro.S |    4 ++--
>>> >  arch/arm/mach-omap2/io.c                       |    9 +++++++++
>>> >  arch/arm/plat-omap/include/plat/serial.h       |    2 +-
>>> >  5 files changed, 23 insertions(+), 4 deletions(-)
>>> >
>>> > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
>>> > index eb62bf9..fd870e1 100644
>>> > --- a/arch/arm/kernel/head.S
>>> > +++ b/arch/arm/kernel/head.S
>>> > @@ -328,6 +328,16 @@ __create_page_tables:
>>> >  	add	r0, r4, #0xd8000000 >> 18
>>> >  	str	r3, [r0]
>>> >  #endif
>>> > +#if defined(CONFIG_MACH_OMAP_ZOOM2) ||
>defined(CONFIG_MACH_OMAP_ZOOM3)
>>> > +	/*
>>> > +	 * Zoom2 and Zoom3 have UARTs only on the debug board.
>>> > +	 * The debug board is connected to the GPMC.
>>> > +	 */
>>> > +	add	r0, r4, #0xfa000000 >> 18
>>> > +	orr	r0, r0, #0x00400000 >> 18	@ ZOOM_UART_VIRT
>>> > +	orr	r3, r7, #0x10000000		@ ZOOM_UART_BASE
>>> > +	str	r3, [r0]
>>> > +#endif
>>>
>>> I don't see why this part is needed.  The same mapping is done using
>>> the .io_pg_offset in the machine description which is done just before
>>> this in head.S
>>
>> That mapping does not cover the GPMC area where this UART is.
>
>Hmm, then shouldn't that be fixed?  I understood the .phys_io and and
>.io_pg_offset fields of the mach_desc to be specifically for mapping
>the early UART, and nothing else.

Here is the problem - 
with current approach we need two mappings to happen and the MACHINE_START() code allows for only one via .io_pg_offset and .phys_io

Why:
Tony's approach is to pass the information about the debug uart number from the UART1 Scratchpad register.

this introduces a dependency that 
UART1 registers also be mapped (virt<->phy).

So for Tony's approach to work, .phys_io/.io_pg_offset continued to have 0x4800000 based mapping and for external uart zoom3 port, create this extra mapping.

So find a better way from compressed.S to pass the uart number to kernel, and we can solve the problem.

>
>Kevin
>

