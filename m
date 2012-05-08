From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Tue, 8 May 2012 08:47:20 -0700
Message-ID: <20120508154719.GR5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
 <alpine.DEB.2.00.1205071259090.9984@utopia.booyaka.com>
 <20120507191847.GJ5088@atomide.com>
 <alpine.DEB.2.00.1205072321190.9984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23985 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab2EHPrY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 11:47:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1205072321190.9984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

* Paul Walmsley <paul@pwsan.com> [120507 22:35]:
> On Mon, 7 May 2012, Tony Lindgren wrote:
> > 
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67938.html
> 
> I see.  Yeah, the problem is that it's hard to figure out which SoCs 
> should go into SOC_OMAP3PLUS.  AM33xx?  TI81xx?  etc.  Some of these chips 
> draw some aspects from chips that we've historically considered part of 
> OMAP3, and other aspects from OMAP4-style chips.

Yes agreed it should be finer grained and feature specific.
 
> What seems better to me would be to use a more specific, IP block-focused 
> macro as needed.  So to pick a random example, in mach-omap2/control.c, we 
> currently skip compilation of the scratchpad functions unless 
> CONFIG_ARCH_OMAP3 is defined.  Instead of making this 
> SOC_OMAP3PLUS-dependent, or dependent on a mess of CONFIG_SOC_* macros, 
> maybe something like CONFIG_OMAP3430_SCM_SCRATCHPAD_FORMAT?

Yes that makes sense. How about let's standardize on naming like
SOC_HAS_OMAP3430_SCM_SCRATCHPAD_FORMAT?

We already have similar naming for generic things like ARCH_HAS_XYZ.

> Of course, for some of these cases, maybe it makes more sense to move the 
> code out into a separate file, control-omap3-scratchpad.c or something, 
> and just conditionally compile it to avoid the #ifdefs.

Agreed.

Regards,

Tony 
