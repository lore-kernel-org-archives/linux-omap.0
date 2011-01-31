From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs. runtime suspend
Date: Mon, 31 Jan 2011 19:19:48 +0100
Message-ID: <201101311919.49225.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1101311119190.1931-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1101311119190.1931-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-pm mailing list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday, January 31, 2011, Alan Stern wrote:
> On Mon, 31 Jan 2011, Kevin Hilman wrote:
> 
> > I understand how this works, but frankly I'm still a bit fuzzy on why.
> > 
> > I guess I'm still missing a good understanding of what "interfering with a
> > system power transition" means, and why a runtime suspend qualifies as
> > interfering but not a runtime resume.
> 
> These are good questions.  Rafael implemented this design originally; 
> my contribution was only to warn him of the potential for problems.  
> Therefore he should explain the rationale for the design.

The reason why runtime resume is allowed during system power transitions is
because in some cases during system suspend we simply have to resume devices
that were previously runtime-suspended (for example, the PCI bus type does
that).

The reason why runtime suspend is not allowed during system power transitions
if the following race:

- A device has been suspended via a system suspend callback.
- The runtime PM framework executes a (scheduled) suspend on that device,
  not knowing that it's already been suspended, which potentially results in
  accessing the device's registers in a low-power state.

Now, it can be avoided if every driver does the right thing and checks whether
the device is already suspended in its runtime suspend callback, but that would
kind of defeat the purpose of the runtime PM framework, at least partially.

Thanks,
Rafael
