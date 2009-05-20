From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v3 1/3] OMAP3:zoom2: Add support for OMAP3 Zoom2 board
Date: Wed, 20 May 2009 05:31:08 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F50968B2@dbde02.ent.ti.com>
References: <1242422451-21551-1-git-send-email-mlc@ti.com>
 <1242422451-21551-2-git-send-email-mlc@ti.com>
 <20090518212216.GR19742@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F50963E1@dbde02.ent.ti.com>
 <20090518213902.GS19742@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5096447@dbde02.ent.ti.com>
 <20090519162940.GX19742@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F50968B0@dbde02.ent.ti.com>
 <20090519235520.GO19742@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57074 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbZETABS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 20:01:18 -0400
In-Reply-To: <20090519235520.GO19742@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Christensen, Mikkel" <mlc@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Tuesday, May 19, 2009 6:55 PM
>To: Pandita, Vikram
>Cc: Christensen, Mikkel; linux-omap@vger.kernel.org
>Subject: Re: [PATCH v3 1/3] OMAP3:zoom2: Add support for OMAP3 Zoom2 board
>
>* Pandita, Vikram <vikram.pandita@ti.com> [090519 16:48]:
>> Tony
>>
>> >-----Original Message-----
>> >From: Tony Lindgren [mailto:tony@atomide.com]
>> >Sent: Tuesday, May 19, 2009 11:30 AM
>> >To: Pandita, Vikram
>> >Cc: Christensen, Mikkel; linux-omap@vger.kernel.org
>> >Subject: Re: [PATCH v3 1/3] OMAP3:zoom2: Add support for OMAP3 Zoom2 board
>> >
>> >* Pandita, Vikram <vikram.pandita@ti.com> [090518 20:55]:
>> >> Tony
>> >>
>> >> >* Pandita, Vikram <vikram.pandita@ti.com> [090518 14:31]:
>> >> >> Tony
>> >> >>
>> >> >> >>
>> >> >> >> +
>> >> >> >> +	zoom2_init_smsc911x();
>> >> >> >> +	zoom2_init_quaduart();
>> >> >> >> +	return platform_add_devices(zoom2_devices, ARRAY_SIZE(zoom2_devices));
>> >> >> >> +}
>> >> >> >> +arch_initcall(omap_zoom2_debugboard_init);
>> >> >> >
>> >> >> >Please just move all the related functions to board-zoom2.c. I don't see any
>> >> >> >reason to have a separate file for the debugboard features. The runtime detection
>> >> >> >should do the trick.
>> >> >>
>> >> >> Two reasons for keeping a separate debug board.
>> >> >> a) debug board is detachable in h/w and hence we thought its better to keep the s/w also that
>> >way
>> >> >> The quart chip on debug bard is a quard-uart and can support 4 different console outputs.
>> >> >> All those we thought of adding in future.
>> >> >
>> >> >Well those you can easily optimize out by not compiling in those devices.
>> >> >
>> >> >>
>> >> >> b) we took reference from board-rx51-peripherals.c wherein some parts of the board file can
>be
>> >> >moved out to a new file
>> >> >>
>> >> >> If you still think we need to merge, then let us know.
>> >> >> We are open to suggestions/changes.
>> >> >
>> >> >Well the reason for separate board-*-peripheral-whatever.c files is that
>> >> >they're intended to be shared with other board-*.c files. Currently n8x0
>> >> >and rx51 share devices. In general, we should try to do generic platform
>> >> >init files, like gpmc-onenand.c and gpmc-smc91x.c.
>> >> >
>> >> >Then I see need for gpmc-sdp-flash.c that's shared between 2430 and 3430 sdp
>> >> >at least.
>> >> >
>> >> >So yeah, for zoom2, I'd rather see just board-zoom2.c for now. But if you
>> >> >create some other board that uses the same debug board functions, then
>> >> >there could be a separate zoom-debugboard.c.
>> >>
>> >>
>> >> Yes. There is next generation of zoom boards that will re-use the Debug board.
>> >> That way the debug board file will get re-used.
>> >
>> >OK, how about rename it to something that makes sense as a name for
>> >multiple zoom like boards and resubmit.
>>
>> I am planning on renaming debug board zoom2 file to board-zoom-debugboard.c
>> That way it can be used by different Zoom family of boards.
>
>OK
>
>> >Also the arch_initcall() issue below still needs fixing.
>>
>> I have cleaned the issue by making the debug_board_init call as late_initcall().
>>
>> There is a dependency on serial.c file and hence the need for arch_init/late_init calls.
>>
>> platform_device_register() should happen for serial.c file (8250) for the omap uarts first and this
>should be followed by platform_device_register() for the quard uart on debug board.
>>
>> So there is a dependency on order of registration of platform device for the same 8250 driver.
>>
>> If you ack, then I can post the patches with the changes.
>
>Well you still cannot have it as a late_initcall(), you should just call the
>function from board-zoom2.c. Otherwise it will run for all the boards.

The problem is that serial.c: platform_device_register() for UART1/2/3 happens as arch_init().

We want that Quard/Dbg-board Uart console to appear as UART4(ttyS3) and so the platform_device_register() has to happen after the arch_init() call from serial.c

If we put the dbg-board init in .init_machine   = omap_zoom2_init() function, then this gets called first before the serial.c:arch_init() and assigns ttyS0(UART0) to the debug board uart.

This is not what we want to do.

 
>
>Regards,
>
>Tony
>

