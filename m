From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: add dev_dbg() message for
 effective period and duty cycle
Date: Tue, 2 Feb 2016 18:44:43 -0500
Message-ID: <20160202184443.1e1b0bf5.drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
	<1454128014-22866-5-git-send-email-drivshin.allworx@gmail.com>
	<CAA3gFWvSsctXtds6_SEtYY1yUdWJDR1XjznGS6qjdrGW5Dbw=A@mail.gmail.com>
	<20160201132228.2634b72e.drivshin.allworx@gmail.com>
	<20160201185952.GN19432@atomide.com>
	<20160202162330.GA4918@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20160202162330.GA4918@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2 Feb 2016 17:23:30 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Feb 01, 2016 at 10:59:52AM -0800, Tony Lindgren wrote:
> > Hi,
> > 
> > * David Rivshin (Allworx) <drivshin.allworx@gmail.com> [160201
> > 10:23]:  
> > > On Sat, 30 Jan 2016 15:51:06 +0100
> > > Neil Armstrong <narmstrong@baylibre.com> wrote:
> > >   
> > > > 2016-01-30 5:26 GMT+01:00 David Rivshin (Allworx)
> > > > <drivshin.allworx@gmail.com>:  
> > > > > From: David Rivshin <drivshin@allworx.com>
> > > > >
> > > > > After going through the math and constraints checking to
> > > > > compute load and match values, it is helpful to know what the
> > > > > resultant period and duty cycle are.
> > > > >
> > > > > Signed-off-by: David Rivshin <drivshin@allworx.com>
> > > > > ---
> > > > >
> > > > > I found this helpful while testing the other changes, so I
> > > > > included it in case it may be of use to someone in the
> > > > > future. I would have no issues with dropping this if it's not
> > > > > considered worthwhile.    
> > > > 
> > > > It's useful, but converting it as a sysfs attribute would be
> > > > great !  
> > > 
> > > Hrm, yes that is an interesting thought. I imagine that many PWM 
> > > devices have similar constraints, so perhaps that would be best 
> > > handled generically in the pwm core? Maybe as new optional
> > > get_*() ops, a modification to the config() op to add output
> > > params, or just updating new fields in the struct pwm directly?  
> > 
> > Yeah for /sys entry it should be Linux generic. The other option
> > is to use debugfs for driver specific things.  
> 
> Let's go with debugfs for this one. This is used for diagnostic

I had looked at using the dbg_show() op to add some additional data. 
One thing that discouraged me from going down that path was that 
it replaced the call to pwm_dbg_show() for that chip. I wouldn't 
want to loose the existing output, as it is useful, but also didn't
like the thought of duplicating the logic/formatting. I think some 
way to have both the standard output and add extra output somewhere
(e.g. same line, line after each pwm_device, block after all 
pwm_devices on the chip) would make that path more attractive.

Or were you thinking of a separate (per-chip) debugfs file for this 
type of information? 

> purposes and not typically needed when configuring a PWM. While other
> drivers may compute similar hardware-specific values, there's nothing
> generic to them. The period and duty cycle are the generic input
> values and those are already exposed via sysfs.

Just to clarify, what I was thinking of as generic was the concept
that "period/duty I asked for" and "period/duty I got" may be
different, sometimes to a substantial degree. I could imagine 
userspace wanting to know the latter, which is what I think Neil 
was suggesting.

For the sake of an example, the input clock for a dmtimer is sometimes
(often?) 32768Hz, which means that the real period and duty_cycle output
are limited to being a multiple of ~61035.2ns (16384Hz). So an attempt 
to set a period of 100000ns (10KHz) would result in either 61035.2ns, or 
122070.4ns (8192Hz), depending on the implementation of the driver (and 
patch 2 changes behavior from the former to the latter). You can also 
have cases where you desired a 33% duty cycle, but got a 25% duty cycle 
instead.

In a quick look, I see substantially similar calculations (i.e. 
clk_rate*period_ns/10^9) in most of the other pwm drivers, which makes 
sense for any that are programmed in terms of some input clock. This 
type of calculation almost guarantees that requested and actual period/
duty_cycle are going to be different to some degree. Some drivers look 
like they have even more complicated behavior, apparently due to other 
hardware constraints. For instance, fsl-ftm (among others) looks to be 
using a power-of-2 prescaler to fit the period_cycles into a 16bit field.

Of course if the input clock rate for these types of devices is 
sufficiently high (enough that the desired period is many input clock 
cycles), then the difference between "desired" and "actual" is probably 
small enough that noone cares. I'm not sure how common it is that
  a) there is a substantial difference, and
  b) userspace cares about it, and
  c) userspace didn't carefully select an achievable value already
If noone has brought it up before, then I'd guess the answer is "not very".
