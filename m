From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [024/115] USB: prevent buggy hubs from crashing the USB stack
Date: Thu, 24 Feb 2011 11:16:38 +0200
Message-ID: <20110224091638.GH3528@legolas.emea.dhcp.ti.com>
References: <4D64C81B.5060807@ahsoftware.de>
 <Pine.LNX.4.44L0.1102231021210.2233-100000@iolanthe.rowland.org>
 <20110224085735.GD3528@legolas.emea.dhcp.ti.com>
 <4D6621AB.10205@ahsoftware.de>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D6621AB.10205-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Michael Jones <michael.jones-P0pTl12WyEgpBod+wgzj8A@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stable-review-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Feb 24, 2011 at 10:15:23AM +0100, Alexander Holler wrote:
> >On Wed, Feb 23, 2011 at 10:26:20AM -0500, Alan Stern wrote:
> >>In both cases, it appears that the problem is caused by the fact that
> >>the musb host-controller driver doesn't set the hcd->has_tt flag.
> >>
> >>Felipe, you should know where it belongs.  It should be easy enough to
> >>add.
> >
> >Sure Alan, it's attached to this mail. Compile tested only though.
> >Michael, would you care to give your tested-by ?
> 
> I can do, I'm using exactly the same patch since yesterday. ;)
> 
> Tested-by: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>

Thanks a lot Alex, Greg, can you still take this to -rc ? Do you need a
pull request or you can take this one patch ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
