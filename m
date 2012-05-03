From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx cleanups
Date: Thu, 03 May 2012 13:39:06 -0700
Message-ID: <87bom5j8yd.fsf@ti.com>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:39124 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753382Ab2ECUjG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 16:39:06 -0400
Received: by pbbrr13 with SMTP id rr13so3301197pbb.26
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 13:39:04 -0700 (PDT)
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Tue, 24 Apr 2012 16:05:21 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Hi Daniel,

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> This patchset makes some cleanup on these cpuidle drivers
> and consolidate the code across both architecture.

I think I said it before, but it's worth repeating: Very nice cleanup!
Thanks for your persistence.

I've now been through this version and I think it's ready for v3.5.  I
had a few very minor comments on some specific patches but made the
changes myself.  Please comment on those patches if you think my changes
are OK or not.  Also, I had to drop the Makefile change due to compile
problems.

With those changes made, and Reviewed-by and Tested-by tags added from
Santosh, I've created a branch[1] and will queue it for v3.5.  Any
additional patches can be sent against this branch.

> Tested on OMAP3 (igepV2).
> Partially tested on OMAP4 (pandaboard), without offlining the cpu1.

I've also tested on OMAP3430/n900, OMAP3530/Overo and OMAP4430/Pandabord
with CPU1 offlined so the deeper C-states are hit.  Combined with the
review and testing from Jean and Santosh (thanks!), I think this is
ready to go.

Thanks again for this great cleanup and consolidation,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/cleanup/omap-cpuidle

