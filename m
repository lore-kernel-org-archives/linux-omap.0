From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] Two phy-twl4030-usb fixes for unloading the module
Date: Tue, 9 Feb 2016 07:46:00 -0800
Message-ID: <20160209154559.GF19432@atomide.com>
References: <1448948394-32078-1-git-send-email-tony@atomide.com>
 <20160208195149.GV19432@atomide.com>
 <56B9751F.9070100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56B9751F.9070100-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [160208 21:13]:
> Hi Tony,
> 
> On Tuesday 09 February 2016 01:21 AM, Tony Lindgren wrote:
> > Hi Kishon,
> > 
> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [151130 21:40]:
> >> Hi,
> >>
> >> Here are two fixes for rmmod and PM. These can be merged separately after
> >> the review from the MUSB related changes.
> > 
> > Looks like these two fixes never got merged. Care to merge
> > these for v4.5-rc cycle with Cc stable v4.4?
> > 
> > Without these omap3 PM is blocked as the USB modules can
> > never be unloaded.
> > 
> > I can also merge these via the ARM SoC tree if you ack and have
> > no other fixes for the -rc cycle.
> 
> merged this to linux-phy now. I have a couple of other fixes for this -rc
> cycle. Will send this along with the other fixes.

OK thanks!

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
