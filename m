From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: timer fixes / cleanup
Date: Thu, 6 Oct 2011 13:12:25 -0700
Message-ID: <20111006201225.GS6324@atomide.com>
References: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55608 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755456Ab1JFUM3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 16:12:29 -0400
Content-Disposition: inline
In-Reply-To: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tarun.kanti@ti.com

* Benoit Cousson <b-cousson@ti.com> [111004 13:46]:
> Hi Tony,
> 
> Here is the series to fix the warning and remove the redundant
> latency structure that be removed since the timer runtime PM
> adaptation was just pulled.
> 
> I was just able to test that on OMAP4.
> 
> Patches are based on Kevin's for_3.2/omap_device-2 branch
> and are available here:
> git://gitorious.org/omap-pm/linux.git for_3.2/timer_fixes

Thanks, applying both into fixes-part2 branch.

Regards,

Tony
