From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Wed, 14 May 2014 16:31:19 -0700
Message-ID: <20140514233119.GA31594@atomide.com>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com>
 <5373C78E.7040301@linaro.org>
 <5373C8E8.6040208@ti.com>
 <5373CBB9.40506@linaro.org>
 <20140514205649.GC27426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62252 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751425AbaENXbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 19:31:25 -0400
Content-Disposition: inline
In-Reply-To: <20140514205649.GC27426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

* Tony Lindgren <tony@atomide.com> [140514 13:57]:
> * Daniel Lezcano <daniel.lezcano@linaro.org> [140514 13:02]:
> > 
> > So the broadcast timer does not operate with this revert. Moreover, I am not
> > sure reverting this patch is the right solution.
> 
> OK I'll hold on sending anything until there's some conclusion.
> 
> Are you able to reproduce the problem with current Linux next?

BTW, I'm also noticing now hangs on omap3 with my PM patches
on v3.15-rc4 that seem similar to the panda cpuidle hang.

The hangs on omap3 do not happen on my v3.14 based branch, so
I'm wondering if there are some recent cpuidle regressions too
in play?

Regards,

Tony
