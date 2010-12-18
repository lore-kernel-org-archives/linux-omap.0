From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] omap2+: Initialize serial ports for wake-up events
 for n8x0
Date: Sat, 18 Dec 2010 09:53:42 -0800
Message-ID: <20101218175342.GW5941@atomide.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
 <20101203004531.31687.55661.stgit@baageli.muru.com>
 <87y67t11r3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:29737 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756640Ab0LRRxp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 12:53:45 -0500
Content-Disposition: inline
In-Reply-To: <87y67t11r3.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [101213 19:17]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > Use omap_serial_init_port so we can let the serial code handle the
> > remuxing of the RX pads.
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Does this work for UART wakeups on n810?  I don't see any 'idle' value
> for the pads, so I'm guessing it wont work without those, right?  Or am
> I missing something here.

Well this is still missing the gpio_request parts that are needed
for the serial port to wake. I have not added that as it currently
means we also get a gpio interrupt for every rx.

I'll do more patches to deal with the gpio parts later on.

The idle values are only needed for rx pins:

+static struct omap_device_pad serial2_pads[] __initdata = {
+       {
+               .name   = "uart3_rx_irrx.uart3_rx_irrx",
+               .flags  = OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+               .enable = OMAP_MUX_MODE0,
+               .idle   = OMAP_MUX_MODE3        /* Mux as GPIO for idle */
+       },
+       { .name = "uart3_tx_irtx.uart3_tx_irtx", .enable = OMAP_MUX_MODE0, },
+};

For the others, nothing is done dynamically.

Regards,

Tony
