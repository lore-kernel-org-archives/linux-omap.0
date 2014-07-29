From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: OMAP3/AM3517 EHCI USB Issue
Date: Tue, 29 Jul 2014 16:21:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1407291612020.918-100000@iolanthe.rowland.org>
References: <20140729195544.GA20656@sysresccd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140729195544.GA20656@sysresccd>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-ei31t81uNw5BDgjK7y7TUQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 29 Jul 2014, Michael Welling wrote:

> Today I enabled debugging in the core hub driver and found that
> once the external HUB suspends, the root HUB suspends.

Naturally.  You can prevent that by forcing the root hub to remain 
active.

> Once the root HUB suspends, it seems there is no way for the external
> HUB to wake the root HUB with the hardware setup that I have.

> Here is what happens when I echo on into the power control for the HUB
> afterwards:
> 
> root@som3517:/# echo on > /sys/bus/usb/devices/1-1/power/control
> [ 1050.003689] hub 1-0:1.0: hub_resume
> [ 1050.011306] usb usb1-port1: status 0507 change 0000
> [ 1050.019975] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> [ 1050.028076] usb 1-1: usb auto-resume
> [ 1050.065904] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0002
> [ 1050.084623] usb 1-1: finish resume
> [ 1050.092469] usb 1-1: retry with reset-resume
> [ 1050.156167] hub 1-0:1.0: port_wait_reset: err = -16
> [ 1050.161331] usb usb1-port1: not enabled, trying reset again...
> [ 1050.376402] usb usb1-port1: logical disconnect
> [ 1050.381354] usb 1-1: gone after usb resume? status -19
> [ 1050.386941] usb 1-1: can't resume, status -19
> [ 1050.391537] usb usb1-port1: logical disconnect
> [ 1050.400203] usb usb1-port1: status 0100, change 0003, 12 Mb/s
> [ 1050.406410] usb 1-1: USB disconnect, device number 2
> [ 1050.411650] usb 1-1: unregistering device
> [ 1050.604563] usb usb1-port1: debounce total 100ms stable 100ms status 0x100
> [ 1050.611901] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> [ 1050.618428] hub 1-0:1.0: hub_suspend

The hub disconnects.

> Further research led me to find multiple errata that may be causing this
> issue.
> 
> www.ti.com/lit/pdf/sprz306

That 1.1.18 advisory looks pretty bad.

> Still does not explain why the same hardware works with the 2.6.37 and
> 3.2 kernels.

Maybe you should try bisection.  It's slow but it gives you an answer.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
