From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [alsa-devel] channel swapping issue on OMAP3/TWL4030 is back
Date: Fri, 22 Mar 2013 16:35:06 +0000
Message-ID: <20130322163506.GL30923@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net> <alpine.DEB.2.01.1303221023070.7975@pmeerw.net> <514C2E5E.2040909@gmail.com> <alpine.DEB.2.01.1303221348250.7975@pmeerw.net> <514C56EA.7020304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42235 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161021Ab3CVQfb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Mar 2013 12:35:31 -0400
Content-Disposition: inline
In-Reply-To: <514C56EA.7020304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, Daniel Mack <zonque@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Fri, Mar 22, 2013 at 02:04:42PM +0100, Peter Ujfalusi wrote:
> Russell: can we remove the tasklet use from dma-omap and start the DMA right
> away in omap_dma_issue_pending()? This is the only way to prevent channel
> swap when starting audio.

What I fear is that we may run up against having too many DMA channels
tied up to the peripherals.  I structured the driver in this way to
allow us to move the physical DMA channel allocation to that tasklet
when that becomes a problem.

Not only that but I was hoping to lift some more of this code out of
DMA engine drivers, so DMA engine drivers had even less code in them.

I guess we could keep the tasklet, but mark the audio DMA channels as
"pre-reserved" and arrange for pre-reserved channels to avoid the
tasklet, rather than throwing the tasklet out completely.
