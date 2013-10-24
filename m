From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] dma: edma: Add support for Cyclic DMA
Date: Thu, 24 Oct 2013 22:08:29 +0530
Message-ID: <20131024163829.GA21230@intel.com>
References: <1379977515-3794-1-git-send-email-joelf@ti.com>
 <1379977515-3794-3-git-send-email-joelf@ti.com>
 <20131021065319.GM14013@intel.com>
 <52669A23.2080805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57190 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304Ab3JXRdM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Oct 2013 13:33:12 -0400
Content-Disposition: inline
In-Reply-To: <52669A23.2080805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>, dmaengine@vger.kernel.org
Cc: Matt Porter <matt@ohporter.com>, Mark Brown <broonie@linaro.org>, Russell King <linux@arm.linux.org.uk>, Dan Williams <djbw@fb.com>, Jyri Sarha <jsarha@ti.com>, Lars Peter-Clausen <lars@metafoo.de>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org

On Tue, Oct 22, 2013 at 10:30:43AM -0500, Joel Fernandes wrote:
> On 10/21/2013 01:53 AM, Vinod Koul wrote:
> > On Mon, Sep 23, 2013 at 06:05:14PM -0500, Joel Fernandes wrote:
> >> +	nr_periods = (buf_len / period_len) + 1;
> > ?
> > 
> > consider the case of buf = period_len, above makes nr_period = 2.
> > 
> > Or buf len 100, period len 50, makes nr_period = 3
> > 
> > Both doesnt seem right to me?
> 
> I guess that variable name is misleading.
> 
> nr_periods is actually the total no.of slots needed to process the request. Its
> value is 1 greater than the total number of periods.
Okay sounds good to me. I tried applying below but looks like it fails as I have
already applied, 1 & 3. Can you pls rebase this resend

--
~Vinod
