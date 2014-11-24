From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 2/4] i2c: omap: implement workaround for handling
 invalid BB-bit values
Date: Mon, 24 Nov 2014 11:25:17 -0800
Message-ID: <20141124192517.GE2757@atomide.com>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
 <1416685634-5864-1-git-send-email-al.kochet@gmail.com>
 <1416685634-5864-3-git-send-email-al.kochet@gmail.com>
 <CAMAWPa8whctBR6fBFaSzPvm3qn+QK06CimRrxFxxH=0kNkF4UA@mail.gmail.com>
 <20141124191023.GG25712@saruman>
 <20141124191347.GA26751@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141124191347.GA26751@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> [141124 11:14]:
> On Mon, Nov 24, 2014 at 01:10:23PM -0600, Felipe Balbi wrote:
> > On Mon, Nov 24, 2014 at 11:08:48AM -0800, Kevin Hilman wrote:
> > > On Sat, Nov 22, 2014 at 11:47 AM, Alexander Kochetkov
> > > <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > > In a multimaster environment, after IP software reset, BB-bit value doesn't
> > > > correspond to the current bus state. It may happen what BB-bit will be 0,
> > > > while the bus is busy due to another I2C master activity.
> > > >
> > > > Any transfer started when BB=0 and bus is busy wouldn't be completed by IP
> > > > and results in controller timeout. More over, in some cases IP could
> > > > interrupt another master's transfer and corrupt data on wire.
> > > >
> > > > The commit implement method allowing to prevent IP from entering into
> > > > "controller timeout" state and from "data corruption" state.
> > > >
> > > > The one drawback is the need to wait for 10ms before the first transfer.
> > > >
> > > > Tested on Beagleboard XM C.
> > > > Tested on BBB and AM437x Starter Kit by Felipe Balbi.
> > > >
> > > > Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > > > Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > > 
> > > This patch recently hit linux-next (as commit 903c3859f77f) and boot
> > > breakage[1] in next-20141124 on OMAP3530 Beagle and Overo/Tobi boards
> > > was bisected down to this commit.
> > > 
> > > Kevin
> > > 
> > > [1] http://status.armcloud.us/boot/?next-20141124&omap
> > 
> > btw, based on Kevin's boot test, only OMAP3530 is failing.
> 
> OK, giving Alexander some time for a fix. If it can't be found, I'll
> revert this patch. Thanks!

I can confirm reverting it fixes things for me as well thanks.

Regards,

Tony
