From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 0/3] ARM: fix three implicit module use cases fed via gpio
Date: Sat, 23 Jul 2016 10:10:52 -0400
Message-ID: <20160723141051.GB12632@windriver.com>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
 <8737n022tr.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8737n022tr.fsf@belgarion.home>
Sender: linux-gpio-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

[Re: [PATCH 0/3] ARM: fix three implicit module use cases fed via gpio] On 23/07/2016 (Sat 10:09) Robert Jarzmik wrote:

> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 

[...]

> >
> > But with ARM and GPIO being different subsystems, we'll need to get
> > this in ARM 1st, and then wait a release before changing the GPIO
> > header, otherwise we'll risk triggering these three build failures.
> >
> > So, if folks consider these three trivial changes OK for late in the
> > for-4.8 cycle, then great.  Otherwise I'll resubmit the ARM parts for
> > for-4.9 and the GPIO bits for the one after that.

[...]

> Hi Paul,
> 
> I'll take the mach-pxa changes to pxa/for-next tree with Linus's ack.
> Tony, I think you will carry the remaining omap2 one, right ?
> 
> As for the cycle, I'd prefer have it for-4.9 as we're at rc7 and it's a bit late
> for me. If you want your GPIO bits to get in 4.9 I think I can commit to request
> pull very early (-rc1 time) or give my ack so that Linus can carry these changes
> through the gpio tree with the other changes.

Yep, agreed it is now (Sat) a bit late, so as per what I said above, do
whatever you are comfortable with and I'll react accordingly to make
sure the gpio fix lands on a baseline with all the other three patches
present and doesn't introduce build regressions.

Thanks,
Paul.

> 
> Cheers.
> 
> -- 
> Robert
