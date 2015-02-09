From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: Fix getting a generic phy for musb_dsps
Date: Mon, 9 Feb 2015 10:40:02 -0800
Message-ID: <20150209184002.GC2531@atomide.com>
References: <1423154113-23463-1-git-send-email-tony@atomide.com>
 <1423154113-23463-3-git-send-email-tony@atomide.com>
 <54D4BA78.9030704@ti.com>
 <20150206172313.GF25235@atomide.com>
 <54D84BF3.7060801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54D84BF3.7060801-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* George Cherian <george.cherian-l0cyMroinI0@public.gmane.org> [150208 22:02]:
> Hi Tony,
> On 02/06/2015 10:53 PM, Tony Lindgren wrote:
> >* George Cherian <george.cherian-l0cyMroinI0@public.gmane.org> [150206 05:05]:
> >>Hi Tony,
> >>
> >>You also need to add similar things in dsps_musb_reset();
> >>
> >>Otherwise you might not recover from a BABBLE condition.
> >Thank I totally missed that, updated patch below.
> >
> >Do you have some testcase that easily triggers BABBLE
> >on MUSB?
> On a BBB or BBW you can connect a HUB with multiple device connected on HUB.
> Then do a repeated Connect and Disconnect of the HUB, This should trigger a
> BABBLE interrupt.
> Not all HUB's might not lead you to a BABBLE condition.

OK thanks will keep my eyes open, so far have not been able
to trigger it here with the two hubs I've tried.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
