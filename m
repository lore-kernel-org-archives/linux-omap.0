From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Fri, 3 Apr 2015 15:15:17 -0700
Message-ID: <20150403221517.GX10805@atomide.com>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com>
 <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com>
 <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth>
 <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth>
 <551F0F50.1030701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41722 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519AbbDCWTM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Apr 2015 18:19:12 -0400
Content-Disposition: inline
In-Reply-To: <551F0F50.1030701@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [150403 15:08]:
> Hi
> 
> On  3.04.2015 19:35, Sebastian Reichel wrote:
> >
> >Maybe an option would be to provide two cpu_v7_switch_mm
> >implementations (one with the errata and one without). Then
> >the system can start with the simple implementation. Once
> >the boot as progressed far enough to know, that the hardware
> >is affected by the errata, it could switch to the implementation
> >with the flushing.
> 
> Or rather the opposite, as if the kernel itself is thumb-compiled, it most
> probably will have no chance to progress enough to switch to the correct
> implementation before hanging.

We should first verify the same bug happens with armel also.
I just verified the CPU load in the background makes armhf
apps segfault without $subject workaround enabled.

If the segfaulting does not happen with armel, then chances
it's some kind of neon related issue and the fix can be more
targeted.

Regards,

Tony
