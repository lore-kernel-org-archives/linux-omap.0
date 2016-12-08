From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: omap: Fix imprecise external abort and oops
 on boot
Date: Thu, 8 Dec 2016 15:55:14 -0800
Message-ID: <20161208235513.GJ4920@atomide.com>
References: <20161208032108.21962-1-tony@atomide.com>
 <87lgvqkb6f.fsf@linux.intel.com>
 <20161208153734.GF4264@atomide.com>
 <9cce1e34-2fec-9477-4827-6b4c67920a8a@ti.com>
 <20161208225724.GI4920@atomide.com>
 <2a0ce107-dddb-6c59-8681-677e217e9fac@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2a0ce107-dddb-6c59-8681-677e217e9fac-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [161208 15:38]:
> On 12/08/2016 04:57 PM, Tony Lindgren wrote:
> > Seems to work based on few boot tests. Probably both should be applied,
> > my original patch to prevent spurious interrupts before things are
> > initialized,
> 
> you patch - do you mean disable irq  or clean up
> irq status regs before requesting irq? for me, more logical is to
> clean up irq status regs.

What I originally posted in this thread, clear irq registers
before requesting irq.

> this to disable interrupts before pm_runtime_suspend()
> > on exit path:
> > 
> > Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> So, you wanna me to send this as patch or wish to squash in yours?
> (I'll be able to do this only tomorrow)

I think this should be a separate patch for the exit path.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
