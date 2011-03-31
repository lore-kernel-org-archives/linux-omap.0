From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 09:55:31 -0500
Message-ID: <BANLkTinmoTyceJCT+K-RCm4NC76qfDyeVw@mail.gmail.com>
References: <alpine.LFD.2.00.1103301531420.28032@xanadu.home>
	<AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
	<alpine.LFD.2.00.1103301814250.28032@xanadu.home>
	<alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm>
	<alpine.LFD.2.00.1103302255280.28032@xanadu.home>
	<AANLkTikV5OMifKjWRVdtJLEcxcZ56jrjWLYJBX89pHQ0@mail.gmail.com>
	<alpine.LFD.2.00.1103310012500.28032@xanadu.home>
	<20110331105440.42692165@lxorguk.ukuu.org.uk>
	<20110331105000.GC14323@n2100.arm.linux.org.uk>
	<1301575101.10659.132.camel@e102109-lin.cambridge.arm.com>
	<20110331130123.GB17547@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110331130123.GB17547@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Dave Airlie <airlied@gmail.com>, david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Russell:


On Thu, Mar 31, 2011 at 8:01 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> And since Linus' whinge about ARM defconfigs, I really *hate* merging
> anything with *any* defconfig changes in - as a result, I don't
> particularly want to deal with ARM defconfig changes anymore.

I think the defconfigs are as important as the code itself! Sure there
is a lot of churn in them--- just let git deal with it and move on.

The defconfigs and board code provide critical reference models for
new platform developers.  If these models aren't right, then you end
up providing bad references that get replicated over and over again.
It multiplies the problem we're trying to solve.

> Just look at the removal of AAEC2000, LH7A40x and 2000 lines from the
> mach-types file removed 6000 lines, which in itself is about the numb=
er
> of lines of change submitted during the last merge window for any one
> non-ARM architecture. =A0At this point in time with this complaint, I=
've
> absolutely no idea why I bothered to do that. =A0I should've left it =
well
> alone and then the diffstat percentage would've been smaller. =A0Afte=
r
> all, it's "pointless churn".

I think you did it because it was the Right Thing To Do.  Even
positive change can be painful at times.

The majority is exceedingly grateful for the effort you make.


b.g.

--=20
Bill Gatliff
bgat@billgatliff.com
