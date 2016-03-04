From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Subject: Re: [PATCH 0/4] pwm: omap-dmtimer: fix period/duty_cycle
 calculation
Date: Fri, 4 Mar 2016 15:01:09 -0500
Message-ID: <20160304150109.2c4941ef.drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
	<20160226203100.303fe192.drivshin.allworx@gmail.com>
	<20160304151948.GF26400@ulmo.nvidia.com>
	<20160304112736.660e4223.drivshin.allworx@gmail.com>
	<CAHCN7xJYi8VCe8ue_QuYmqTEo-8GPSPiwzM2F_631mMUrwajSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xJYi8VCe8ue_QuYmqTEo-8GPSPiwzM2F_631mMUrwajSA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Joachim Eastwood <manabian@gmail.com>, linux-arm-kernel@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, Grant Erickson <marathon96@gmail.com>, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 4 Mar 2016 10:29:07 -0600
Adam Ford <aford173@gmail.com> wrote:

> I am OK with it. 0% vs 1% is not perceivable and neither is 99% vs 100%.

IIRC, you tested with none of these patches, and with all of them. You 
might want to double check the behavior with just patch 1 and 3, since
that's what Thierry applied. I'm just concerned that the behavior now 
might be worse at one extreme or the other, compared to your previous 
tests. 

> 
> Thanks!
> 
> Adam
> On Mar 4, 2016 10:27 AM, "David Rivshin (Allworx)" <
> drivshin.allworx@gmail.com> wrote:  
> 
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
> > > > > pwm-omap-dmtimer does not produce accurate results. In the worst  
> > case a  
> > > > > requested period of 2/clk_rate would result in a real period of  
> > 4/clk_rate  
> > > > > instead. This is a series includes a fix for that problem, as well as
> > > > > other related improvements, and is based on the current  
> > linux-pwm/for-next  
> > > > > tip.
> > > > >
> > > > > I have tested on a Sitara AM335x platform, using a scope to verify  
> > the  
> > > > > output with a variety of periods and duty cycles. This includes a PWM
> > > > > rate up clk_rate/2 with 50% duty cycle (e.g. generating fclk/2) with
> > > > > both 32768Hz and 24MHz fclks. I do not have an OMAP4 board to test  
> > with,  
> > > > > although appropriate sections in the the reference manuals appear
> > > > > substantially the same, so I believe the changes are equally correct
> > > > > there.
> > > > >
> > > > > Note that the OMAP4 TRMs do effectively state that the maximum PWM
> > > > > rate is clk_rate/4, so at very fast PWM rates the behavior may not be
> > > > > as reliable as I observed with Sitara. Although I suspect that it's
> > > > > the same module and will also work, at least under some  
> > circumstances.  
> > > > > If anyone with OMAP4 hardware and a scope is so inclined, I would be
> > > > > curious to know the results.
> > > > >
> > > > > David Rivshin (4):
> > > > >   pwm: omap-dmtimer: fix inaccurate period/duty_cycle calculation
> > > > >   pwm: omap-dmtimer: add sanity checking for load and match values
> > > > >   pwm: omap-dmtimer: round load and match values rather than truncate
> > > > >   pwm: omap-dmtimer: add dev_dbg() message for effective period and  
> > duty  
> > > > >     cycle
> > > > >
> > > > >  drivers/pwm/pwm-omap-dmtimer.c | 71  
> > ++++++++++++++++++++++++++++++++----------  
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
> >
> > FYI, I know that Adam Ford is using this driver as the backend for
> > a pwm-backlight control. Without patch 2 this driver will not configure
> > the HW in a legal way at 0 or 100% duty cycle. However, I forget what
> > the practical effect of that is, and Adam seemed to indicate it was OK
> > for his purposes.
> >
> >  
