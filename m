From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 11:34:07 -0700
Message-ID: <20110331113407.36b7466b@jbarnes-desktop>
References: <alpine.LFD.2.00.1103301814250.28032@xanadu.home>
	<alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm>
	<alpine.LFD.2.00.1103302255280.28032@xanadu.home>
	<AANLkTikV5OMifKjWRVdtJLEcxcZ56jrjWLYJBX89pHQ0@mail.gmail.com>
	<alpine.LFD.2.00.1103310012500.28032@xanadu.home>
	<20110331105440.42692165@lxorguk.ukuu.org.uk>
	<20110331105000.GC14323@n2100.arm.linux.org.uk>
	<1301575101.10659.132.camel@e102109-lin.cambridge.arm.com>
	<20110331130123.GB17547@n2100.arm.linux.org.uk>
	<20110331181254.GA21981@merkur.ravnborg.org>
	<20110331181751.GC19452@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110331181751.GC19452@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>, Catalin Marinas <catalin.marinas@arm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Dave Airlie <airlied@gmail.com>, david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 31 Mar 2011 19:17:51 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Mar 31, 2011 at 08:12:54PM +0200, Sam Ravnborg wrote:
> > > And since Linus' whinge about ARM defconfigs, I really *hate* merging
> > > anything with *any* defconfig changes in - as a result, I don't
> > > particularly want to deal with ARM defconfig changes anymore.
> > 
> > I thought we solved this with the introduction of "make savedefconfig"
> > that created much much smaller defconfig.
> 
> Did we solve it to Linus' satisfaction, or did we solve it sufficiently
> to avoid the immediate threat of them all being removed and we still have
> work to do?  I've no idea.
> 
> Personally, I'd still like to see less of them but without significantly
> impacting the usefulness of automated built tooks like Simtec's
> kautobuild.

Might be neat if kbuild could wget config files automatically from a
known location.  Bonus points if it properly detected the right one to
grab in the first place...

-- 
Jesse Barnes, Intel Open Source Technology Center
