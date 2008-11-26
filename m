From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: ARM : OMAP: Pass logical DMA channel number always to callback
 handlers
Date: Wed, 26 Nov 2008 16:26:42 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02936BEC19@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02936BEAED@dbde02.ent.ti.com>
 <20081126121143.f564a966.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43737 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbYKZK46 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 05:56:58 -0500
In-Reply-To: <20081126121143.f564a966.jarkko.nikula@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Jarkko Nikula [mailto:jarkko.nikula@nokia.com] 
> Sent: Wednesday, November 26, 2008 3:42 PM
> To: Shilimkar, Santosh
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: ARM : OMAP: Pass logical DMA channel number 
> always to callback handlers
> 
> On Wed, 26 Nov 2008 14:43:02 +0530
> "ext Shilimkar, Santosh" <santosh.shilimkar@ti.com> wrote:
> 
> > Hi Jarkko\Tony ,
> > 
> > Recently during some debugging, I observed this patch.
> > 
> http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commitdif
> f;h=538528de0cb256f65716ab2e9613d9e920f97fe2;hp=29e8c3c304b62f
> 31b799565c9ee85d42bd163f80
> > 

> > As per your description,it improves the debugging. Can you 
> elaborate more on this ?
> > 
> Honestly don't remember what I meant for easier debugging, probably
> just watching how the logical channels are rotating during 
> the transfer or something like that.
Yes but It will be of just academic interest to see it. :-)
 
> > For users this change is little confusing, if they go as 
> per the signatures of the 'omap_request_dma_chain' and 
> 'omap_request_dma' APIs. Also separating the callbacks for 
> chained and non-chained transfers seems to be the practical 
> usage in most of the cases. Also users would be only 
> interested in 'chain_id' and not 'channel number' in case of 
> chaining.  
> > 
> As commit log says, user can pass the chain_id via callback data if
> needed. 
Yes there are few ways you can achieve this if you don't want to pass the chain_id as part of the callback. But in that case the 'omap_request_dma_chain' callback signature should have been also cleaned ( 'ch' instead of 'chain_id').

>I think chained dma callback may also find more use 
> for logical channel number than chain_id e.g. when modifying the transfer
> parameters etc.
When user wants to use chaining,they expects that the chain internals ( free channel allocation etc) should be managed by DMA library. So even user wants to modify the parameters, it can directly use 'omap_modify_dma_chain_params' api and just provide 'chain_id'. For which channel the parameters should be changed will be decided by the DMA library internally depending on free channels from chain.
In fact if users modifies parameters using 'omap_set_dma_params' + 'ch' number directly in a chained transfer, then it can tamper the chaining state machine.  

> And uniform, smaller API set is always better than bloated one.
This change any way don't reduce a single API so not sure what you mean by 'smaller API set is always better than bloated one'. It may reduce a callback for a user in case he wants to use normal and chaining feature together for a module. But he has to any way add the logic to differentiate between callers. I have not seen any driver using DMA that way. 
 
So I still don't see a real benefit of this patch. Because of above mentioned reasons I think  we should revert this patch.

Regards
Santosh Shilimkar