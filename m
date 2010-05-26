From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 18:33:47 +0300
Message-ID: <20100526153346.GB17655@gandalf>
References: <1274863655.5882.4875.camel@twins>
 <AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
 <1274867106.5882.5090.camel@twins>
 <20100526120242.5c9b73ad@schatten.dmk.lab>
 <AANLkTim4021cTnhVZrQpefq1MG-eEPOFLDRO-XDepHb4@mail.gmail.com>
 <20100526133721.602633b2@schatten.dmk.lab>
 <AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com>
 <20100526142430.327ccbc4@schatten.dmk.lab>
 <20100526141612.3e2e0443@lxorguk.ukuu.org.uk>
 <alpine.LFD.2.00.1005261521510.2995@localhost.localdomain>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005261521510.2995@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, May 26, 2010 at 03:46:55PM +0200, Thomas Gleixner wrote:
> > > Really, what are you getting at? Do you deny that there are programs,
> > > that prevent a device from sleeping? (Just think of the bouncing
> > > cows app)
> > > 
> > > And if you have two kernels, one with which your device is dead after 1
> > > hour and one with which your device is dead after 10 hours. Which would
> > > you prefer? I mean really... this is ridiculous. 
> > 
> > The problem you have is that this is policy. If I have the device wired
> > to a big screen and I want cows bouncing on it I'll be most upset if
> > instead it suspends. What you are essentially arguing for is for the
> > kernel to disobey the userspace. It's as ridiculous (albeit usually less
> > damaging) as a file system saying "Ooh thats a rude file name, the app
> > can't have meant it, I'll put your document soemwhere else"
> > 
> > The whole API feels wrong to me. It's breaking rule #1 of technology "You
> > cannot solve a social problem with technology". In this case you have a
> > social/economic problem which is crap code. You solve it with an
> > economics solution - creative incentives not to produce crap code like
> > boxes that keep popping up saying "App XYZ is using all your battery" and
> > red-amber-green powermeter scores in app stores.
> 
> I completely agree. 
> 
> We have already proven that the social pressure on crappy applications
> works. When NOHZ was merged into the kernel we got no effect at all
> because a big percentage of user space applications just used timers
> at will and without any thoughts, also it unveiled busy polling and
> other horrible coding constructs. So what happened ? Arjan created
> powertop which lets the user analyse the worst offenders in his
> system. As a result the offending apps got fixed rapidly simply
> because no maintainer wanted to be on top of the powertop sh*tlist.
> 
> In the mobile app space it's basically the same problem. Users can
> influence the app writers simply by voting and setting up public lists
> of apps which are crappy or excellent. All it needs is a nice powertop
> tool for the phone which allows the users to identify the crap on
> their phones. That provides much more incentive - especially for
> commercial players - to fix their crappy code.
> 
> Adding that sys_try_to_fix_crappy_userspace_code() API to the kernel
> is just counter productive as it signals to the app provider: Go
> ahead, keep on coding crap!
> 
> That's not a solution, that's just capitulation. 
> 
> It's absurd that some folks believe that giving up the most efficient
> tool to apply pressure to crappy app providers is a good idea.

I couldn't agree more with both of you. I also have stated that a
powertop application with a fancy UI would do the job. Also building
some sort of power estimations on the SDK would allow the developer the
have fast feedback about potential power consumption caused by his app
on the device.

On top of that, the app stores can use the same power estimation
"technology" to rate apps automatically and even reject apps that are
waaaay too badly written.

I also feel that kernel shouldn't have to deal, fix, hide bad behavior
from apps.

-- 
balbi
