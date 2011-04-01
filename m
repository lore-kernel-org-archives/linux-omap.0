From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 1 Apr 2011 02:17:58 +0100
Message-ID: <20110401011758.GB17857@sirena.org.uk>
References: <20110317183048.GW7258@atomide.com> <AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com> <20110318101512.GA15375@n2100.arm.linux.org.uk> <201103301906.42429.arnd@arndb.de> <20110330210726.GA4593@n2100.arm.linux.org.uk> <20110330221410.GK18334@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:36862 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587Ab1DABSE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Mar 2011 21:18:04 -0400
Content-Disposition: inline
In-Reply-To: <20110330221410.GK18334@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, David Brown <davidb@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Catalin Marinas <catalin.marinas@arm.com>

On Wed, Mar 30, 2011 at 03:14:10PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110330 14:05]:

> > And I have got to the point of just not giving a damn.  I can't change
> > the ARM community (I've tried over the years to get more active review
> > of platform changes and failed - and had it pointed out by folk like
> > Alan Cox, that such a system is impossible due to lack of motivation
> > by, eg, an OMAP person to review a Samsung change.)

> I think this is happening more and more as we have more ARM generic
> and Linux generic code.

Plus you've now got some non-trivial code for off-SoC devices which
means you've got a growing number of people who do actively work over
many SoCs.
