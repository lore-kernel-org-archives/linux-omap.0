From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
Date: Thu, 17 Feb 2011 13:59:08 +0000
Message-ID: <20110217135907.GB24989@n2100.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk> <E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk> <AANLkTinL0HgSsFmoxyiBuRA6JiWKsHTLW4wFnVDJf_1w@mail.gmail.com> <20110215110453.GB11199@n2100.arm.linux.org.uk> <AANLkTik_c4D7CPO9j9ZYUSuR45ggJ8Y953VLQCg4tkkr@mail.gmail.com> <1297939312.7096.32.camel@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52130 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab1BQN72 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 08:59:28 -0500
Content-Disposition: inline
In-Reply-To: <1297939312.7096.32.camel@e102568-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Colin Cross <ccross@google.com>, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org

On Thu, Feb 17, 2011 at 10:41:52AM +0000, Lorenzo Pieralisi wrote:
> When calling suspend from cpuidle, do you flush the stack (ie CPU
> context) from L2 using outer_cache functions ? This has to be done when
> one CPU is shut down with L2 enabled for the MMU off resume path to work
> properly.
> I think that on resume you invalidate L1 in the reset vector before
> jumping to cpu_resume, correct ?

Let's forget cpuidle using this code for the time being - the issues
there appear to be more complex than the suspend-to-ram which this code
is currently being used for.  What I'm saying is that cpuidle using
this is an enhancement over and above its current use.

Once we have the S2R stuff working and tested, then we can go back to
cpuidle stuff.

I fear that trying to get this to work for cpuidle will result in the
entire thing being thrown away.
