From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] [I2C-OMAP] Add support for 16-bit registers
Date: Thu, 11 Mar 2010 16:17:53 -0800
Message-ID: <20100312001753.GC2900@atomide.com>
References: <1260669242-29865-1-git-send-email-darkstar6262@gmail.com>
 <6cb013311001090947m2268833cv3784f469dc8b861d@mail.gmail.com>
 <20100109183321.GH2879@atomide.com>
 <6cb013311001091035x54321b3aqb814f476200980af@mail.gmail.com>
 <20100112012814.GK5055@atomide.com>
 <87k4tkf3ye.fsf@deeprootsystems.com>
 <20100310223000.GT2900@atomide.com>
 <878w9ydd6x.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <878w9ydd6x.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> [100311 08:36]:
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> >
> > Anyways, for the future, considering how critical this driver is
> > for all omaps.. And considering how badly this driver needs some
> > updates done..
> >
> > How about we pile up the i2c-omap patches for testing into linux-omap
> > branch first, then ask Ben to pull it around -rc6 after we've all
> > acked and tested the changes?
> >
> > Ben does that sound OK to you?
> 
> Here's another one to add to omap-testing then.
> 
> This one has been submitted to linux-i2c a couple times and been in
> the OMAP PM branch for a while.

OK, let's add that to omap-testing after we're done with the initial
fixes. This does not currently apply on top of omap-testing, BTW.

Regards,

Tony
