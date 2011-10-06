From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 01/28] OMAP: change get_context_loss_count ret value
 to int
Date: Thu, 6 Oct 2011 16:14:49 -0700
Message-ID: <20111006231449.GB6324@atomide.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
 <1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.00.1110061710510.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38246 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab1JFXOw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 19:14:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1110061710510.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com

* Paul Walmsley <paul@pwsan.com> [111006 15:37]:
> On Thu, 9 Jun 2011, Tomi Valkeinen wrote:
> 
> > get_context_loss_count functions return context loss count as u32, and
> > zero means an error. However, zero is also returned when context has
> > never been lost and could also be returned when the context loss count
> > has wrapped and goes to zero.
> > 
> > Change the functions to return an int, with negative value meaning an
> > error.
> > 
> > OMAP HSMMC code uses omap_pm_get_dev_context_loss_count(), but as the
> > hsmmc code handles the returned value as an int, with negative value
> > meaning an error, this patch actually fixes hsmmc code also.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>> 

Thanks, picking this into fixes-part2 branch as requested by Paul.

Tony
