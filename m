From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 5/6] OMAP3: Serial: Made serial to work properly with PRCM chain handler
Date: Fri, 24 Jun 2011 08:15:30 -0700
Message-ID: <87k4cb45wt.fsf@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
	<1308760934-9757-6-git-send-email-t-kristo@ti.com>
	<20110623082150.GX23145@atomide.com>
	<1308820284.5972.18.camel@sokoban>
	<20110623100054.GA23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:56596 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754182Ab1FXPPe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 11:15:34 -0400
Received: by mail-pz0-f54.google.com with SMTP id 27so2438415pzk.13
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 08:15:33 -0700 (PDT)
In-Reply-To: <20110623100054.GA23145@atomide.com> (Tony Lindgren's message of
	"Thu, 23 Jun 2011 03:00:55 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Tero Kristo <t-kristo@ti.com> [110623 02:06]:
>> On Thu, 2011-06-23 at 10:21 +0200, Tony Lindgren wrote:
>> > * Tero Kristo <t-kristo@ti.com> [110622 09:38]:
>> > > @@ -550,6 +550,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>> > >  	ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
>> > >  				   IRQF_SHARED, "serial idle", (void *)uart);
>> > >  	WARN_ON(ret);
>> > > +	ret = omap_prcm_register_pad_irq(uart->padconf, uart->irq);
>> > > +	WARN_ON(ret);
>> > >  }
>> > 
>> > Argh, looks like we still have direct mux register tinkering in serial.c:
>> > 
>> > $ grep "padconf = 0x" serial.c
>> >                         padconf = 0x182;
>> >                         padconf = 0x17a;
>> >                         padconf = 0x19e;
>> >                         padconf = 0x0d2;
>> > 
>> > By deducting 0x30 from the values above, these map into the following mux defines:
>> > 
>> > $ grep RX_OFFSET mux34xx.h
>> > #define OMAP3_CONTROL_PADCONF_UART2_RX_OFFSET                   0x14a
>> > #define OMAP3_CONTROL_PADCONF_UART1_RX_OFFSET                   0x152
>> > #define OMAP3_CONTROL_PADCONF_UART3_RX_IRRX_OFFSET              0x16e
>> > 
>> > So you can make things more generic by getting rid of those and using
>> > struct omap_mux_partition instead for omap_prcm_register_pad_irq.
>> > The pins used are set already in serial.c with omap_hwmod_mux_init.
>> > 
>> > Otherwise we have to patch the hardcoded padconf values for every new omap.
>> > And looks like we're already missing them for 44xx in serial.c.
>> > 
>> > Then access to the padconf registers should be done with
>> > omap_mux_read/write instead. If you need to do something more complex
>> > with them maybe consider adding some new functions to mux.c as needed.
>> > 
>> 
>> Padconf stuff is not that much related to this patch set yet (I am not
>> touching the serial padconf code), but I can probably take a look at
>> this also later on, unless you want this fixed with this set already?
>
> Yes please, maybe make it a separate patch before your series to
> prepare things?
>
> Otherwise we will have to change the omap_prcm_register_pad_irq
> later on in each driver using it.

Govindraj's UART runtime PM series is addressing this so Tero shouldn't
need to make those changes as part of this series.

IOW, $SUBJECT patch is only temporary until the UART runtime PM series
is ready.

Govindraj, are you able to use this series with your runtime PM
conversion?

Kevin
