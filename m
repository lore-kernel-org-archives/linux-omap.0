From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 GPTIMER: fix GPTIMER12 IRQ
Date: Sun, 10 Aug 2008 11:05:30 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808101104080.10219@utopia.booyaka.com>
References: <alpine.DEB.1.00.0808080256150.21853@utopia.booyaka.com> <20080808090624.GO24923@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38016 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbYHJRFc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Aug 2008 13:05:32 -0400
In-Reply-To: <20080808090624.GO24923@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Fri, 8 Aug 2008, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [080808 11:57]:
> > 
> > GPTIMER12 IRQ is at IRQ 95 on OMAP3, unlike OMAP2.  (ref: OMAP34xx
> > Multimedia High Security (HS) Device Silicon Revision 3.0 Security
> > Addendum Rev. B, SWPU119B)
> 
> That probably explains why it did not work earlier :) Pushing today.

Yeah, the GPTIMER1 issue on Beagle is still present.  This patch just 
fixes the use of GPTIMER12 as a workaround...


- Paul
