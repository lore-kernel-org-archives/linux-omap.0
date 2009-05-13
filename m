From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP: sDMA: Correct the the omap_request_dma_chain()
 	signature
Date: Wed, 13 May 2009 15:42:33 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B4843E8E@dbde02.ent.ti.com>
References: <1241006956-29268-1-git-send-email-santosh.shilimkar@ti.com>
	 <20090429220804.2d130ceb.jhnikula@gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02B446F94B@dbde02.ent.ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02B446F96B@dbde02.ent.ti.com>
	 <bd7b27490904300146p17cb127asf2013cc3f0840a26@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02B446FC72@dbde02.ent.ti.com>
 <bd7b27490904300236q458b8198x200a976b9941dc10@mail.gmail.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B446FCCF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53612 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758164AbZEMKMl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 06:12:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4DACaPR007745
	for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 05:12:42 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4DACZcR022097
	for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 15:42:35 +0530 (IST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B446FCCF@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,

Can you merge this.

Regards,
Santosh
 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Shilimkar, Santosh
> Sent: Thursday, April 30, 2009 3:15 PM
> To: Jarkko Nikula
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] OMAP: sDMA: Correct the the 
> omap_request_dma_chain() signature
> 
> ________________________________
> 
> From: Jarkko Nikula [mailto:jhnikula@gmail.com] 
> Sent: Thursday, April 30, 2009 3:06 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP: sDMA: Correct the the 
> omap_request_dma_chain() signature
> 
> 
> 
> 	On Thu, Apr 30, 2009 at 12:18 PM, Shilimkar, Santosh 
> <santosh.shilimkar@ti.com> wrote:
> 	
> 
> 		 Yor tow comments....I think I answered 
> both.....Just a correction you comment itself.
> 		
> 
> 		> > You mean callback gets lch instead of 
> chain_id as an argument?
> 		
> 		You mean callback **** returns *** lch instead 
> of chain_id as an argument?
> 		
> 
> 
> 
> 	I mean argument passed to the callback. Callback is 
> void so not returning anything.
> 	
> 	        if (likely(dma_chan[ch].callback != NULL))
> 	                dma_chan[ch].callback(ch, status, 
> dma_chan[ch].data);
> 
> 	My ***return ** was from the dma user point of view and 
> not the fucntion return :). Anyway the point is callback 
> first argument is dma channel nubmer and not chain_id. So 
> User will get the channel number and not chain_id via callback.
> 	
