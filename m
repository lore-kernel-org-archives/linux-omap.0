From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 2/4] ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
Date: Tue, 17 Feb 2015 15:06:35 +0100
Message-ID: <CAMdRc4F1Ja2Y96W_VESuS=tueYE8Q+iWmoiJW2dj+6-HeDzNqQ@mail.gmail.com>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<54E2F803.3070901@ti.com>
	<CAMdRc4F9B0ft-ExgQ1vHqwXMiONwWKn3FPCRDyHsjgGe1Dn_1w@mail.gmail.com>
	<54E34786.1010102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E34786.1010102@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Tue, Feb 17, 2015 at 2:52 PM, Roger Quadros <rogerq@ti.com> wrote:
> nobody stops the DT binding from specifying a large enough "gpmc,wait-monitoring-ns" value.
> The driver must use that to scale the GPMC_CLK if it doesn't fit in the GPMC_FCLK.
> This feature can come separately though. So for now I was suggesting to set the divisor to 1.
> [...]
> AFAIK "gpmc,sync-clk-ps" is not specified for asynchronous devices so it defaults to 0
> in the driver.

As you have rightly pointed out, sync-clk-ps defaults to 0, i.e.
divider 1. My solution would work for people /now/ with different
gpmc,wait-monitoring-ns requirements. Of course, in general you're
right, the driver could compute that on its own. However, this
influences sampling behavior of the GPMC, which is somewhat strange
anyway. Since I lack a proper test setup and time to experiment with
the GPMC, I'd compromise on leaving sync-clk-ps default to 0, divider
defaults to 1. If somebody feels up to implementing driver-side
GPMC_CLK scaling, they might as well nix the dependency at that point
in time. Right now, keeping the dependency seems more useful to users
than killing it right away.

> What I'm stressing on is that there shouldn't be any dependency on "gpmc,sync-clk-ps" for
> asynchronous devices. It also becomes easier to specify the wait-monitoring-ns as we don't need
> to cross reference with "sync-clk-ps".

As an aside: There shouldn't be a dependency on the FCLK for
synchronous accesses either. The GPMC driver is in a somewhat terrible
state that synchronous protocols have to specify in ns, which get
scaled by the startup FCLK period... So this wrongful dependency
doesn't make my top ten, especially since it right now would fit a use
case.

Regards,

Robert
