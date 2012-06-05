From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap: dma: Clear status registers on enable/disable
 irq.
Date: Mon, 4 Jun 2012 23:39:13 -0700
Message-ID: <20120605063912.GB12766@atomide.com>
References: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
 <2491206.Xgf8oVG38F@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38243 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab2FEGjT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 02:39:19 -0400
Content-Disposition: inline
In-Reply-To: <2491206.Xgf8oVG38F@acer>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Oleg Matcovschi <oleg.matcovschi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, jarkko.nikula@bitmer.com

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120604 15:01]:
> On Tue, 15 May 2012 14:35:08 Oleg Matcovschi wrote:
> > Use omap_disable_channel_irq() function instead of directly accessing CICR.
> > The omap_disable_chanel_irq() function clears pending interrupts
> > and disables interrupt on channel.
> > Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear interrupt
> > status register.
> > 
> > 
> > Signed-off-by: Oleg Matcovschi <oleg.matcovschi@ti.com>
> > ---
> > v1 initial revision
> > v2 Review by Tony Lindgren
> 
> My Tested-by: on OMAP1 still valid for v2 if you care.

OK good to hear, will add that.

Regards,

Tony
