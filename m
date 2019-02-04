From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Date: Mon, 4 Feb 2019 10:43:17 -0800
Message-ID: <20190204184317.GO5720@atomide.com>
References: <20190202055827.12956-1-andreas@kemnade.info>
 <20190204155604.GH5720@atomide.com>
 <20190204193311.102a60e6@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204193311.102a60e6@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux@armlinux.org.uk, khilman@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190204 18:33]:
> On Mon, 4 Feb 2019 07:56:04 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Andreas Kemnade <andreas@kemnade.info> [190202 06:01]:
> > > Enabling off mode was only reachable deeply hidden
> > > in the debugfs. As powersaving is an important feature,
> > > move the option out of its shady place.  
> > 
> > How about let's enable always if we have the twl4030
> > configured to allow it? You can just check if the dts has
> > "ti,twl4030-power-idle" or "ti,twl4030-power-idle-osc-off"
> > properties set.
> > 
> > In order to enable deeper idle states, the user space still
> > needs to idle the UARTs and possibly other hardware blocking
> > idle. So we should be safe there.
> > 
> Let us not mix up runtime pm and system pm. The uarts need
> to be idled for runtime suspend, but they are off/ret for
> system suspend without userspace intervention, so allowing off mode
> will have an influence even without uart runtime suspend,
> and also probably for other powerdomains (non-core/per).
> So we still need to be sure to handle at least some erratas and
> context save/restore correctly.

True that's a good point.

> Your Idea seems to be in pseudocode
> if (powersaving_wanted)
> 	enable_off_mode()
> 
> I had something in mind like
> if (system_is_trusted_to_handle_offmode()
> 	enable_off_mode()

For omap3, the properties for "ti,twl4030-power-idle" or
"ti,twl4030-power-idle-osc-off" mean just that.

The PMIC is wired and configured for off mode, and those
properties should not be set unless the system is truly capable
of entering off mode. If not set, we should not enable off
idle by default.

Otherwise the boards should be already using just
"ti,twl4030-power" or "ti,twl4030-power-reset".

So it should be safe to set a flag for off_mode based
on that flag during boot, or set a flag for off
mode allowed if the flag is needed later on.

Regards,

Tony
