From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCH 0/4] Add support for DesignWare Core USB3 IP
Date: Mon, 15 Aug 2011 18:10:25 -0700
Message-ID: <20110816011025.GB21549@kroah.com>
References: <1313423845-2288-1-git-send-email-balbi@ti.com>
 <20110815161631.GA14830@kroah.com>
 <20110815184132.GE2876@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110815184132.GE2876-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 15, 2011 at 09:41:33PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Aug 15, 2011 at 09:16:31AM -0700, Greg KH wrote:
> > On Mon, Aug 15, 2011 at 06:57:21PM +0300, Felipe Balbi wrote:
> > > The driver is usable and we have tested many transfers
> > > with g_zero and mass storage. Nevertheless, it's not
> > > finished and we'd like more time to test it before
> > > accepting it in mainline. Still, we think it's good
> > > to show to the community the design decisions we have
> > > made on the way and we'd like to hear from the rest of
> > > the community any comments/criticisms wrt this driver.
> > 
> > Why wait?  I have no problems taking drivers that are barely working, or
> > not quite there, if it makes development and testing by others easier.
> 
> That's very good to hear. So, I can send you a pull request by friday if
> you like ;-) Will add a patch on MAINTAINERS too so people have a
> contact point.

That would be fine.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
