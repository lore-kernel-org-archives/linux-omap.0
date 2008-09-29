From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 4/5] [RFC] ALSA ASOC adds destination and source port
 for dma
Date: Mon, 29 Sep 2008 14:06:42 +0300
Message-ID: <20080929140642.2be080ff.jarkko.nikula@nokia.com>
References: <dfeb90390809290253kdf153b6p9993882e495f5e5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63789 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbYI2LHV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 07:07:21 -0400
In-Reply-To: <dfeb90390809290253kdf153b6p9993882e495f5e5c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arun KS <arunks@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, alsa-devel@vger.kernel.org, felipe.balbi@nokia.com

On Mon, 29 Sep 2008 15:23:52 +0530
"ext Arun KS" <arunks@mistralsolutions.com> wrote:

> Adds destination and source ports for dma which is required for OMAP1
> 
> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  sound/soc/omap/omap-pcm.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
>  	err = omap_request_dma(dma_data->dma_req, dma_data->name,
>  			       omap_pcm_dma_irq, substream, &prtd->dma_ch);
> +
>  	if (!cpu_is_omap1510()) {

Accidentally added line? Actually it pointed out that line after it
should include test for err before linking channel with itself.

	if (!err && !cpu_is_omap1510()) {

> +		dma_params.dst_port		= OMAP_DMA_PORT_MPUI;
>  	} else {
...
> +		dma_params.src_port		= OMAP_DMA_PORT_MPUI;
>  	}

I don't have OMAP1 HW at hand to test but looks ok to me. And this port
variable is used only with OMAP1's.


Jarkko
