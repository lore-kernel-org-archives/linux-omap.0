From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
Date: Mon, 8 Dec 2014 15:11:26 +0000
Message-ID: <20141208151126.GD11502@n2100.arm.linux.org.uk>
References: <5481D913.9040109@ti.com>
 <5481D9BF.2090007@ti.com>
 <20141205162312.GB11502@n2100.arm.linux.org.uk>
 <CA+Ln22EFKRm_9HPaVvL7zFdmmB5Zz5RnJKbZkESVOBOLPvUnGA@mail.gmail.com>
 <20141208122235.GC11502@n2100.arm.linux.org.uk>
 <5485AD80.1050008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:45355 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752960AbaLHPLj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2014 10:11:39 -0500
Content-Disposition: inline
In-Reply-To: <5485AD80.1050008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Kevin Hilman <khilman@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-omap <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

On Mon, Dec 08, 2014 at 07:54:08AM -0600, Nishanth Menon wrote:
> On 12/08/2014 06:22 AM, Russell King - ARM Linux wrote:
> > On Mon, Dec 08, 2014 at 08:54:18PM +0900, Tomasz Figa wrote:
> >> 2014-12-06 1:23 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> >>> Given where we are in the cycle (-final likely this weekend) the only
> >>> thing we can do right now is to drop the patch set; exynos (and mvebu)
> >>> will have to wait another cycle until this patch set (hopefully in a
> >>> revised form) can be merged.
> >>
> >> Or a fix could be queued on top of this. Since (I believe) this series
> >> has been queued for 3.19, we have 6 or 7 RC releases ahead, which
> >> could be used for the purpose of fixing things (as they are supposed
> >> to?).
> > 
> > They were merged on 27th November, so they would've been in linux-next
> > from about last Monday.  Nishanth reported a failure on Friday, the
> 
> For what ever it is worth, the l2c changes actually appeared on
> Thursday CST (next-20141204). Found the regression against
> next-20141203 tag and it took me a day to track it down (after looking
> at a few other regressions as well)..

I wonder if that's because I didn't push my tree out until Tuesday-ish.
It takes around 48 hours between when I push stuff out to it appearing
in linux-next, which is not particularly desirable, but unavoidable due
to timezone differences.

I did decide that I wouldn't push it out the same day I merged it because
I wanted it to run through my build/boot system, which it did successfully,
but then my OMAP4 build doesn't have CPU idle enabled (and as you've
identified, when CPU idle is disabled, it works.)

The problem there is that if I decide not to push some merged changes out,
it takes several days before I get around to touching the kernel tree
again.  Hence why it took from Thursday until Tuesday for it to eventually
get pushed out.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
