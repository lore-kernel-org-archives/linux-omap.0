From: Pavel Machek <pavel@ucw.cz>
Subject: GPRS data on N900 working was Re: N900 modem support in 3.18-rc1
Date: Wed, 26 Nov 2014 00:21:56 +0100
Message-ID: <20141125232156.GA26116@amd>
References: <20141106180335.GA21513@earth.universe>
 <20141106225005.GA14002@amd>
 <201411070001.46481@pali>
 <545C6F14.8050303@gmail.com>
 <20141113162420.GB8512@xo-6d-61-c0.localdomain>
 <5465A977.4030605@gmail.com>
 <20141114172008.GB12250@earth.universe>
 <54665E02.8050108@gmail.com>
 <20141114215749.GA19023@earth.universe>
 <20141120101320.GA6356@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141120101320.GA6356@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali Roh?r <pali.rohar@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, Sakari Ailus <sakari.ailus@iki.fi>
List-Id: linux-omap@vger.kernel.org

Hi!

> Then go to /my/tui/ofone. Run "./run" -- that should start
> pulseaudio. Run "./ofone", hit "lowlevel: online", hit "contacts",
> enter phone number you want to call, hit the number, it should start
> dialing.
> 
> Wait a while, hit "lowlevel: hangup".

I played a bit more, and now ofone can connect to GPRS. You'll need
version from git, see

https://gitorious.org/tui/tui/source/dff269a7ba419f573de5b90e8eea58227de8a9e6:ofone

Good luck,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
