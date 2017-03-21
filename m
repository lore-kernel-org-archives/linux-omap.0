From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing
 handle_reread
Date: Tue, 21 Mar 2017 16:43:30 +0000
Message-ID: <20170321164330.GB6986@localhost.localdomain>
References: <20170317003633.7361-1-tony@atomide.com>
 <20170317003633.7361-2-tony@atomide.com>
 <20170320151413.GT6986@localhost.localdomain>
 <20170320153341.GK20572@atomide.com>
 <20170321092340.GU6986@localhost.localdomain>
 <20170321154122.GB10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170321154122.GB10760@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 21, 2017 at 08:41:22AM -0700, Tony Lindgren wrote:
> * Charles Keepax <ckeepax@opensource.wolfsonmicro.com> [170321 02:24]:
> > On Mon, Mar 20, 2017 at 08:33:42AM -0700, Tony Lindgren wrote:
> > > * Charles Keepax <ckeepax@opensource.wolfsonmicro.com> [170320 08:15]:
> > > > On Thu, Mar 16, 2017 at 05:36:30PM -0700, Tony Lindgren wrote:
> > That sounds a lot like a level triggered IRQ. If they are
> > repeatedly reading the GPIO line until it returns to high to know
> > they need to process more IRQs, that implies the line is staying
> > low whilst IRQs need handling which is level triggered.
> 
> Yeah.. Actually my description above is a bit wrong sorry. It seems
> the GPIO line changes status too early in some cases meaning the
> interrupts stop. So it's like a buggy implementation of level IRQ
> that stops driving the GPIO interrupt line to the SoC in some cases
> even with PMIC interrupts pending. So it seems like a bug in the
> CPCAP PMIC.
> 
> So the handling needs to be "read while CPCAP interrupts in the
> registers even if the GPIO line to SoC has cleared stopped
> signaling interrupts" :)
> 

Ah ok thanks for taking the time to explain that. Yeah that
sounds like the PMIC hardware is a bit buggy so you will
presumably need something to support this.

Thanks,
Charles
