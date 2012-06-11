From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Mon, 11 Jun 2012 18:39:30 +0100
Message-ID: <20120611173930.GD28235@mudshark.cambridge.arm.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-2-git-send-email-jon-hunter@ti.com>
 <20120608094708.GC19062@mudshark.cambridge.arm.com>
 <4FD21930.4000800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:60556 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112Ab2FKRjr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 13:39:47 -0400
Content-Disposition: inline
In-Reply-To: <4FD21930.4000800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

On Fri, Jun 08, 2012 at 04:24:32PM +0100, Jon Hunter wrote:
> Hi Will,

Hi Jon,

> Here is an updated version. I was going to send out a V3, but I wanted
> to wait to see if others had more comments first.

This looks better to me, so I took it for a spin on my 4460 (thanks Nicolas!)
and noticed that only the cycle counter seems to tick -- the event counters
always return 0 deltas (that is, they don't increment). Booting the same SD
card on a 4430 (same MLO, u-boot, kernel and filesystem) I see that the
event counters function correctly there.

It also seems that we can remove the dependency on CONFIG_OMAP3_EMU with these
patches but I don't have any OMAP3 hardware to check if we get any regressions
on older platforms. Do your patches only deal with OMAP4?

Cheers,

Will
