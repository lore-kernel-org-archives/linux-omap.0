From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Tue, 17 May 2011 15:57:00 +0300
Message-ID: <20110517125700.GY5323@atomide.com>
References: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com>
 <20110517152954.477365e6.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:31364 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754620Ab1EQM5H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 May 2011 08:57:07 -0400
Content-Disposition: inline
In-Reply-To: <20110517152954.477365e6.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>

* Jarkko Nikula <jhnikula@gmail.com> [110517 15:24]:
> On Tue, 17 May 2011 13:33:40 +0300
> Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> > On OMAP4 we have one interrupt line per McBSP port.
> > At proble time tx, and rx irq value will be -ENXIO,
> > and only the tx irq will get corrected.
> > In omap_mcbsp_request if the rx_irq is not 0 we proceed,
> > and try to request the interrupt, which will fail on
> > OMAP4 (rx_irq == -6).
> > To avoid this error, clear the rx_irq at probe time
> > on OMAP4.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> >  arch/arm/plat-omap/mcbsp.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> > 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

This file should be under drivers/ somewhere, can you
guys please take care of that?

Regards,

Tony
