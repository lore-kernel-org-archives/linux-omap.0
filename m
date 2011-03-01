From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5 v3] usb: musb: Power management support
Date: Tue, 1 Mar 2011 11:26:56 +0200
Message-ID: <20110301092656.GC2942@legolas.emea.dhcp.ti.com>
References: <1298882976-4997-1-git-send-email-hemahk@ti.com>
 <20110228085611.GL2459@legolas.emea.dhcp.ti.com>
 <20110228142030.GA25724@kroah.com>
 <20110228212227.GK20560@atomide.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110228212227.GK20560-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 28, 2011 at 01:22:28PM -0800, Tony Lindgren wrote:
> * Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> [110228 06:21]:
> > On Mon, Feb 28, 2011 at 10:56:11AM +0200, Felipe Balbi wrote:
> > > On Mon, Feb 28, 2011 at 02:19:31PM +0530, Hema HK wrote:
> > > > 
> > > > There is some problem with idle path offmode in mainline, I could not test
> > > > with offmode. But I have tested this patch with resetting the controller
> > > > in the idle path when wakeup from retention just to make sure that the
> > > > context is lost, and restore path is working fine.
> > > 
> > > Tony and Greg, how do we handle this one ? Who should take my pull request
> > > for this series ? I hope we still have a little time to get this into
> > > 2.6.39, but if we don't I can hold on to them until 2.6.40.
> > 
> > Doesn't bother me which tree they go through, I can take them, or, if
> > it's easier due to omap merges, Tony can.
> 
> I prefer Greg's queue unless there's some dependency issue to the
> patches we have in omap-for-linus.

Turns out I can easily split what's supposed to go for you and what's
supposed to go for Greg, so I'll do it. Tony which commit can I use for
your tree ? Is mainline 2.6.38-rc6 ok ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
