From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP: use fncpy to copy the PM code functions to
 SRAM
Date: Wed, 19 Jan 2011 14:10:57 -0800
Message-ID: <20110119221056.GG4957@atomide.com>
References: <1295352126-29171-1-git-send-email-j-pihet@ti.com>
 <87vd1ksq2i.fsf@ti.com>
 <87mxmwr2un.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55437 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab1ASWLS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 17:11:18 -0500
Content-Disposition: inline
In-Reply-To: <87mxmwr2un.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: jean.pihet@newoldbits.com, Dave Martin <dave.martin@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

* Kevin Hilman <khilman@ti.com> [110119 13:37]:
> Kevin Hilman <khilman@ti.com> writes:
> 
> > jean.pihet@newoldbits.com writes:
> >
> >> From: Jean Pihet <j-pihet@ti.com>
> >>
> >> The new fncpy API is better suited for copying some
> >> code to SRAM at runtime. This patch changes the ad-hoc
> >> code to the more generic fncpy API.
> >>
> >> Tested OK on OMAP3 in low power modes (RET/OFF)
> >> using omap2plus_defconfig with !CONFIG_THUMB2_KERNEL.
> >> Compile tested on OMAP1/2 using omap1_defconfig.
> >>
> >> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> >
> > Acked-by: Kevin Hilman <khilman@ti.com>
> >
> > Boot tested on OMAP1 & OMAP2 as well.  Note that neither OMAP1 or OMAP2
> > has had working suspend/resume for a long time now, so I did not test
> > suspend/resume.
> 
> For OMAP2:
> 
> Tested-by: Kevin Hilman <khilman@ti.com>
> 
> to test a little more on OMAP2, I just removed the WFI from the
> low-level code and tested suspend that way.  That's enough to be sure
> the copied code is copied and executed.
> 
> Worked fine on OMAP2420/n810.
> 
> For OMAP1, this didn't work and would require more serious hacking on
> the OMAP1 suspend path, which I currently have no plans to do.

Boots fine on osk5912 and n800 too:

Tested-by: Tony Lindgren <tony@atomide.com>
