From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3_beagle: Init only uart3 used for console
Date: Mon, 5 Mar 2012 12:51:49 -0800
Message-ID: <20120305205149.GS12083@atomide.com>
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
 <87399mkecv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54828 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757455Ab2CEUvw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 15:51:52 -0500
Content-Disposition: inline
In-Reply-To: <87399mkecv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120305 11:28]:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
> 
> > From: "Govindraj.R" <govindraj.raja@ti.com>
> >
> > On beagle some of uart mux lines are used for other
> > purpose so init only uart3.
> 
> OK, but you should also be clear that this patch is effectively
> disabling all UARTS (except UART3) by defatul, which I'm not sure all
> Beagle users will be happy about.
> 
> > Uart2 rx line clashes with gpio_147 used for usb ehci
> > phy reset. Initializing uart2 pad_mux lines can break
> > ehci module on beagle xm.
> > (gpio_147 is available on uart2_rx in mode4 reference 
> > mux34xx.c -> uart2_rx.gpio_147)
> 
> As Koen mentioned, this conflict only exists on certain boards, so
> you should be clear that this is just an example.

OK, thanks for the comments. Also it's a bit clear if
this really is safe to do on all beagles.
 
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Tested-by: Robert Nelson <robertcnelson@gmail.com>
> > Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> 
> [...]
> 
> > +
> > +static inline void board_serial_init(void)
> 
> Should be __init
> 
> [...]
> 
> > +static inline void board_serial_init(void)
> 
> here too.

..so dropping the patch for now until these are fixed
and we have some tested-bys for non-xm beagles too.

Regards,

Tony
