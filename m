From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: ARM : OMAP: Pass logical DMA channel number always to callback
 handlers
Date: Wed, 26 Nov 2008 12:11:43 +0200
Message-ID: <20081126121143.f564a966.jarkko.nikula@nokia.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02936BEAED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48006 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbYKZKMJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 05:12:09 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02936BEAED@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 26 Nov 2008 14:43:02 +0530
"ext Shilimkar, Santosh" <santosh.shilimkar@ti.com> wrote:

> Hi Jarkko\Tony ,
> 
> Recently during some debugging, I observed this patch.
> http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commitdiff;h=538528de0cb256f65716ab2e9613d9e920f97fe2;hp=29e8c3c304b62f31b799565c9ee85d42bd163f80
> 
> As per your description,it improves the debugging. Can you elaborate more on this ?
> 
Honestly don't remember what I meant for easier debugging, probably
just watching how the logical channels are rotating during the transfer
or something like that.

> For users this change is little confusing, if they go as per the signatures of the 'omap_request_dma_chain' and 'omap_request_dma' APIs. Also separating the callbacks for chained and non-chained transfers seems to be the practical usage in most of the cases. Also users would be only interested in 'chain_id' and not 'channel number' in case of chaining.  
> 
As commit log says, user can pass the chain_id via callback data if
needed. I think chained dma callback may also find more use for logical
channel number than chain_id e.g. when modifying the transfer
parameters etc.

And uniform, smaller API set is always better than bloated one.


Jarkko
