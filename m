From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 13:38:21 +0100
Message-ID: <1301575101.10659.132.camel@e102109-lin.cambridge.arm.com>
References: <201103301906.42429.arnd@arndb.de>
	 <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
	 <alpine.LFD.2.00.1103301531420.28032@xanadu.home>
	 <AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
	 <alpine.LFD.2.00.1103301814250.28032@xanadu.home>
	 <alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm>
	 <alpine.LFD.2.00.1103302255280.28032@xanadu.home>
	 <AANLkTikV5OMifKjWRVdtJLEcxcZ56jrjWLYJBX89pHQ0@mail.gmail.com>
	 <alpine.LFD.2.00.1103310012500.28032@xanadu.home>
	 <20110331105440.42692165@lxorguk.ukuu.org.uk>
	 <20110331105000.GC14323@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110331105000.GC14323@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Dave Airlie <airlied@gmail.com>, david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2011-03-31 at 11:50 +0100, Russell King - ARM Linux wrote:
> Given this thread, I've lost the motivation to continue with it because
> it's just going to cause more 'pointless churn' and end up annoying
> Linus even more.

I don't think the criticism was directed at the core ARM code that you
maintain (Ingo and others even praised it). I also don't think that you
stopping maintaining it would help in any way with this situation.

We probably shouldn't take criticism personally. Linus has some points
which the ARM community is aware of already since there is ongoing work
for consolidating the platform code (recent v2p patches, SMP-on-UP, FDT
and probably more will come) only that this won't happen overnight. If
you stop merging any of these, there's definitely no way out (other than
doing the work separately for the next two years and replacing the
arch/arm in a single pull request).

-- 
Catalin
