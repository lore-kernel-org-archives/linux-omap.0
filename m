From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V2 3/4] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef around __omap2_set_globals
Date: Tue, 08 May 2012 15:38:09 -0700
Message-ID: <87397ajo32.fsf@ti.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
	<1336506724-5494-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:39687 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751589Ab2EHWhx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 18:37:53 -0400
Received: by pbbrr13 with SMTP id rr13so9957847pbb.26
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 15:37:52 -0700 (PDT)
In-Reply-To: <1336506724-5494-4-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Wed, 9 May 2012 01:22:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> The function __omap2_set_globals() can be common across all
> platforms/architectures, even in case of omap4, internally it
> calls same set of functions as in __omap2_set_globals() function
> (except for sdrc).

OK so far.

> This patch adds new config flag SOC_HAS_OMAP2_SDRC to handle sdrc,
> so that we can reuse same function across omap2/3/4...

But what happens when a single kernel is built that has support for an
SoC with an SDRC (OMAP4) and one that doesn't (AM33xx)?

In that case this new SOC_HAS_OMAP2_SDRC will be set, and
set_globals_sdrc() will be called even for the SoCs without SDRC.

So, rather than add a new Kconfig option for this, I would rather see 
you using the existing runtime feature check for the SDRC: omap_has_sdrc()

Kevin
