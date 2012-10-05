From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next,
 working on 3.2
Date: Fri, 5 Oct 2012 10:06:19 +0200
Message-ID: <20121005100619.13345be0@skate>
References: <20120504155255.140b4e3f@skate>
	<87397fewso.fsf@ti.com>
	<20120504175124.GI5613@atomide.com>
	<878vh78q7b.fsf@ti.com>
	<20121004180747.3b342904@skate>
	<87vcequpf7.fsf@deeprootsystems.com>
	<20121004221118.4316181d@skate>
	<877gr5vnv0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:49493 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab2JEIGd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 04:06:33 -0400
In-Reply-To: <877gr5vnv0.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>, Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>

Kevin,

On Thu, 04 Oct 2012 16:06:27 -0700, Kevin Hilman wrote:

> > It seems they are exactly the same, unless my eyes missed
> > something, of course.
> 
> The example I gave was only for the UART3 RX, you should dump the
> UART3 TX pins as.  Using the omap_mux debugfs, you can see all of the
> potential pins where uart3_tx can be routed:

Well, UART3 TX seems to be working fine. Do RX and TX have mutual
influence in terms of pin muxing?

> Yes, that tells me where UART3 is expected to be mux'd on the board.
> So you can ignore the dss_data* and husb_data* files above and focus
> on uart3*
> 
> So to summarize, in /sys/kernel/debug/omap_mux, just do a 'cat uart3*'
> on a working and non-working board and see if there are any
> differences.

3.2 (working)

name: uart3_cts_rctx.uart3_cts_rctx (0x4800219a/0x16a = 0x0108), b h18, t NA
mode: OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE0
signals: uart3_cts_rctx | NA | NA | NA | gpio_163 | NA | NA | safe_mode
name: uart3_rts_sd.uart3_rts_sd (0x4800219c/0x16c = 0x0000), b h19, t NA
mode: OMAP_PIN_OUTPUT | OMAP_MUX_MODE0
signals: uart3_rts_sd | NA | NA | NA | gpio_164 | NA | NA | safe_mode
name: uart3_rx_irrx.uart3_rx_irrx (0x4800219e/0x16e = 0x0100), b h20, t NA
mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
signals: uart3_rx_irrx | NA | NA | NA | gpio_165 | NA | NA | safe_mode
name: uart3_tx_irtx.uart3_tx_irtx (0x480021a0/0x170 = 0x0000), b h21, t NA
mode: OMAP_PIN_OUTPUT | OMAP_MUX_MODE0
signals: uart3_tx_irtx | NA | NA | NA | gpio_166 | NA | NA | safe_mode

3.6 (not working)

name: uart3_cts_rctx.uart3_cts_rctx (0x4800219a/0x16a = 0x0108), b h18, t NA
mode: OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE0
signals: uart3_cts_rctx | NA | NA | NA | gpio_163 | NA | NA | safe_mode
name: uart3_rts_sd.uart3_rts_sd (0x4800219c/0x16c = 0x0000), b h19, t NA
mode: OMAP_PIN_OUTPUT | OMAP_MUX_MODE0
signals: uart3_rts_sd | NA | NA | NA | gpio_164 | NA | NA | safe_mode
name: uart3_rx_irrx.uart3_rx_irrx (0x4800219e/0x16e = 0x0100), b h20, t NA
mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
signals: uart3_rx_irrx | NA | NA | NA | gpio_165 | NA | NA | safe_mode
name: uart3_tx_irtx.uart3_tx_irtx (0x480021a0/0x170 = 0x0000), b h21, t NA
mode: OMAP_PIN_OUTPUT | OMAP_MUX_MODE0
signals: uart3_tx_irtx | NA | NA | NA | gpio_166 | NA | NA | safe_mode

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
