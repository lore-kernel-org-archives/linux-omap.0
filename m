From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: ARM : OMAP: Pass logical DMA channel number always to callback
 handlers
Date: Wed, 26 Nov 2008 14:34:40 +0200
Message-ID: <20081126143440.bfe30f25.jarkko.nikula@nokia.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02936BEAED@dbde02.ent.ti.com>
	<20081126121143.f564a966.jarkko.nikula@nokia.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02936BEC19@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62252 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbYKZMfE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 07:35:04 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02936BEC19@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 26 Nov 2008 16:26:42 +0530
"ext Shilimkar, Santosh" <santosh.shilimkar@ti.com> wrote:

> > As commit log says, user can pass the chain_id via callback data if
> > needed. 
> Yes there are few ways you can achieve this if you don't want to pass the chain_id as part of the callback. But in that case the 'omap_request_dma_chain' callback signature should have been also cleaned ( 'ch' instead of 'chain_id').
> 
Ah, yeah, then it was missing from my patch and have to send a patch
changing it.

> >I think chained dma callback may also find more use 
> > for logical channel number than chain_id e.g. when modifying the transfer
> > parameters etc.
> When user wants to use chaining,they expects that the chain internals ( free channel allocation etc) should be managed by DMA library. So even user wants to modify the parameters, it can directly use 'omap_modify_dma_chain_params' api and just provide 'chain_id'. For which channel the parameters should be changed will be decided by the DMA library internally depending on free channels from chain.
>
This approach doesn't work e.g. with audio. Let's assume you would like
to use DMA chaining with ALSA (been there, done that, until found a
better solution. See sound/soc/omap-pcm.c).

ALSA application may ask to use e.g. 100 periods, which is more than
n.o. logical DMA channels in OMAP so chain length is have to be shorter
than n.o. periods. Which then means that channel parameters are have to
modify while the chain is running.

omap_modify_dma_chain_params is setting parameters for all channels in
a chain, and more over, function header of it says "Dont do this while
dma is running!!".

> > And uniform, smaller API set is always better than bloated one.
> This change any way don't reduce a single API so not sure what you mean by 'smaller API set is always better than bloated one'. It may reduce a callback for a user in
>  
IMO, API is a one step bigger if DMA callback has different arguments
depending is it in non-chained vs. chained configuration.

> So I still don't see a real benefit of this patch. Because of above mentioned reasons I think  we should revert this patch.
> 
Probably you would like to show/share opposite example?


Jarkko
