From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next,
 working on 3.2
Date: Thu, 4 Oct 2012 22:11:18 +0200
Message-ID: <20121004221118.4316181d@skate>
References: <20120504155255.140b4e3f@skate>
	<87397fewso.fsf@ti.com>
	<20120504175124.GI5613@atomide.com>
	<878vh78q7b.fsf@ti.com>
	<20121004180747.3b342904@skate>
	<87vcequpf7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:45874 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab2JDULk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 16:11:40 -0400
In-Reply-To: <87vcequpf7.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>, Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>

Kevin,

On Thu, 04 Oct 2012 10:18:04 -0700, Kevin Hilman wrote:

> Can you dump the UART mux registers on a working kernel and compare
> them to the broken one? (Table 7-4 in the 34xx public TRM[1] will
> list all the mux registers.)  Maybe the bootloader code for that
> board will shed some light as well since it will be setting the
> muxing too.
> 
> If the console uart is ttyO2 (UART3 in TI docs), then the interesting
> registers will be any of the padconf registers in that table that
> contain 'uart3'.  e.g. for UART3 RX:
> 
> CONTROL_PADCONF_DSS_DATA4 (mode 2)
> CONTROL_PADCONF_UART3_RTS_SD (mode 0)
> CONTROL_PADCONF_HSUSB0_DATA1  (mode 2)
>                               
> omap_mux has some useful debugfs output under <debugfs>/omap_mux.  For
> example:
> 
> # cd /sys/kernel/debug/omap_mux
> # cat dss_data4
> # cat uart3_rx_irrx
> # cat hsusb0_data1
> 
> would provide a very useful comparison between a working kernel and a
> non-working one.

It seems they are exactly the same, unless my eyes missed something, of course.

Note: the 3.6 kernel is booted with the patch I posted earlier, but it
doesn't make it work any better.

Here is what I have :

3.6 (not working)
=================

name: dss_data4.dss_data4 (0x480020e4/0x0b4 = 0x0000), b ag24, t NA
mode: OMAP_PIN_OUTPUT | OMAP_MUX_MODE0
signals: dss_data4 | NA | uart3_rx_irrx | NA | gpio_74 | NA | NA | safe_mode
name: uart3_rx_irrx.uart3_rx_irrx (0x4800219e/0x16e = 0x0100), b h20, t NA
mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
signals: uart3_rx_irrx | NA | NA | NA | gpio_165 | NA | NA | safe_mode
name: hsusb0_data1.hsusb0_data1 (0x480021ac/0x17c = 0x0100), b u28, t NA
mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
signals: hsusb0_data1 | NA | uart3_rx_irrx | NA | gpio_130 | NA | NA | safe_mode

Complete boot log: http://code.bulix.org/76m2kn-82254?raw

3.2 (working)
=============

name: dss_data4.dss_data4 (0x480020e4/0x0b4 = 0x0000), b ag24, t NA
mode: OMAP_PIN_OUTPUT | OMAP_MUX_MODE0
signals: dss_data4 | NA | uart3_rx_irrx | NA | gpio_74 | NA | NA | safe_mode
name: uart3_rx_irrx.uart3_rx_irrx (0x4800219e/0x16e = 0x0100), b h20, t NA
mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
signals: uart3_rx_irrx | NA | NA | NA | gpio_165 | NA | NA | safe_mode
name: hsusb0_data1.hsusb0_data1 (0x480021ac/0x17c = 0x0100), b u28, t NA
mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
signals: hsusb0_data1 | NA | uart3_rx_irrx | NA | gpio_130 | NA | NA | safe_mode

Complete boot log: http://code.bulix.org/kh0v71-82255?raw

Regarding the bootloader, I am not 100% sure what are the relevant
bits, but the UART3 related muxing for this board, done in U-Boot seems
to be:

        MUX_VAL(CP(UART3_TX_IRTX),  (IDIS | PTD | DIS | M0)) /* UART3_TX */\
        MUX_VAL(CP(UART3_RX_IRRX),  (IEN  | PTD | DIS | M0)) /* UART3_RX */\

Does this helps?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
