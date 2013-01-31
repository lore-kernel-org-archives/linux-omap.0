From: Tony Lindgren <tony@atomide.com>
Subject: Re: Failure to boot...
Date: Thu, 31 Jan 2013 08:00:02 -0800
Message-ID: <20130131160000.GW15361@atomide.com>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk>
 <20130131104044.GO2637@n2100.arm.linux.org.uk>
 <510A6877.9080307@ti.com>
 <20130131130437.GP2637@n2100.arm.linux.org.uk>
 <510A78E1.8010308@ti.com>
 <20130131141320.GQ2637@n2100.arm.linux.org.uk>
 <20130131141635.GR2637@n2100.arm.linux.org.uk>
 <510A7D9F.7040507@ti.com>
 <20130131142758.GS2637@n2100.arm.linux.org.uk>
 <510A82FE.6050803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56363 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755138Ab3AaQAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 11:00:08 -0500
Content-Disposition: inline
In-Reply-To: <510A82FE.6050803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130131 06:45]:
> On Thursday 31 January 2013 07:57 PM, Russell King - ARM Linux wrote:
> >>>
> >>># 13 Jan 2013: Update for OMAP moving to multiplatform
> >>>CONFIG_ARCH_MULTIPLATFORM=y
> >>>CONFIG_ARCH_MULTI_V7=y
> >>>
> >>>don't fix it either, it needs more options defined...

Just trying to figure out what was the missing entry in case
others have the same problem.

In addition to the ones above, I had also CONFIG_ARCH_OMAP2PLUS=y
listed in my comments. Did you also need something else added
manually?

Regards,

Tony
