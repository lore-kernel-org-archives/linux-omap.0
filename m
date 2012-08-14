From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V3] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
Date: Tue, 14 Aug 2012 01:29:12 -0700
Message-ID: <20120814082911.GG11011@atomide.com>
References: <1343214422-28718-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1207251438210.23542@utopia.booyaka.com>
 <alpine.DEB.2.00.1207261359500.14468@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:13675 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab2HNI3P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Aug 2012 04:29:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1207261359500.14468@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi,

* Paul Walmsley <paul@pwsan.com> [120726 13:07]:
> On Wed, 25 Jul 2012, Paul Walmsley wrote:
> 
> > These IP blocks and the ECAP IP blocks have periods in their names.
> > The rest of the IP block named in the file don't use periods -- which
> > is also the style used by the rest of the OMAP SoCs.  Is there
> > some reason that these have periods in their names?
> 
> I've changed those to match the rest of the names, and queued the 
> following for 3.7.
> 
> Thanks again for all the hard work you all put into this.  I realize that 
> with all the upstream changes, this was probably a little painful for you. 
> But from my perspective you've been a pleasure to work with through the 
> process.

As am33xx and omap5 are DT only, we should start moving towards getting
rid of grep -E "irq|pa_start|pa_end|dma" in this patch and get the standard
data from .dtsi files instead.

Alternatively we could get rid of the names and match the module based on
pa_start and pa_end.

Regards,

Tony
