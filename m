From: Pavel Machek <pavel@ucw.cz>
Subject: Re: "advanced" LED controllers
Date: Sat, 28 Feb 2015 17:18:22 +0100
Message-ID: <20150228161822.GA4978@amd>
References: <20150219211424.GN13603@saruman.tx.rr.com>
 <20150223223457.GA4073@amd>
 <20150223225836.GB4355@saruman.tx.rr.com>
 <20150225214940.GA29527@amd>
 <20150226105552.367fc141@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150226105552.367fc141@notabene.brown>
Sender: linux-leds-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <balbi@ti.com>, cooloney@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi!

On Thu 2015-02-26 10:55:52, NeilBrown wrote:
> On Wed, 25 Feb 2015 22:49:41 +0100 Pavel Machek <pavel@ucw.cz> wrote:
> 
> > On Mon 2015-02-23 16:58:36, Felipe Balbi wrote:
> > > On Mon, Feb 23, 2015 at 11:34:57PM +0100, Pavel Machek wrote:
> > > > On Thu 2015-02-19 15:14:24, Felipe Balbi wrote:
> > > > > Hi,
> > > > > 
> > > > > Do we have support for LED controllers which can handle patterns of
> > > > > different kinds ? I mean, currently, if we have an LED controller such
> > > > > as TPIC2810 [1] which can control 8 different leds and each LED
> > > > > corresponds to one bit on register 0x44, we could control leds by just
> > > > > "playing" a wave file on the controller and create easy patterns with
> > > > > that.
> > 
> > > > > [1] http://www.ti.com/product/tpic2810

Does tpic2810 support brightness on the LEDs, or is it just one bit
per led?

> > Well, question is what we want. Possibilities I see:
> > 
> > 1) We won't support all the features, just some common subset. Kernel
> > will get commands for LED controller and translate them. Question is
> > what reasonable subset is, then.
> > 
> > I guess "delay", "set led brightness to X", "jump" would be minimal
> > shared command set. lp5523 can do also "slowly increase/decrease
> > brightness to X" (I believe we should support that one), arithmetics,
> > conditional jumps, and communications between 3 threads.
> > 
> > 2) We want to support all the features. I guess that would mean doing
> > compilation in userspace, and having "compiler" for each led
> > controller. Having common source code would still be nice.
> 
> All (most) current options for controlling LEDs are based on what a user
> might want, rather than what the hardware can provide.
> 
> I think it would be good to keep that approach, but add more "interesting"
> functions which each hardware can support in whichever way suits it best.
> 
> So "ramp_blink" which allow a ramp on/off time to be specified would be
> useful.

Well, ramp_blink would certainly cover a lot of cases, but not
everything. For example, I'd like to do "ramp to 25% brightness, wait,
ramp to 50% brightness, 

> > Well, question is what we want. Possibilities I see:
> > 
> > 1) We won't support all the features, just some common subset. Kernel
> > will get commands for LED controller and translate them. Question is
> > what reasonable subset is, then.
> > 
> > I guess "delay", "set led brightness to X", "jump" would be minimal
> > shared command set. lp5523 can do also "slowly increase/decrease
> > brightness to X" (I believe we should support that one), arithmetics,
> > conditional jumps, and communications between 3 threads.
> > 
> > 2) We want to support all the features. I guess that would mean doing
> > compilation in userspace, and having "compiler" for each led
> > controller. Having common source code would still be nice.
> 
> All (most) current options for controlling LEDs are based on what a user
> might want, rather than what the hardware can provide.
> 
> I think it would be good to keep that approach, but add more "interesting"
> functions which each hardware can support in whichever way suits it best.
> 
> So "ramp_blink" which allow a ramp on/off time to be specified would be
> useful.

Well, ramp_blink would certainly cover a lot of cases, but not
everything. For example, I'd like to do "ramp to 25% brightness, wait,
ramp to 50% brightness

> > Well, question is what we want. Possibilities I see:
> > 
> > 1) We won't support all the features, just some common subset. Kernel
> > will get commands for LED controller and translate them. Question is
> > what reasonable subset is, then.
> > 
> > I guess "delay", "set led brightness to X", "jump" would be minimal
> > shared command set. lp5523 can do also "slowly increase/decrease
> > brightness to X" (I believe we should support that one), arithmetics,
> > conditional jumps, and communications between 3 threads.
> > 
> > 2) We want to support all the features. I guess that would mean doing
> > compilation in userspace, and having "compiler" for each led
> > controller. Having common source code would still be nice.
> 
> All (most) current options for controlling LEDs are based on what a user
> might want, rather than what the hardware can provide.
> 
> I think it would be good to keep that approach, but add more "interesting"
> functions which each hardware can support in whichever way suits it best.
> 
> So "ramp_blink" which allow a ramp on/off time to be specified would be
> useful.

Well, ramp_blink would certainly cover a lot of cases, but not
everything. For example, I'd like to do "ramp to 25% brightness, wait,
ramp to 50% brightness, 

> > Well, question is what we want. Possibilities I see:
> > 
> > 1) We won't support all the features, just some common subset. Kernel
> > will get commands for LED controller and translate them. Question is
> > what reasonable subset is, then.
> > 
> > I guess "delay", "set led brightness to X", "jump" would be minimal
> > shared command set. lp5523 can do also "slowly increase/decrease
> > brightness to X" (I believe we should support that one), arithmetics,
> > conditional jumps, and communications between 3 threads.
> > 
> > 2) We want to support all the features. I guess that would mean doing
> > compilation in userspace, and having "compiler" for each led
> > controller. Having common source code would still be nice.
> 
> All (most) current options for controlling LEDs are based on what a user
> might want, rather than what the hardware can provide.
> 
> I think it would be good to keep that approach, but add more "interesting"
> functions which each hardware can support in whichever way suits it best.
> 
> So "ramp_blink" which allow a ramp on/off time to be specified would be
> useful.

Well, ramp_blink would certainly cover a lot of cases, but not
everything. For example, I'd like to do "ramp to 25% brightness, wait,
ramp to 50% brightness, wait, ramp to 75% brightness, wait, ramp to
100% brightness, wait, ramp back to 0" pattern to indicate charging..

Also, I'd like to do "smoothly go through colors of rainbow" pattern
to indicate booting.

So yes, "ramp_blink" would cover some common cases, but not nearly everything.

> "audio_meter" which allows a particular sound card (or output or something)
> to be specified would also be useful.  You could also specify a what volume
> the LED saturates.

audio_meter would have to be done by software, as hardware can not
really accelerate that.

256 brightness values to cycle through for each r/g/b channel might be
enough for most patterns... but it would be quite hard to "compile"
that into program for lp5523.

Other solution would be specifying series of "time, brightness"
points, with expectation of linear change between those".

So [ 0sec, 0%; 1sec, 0%; 1sec, 100%] would be turn the LED on quickly,
and [ 0sec, 0%, 1sec, 100% ] would be slowly ramp the LED over one
second.

Advantage would be that it should be fairly easy to compile from this
to lp5523 and similar.

> Maybe 'blinking' should have a 'synchronise' setting to that a bunch of LEDs
> can be synchonised so you can create a "cylon eye" effect.

> i.e. don't focus on the low-level 'what can we provide' but on the high level
> "what might users want".

See above what I'd want, and

http://my-maemo.com/software/applications.php?fldAuto=1275&faq=42
http://my-maemo.com/software/applications.php?fldAuto=2096&faq=42
https://wiki.maemo.org/LED_patterns

what other people want.

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
