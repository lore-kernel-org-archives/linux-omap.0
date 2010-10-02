From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Sat, 2 Oct 2010 10:13:06 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C5B9@dbde02.ent.ti.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com>
 <1285936577-14881-3-git-send-email-peter.ujfalusi@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE0D1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44307 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab0JBEnU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Oct 2010 00:43:20 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE0D1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Shilimkar, Santosh
> Sent: Friday, October 01, 2010 8:35 PM
> To: Peter Ujfalusi; Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Jarkko Nikula; Liam Girdwood
> Subject: RE: [PATCH v3 2/2] OMAP3: DMA: Errata: sDMA FIFO 
> draining does not finish
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap- 
> > owner@vger.kernel.org] On Behalf Of Peter Ujfalusi
> > Sent: Friday, October 01, 2010 6:06 PM
> > To: Tony Lindgren
> > Cc: linux-omap@vger.kernel.org; Jarkko Nikula; Liam Girdwood
> > Subject: [PATCH v3 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does 
> > not finish
> > 
> > Implement the suggested workaround for OMAP3 regarding to sDMA 
> > draining issue, when the channel is disabled on the fly.
> > This errata affects the following configuration:
> > sDMA transfer is source synchronized
> > Buffering is enabled
> > SmartStandby is selected.
> > 
> > The issue can be easily reproduced by creating overrun 
> situation while 
> > recording audio.
> > Either introduce load to the CPU:
> > nice -19 arecord -D hw:0 -M -B 10000 -F 5000 -f dat > 
> /dev/null & \ dd 
> > if=/dev/urandom of=/dev/null
> > 
> > or suspending the arecord, and resuming it:
> > arecord -D hw:0 -M -B 10000 -F 5000 -f dat > /dev/null
> > CTRL+Z; fg; CTRL+Z; fg; ...
> > 
> > In case of overrun audio stops DMA, and restarts it 
> (without reseting 
> > the sDMA channel). When we hit this errata in stop case (sDMA drain 
> > did not complete), at the coming start the sDMA will not 
> going to be 
> > operational (it is still draining).
> > This leads to DMA stall condition.
> > On OMAP3 we can recover with sDMA channel reset, it has 
> been observed 
> > that by introducing unrelated sDMA activity might also help 
> (reading 
> > from MMC for example).
> > 
> Just fyi, FIFO drain errata is not applicable for OMAP4 SDMA 
> IP version.
> Patch looks good to me.
> 
> > The same errata exists for OMAP2, where the suggestion is 
> to disable 
> > the buffering to avoid this type of error.
> > On OMAP3 the suggestion is to set sDMA to NoStandby before 
> disabling 
> > the channel, and wait for the drain to finish, than 
> configure sDMA to 
> > SmartStandby again.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>

I can rebase this patch on top of dma hwmod changes.

Acked-by : G, Manjunath Kondaiah <manjugk@ti.com>

-Manjunath

