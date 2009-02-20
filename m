From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: omap_apollon_2420_defconfig
Date: Fri, 20 Feb 2009 13:27:06 -0800
Message-ID: <200902201327.06399.david-b@pacbell.net>
References: <20090209192614.GF19453@n2100.arm.linux.org.uk> <20090220205812.GA13961@n2100.arm.linux.org.uk> <20090220210644.GE7414@atomide.com>
Reply-To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090220210644.GE7414-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 20 February 2009, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> [090220 12:58]:
> > On Tue, Feb 10, 2009 at 10:54:25AM +0900, Kyungmin Park wrote:
> > > In the previous patch, it's only fixed host side. But apollon case, it
> > > only used udc, so udc configuration should select USB_OTG_UTILS also.
> > 
> > So, it's 10 days later, mainline is still broken.  In fact, this is
> > now the only ARM defconfig which is failing.
> > 
> > What's happening?  Is someone going to ack this patch?  Is it going
> > to be submitted to me or is it going to be submitted via some USB
> > tree?
> 
> Well it would be nice to get an ack from the USB people, here's mine:
> 
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

I thought this was already handled ... evidently not, so I
just sent it to Greg as a buildfix.


> > Sick of chasing people about build errors.  People here need to get
> > off their lazy backsides, check kautobuild regularly and submit build
> > fixes.

Actually the *standard* practice involves

 (a) bugs getting reported
 (b) patches getting provided
 (c) nagging until the patches merge

I can't fault anyone for sticking to that process and not
going out of their way to seek out kautobuild issues;
there's already *way* too much to do.


> How about automatic notifications on the failing omap builds sent to
> to linux-omap list? The 34xx builds failing because of the compiler
> should be filtered out until the compiler is updated though.

That's a much better solution.  I'd suggest no more than
one such nag message a week though.


> 
> Tony
> 
> 



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
