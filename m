From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Thu, 10 Oct 2013 09:15:42 -0700
Message-ID: <20131010161542.GB29913@atomide.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost>
 <5256AA7F.8030005@ti.com>
 <CACRpkdZx5+OCcQytkpjd7_nz4hw6VXoXOS0LByKgJ8_cQjbA4g@mail.gmail.com>
 <5256BB27.6010107@ti.com>
 <CACRpkdY6NSR7gSc6=_nEr_BdTiEM0Mt9t4GoBSoP26ceVphDhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdY6NSR7gSc6=_nEr_BdTiEM0Mt9t4GoBSoP26ceVphDhA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Prakash Manjunathappa <prakash.pm-l0cyMroinI0@public.gmane.org>, Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [131010 08:40]:
> On Thu, Oct 10, 2013 at 4:35 PM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> > On 10/10/2013 05:04 PM, Linus Walleij wrote:
> 
> >> As an innocent bystander who has no clue what the _reconfigure_io_chain()
> >> is about can you tell me what this is all about?
> >
> > The OMAP SoC has a mechanism to monitor and wakeup from a low power state by creating
> > an IO ring of all the pads. But there is one bit in one of the control registers that
> > needs to be toggled each time the pad configuration is changed to re-arm the IO ring.
> > This is exactly what _reconfigure_io_chain() does.
> 
> OK I get it, I checked the function in the machone.
> 
> >> Is this another one of the OMAP forked paths where you must call back into
> >> the machine with a special callback from each and every driver?
> >
> > _reconfigure_io_chain() is not available for public use and is not called by any driver yet.
> > However, it somehow needs to be called from this pinctrl-single driver each time the
> > wakeup configuration for any pad is changed.
> 
> Actually this is one of those things where the complexity of the platform
> seems to start to leak into the nice picture of one-register-per-pin.
> 
> If this was *not* pinctrl-single but pinctrl-omap.c, it would make sense to
> move this _reconfigure_io code and the PRM registers it is touching down
> into the pinctrl driver, because it seems like absolutely no-one else
> is using it.
> 
> Both the other occurences seem to be in omap_hwmod.c, and seems
> to be related to pin muxing, which is now supposed to be handled by
> the pin control driver, right?

Right, that's for the legacy muxing code. With the legacy code we know
the device using the pins and it's interrupt in the hwmod code, so
transparent handling of the runtime PM wake-up events is easy. But that
is at the cost of huge data tables for every SoC variant, which is what
we're trying to avoid here.
 
> I think the real solution to this would be something like:
> 
> - Add the compatible strings "pinctrl-single-omap3" and
> "pinctrl-single-omap4" to drivers/pinctrl/pinctrl-single.c,
> 
> - Pass an additional <&ampersand> resource for the prm
>  thing to the single driver in the OMAP platform.
> 
> - Move this _reconfigure_io code out of the mach-omap2
>   machines and hwmod and down into the pinctrl-single driver,
>   it can be #ifdef ARCH_OMAP with stubs or whatever, the
>   important thing is that it lives with the pinctrl driver.
> 
> This does the right thing and let the pinctrl driver handle the io ring,
> instead of artificially trying to hide that in the mach-omap2 directory
> which is only creating a mess of things.
> 
> I know this is sort of breaking the promise of pinctrl-single.c only
> handling single registers but we just need to accept the fact that
> if this idea is not perfect, trying to hide the facts of life isn't any
> good either.
> 
> What do you say about this Tony? Good/bad/Linus is a moron? ;-)

Yes once we have made omap3 to be DT only, a lot of the legacy mux stuff
will clear out. And at that point we can start moving things into PRCM
drivers to handle the single shared wake-up interrupt that PRM and also
pinctrl-single is using.

However, the reconfigure_io_chain() registers are in the PRM module, so
it still should be the PRM driver managing it rather than pinctrl-single
that's in the SCM module as they can at least in theory live a separate
power state lifes. But in any case, things will get simpler once the
dependencies to the legacy code are cut.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
