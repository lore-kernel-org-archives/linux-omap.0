From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] OMAP compile warning fix
Date: Wed, 19 Jan 2011 17:25:46 -0800
Message-ID: <20110120012545.GQ4957@atomide.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20081 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141Ab1ATBZ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 20:25:58 -0500
Content-Disposition: inline
In-Reply-To: <1295238680-26738-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110116 20:30]:
> Hi Tony,
> 
> I gave it a shot at dropping a few compile warnings
> from omap1-only and omap2-only builds.
> 
> Following are 7 patches which I came up with. All
> compile tested with omap1_defconfig and omap2_defconfig
> (the latter being a result of omap2plus_defconfig -
> omap3 and omap4 support and adding any other config option
> which was disabled)
> 
> There are a few more warnings to clean up, though. I didn't
> tackle all of them.

Thanks, adding all but the last one into devel-cleanup
for the next merge window. Let's see what Paul says about
the last one.

Tony
