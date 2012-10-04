From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next, working on 3.2
Date: Thu, 04 Oct 2012 16:06:27 -0700
Message-ID: <877gr5vnv0.fsf@deeprootsystems.com>
References: <20120504155255.140b4e3f@skate> <87397fewso.fsf@ti.com>
	<20120504175124.GI5613@atomide.com> <878vh78q7b.fsf@ti.com>
	<20121004180747.3b342904@skate> <87vcequpf7.fsf@deeprootsystems.com>
	<20121004221118.4316181d@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:57409 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab2JDXGZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 19:06:25 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so459701dak.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 16:06:25 -0700 (PDT)
In-Reply-To: <20121004221118.4316181d@skate> (Thomas Petazzoni's message of
	"Thu, 4 Oct 2012 22:11:18 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>, Gregory =?utf-8?Q?Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> Kevin,
>
> On Thu, 04 Oct 2012 10:18:04 -0700, Kevin Hilman wrote:
>
>> Can you dump the UART mux registers on a working kernel and compare
>> them to the broken one? (Table 7-4 in the 34xx public TRM[1] will
>> list all the mux registers.)  Maybe the bootloader code for that
>> board will shed some light as well since it will be setting the
>> muxing too.
>> 
>> If the console uart is ttyO2 (UART3 in TI docs), then the interesting
>> registers will be any of the padconf registers in that table that
>> contain 'uart3'.  e.g. for UART3 RX:
>> 
>> CONTROL_PADCONF_DSS_DATA4 (mode 2)
>> CONTROL_PADCONF_UART3_RTS_SD (mode 0)
>> CONTROL_PADCONF_HSUSB0_DATA1  (mode 2)
>>                               
>> omap_mux has some useful debugfs output under <debugfs>/omap_mux.  For
>> example:
>> 
>> # cd /sys/kernel/debug/omap_mux
>> # cat dss_data4
>> # cat uart3_rx_irrx
>> # cat hsusb0_data1
>> 
>> would provide a very useful comparison between a working kernel and a
>> non-working one.
>
> It seems they are exactly the same, unless my eyes missed something, of course.

The example I gave was only for the UART3 RX, you should dump the UART3
TX pins as.  Using the omap_mux debugfs, you can see all of the
potential pins where uart3_tx can be routed:

# cd /sys/kernel/debug/omap_mux
# grep -H uart3_tx * |grep signal
dss_data5:signals: dss_data5 | NA | uart3_tx_irtx | NA | gpio_75 | NA | NA | safe_mode
hsusb0_data0:signals: hsusb0_data0 | NA | uart3_tx_irtx | NA | gpio_125 | NA | NA | safe_mode
uart3_tx_irtx:signals: uart3_tx_irtx | NA | NA | NA | gpio_166 | NA | NA | safe_mode

So a 'cat' on dss_data, hsusb0_data0 and uart3_tx_irtx on a working an
non-working kernel should point us in the right direction (assuming of
course, that it's acutally a muxing problem that we're after.)

[...]

> Regarding the bootloader, I am not 100% sure what are the relevant
> bits, but the UART3 related muxing for this board, done in U-Boot seems
> to be:
>
>         MUX_VAL(CP(UART3_TX_IRTX),  (IDIS | PTD | DIS | M0)) /* UART3_TX */\
>         MUX_VAL(CP(UART3_RX_IRRX),  (IEN  | PTD | DIS | M0)) /* UART3_RX */\
>
> Does this helps?
>

Yes, that tells me where UART3 is expected to be mux'd on the board.  So
you can ignore the dss_data* and husb_data* files above and focus on
uart3*

So to summarize, in /sys/kernel/debug/omap_mux, just do a 'cat uart3*'
on a working and non-working board and see if there are any differences.

Kevin
