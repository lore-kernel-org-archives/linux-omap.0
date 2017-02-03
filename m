From: Tony Lindgren <tony@atomide.com>
Subject: Re: v4.9 to v4.10 regression: oops when USB cable is plugged in.
Date: Fri, 3 Feb 2017 08:30:48 -0800
Message-ID: <20170203163048.GA3721@atomide.com>
References: <20170123222537.GA11543@amd>
 <20170123224454.GY7403@atomide.com>
 <20170124091817.GA29246@amd>
 <20170124100133.GA21079@pali>
 <20170124145127.GC7403@atomide.com>
 <20170127215512.GG20571@amd>
 <20170127234832.cte4ki4ajwme2b2j@earth>
 <20170203075907.GA21338@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170203075907.GA21338@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, b-liu@ti.com, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [170203 00:00]:
> Hi!
> 
> > On Fri, Jan 27, 2017 at 10:55:12PM +0100, Pavel Machek wrote:
> > > Ok, I can try. But so far even -rc1 is a lot of fun. But... I consider
> > > phone calls core feature of a phone. I'd very much like to get that to
> > > work. Unfortunately, that means real-time audio, and a lot of
> > > fun. Plus, as it is touchscreen device, it needs a GUI. 
> > 
> > Talking about testing - kernelci's n900 is broken?
> > 
> > https://kernelci.org/boot/omap3-n900/
> 
> The N900 regressions are now more of "audio mixers no longer work"
> than "it fails to boot" kind -- thus difficult to test automatically,
> I'm afraid.

Talking about audio testing, next now has commit 9834ffd1ecc3
("ASoC: omap-mcbsp: Add PM QoS support for McBSP to prevent glitches"),
care to check if that also fixes the n900 audio glitch issues you
reported earlier?

Regards,

Tony
