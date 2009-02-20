From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: omap_apollon_2420_defconfig
Date: Fri, 20 Feb 2009 21:24:33 +0000
Message-ID: <20090220212433.GB13961@n2100.arm.linux.org.uk>
References: <20090209192614.GF19453@n2100.arm.linux.org.uk> <20090209205319.GH14200@atomide.com> <9c9fda240902091754q7f723bf2ha46206e52641297b@mail.gmail.com> <20090220205812.GA13961@n2100.arm.linux.org.uk> <20090220210644.GE7414@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090220210644.GE7414-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 20, 2009 at 01:06:44PM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> [090220 12:58]:
> > On Tue, Feb 10, 2009 at 10:54:25AM +0900, Kyungmin Park wrote:
> > > In the previous patch, it's only fixed host side. But apollon case, it
> > > only used udc, so udc configuration should select USB_OTG_UTILS also.
> > 
> > So, it's 10 days later, mainline is still broken.  In fact, this is
> > now the only ARM defconfig which is failing.

Really, it's actually almost one month later.  I checked.  I brought
this issue up 27th January and then again on 9th February and here we
are *three* *and* *a* *half* *weeks* later no further forward.

This is plain and simple not acceptable.

> > What's happening?  Is someone going to ack this patch?  Is it going
> > to be submitted to me or is it going to be submitted via some USB
> > tree?
> 
> Well it would be nice to get an ack from the USB people, here's mine:
> 
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Right, so one ack which is progress.  That still leaves the question
about how the patch gets into mainline.

> > Sick of chasing people about build errors.  People here need to get
> > off their lazy backsides, check kautobuild regularly and submit build
> > fixes.
> 
> How about automatic notifications on the failing omap builds sent to
> to linux-omap list? The 34xx builds failing because of the compiler
> should be filtered out until the compiler is updated though.

Well, 17 days ago, the compiler was upgraded and the OMAP34xx builds
started to complete.  So your statement tells me that you've not looked
at kautobuild for at least the last 17 days.

If you want any features, please talk to the kautobuild people.  I've
nothing to do with kautobuild other than seemingly being the *sole*
person who checks the kautobuild website and chases people when things
get broken.

Having done some research by reading through the kautobuild site, if you
want to be mailed the results, kautobuild has its own mailing list.  See
http://armlinux.simtec.co.uk/kautobuild/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
