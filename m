From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 25/25] ARM: pm: omap34xx: convert to generic suspend/resume support
Date: Thu, 23 Jun 2011 12:05:28 -0700
Message-ID: <874o3g9xmv.fsf@ti.com>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
	<E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [74.125.149.109] ([74.125.149.109]:35750 "EHLO psmtp.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759457Ab1FWTFc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 15:05:32 -0400
In-Reply-To: <E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Wed, 22 Jun 2011 16:16:58 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

Hi Russell,

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Convert sa11x0 to use the generic CPU suspend/resume support, rather
> than implementing its own version.  Tested on 3430 LDP.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I tested this on 3430/n900 and 3530/Overo and it worked fine for
retention, but not for off.

Testing with off-mode, I found the MULTI_CPU path to be broken in
cpu_suspend (jumping to zero.)  Rebuilding for only OMAP3, it worked
fine for full-chip retention in suspend and idle as well as full-chip
off in suspend and idle.

I'm digging into the MULTI_CPU path now.

Kevin
