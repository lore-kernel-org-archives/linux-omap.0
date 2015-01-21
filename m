From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 13/21] ARM: omap: convert wakeupgen to stacked domains
Date: Wed, 21 Jan 2015 13:37:07 -0800
Message-ID: <20150121213706.GU7718@atomide.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
 <1421660655-21394-14-git-send-email-marc.zyngier@arm.com>
 <20150121163031.GR7718@atomide.com>
 <54BFE05E.9080403@arm.com>
 <20150121183615.GS7718@atomide.com>
 <54C00832.1070807@oracle.com>
 <20150121204347.GT7718@atomide.com>
 <54C019EB.5030007@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54C019EB.5030007@oracle.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: santosh shilimkar <santosh.shilimkar@oracle.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Stefan Agner <stefan@agner.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-s>
List-Id: linux-omap@vger.kernel.org

* santosh shilimkar <santosh.shilimkar@oracle.com> [150121 13:31]:
> On 1/21/2015 12:43 PM, Tony Lindgren wrote:
> >* santosh shilimkar <santosh.shilimkar@oracle.com> [150121 12:16]:
> >>
> >>TWD is useless on this machine since single core and TWD
> >>as know die in low power states. All the broadcast stuff
> >>is for SMP machines.
> >
> >Hmm it seems we should still use TWD during runtime and
> >swich over to the gptimer for idle states for wake-up
> >events.
> >
> Well timer wheel code don't support it so if you are serious,
> some one needs to do that. For me, it is not worth at all.
> You will have more to loose than gain with these time switching
> schemes since you have to keep 2 times alive, do switching, loose
> the idle time.
> 
> All of that is to save few CPU cycles since TWD is closer
> compared to other SOC timer.
> 
> Anyways I will let you fight it out but IIRC, I had a
> discussion a while back with tglx in one of the conference
> and the conclusion was it not worth doing.
> Rather TWD hardware on SOC should be made wakeup capable
> and then everything is good.
> 
> Till you have support, using TWD on AM43XX will break CPUIDLE.
> Not sure if it is supported or some one cares about it. Just
> keep that aspect in mind.

Yes sure I'm aware of this. It should be easy to profile the
speed gain to see if it would make much of a difference
before starting to tinker with that.

The way I think it's possible to do would be to copy the TWD
timer value to a wake-up capable gptimer before hitting any
deeper idle state. Of course some aux timer support might be
still needed :)

Regards,

Tony
