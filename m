From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Mon, 7 May 2012 12:35:01 -0700
Message-ID: <20120507193500.GK5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
 <alpine.DEB.2.00.1205071259090.9984@utopia.booyaka.com>
 <20120507191847.GJ5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:25935 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757265Ab2EGTfF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 15:35:05 -0400
Content-Disposition: inline
In-Reply-To: <20120507191847.GJ5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

* Tony Lindgren <tony@atomide.com> [120507 12:22]:
> * Paul Walmsley <paul@pwsan.com> [120507 12:11]:
> > Hi,
> > 
> > On Fri, 4 May 2012, Tony Lindgren wrote:
> > 
> > > How about we add CONFIG_SOC_OMAP3PLUS in the clean-up series?
> > > Then this becomes just:
> > > 
> > > #ifdef CONFIG_SOC_OMAP3PLUS
> > 
> > We might want to consider having separate CONFIG_SOC_* values for each 
> > SoC.  So rather than CONFIG_SOC_OMAP3PLUS, we'd have CONFIG_SOC_OMAP3430, 
> > CONFIG_SOC_OMAP3630, etc.
> 
> Hmm but this would be in addition to the SOC specific options. The goal
> is to cut down the ifdeffery needed all over the place to add new SoCs,
> see the experimental patch I posted:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67938.html

Of course we could make this finer grained based on features
like SOC_HAS_XYZ or SOC_HAS_OMAP3PLUS_PRMXYZBITS if you have some
grouping like that in mind.

Regards,

Tony
