From: Tony Lindgren <tony@atomide.com>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Date: Tue, 29 Jan 2019 09:11:51 -0800
Message-ID: <20190129171151.GC5720@atomide.com>
References: <20190129164813.GA5720@atomide.com>
 <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Doug Anderson <dianders@chromium.org> [190129 17:05]:
> Hi,
> 
> On Tue, Jan 29, 2019 at 8:48 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hi,
> >
> > Looks like commit 5451781dadf8 ("regulator: core: Only count load for
> > enabled consumers") started showing new warnings with v5.0-rc cycle:
> >
> > regulator-dummy: Underflow of regulator enable count
> >
> > I'm seeing this at least with my pwm-vibra test case:
> >
> > # rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
> > pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulator
> > input: pwm-vibrator as /devices/platform/vibrator/input/input4
> > regulator-dummy: Underflow of regulator enable count
> > Upload rumble effect... id=0
> > regulator-dummy: Underflow of regulator enable count
> >
> > Are these bogus warnings for dummy regulator or do we have
> > real unpaired regulator calls or somewhere?
> 
> My first guess is that there's a real unpaired regulator call somewhere.
> 
> I actually meant to include this in the commit message, but I'm an
> idiot and I used "--" to break up the parts of the commit message
> which confused git when Mark applied it.  Sigh.  For the full commit
> message, see:
> 
> https://lkml.kernel.org/r/20181120175255.227783-1-dianders@chromium.org

Oh I see, thanks for the link :)

> In that message I said:
> 
> > - We can (and will) spit errors out for code that used to be invalid
> >   but was never caught before.  Specifically if someone leaves a
> >   regulator enabled and calls regulator_put() we'll yell.  We'll also
> >   yell if a single consumer calls more disables than enables.
> 
> Looking quickly at 'pwm-vibra.c' it wouldn't surprise me at all if you
> call regulator_disable() more times than regulator_enable().  If
> that's true it should be fixed.

OK. Let's see if Sebastian spots where pwm_vibrator_start()
and pwm_vibrator_stop() might get called multiple times
or something similar.

Regards,

Tony
