From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Mon, 7 May 2012 12:18:47 -0700
Message-ID: <20120507191847.GJ5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
 <alpine.DEB.2.00.1205071259090.9984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19738 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab2EGTSv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 15:18:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1205071259090.9984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

* Paul Walmsley <paul@pwsan.com> [120507 12:11]:
> Hi,
> 
> On Fri, 4 May 2012, Tony Lindgren wrote:
> 
> > How about we add CONFIG_SOC_OMAP3PLUS in the clean-up series?
> > Then this becomes just:
> > 
> > #ifdef CONFIG_SOC_OMAP3PLUS
> 
> We might want to consider having separate CONFIG_SOC_* values for each 
> SoC.  So rather than CONFIG_SOC_OMAP3PLUS, we'd have CONFIG_SOC_OMAP3430, 
> CONFIG_SOC_OMAP3630, etc.

Hmm but this would be in addition to the SOC specific options. The goal
is to cut down the ifdeffery needed all over the place to add new SoCs,
see the experimental patch I posted:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67938.html

> This would be for two main reasons.  One is that Kconfig options like 
> CONFIG_SOC_OMAP3PLUS don't have much meaning.  It is really unclear to me 
> what SoCs would be included in CONFIG_SOC_OMAP3PLUS, since some of them 
> differ so radically -- different interconnects, different power and system 
> management IP blocks, different CPU subsystems, different RAM controllers, 
> etc.  The advantage of using SoC-specific Kconfig options, from this point 
> of view, is that it is easy to know what they mean.  Then those 
> SoC-specific Kconfig options can select the appropriate SoC-independent 
> interconnect driver, PRCM drivers, CPU options, etc.

Just to continue exploring just using the SoC specific options, we would
currently end up with more of this kind of nastiness:

#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) ||      \
					defined(CONFIG_ARCH_OMAP3))
 
> The other motivation would be to support device manufacturers who only 
> wish to build a kernel for the single device that they are shipping.  In 
> terms of kernels shipped, this is probably the most popular use-case. With 
> something like CONFIG_SOC_OMAPAM33XX, they can avoid building quite a bit 
> of code and data (and potentially bugs) that are not needed for their 
> specific device.

Sure, but I think you're missing the point: This would be in addition
to the SoC specific options. Do you still see issues with that?

Regards,

Tony
