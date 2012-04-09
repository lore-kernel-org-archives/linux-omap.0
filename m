From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/17][V2] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx cleanups
Date: Mon, 09 Apr 2012 16:23:46 -0700
Message-ID: <87vcl87am5.fsf@ti.com>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:36774 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758140Ab2DIXXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 19:23:40 -0400
Received: by pbcun1 with SMTP id un1so6042027pbc.29
        for <linux-omap@vger.kernel.org>; Mon, 09 Apr 2012 16:23:39 -0700 (PDT)
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Wed, 4 Apr 2012 22:12:34 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rob.lee@linaro.org, linaro-dev@lists.linaro.org, patches@linaro.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> This patchset makes some cleanup on these cpuidle drivers
> and consolidate the code across both architecture.

Thanks for this really nice cleanup.  I have some comments on specific
patches, but here's some general comments:

Some minor comments:

First, please be sure all patches have a descriptive changelog.  Yes,
even simple ones need changelogs.  In particular, maintainers are
looking for the "why" of a patch, not just the "what" or "how".

Second, this series introduced a couple sparse warnings:

/work/kernel/omap/pm/arch/arm/mach-omap2/cpuidle44xx.c:134:1: warning: symbol 'omap4_idle_dev' was not declared. Should it be static?
/work/kernel/omap/pm/arch/arm/mach-omap2/cpuidle44xx.c:136:23: warning: symbol 'omap4_idle_driver' was not declared. Should it be static?

Thanks,

Kevin
