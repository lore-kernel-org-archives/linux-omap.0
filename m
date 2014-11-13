From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for
 devconf1 register
Date: Thu, 13 Nov 2014 22:59:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411132251320.17030@utopia.booyaka.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com> <1415051968-4878-5-git-send-email-marek@goldelico.com> <5463585D.9070209@ti.com> <20141112150210.GC26481@atomide.com> <5464969F.30708@ti.com> <20141113182848.GQ26481@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141113182848.GQ26481-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi

On Thu, 13 Nov 2014, Tony Lindgren wrote:

> * Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [141113 03:33]:
> > On 12/11/14 17:02, Tony Lindgren wrote:
> > 
> > >> And, with a quick grep, I see CONTROL_DEVCONF1 touched in multiple
> > >> places in the kernel. I wonder if adding a pinmux entry for it could
> > >> cause some rather odd problems.
> > > 
> > > They can all use pinctrl-single no problem.
> > 
> > Can, but don't. That's my worry. If we touch the DEVCONF1 via pinmux,
> > and we have code in mach-omap2 that also touch DEVCONF1, without any
> > knowledge (and locking) between those...
> 
> Hmm yeah the McBSP clock mux could be racy as the mux register for
> McBSP is treated as a clock. This register muxes the clock between
> external pin and internal clock. Considering that this should be
> selectable at board level as the external clock probably needs to be
> used if level shifters are being used, it should be really handled by
> pinctrl-single.
> 
> The other use for hsmmc.c and pdata-quirks.c for the one time mux for
> MMC clock from the MMC clock pin. That can be done with pinctrl-single
> from the MMC driver too for DT based booting.
> 
> Then we just have the save and restore of the registers for
> off-idle.
>  
> > So _maybe_ that's not an issue, as the pinmux config we have here is
> > fixed, and done once at boot time, and maybe the code in mach-omap2 that
> > touch DEVCONF1 is also ran just once and not at the same time as the
> > pinmux. But I don't know if that's so.
> 
> It seems we could just do a read-only check for McBSP in the clock
> code for the mux register, or even completely drop that code from
> cclock3xxx_data.c and start using the pinctrl for that mux.
> 
> Paul & Tero, got any comments here?

It's best to move all of the SCM register reads/writes to an SCM IP block 
driver.  This driver would be the only entity that would touch the SCM IP 
block registers - no other code on the system would touch it (perhaps 
aside from anything needed for early init).  The SCM driver would enforce 
mutual exclusion via a spinlock, so concurrent SCM register modifications 
wouldn't flake out.  Then the SCM driver would register clocks with the 
CCF, register pins with the pinctrl subsystem, etc. etc.

- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
