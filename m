From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: omap_apollon_2420_defconfig
Date: Fri, 20 Feb 2009 20:58:12 +0000
Message-ID: <20090220205812.GA13961@n2100.arm.linux.org.uk>
References: <20090209192614.GF19453@n2100.arm.linux.org.uk> <20090209205319.GH14200@atomide.com> <9c9fda240902091754q7f723bf2ha46206e52641297b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9c9fda240902091754q7f723bf2ha46206e52641297b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 10, 2009 at 10:54:25AM +0900, Kyungmin Park wrote:
> In the previous patch, it's only fixed host side. But apollon case, it
> only used udc, so udc configuration should select USB_OTG_UTILS also.

So, it's 10 days later, mainline is still broken.  In fact, this is
now the only ARM defconfig which is failing.

What's happening?  Is someone going to ack this patch?  Is it going
to be submitted to me or is it going to be submitted via some USB
tree?

Sick of chasing people about build errors.  People here need to get
off their lazy backsides, check kautobuild regularly and submit build
fixes.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
