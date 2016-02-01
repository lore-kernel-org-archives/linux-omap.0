From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Subject: Re: [PATCH 0/4] pwm: omap-dmtimer: fix period/duty_cycle
 calculation
Date: Mon, 1 Feb 2016 15:14:09 -0500
Message-ID: <20160201151409.24a5957e.drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
	<CAA3gFWsc6YxEvaFW2MJ2D-xBZqEzLOJne9AHZ6zBK3h3THy0CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <CAA3gFWsc6YxEvaFW2MJ2D-xBZqEzLOJne9AHZ6zBK3h3THy0CA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 30 Jan 2016 15:52:12 +0100
Neil Armstrong <narmstrong@baylibre.com> wrote:

> 2016-01-30 5:26 GMT+01:00 David Rivshin (Allworx)
> <drivshin.allworx@gmail.com>:
> > From: David Rivshin <drivshin@allworx.com>
> >
> > When using a short PWM period (approaching the min of 2/clk_rate),
> > pwm-omap-dmtimer does not produce accurate results. In the worst
> > case a requested period of 2/clk_rate would result in a real period
> > of 4/clk_rate instead. This is a series includes a fix for that
> > problem, as well as other related improvements, and is based on the
> > current linux-pwm/for-next tip.
> >
> > I have tested on a Sitara AM335x platform, using a scope to verify
> > the output with a variety of periods and duty cycles. This includes
> > a PWM rate up clk_rate/2 with 50% duty cycle (e.g. generating
> > fclk/2) with both 32768Hz and 24MHz fclks. I do not have an OMAP4
> > board to test with, although appropriate sections in the the
> > reference manuals appear substantially the same, so I believe the
> > changes are equally correct there.
> >
> > Note that the OMAP4 TRMs do effectively state that the maximum PWM
> > rate is clk_rate/4, so at very fast PWM rates the behavior may not
> > be as reliable as I observed with Sitara. Although I suspect that
> > it's the same module and will also work, at least under some
> > circumstances. If anyone with OMAP4 hardware and a scope is so
> > inclined, I would be curious to know the results.  
> 
> Hi David,
> 
> Thanks for the work, it seems all good, I'll test them on my side the
> next days, but this work needed to be done for sure !

Thanks to you (and everyone else involved) for doing the heavy lifting 
on the driver to begin with. It came just as I had a need for the PWM 
output of a dmtimer, and came to the conclusion that just such a
timer-to-PWM adapter was needed. 

> The only OMAP4 HW I have is a Pandaboard and it's very difficult to
> get the timer outputs...

For what its worth, I took a quick look at the Pandaboard Rev EA1 
schematic, and I can see how it doesn't make using a timer PWM output 
easy. Easiest option I found might be to change the pinmux for AG24 
(h_GPIO_121) to be DMTIMER11_PWM_EVT, and probe it at S2 or J13.
