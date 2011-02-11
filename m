From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] PM: Allow pm_runtime_suspend() to succeed during system
 suspend
Date: Fri, 11 Feb 2011 15:36:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102111514180.2048-100000@iolanthe.rowland.org>
References: <201102112100.23996.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201102112100.23996.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 11 Feb 2011, Rafael J. Wysocki wrote:

> > The reason why runtime suspend is not allowed during system power transitions
> > if the following race:
> > 
> > - A device has been suspended via a system suspend callback.
> > - The runtime PM framework executes a (scheduled) suspend on that device,
> >   not knowing that it's already been suspended, which potentially results in
> >   accessing the device's registers in a low-power state.
> > 
> > Now, it can be avoided if every driver does the right thing and checks whether
> > the device is already suspended in its runtime suspend callback, but that would
> > kind of defeat the purpose of the runtime PM framework, at least partially.
> 
> In fact, I've just realized that the above race cannot really occur, because
> pm_wq is freezable, so I'm proposing the following change.

Yes, I had reached essentially the same conclusion.  Of course, there 
may still be other kernel threads running or interrupt handlers that 
can interfere.  It's probably okay to assume that drivers will handle 
these things.

> Of course, it still doesn't prevent user space from disabling the runtime PM
> framework's helpers via /sys/devices/.../power/control.

True.  So in the end this won't make much difference, but we might as 
well do it.

Alan Stern
