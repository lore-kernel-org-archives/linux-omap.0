From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] EDMA: TI: fixed wrongly initialized data parameter
 to the edma callback
Date: Tue, 24 Mar 2015 12:07:01 +0200
Message-ID: <55113745.3010602@ti.com>
References: <1427142901-16391-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59444 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466AbbCXKHI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 06:07:08 -0400
In-Reply-To: <1427142901-16391-1-git-send-email-petr@barix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Petr Kulhavy <petr@barix.com>, vinod.koul@intel.com
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, trivial@kernel.org

On 03/23/2015 10:35 PM, Petr Kulhavy wrote:
> The "data" parameter passed indirectly to the edma_callback() should be
> edma_chan and not the dma_chan.
> 
> This bug was so far harmless since the offset of struct dma_chan within struct
> edma_chan is 0. However as soon as someone changes struct edma_chan this would
> cause troubles.

Good catch. This seams to be in the code since the first commit ;)

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---
>  drivers/dma/edma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 1465610..4c8208b 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -813,7 +813,7 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
>  	LIST_HEAD(descs);
>  
>  	a_ch_num = edma_alloc_channel(echan->ch_num, edma_callback,
> -					chan, EVENTQ_DEFAULT);
> +					echan, EVENTQ_DEFAULT);
>  
>  	if (a_ch_num < 0) {
>  		ret = -ENODEV;
> 


