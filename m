From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Thu, 18 Jan 2018 17:47:36 +1100
Message-ID: <20180118064736.GH3286@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <20180109184347.28ba0a6e@aktux>
 <20180112144647.GA5992@localhost>
 <20180112194022.7da1e726@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180112194022.7da1e726-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 12, 2018 at 07:40:35PM +0100, Andreas Kemnade wrote:
> On Fri, 12 Jan 2018 15:46:47 +0100
> Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> > On Tue, Jan 09, 2018 at 06:43:47PM +0100, Andreas Kemnade wrote:
> > > On Fri, 22 Dec 2017 13:44:27 +0100
> > > Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > > 
> > > [...]  
> > > > I'd suggest reiterating the problem you're trying to solve and
> > > > enumerating the previously discussed potential solutions in order to
> > > > find a proper abstraction level for this (before getting lost in
> > > > implementation details).
> > > >   
> > > The main point here is in short words: Having a device powered on or off
> > > when the uart it is attached to, is used or not used anymore,
> > > so the already available userspace applications do not need to be changed.  
> > 
> > So we'd end up with something in-between a kernel driver and a
> > user-space solution. What about devices that need to be (partially)
> > powered also when the port isn't open? A pure user-space solution would
> > be able to handle all variants.
> > 
> Well partly powered devices are at many places, And they hide that problem
> from userspace, just get the open()/get() and close()/put() from there and power the
> device accordingly. 
> 
> So the question still remains why should the kernel hide some things and some
> it should not.
> If it all is in userspace, then there is still something needed in the devicetree
> (if I understand correctly, every information about hardware which cannot be
> auto-probed belongs into device tree) so that the userspace knows what kind of
> device is at that port. So there can be a daemon powering on and off devices.
> But that would break existing applications which just expect that they just need
> to open/close the device. 
> 
> Or you need to have some inotify handler in userspace and attach it there to
> react on close() and open() of that device.
> But this thing needs to have two kind of information:
> 
> 1. the type of chip available to do the right powerup sequence. 
> 
> 2. how the chip is wired up to the cpu. 
> 
> So to avoid having hardware information spread all over the table at least
> these information would need to be in devicetree. But that also all feels
> like a hack and hard to maintain.

Having the device described in the device tree is certainly desirable,
not least for chip identification. And with a GPS framework in the
kernel with a well-defined interface, implementing power management
would be straight forward.

I'm just not convinced that the proposed tty interface is the right
interface for this. User space would still rely on gpsd for the GPS
protocols, and would also ultimately be managing power by killing gpsd
or whatever daemon that would otherwise be holding the port open.

Something like the generic power sequences that has been discussed
elsewhere might be a better fit for this if all you want to do is power
on and off on port open and close (and on suspend/resume). There really
isn't anything GPS-specific in the current proposal (besides the
suggested tty-device name).

But sure, that wouldn't be sufficient to deal with the
unknown-power-state problem with the device in question.

Johan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
