From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-omap: Make sure i2c bus is free before setting it
	to idle
Date: Wed, 22 Sep 2010 01:07:49 +0100
Message-ID: <20100922000748.GG7494@trinity.fluff.org>
References: <1282808204-1689-1-git-send-email-mathias.nyman@nokia.com> <20100826074118.GH23263@nokia.com> <20100916224050.GU29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100916224050.GU29610-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Nyman Mathias (Nokia-MS/Helsinki)" <Mathias.Nyman-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 16, 2010 at 03:40:50PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> [100826 00:34]:
> > Hi,
> > 
> > On Thu, Aug 26, 2010 at 09:36:44AM +0200, Nyman Mathias (Nokia-MS/Helsinki) wrote:
> > >If the i2c bus receives an interrupt with both BB (bus busy) and
> > >ARDY (register access ready) statuses set during the tranfer of the last message
> > >the bus was put to idle while still busy.
> > >
> > >This caused bus to timeout.
> > >
> > >Signed-off-by: Mathias Nyman <mathias.nyman-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > 
> > adding linux-i2c and Ben Dooks to Cc list.
> 
> Ben, can you please take this? The patchwork.kernel.org link is:

thanks, added to for-linus/2636-rc6-i2c

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
