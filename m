From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 5/5] pwm: pwm-omap-dmtimer: Add capture functionality
Date: Mon, 8 Jan 2018 14:13:27 -0800
Message-ID: <20180108221327.GW3875@atomide.com>
References: <20180108153926.GA3916@lenoch>
 <20180108154336.GE4077@lenoch>
 <20180108215931.GV3875@atomide.com>
 <20180108220602.GA17615@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180108220602.GA17615@lenoch>
Sender: linux-pwm-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Keerthy <j-keerthy@ti.com>, aaro.koskinen@iki.fi, thierry.reding@gmail.com, daniel.lezcano@linaro.org, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [180108 22:09]:
> On Mon, Jan 08, 2018 at 01:59:31PM -0800, Tony Lindgren wrote:
> > * Ladislav Michl <ladis@linux-mips.org> [180108 15:46]:
> > > Here it seems hardware can capture both edges, but I do not see a way
> > > how to tell it I want start from either low to high or high to low
> > > transition. Clues?
> > 
> > At least dm3730 TRM documents TCM bits [9:8] for TCLR, but you
> > probably know that already..
> > 
> > If you're having hard time getting things starting, maybe something
> > like this helps:
> > 
> > stop timer in TCLR register
> > configure timer in TCLR
> > write some value to TLDR, maybe 0?
> > set ST bit in TCLR to start
> 
> Let me clarify it a bit more. I have no problem starting timer and capture
> events. I just didn't find a way how to tell hardware I want to start
> with for example rising edge, so rising edge goes to TCAR1 and failing edge
> to TCAR2. Substracting those gives pulse width.

Oh I see, yeah that would be cool :) Maybe you can first configure
an interrupt to trigger on rising edge, then configure things for
falling edge, then subtract..

Regards,

Tony
