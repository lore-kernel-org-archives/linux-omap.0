From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: Fix getting a generic phy for musb_dsps
Date: Mon, 9 Feb 2015 10:39:22 -0800
Message-ID: <20150209183922.GB2531@atomide.com>
References: <1423154113-23463-1-git-send-email-tony@atomide.com>
 <1423154113-23463-3-git-send-email-tony@atomide.com>
 <54D4BA78.9030704@ti.com>
 <20150206172313.GF25235@atomide.com>
 <CADYTM3brwenr4706Xqp91Vg7OVxT0CENy8aHhyzJ+vOGxxvRVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADYTM3brwenr4706Xqp91Vg7OVxT0CENy8aHhyzJ+vOGxxvRVw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150206 10:21]:
> Tony,
> 
> On Fri, Feb 6, 2015 at 11:23 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > * George Cherian <george.cherian-l0cyMroinI0@public.gmane.org> [150206 05:05]:
> >> Hi Tony,
> >>
> >> You also need to add similar things in dsps_musb_reset();
> >>
> >> Otherwise you might not recover from a BABBLE condition.
> >
> > Thank I totally missed that, updated patch below.
> >
> > Do you have some testcase that easily triggers BABBLE
> > on MUSB?
> 
> I normally just shorten DP or DM to VBUS to trigger babble. No device
> is connected to the port, if I remembered correctly.

Oh OK, that sounds a bit risky with 5V on the VBUS if a
device is detected? I think I'll wait on that :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
