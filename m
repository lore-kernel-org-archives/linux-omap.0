From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: gta04: add serial console wakeup irq
Date: Tue, 25 Sep 2018 09:48:33 -0700
Message-ID: <20180925164833.GP5662@atomide.com>
References: <20180923150719.8211-1-andreas@kemnade.info>
 <20180924220345.GG5662@atomide.com>
 <20180925072550.424e82e7@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180925072550.424e82e7@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [180925 05:32]:
> Hi Tony,
> 
> On Mon, 24 Sep 2018 15:03:45 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Andreas Kemnade <andreas@kemnade.info> [180923 08:12]:
> > > This enables the possibility to have more aggressive runtime pm
> > > by providing proper wakeup irq for the serial console.  
> > 
> > Thanks applying to omap-for-v4.20/dt.
> > 
> > FYI, you can now grep wake /proc/interrupts and see the
> > wakeirq counts increase when they trigger. Might be handy
> > for debugging PM stuff.
> > 
> thanks for that information, you also had a patch for checking
> pm which was explicitely marked as not-to-merge. Is there
> any up-to-date version of it?

It's still the same so no updates to it.

> Well, for debugging I check first average currents via bq27000
> attached to omap_hdq. omap_hdq gets stuck after first transaction
> after idling uarts which does not happen when CM_AUTOIDLE1_CORE.AUTO_HDQ
> is cleared. Reloading the omap_hdq module to try to fix things
> makes w1 really freak out (patch already sent for that).
> Well, will do some rtfm and hopefully come back with a patch.
> afaicr there was something special...

Hmm sounds like drivers/w1/masters/omap_hdq.c needs to implement
PM runtime calls, it's probably just enabled because of only
needing the interconnect fck that the uart happens to keep
enabled.

> The result are power management problem in /dev/brain ;-)

:)

Tony
