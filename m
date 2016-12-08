From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: omap: Fix imprecise external abort and oops
 on boot
Date: Thu, 8 Dec 2016 11:45:58 -0800
Message-ID: <20161208194557.GF4920@atomide.com>
References: <20161208032108.21962-1-tony@atomide.com>
 <87lgvqkb6f.fsf@linux.intel.com>
 <20161208153734.GF4264@atomide.com>
 <87a8c6pavm.fsf@linux.intel.com>
 <20161208182521.GA4920@atomide.com>
 <8760mu8c4m.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8760mu8c4m.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161208 11:17]:
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> > The call to pm_runtime_get_sync() in dwc3_omap_probe() will use it.
> 
> right, but there's no runtime suspend until ->remove(). IOW, after
> pm_runtime_get_sync(), all necessary clocks should already be
> enabled. If they aren't, there's either an erratum or a bug in drivers/clk/ti/

I think it's some dependency to the dwc3 core probe. That's because I'm
able to read and print out the wrapper interrupt registers just fine
before the imprecise external abort happens in probe. So that means it's
something dwc3 specific after the TI wrapper module clckctl bit.

> > Is there also some dwc3 internal clock? If we assume the usb_otg_ss
> > module is properly enabled it could be some dwc3 internal clock not
> > enabled?
> 
> no extra clocks.

It seems that if we get an interrupt before dwc3 core has probed with
of_platform_populate(), we get the imprecise external abort.

> is IRQ status already 0x2121 from u-boot prompt?

Yes md 0x4A020034 shows 0x2121.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
