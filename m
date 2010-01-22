From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code
 generic, v2
Date: Sat, 23 Jan 2010 04:40:20 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703007F2340@dbde02.ent.ti.com>
References: <20100116013515.10065.30649.stgit@baageli.muru.com>
 <20100116093555.GA13596@n2100.arm.linux.org.uk>
 <20100116191820.GI10318@atomide.com>
 <20100116193313.GA23092@n2100.arm.linux.org.uk>
 <20100116200003.GL10318@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC356087030070F296@dbde02.ent.ti.com>
 <20100122030711.GP23467@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608703007F2289@dbde02.ent.ti.com>
 <20100122205511.GB11835@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608703007F232B@dbde02.ent.ti.com>
 <20100122211052.GE11835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42599 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755127Ab0AVXKn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 18:10:43 -0500
In-Reply-To: <20100122211052.GE11835@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony

>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Friday, January 22, 2010 3:11 PM
>To: Pandita, Vikram
>Cc: Russell King - ARM Linux; linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
>Subject: Re: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic, v2
>
>* Pandita, Vikram <vikram.pandita@ti.com> [100122 12:56]:
>>
>>
>> >-----Original Message-----
>> >From: Tony Lindgren [mailto:tony@atomide.com]
>> >Sent: Friday, January 22, 2010 2:55 PM
>> >To: Pandita, Vikram
>> >Cc: Russell King - ARM Linux; linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
>> >Subject: Re: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic, v2
>> >
>> >* Pandita, Vikram <vikram.pandita@ti.com> [100122 06:46]:
>> >> >
>> >> >OK, I've added that too, but for mach-omap2 only. I've also
>> >> >added an experimental zoom2/3 support.
>> >> >
>> >> >Care to take try it out and see what happens on a zoom?
>> >>
>> >> Test on zoom3 failed with multi-omap branch.
>> >> Debugging the same, should have a zoom correction patch out today.
>> >
>> >Heh OK. I just pushed more updates into the multi-omap branch
>> >if you want to try to boot zoom2/zoom3 using the same .config.
>>
>> Refreshed my tree and I don't see your patches yet.
>
>Takes a few minutes to get mirrored from master.kernel.org..

Yes I tried with new branch and zoom2/3 does not work.
Root cause: 
There is a very basic issue in low level code.

We are allowed to create only one Physical to Virtual mapping using MACHINE_START() phys_io and io_pg_offst of size 0x100000(1MB).

Now for zoom2/3 we need to do following:
MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
-       .phys_io        = 0x48000000,
-       .io_pg_offst    = ((0xfa000000) >> 18) & 0xfffc,
+       .phys_io        = 0x1000000, /*ZOOM_UART_BASE*/
+       .io_pg_offst    = ((0xfb000000) >> 18) & 0xfffc, /*ZOOM_UART_VIRT*/
        .boot_params    = 0x80000100,
        .map_io         = omap_zoom_map_io,
        .init_irq       = omap_zoom_init_irq,

This will create mapping:
0x1000000 <-> 0xfb000000 of 1MB

Now that leaves the phy address 0x4800000 omap register mapping, unmapped.

So the code to get scratchpad contents will abort:
arch/arm/mach-omap2/include/mach/debug-macro.S
	moveq   \rx, #0x48000000        @ physical base address
	movne   \rx, #0xfa000000        @ virtual base
	orr     \rx, \rx, #0x0006a000   @ uart1 on omap2/3/4


This seems to be a basic limitation of low level code and I have not clue how to circumvent this.
Thoughts?

Regards,
Vikram 

