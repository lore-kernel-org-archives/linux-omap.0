From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/7] omap hsmmc init cleanup and section warning
 fixes for v3.4 merge window
Date: Thu, 23 Feb 2012 10:52:17 -0800
Message-ID: <20120223185217.GY18185@atomide.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28733 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab2BWSwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 13:52:21 -0500
Content-Disposition: inline
In-Reply-To: <1329997247-27342-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120223 03:09]:
> Re-sending as these patches did not make it to the lists due to
> issues with my 'git send-email'
> 
> Hi Tony,
> 
> This is a re-spin of your series to fix up the section
> mismatch warnings noted by Russell with omap2_hsmmc_init().
> The previous series had an issue around multiple insmod/rmmod
> of the twl4030 gpio driver when built as a module as reported
> by Russell again.

OK, can you please rebase your patches on hsmmc branch in linux-omap
at commit 0e91c8ddf0e0932da59ec1d116e34049791b0e73?

Note that at least the hardcoded GPIO numbers are no longer needed.
 
> There were 2 issues, one with gpio_requests failing as they were
> never freed on the module unload/unbind. The other was with the
> mmc devices being registered again. I have fixed both these issues
> in this series, mainly by having a .teardown hook for twl4030 gpio
> driver populated from all OMAP3 board files, which release all the
> requested gpios and also unregister the mmc omap/platform device.

Yes that's great.
 
Regards,

Tony
