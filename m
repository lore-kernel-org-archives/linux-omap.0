From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [v2] musb: omap2430: do not assume balanced enable()/disable()
Date: Fri, 9 Sep 2016 13:55:01 -0700
Message-ID: <20160909205500.onyqllfwgqhvln7w@atomide.com>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
 <1946895.vi37Pmm05X@avalon>
 <20160909200803.4cngkfhgkki4e7o3@atomide.com>
 <1538976.gm2HNISj8k@avalon>
 <20160909224029.57db61f7@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160909224029.57db61f7@aktux>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [160909 13:40]:
> On Fri, 09 Sep 2016 23:21:50 +0300
> Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> > 
> > How exactly is it worse breaking runtime PM than breaking USB gadget 
> > completely ? :-)
> > 
> Does it still break with my phy-twl4030 fixes? At least on gta04,
> they fix real problems and hide the musb problem I tried to fix with
> this patch.
> https://patchwork.kernel.org/patch/9292097/
> https://patchwork.kernel.org/patch/9298447/

Andreas, it's a different USB PHY on pandaboard, that's using
phy-twl6030-usb.c. Probably similar issue.

> > The issue here is that the .disable() platform operation is called by
> > musb with the PHY already powered off, leading to the PHY power
> > reference count becoming negative. The next call to the .enable()
> > operation restores the reference count to 0 without enabling the PHY.
> > 
> > Feel free to send me a better fix and I will test it.
> > 
> The patch has to be reworked on top of the patch series:
> Implement PM runtime for musb-core based on session bit

Yeah that leaves out all most of the trickery with the glue
specific PM runtime tinkering so tracking down any remaining
unbalanced calls should be easier :)

But that's for v4.9, let's see what's the minimal fix for v4.8.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
