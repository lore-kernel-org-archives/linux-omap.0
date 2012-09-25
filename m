From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm: make FORCE_MAX_ZONEORDER configurable for TI
 AM33XX
Date: Tue, 25 Sep 2012 08:27:06 -0700
Message-ID: <20120925152705.GB4840@atomide.com>
References: <1348561590-13361-1-git-send-email-yegorslists@googlemail.com>
 <20120925083245.GH31374@n2100.arm.linux.org.uk>
 <50616F6A.80100@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:63025 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756310Ab2IYP1R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 11:27:17 -0400
Content-Disposition: inline
In-Reply-To: <50616F6A.80100@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, yegorslists@googlemail.com, linux-omap@vger.kernel.org, Dejan Gacnik <dejan.gacnik@gmail.com>, linux-arm-kernel@lists.infradead.org

* Yegor Yefremov <yegor_sub1@visionsystems.de> [120925 01:47]:
> On 25.09.2012 10:32, Russell King - ARM Linux wrote:
> > On Tue, Sep 25, 2012 at 10:26:30AM +0200, yegorslists@googlemail.com wrote:
> >> From: Yegor Yefremov <yegorslists@googlemail.com>
> >>
> >> FORCE_MAX_ZONEORDER of 12 is needed to allocation more than 4MB
> >> of consistent DMA memory (da8xx frame buffer driver).
> > 
> > Okay, so the patch description says "This needs to be 12 on this platform".
> > 
> >>  config FORCE_MAX_ZONEORDER
> >> -	int "Maximum zone order" if ARCH_SHMOBILE
> >> -	range 11 64 if ARCH_SHMOBILE
> >> +	int "Maximum zone order" if ARCH_SHMOBILE || SOC_AM33XX
> >> +	range 11 64 if ARCH_SHMOBILE || SOC_AM33XX
> > 
> > but you leave it up to the user to select something that may not be
> > suitable.  Wouldn't _just_ adding:
> > 
> > 	default "12" if SOC_AM33XX
> > 
> > after the "range", and making no other changes be good enough and match
> > what the patch description says?
> 
> You're right. As we don't allocate anything, but increase the possible size, it shouldn't break anything. Tony is it O.K. with you?

Sure.

Tony
