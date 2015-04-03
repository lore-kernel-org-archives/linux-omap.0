From: Pavel Machek <pavel@ucw.cz>
Subject: Re: ARM errata 430973 on multi platform kernels (was: OMAP3-N900:
 Add microphone bias voltages)
Date: Fri, 3 Apr 2015 22:42:46 +0200
Message-ID: <20150403204246.GB13009@amd>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com>
 <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com>
 <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth>
 <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47131 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbbDCUms (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 16:42:48 -0400
Content-Disposition: inline
In-Reply-To: <20150403163553.GA16247@earth>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi!

> Maybe an option would be to provide two cpu_v7_switch_mm
> implementations (one with the errata and one without). Then
> the system can start with the simple implementation. Once
> the boot as progressed far enough to know, that the hardware
> is affected by the errata, it could switch to the implementation
> with the flushing.

Actually... we should start with the slow&safe option, and then switch
to faster implementation if workaround is not needed.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
