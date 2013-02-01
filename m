From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] arch: arm: gpmc: gpmc migration support
Date: Fri, 1 Feb 2013 14:05:10 -0800
Message-ID: <20130201220510.GY22517@atomide.com>
References: <1358933176-12409-1-git-send-email-avinashphilip@ti.com>
 <1358933176-12409-2-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47472 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757791Ab3BAWFS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 17:05:18 -0500
Content-Disposition: inline
In-Reply-To: <1358933176-12409-2-git-send-email-avinashphilip@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Avinash <avinashphilip@ti.com>
Cc: khilman@ti.com, linux@arm.linux.org.uk, dwmw2@infradead.org, afzal@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com

* Philip Avinash <avinashphilip@ti.com> [130123 01:28]:
> With recent GPMC driver conversion, usage of gpmc_save/restore_context
> can done from gpmc driver itself. Hence removes the usage from pm34xx.c.
> Also removes the conditional compilation primitives ARCH_OMAP3 for
> gpmc_save/restore_context.

Hmm I think this will break GPMC for deeper idle modes. Note that we
need to save and restore the context every time hitting off-idle, not
just for suspend and resume. Or am I missing something here?

Regards,

Tony
