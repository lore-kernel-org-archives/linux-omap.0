From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 10/10] ARM: dts: n950: add display support
Date: Fri, 24 Mar 2017 08:44:00 -0700
Message-ID: <20170324154400.GA10760@atomide.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-10-sre@kernel.org>
 <20170324142939.GY10760@atomide.com>
 <fe873378-a93f-5829-215c-fb4a3cc3f514@ti.com>
 <20170324151202.GZ10760@atomide.com>
 <38bb9030-5244-1751-1606-4d6598139bf0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <38bb9030-5244-1751-1606-4d6598139bf0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [170324 08:22]:
> On 24/03/17 17:12, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [170324 08:01]:
> >> On 24/03/17 16:29, Tony Lindgren wrote:
> >>> * Sebastian Reichel <sre@kernel.org> [170304 16:45]:
> >>>> Add basic panel support for the Nokia N950. It must be tweaked a
> >>>> little bit later, since the panel was built into the device
> >>>> upside-down. Also the first 5 and the last 5 pixels are covered
> >>>> by plastic.
> >>>
> >>> This one seems safe to apply separately to shrink the pending
> >>> patches a bit. Please confirm if that's the case and I'll apply
> >>> this one.
> >>
> >> No, I think there are too many open questions to apply this one. And we
> >> need to move to common DRM drivers at some point (hopefully soon) so the
> >> bindings must be aligned with those if and when possible.
> > 
> > Hmm so what are the open questions and do you have in mind for
> > the panel bindings?
> 
> Well, until we have driver that supports the panel without problems, we
> can't be sure if we have everything in the binding. At least the TE was
> missing or broken.

Sure, I don't think that needs a binding though?

> Normal videotimings don't really make sense for DSI command mode panels,
> so I'm not overly enthusiastic in having them in the bindings. Possibly
> that's the easy way to go, but I'm not sure yet.

Are you talking about passing the clock-frequency = <0> where
dsi calculates it or also some other things too?

> There are the "TODO" parts in the bindings, that's a clear sign of open
> questions.

Yeah the default rotation part seems to be completely open :)
We should probably stick with just kernel cmdline for that for
now until there is some generic solution.

> I haven't looked at how the other DRM drivers handle DSI command mode
> panels. That's something to study, before adding anything new to the
> omap specific bindings.

OK. I suggest we just stick to standard existing bindings for now.

> > Naturally we still need to support the current bindings too.
> 
> Do the current bindings work? I guess they did work on omapfb... Do
> these new bindings work with omapfb?

Well yeah in general they work just fine for the basic resolution +
clock + control GPIOs. I think that binding is just fine. So we should
probably stick to that before adding more stuff.

For command mode panels, looking at patch 1 of this series we always
had the resolution hardcoded into the driver.. And talking about
patch 1, do you also have some issues with it other than that typo there
pointed out by Pavel?

> Generally speaking, I've been bitten badly enough with DT bindings that
> weren't up to the task after all, and then changing the later was a
> major pain (or working around it). So I'd rather not merge anything to
> DT if there are any unclarities, and a driver not working which uses
> those bindings is an unclarity. Especially if the only reason to merge
> is to get a single patch out from a bigger patch series, without
> actually enabling anything.

Sure. The solution there is to just stick to basics until with the
binding until things are clear. So in this case resolutions + clocks +
control GPIOs + regulators. Those all are existing standard bindings
that can easily be supported.

Regards,

Tony
