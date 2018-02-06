From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Tue, 6 Feb 2018 10:16:23 -0800
Message-ID: <20180206181623.GC21573@atomide.com>
References: <20180204000335.29812776@kemnade.info>
 <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com>
 <20180204093831.44322452@kemnade.info>
 <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng@mail.gmail.com>
 <20180206074201.479405e7@aktux>
 <20180206160452.GA21573@atomide.com>
 <20180206175509.4d80e930@aktux>
 <20180206171737.GB21573@atomide.com>
 <20180206185452.34d01d77@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180206185452.34d01d77@aktux>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [180206 18:04]:
> On Tue, 6 Feb 2018 09:17:37 -0800
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > uarts=$(find /sys/class/tty/tty[SO]*/power/ -type d 2>/dev/null)
> > for uart in $uarts; do
> > 	echo enabled > $uart/wakeup 2>&1
> > 	echo auto > $uart/control 2>&1
> > done
> > 
> 
> hmm, this looks a bit like runtime suspend.

Not only that, it enables wakeup for UART also for suspend :)

That is if your dts has it configured with interrupts-extended
for the console UART like omap3-beagle-xm.dts has for example.
Seems like the gta04 dts don't have these.. And you also want
to have chosen with stdout-path = &uart3 or whatever the debug
UART is for earlycon to work.

> I mean suspend aka echo mem >/sys/power/state
> 
> > echo -n 1 > /sys/kernel/debug/pm_debug/enable_off_mode

And the above will enable SoC and PMIC off modes, which will also
take the suspend power to some much much lower value :) You need
to configure the PMIC too depending if the oscillator can be turned
off, in that case set "ti,twl4030-power-idle-osc-off". That too
seems to be missing in gta04 dts files..

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
