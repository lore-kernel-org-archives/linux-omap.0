From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP: sDMA: Correct the the omap_request_dma_chain()
 	signature
Date: Thu, 30 Apr 2009 15:14:40 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B446FCCF@dbde02.ent.ti.com>
References: <1241006956-29268-1-git-send-email-santosh.shilimkar@ti.com>
	 <20090429220804.2d130ceb.jhnikula@gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02B446F94B@dbde02.ent.ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02B446F96B@dbde02.ent.ti.com>
	 <bd7b27490904300146p17cb127asf2013cc3f0840a26@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02B446FC72@dbde02.ent.ti.com>
 <bd7b27490904300236q458b8198x200a976b9941dc10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39093 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbZD3Jot convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 05:44:49 -0400
In-Reply-To: <bd7b27490904300236q458b8198x200a976b9941dc10@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

________________________________

From: Jarkko Nikula [mailto:jhnikula@gmail.com] 
Sent: Thursday, April 30, 2009 3:06 PM
To: Shilimkar, Santosh
Cc: linux-omap@vger.kernel.org
Subject: Re: [PATCH] OMAP: sDMA: Correct the the omap_request_dma_chain() signature



	On Thu, Apr 30, 2009 at 12:18 PM, Shilimkar, Santosh <santosh.shilimkar@ti.com> wrote:
	

		 Yor tow comments....I think I answered both.....Just a correction you comment itself.
		

		> > You mean callback gets lch instead of chain_id as an argument?
		
		You mean callback **** returns *** lch instead of chain_id as an argument?
		



	I mean argument passed to the callback. Callback is void so not returning anything.
	
	        if (likely(dma_chan[ch].callback != NULL))
	                dma_chan[ch].callback(ch, status, dma_chan[ch].data);

	My ***return ** was from the dma user point of view and not the fucntion return :). Anyway the point is callback first argument is dma channel nubmer and not chain_id. So User will get the channel number and not chain_id via callback.
	

