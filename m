From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: ARM : OMAP: Pass logical DMA channel number always to callback
 handlers
Date: Thu, 27 Nov 2008 13:00:49 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02936BF182@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02936BEAED@dbde02.ent.ti.com>
	<20081126121143.f564a966.jarkko.nikula@nokia.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02936BEC19@dbde02.ent.ti.com>
 <20081126143440.bfe30f25.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59750 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbYK0HbI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 02:31:08 -0500
In-Reply-To: <20081126143440.bfe30f25.jarkko.nikula@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Jarkko Nikula [mailto:jarkko.nikula@nokia.com] 
> Sent: Wednesday, November 26, 2008 6:05 PM
> To: Shilimkar, Santosh
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: ARM : OMAP: Pass logical DMA channel number 
> always to callback handlers
> 
> On Wed, 26 Nov 2008 16:26:42 +0530
> "ext Shilimkar, Santosh" <santosh.shilimkar@ti.com> wrote:
> 
> > > As commit log says, user can pass the chain_id via 
> callback data if
> > > needed. 
> > Yes there are few ways you can achieve this if you don't 
> want to pass the chain_id as part of the callback. But in 
> that case the 'omap_request_dma_chain' callback signature 
> should have been also cleaned ( 'ch' instead of 'chain_id').
> > 
> Ah, yeah, then it was missing from my patch and have to send a patch
> changing it.
> 
> > >I think chained dma callback may also find more use 
> > > for logical channel number than chain_id e.g. when 
> modifying the transfer
> > > parameters etc.
> > When user wants to use chaining,they expects that the chain 
> internals ( free channel allocation etc) should be managed by 
> DMA library. So even user wants to modify the parameters, it 
> can directly use 'omap_modify_dma_chain_params' api and just 
> provide 'chain_id'. For which channel the parameters should 
> be changed will be decided by the DMA library internally 
> depending on free channels from chain.
> >
> This approach doesn't work e.g. with audio. Let's assume you 
> would like
> to use DMA chaining with ALSA (been there, done that, until found a
> better solution. See sound/soc/omap-pcm.c).

Don't know how alsa frameworks works but looking at code, it seems this was done when  omap DMA version were not supporting chaining. But even after chaining is available it's not been updated.That's a different topic anyways.
 
> ALSA application may ask to use e.g. 100 periods, which is more than
> n.o. logical DMA channels in OMAP so chain length is have to 
> be shorter
> than n.o. periods. Which then means that channel parameters 
> are have to
> modify while the chain is running.

Not sure about the above scenario's practicality. How much is 'one' period in terms bytes. Is there requirement that for one period , you need a dedicated DMA channel for a transfer. I don't understand how you arrived at above conlcusion.
 
> omap_modify_dma_chain_params is setting parameters for all channels in
> a chain, and more over, function header of it says "Dont do this while
> dma is running!!".

Firstly I don't understand why you want to use 'omap_modify_dma_chain_params' when chain is active. Above example you have given is not telling me how I end in a situation of modifying chanining parametsr. In normal case,you can very much program the transfer related parameters using 'omap_dma_chain_a_transfer' which will find out free channel and queue it.

> > > And uniform, smaller API set is always better than bloated one.
> > This change any way don't reduce a single API so not sure 
> what you mean by 'smaller API set is always better than 
> bloated one'. It may reduce a callback for a user in
> >  
> IMO, API is a one step bigger if DMA callback has different arguments
> depending is it in non-chained vs. chained configuration.
> > So I still don't see a real benefit of this patch. Because 
> of above mentioned reasons I think  we should revert this patch.
> > 
> Probably you would like to show/share opposite example?
Not exactly. But I want to see that the chaining feature should be used as it is intended and supported by design. Because if user wants to manage the programming of free channels then it is as good as , user implements it's own chaining. This can be done with normal DMA APIs as well. :-)


 
> 
> Jarkko
> 
> 