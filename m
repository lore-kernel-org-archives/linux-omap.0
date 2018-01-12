From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Fri, 12 Jan 2018 16:39:03 +0100
Message-ID: <20180112153903.GB5992@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <90F9A8E4-035A-4A9E-8AAB-757491D63E69-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 09, 2018 at 12:55:11PM +0100, H. Nikolaus Schaller wrote:
> Hi Johan,
> 
> > Am 22.12.2017 um 15:40 schrieb H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:
> > 
> > Hi Johan,
> > 
> >> Am 22.12.2017 um 13:44 schrieb Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> >> 
> >> On Fri, Dec 01, 2017 at 08:49:36AM +0100, H. Nikolaus Schaller wrote:
> >>> Add driver for Wi2Wi W2SG0004/84 GPS module connected to some SoC UART.
> >>> 
> >>> It uses serdev API hooks to monitor and forward the UART traffic to /dev/ttyGPSn
> >>> and turn on/off the module. It also detects if the module is turned on (sends data)
> >>> but should be off, e.g. if it was already turned on during boot or power-on-reset.
> >>> 
> >>> Additionally, rfkill block/unblock can be used to control an external LNA
> >>> (and power down the module if not needed).
> >>> 
> >>> The driver concept is based on code developed by Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>
> >>> but simplified and adapted to use the new serdev API introduced in v4.11.
> >> 
> >> I'm sorry (and I know this discussion has been going on for a long
> >> time),but this still feels like too much of a hack.
> 
> Happy new year ... Happy new attempt...

Same to you.

> Let's restart this discussion and focus on the main roadblock (others
> are minor details which can be sorted out later).
> 
> If it feels like a hack, the key issue seems to me to be the choice of
> the API to present the GPS data to user space. Right?

Or even more fundamentally, does this belong in the kernel at all?

Given that we'd still depend on gpsd and other, proprietary, daemons to
actually parse and use (also for control) the plethora of GPS protocols
available, it may even be best to just keep it all in user space.

The next user may want to keep the GPS powered also when the port is
closed; this all seems like policy that should remain in user space.

Now, if we'd ever have a proper GPS framework that handled everything in
kernel space (i.e. no more gpsd) then we would be able to write kernel
drivers that also take care of PM. But perhaps that's unlikely to ever
be realised given the state of things (proprietary protocols, numerous
quirky implementations, etc).

Also it seems at least part of your specific problem is that you have
failed to wire up the WAKEUP pin of the W2SG0004/84 properly, which then
forces you to look at the data stream to determine the power state of
the chip. Judging from a quick look at the GTA04 schematics it seems
you've even connected the WAKEUP output to the 1V8_OUT output?!

The kernel is probably not the place to be working around issues like
that, even if serdev at least allows for such hacks to be fairly
isolated in drivers (unlike some of the earlier proposals touching core
code).

> I see three reasonable options how this presentation can be done:
> 
> 1. char device
> 2. tty device
> 3. some new gps interface API (similar to network, bluetooth interfaces)
> 4. no driver and use the UART tty directly
> 
> Pros and cons:
 
> 4. no driver and use UART directly
> + a non-solution seems to be attractive
> - must turn on/off chip by gpio hacks from user-space

I'm not sure that would amount to more of hack then doing it in the
kernel would.

> - can not guarantee (!) to power off the chip if the last user-space
> process using it is killed (which is essential for power-management of
> a handheld, battery operated device)

That depends on how you implement things (extending gpsd, wrapper
script, pty daemon, ...).

> I would clearly prefer 3 over 2 over 1 over 4.
> 
> So do you see a chance that the kernel core team provides something useable
> (not perfect) for variant 3 in reasonable time (let's say 3-6 months)?

No, I'm afraid not. At least not if we're talking about a framework
that would replace gpsd.

> If not, I want to suggest to accept the second-best choice 2. for now and we
> will update the driver as soon as 3. appears. IMHO it would be a good test case
> for a new subsystem.

Getting the interface right from the start is quite important, as
otherwise we may end up having to support a superseded one for a long
time.

Johan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
