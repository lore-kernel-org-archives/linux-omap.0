From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Subject: Re: [PATCH 0/4] pwm: omap-dmtimer: fix period/duty_cycle
 calculation
Date: Fri, 4 Mar 2016 18:20:13 -0500
Message-ID: <20160304182013.58261fc7.drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
	<20160226203100.303fe192.drivshin.allworx@gmail.com>
	<20160304151948.GF26400@ulmo.nvidia.com>
	<20160304112736.660e4223.drivshin.allworx@gmail.com>
	<20160304211838.GA21731@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20160304211838.GA21731@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>, Adam Ford <aford173@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 4 Mar 2016 22:18:38 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Fri, Mar 04, 2016 at 11:27:36AM -0500, David Rivshin (Allworx) wrote:
> > On Fri, 4 Mar 2016 16:19:48 +0100
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> >   
> > > On Fri, Feb 26, 2016 at 08:31:00PM -0500, David Rivshin (Allworx) wrote:  
> > > > On Fri, 29 Jan 2016 23:26:50 -0500
> > > > "David Rivshin (Allworx)" <drivshin.allworx@gmail.com> wrote:
> > > >     
> > > > > From: David Rivshin <drivshin@allworx.com>
> > > > > 
> > > > > When using a short PWM period (approaching the min of 2/clk_rate),
> > > > > pwm-omap-dmtimer does not produce accurate results. In the worst case a
> > > > > requested period of 2/clk_rate would result in a real period of 4/clk_rate
> > > > > instead. This is a series includes a fix for that problem, as well as
> > > > > other related improvements, and is based on the current linux-pwm/for-next
> > > > > tip.
> > > > > 
> > > > > I have tested on a Sitara AM335x platform, using a scope to verify the
> > > > > output with a variety of periods and duty cycles. This includes a PWM
> > > > > rate up clk_rate/2 with 50% duty cycle (e.g. generating fclk/2) with
> > > > > both 32768Hz and 24MHz fclks. I do not have an OMAP4 board to test with,
> > > > > although appropriate sections in the the reference manuals appear
> > > > > substantially the same, so I believe the changes are equally correct
> > > > > there.
> > > > > 
> > > > > Note that the OMAP4 TRMs do effectively state that the maximum PWM
> > > > > rate is clk_rate/4, so at very fast PWM rates the behavior may not be
> > > > > as reliable as I observed with Sitara. Although I suspect that it's
> > > > > the same module and will also work, at least under some circumstances.
> > > > > If anyone with OMAP4 hardware and a scope is so inclined, I would be
> > > > > curious to know the results.
> > > > > 
> > > > > David Rivshin (4):
> > > > >   pwm: omap-dmtimer: fix inaccurate period/duty_cycle calculation
> > > > >   pwm: omap-dmtimer: add sanity checking for load and match values
> > > > >   pwm: omap-dmtimer: round load and match values rather than truncate
> > > > >   pwm: omap-dmtimer: add dev_dbg() message for effective period and duty
> > > > >     cycle
> > > > > 
> > > > >  drivers/pwm/pwm-omap-dmtimer.c | 71 ++++++++++++++++++++++++++++++++----------
> > > > >  1 file changed, 55 insertions(+), 16 deletions(-)
> > > > >     
> > > > 
> > > > Hi Thierry,
> > > > 
> > > > Gentle ping. It does not look like you've taken this series, and I 
> > > > wanted to make sure you're not waiting on something from me. It would 
> > > > be nice to get at least the first patch into 4.5, if possible.    
> > > 
> > > I've applied patches 1 and 3, and I'm planning on sending out a pull
> > > request for inclusion in v4.5-rc7 later on.  
> > 
> > Thanks!
> >   
> > > Patches 2 and 4 didn't seem ready/critical, so let's finish those up
> > > for v4.6-rc1.  
> > 
> > I know there was a lot of discussion on 4, but I'm not sure what the 
> > concern is on patch 2. Is there something specific you're thinking of?  
> 
> Patch 2 sounded like some optional sanity checking which we didn't hit
> anyway in the current code. Hence I didn't consider it a fix.

Hrm, perhaps there is something I should have added/changed in the
patch description to clarify? 

For further background, patch 2 protects against things that are legal 
in the PWM API itself, but not possible for this hardware to actually do. 
Specifically a very short period, or duty_cycle too close to either 0 or 
100%. Without the checking, the natural result of the normal math results 
in setting up the HW in non-sensical ways. 

As long as noone attempts to configure the PWM in those ways, then I'd
agree it's not critical. What made me think it was more important was 
when I saw that Adam (and so probably others) used it for a PWM-backlight, 
which will naturally try to set 0 and 100% duty cycle.

> > FYI, I know that Adam Ford is using this driver as the backend for
> > a pwm-backlight control. Without patch 2 this driver will not configure 
> > the HW in a legal way at 0 or 100% duty cycle. However, I forget what 
> > the practical effect of that is, and Adam seemed to indicate it was OK
> > for his purposes.  
> 
> Okay, I'll hold back a little longer to give you some time to test.

FYI, I just went and retested what the effect is without those checks.
If the duty_cycle is set too low, the result is that the output is constant 
high. If the duty_cycle is set too high, the result is that the output is 
constant low. IOW, the result is the reverse of what the user requested.

If the period is too low, then you also get one of those two results, 
depending on what the duty_cycle is (essentially the duty_cycle is always
too close to 0/100%). 

With patch 2, it will clamp the duty_cycle to the lowest/highest possible
value. So while imperfect, at least isn't the reverse of the requested
behavior.
