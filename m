From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default
 pads
Date: Fri, 6 Apr 2012 11:15:57 -0700
Message-ID: <20120406181556.GC15734@atomide.com>
References: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
 <20120403181925.GH8240@atomide.com>
 <CAMrsUdLrpyGrhggi820WcR+DoHJVB8GQ1THUOO-C4LqUQtAxWQ@mail.gmail.com>
 <20120405165811.GB3785@atomide.com>
 <CAMrsUdJEY2o2CWjzSg5dabVEkpk48O5njtDU55Z3Jq2vViNJgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:33408 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab2DFSP7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Apr 2012 14:15:59 -0400
Content-Disposition: inline
In-Reply-To: <CAMrsUdJEY2o2CWjzSg5dabVEkpk48O5njtDU55Z3Jq2vViNJgQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>

* Raja, Govindraj <govindraj.raja@ti.com> [120405 23:08]:
> On Thu, Apr 5, 2012 at 10:28 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hmm I don't think any muxing was done automatically unless
> > omap_serial_init_port was being called with pins.
> 
> Muxing was happening even if we don't call omap_serial_init_port
> rx pin was muxed for wakeup capability for all uart pins

OK, but that was only for the wake-up muxing? That sounds risky
too for some boards as the board may be using alternative uart
pins instead of the default ones.
 
> omap_uart_idle_init => was populating padconf offset value for ech uart
> which was used in omap_uart_enable/disable_wakeup functions.
> This mechanism was keeping PM happening for all boards.

OK, that's safe if we also bail out for the cases where the default
uart pins are not muxed to serial functionality to start with.

So to summarize, the right fix is to:

1. Only do muxing of uarts from other modes to uart mode if
   omap_serial_init_port is being called with the board specific
   mux options for the port in question.

2. Bail out early in omap_serial_init for each port that does not
   have it's default uart pins already muxed to uart functionality.

3. For the uart ports configured in #1 or #2 above, allow dynamic
   remuxing of the wake-up capability but don't touch the others.

Regards,

Tony
