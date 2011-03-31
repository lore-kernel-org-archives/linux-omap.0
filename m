From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 15:54:33 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1103311541190.22418@localhost6.localdomain6>
References: <201103301906.42429.arnd@arndb.de> <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com> <alpine.LFD.2.00.1103301531420.28032@xanadu.home> <AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com> <alpine.LFD.2.00.1103301814250.28032@xanadu.home>
 <alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm> <alpine.LFD.2.00.1103302255280.28032@xanadu.home> <AANLkTikV5OMifKjWRVdtJLEcxcZ56jrjWLYJBX89pHQ0@mail.gmail.com> <alpine.LFD.2.00.1103310012500.28032@xanadu.home> <20110331105440.42692165@lxorguk.ukuu.org.uk>
 <20110331105000.GC14323@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110331105000.GC14323@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Dave Airlie <airlied@gmail.com>, david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 31 Mar 2011, Russell King - ARM Linux wrote:
> And I'm not going to be merging anything into my tree for the time being.
> I know there's no way for me to continue without being moaned at by someone.
> So I'm just going to take the easy option at the moment and do precisely
> nothing in terms of queueing patches until something gets resolved one way
> or the other.  I'm not even going to review any patches because I currently
> see it as a total waste of time - I've no idea whether they'll stand any
> chance what so ever of making it into mainline.
> 
> What's the way out of this?  I've no idea.  Can ARM continue being part
> of the mainline kernel?  I've no idea.  Will we be ripping out all the
> ARM platform code from the mainline kernel?  I've no idea.

Moving arm out of mainline would be a complete disaster.
 
> I am now completely demotivated.

I can understand that, but I have to say again, that you do a pretty
damned good job on keeping the ARM core code clean and I always enjoy
working with you when infrastructure I'm working on needs to deal with
ARM requirements. We disagree from time to time, but I don't remember
a single incident where we could not resolve that on a technical base.

It's not your fault, that you can't clone yourself 10 times to deal
with the subarch flood. It's also not your fault that the subarch
maintainers tend not to look over the brim of their SoC sandbox and
figure out how to solve the big picture.

So no, ARM needs to stay and the ARM crowd needs to find competent
people who babysit the SoC crowd and work with you to get the big
picture straight. Something like this should have been done _before_
the wave of ARM spilling out of every other silicon shop became
tsunami sized. But not doing it at all will not solve anything.

Thanks,

	tglx
