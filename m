From: Tony Lindgren <tony@atomide.com>
Subject: Re: DMA example
Date: Wed, 24 Feb 2010 14:52:31 -0800
Message-ID: <20100224225231.GA28173@atomide.com>
References: <4B857F2F.7000201@balister.org>
 <20100224203555.GT28173@atomide.com>
 <4B85A8AD.5060206@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63017 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758042Ab0BXWvb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 17:51:31 -0500
Content-Disposition: inline
In-Reply-To: <4B85A8AD.5060206@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Philip Balister <philip@balister.org> [100224 14:28]:
> On 02/24/2010 12:35 PM, Tony Lindgren wrote:
> >* Philip Balister<philip@balister.org>  [100224 11:31]:
> >>I am trying to setup a dma operation to copy memory from GPMC
> >>address space into RAM. The only examples using the omap-dma api use
> >>hardware triggers.
> >>
> >>When I start a transfer, I end up with a DMA transaction error when
> >>I start the transfer.
> >>
> >>Does anyone have a good example of a software transfer? Currently, I
> >>am tracing the omap dma api to see how things map into the registers
> >>....
> >
> >Enjoy the GPMC timings. I recommend attaching a logic analyzer there
> >to verify the things are right for the key lines if you have chance.
> >
> >Hmm I thought the hardware triggers were optional in at least
> >drivers/usb/musb/tusb6010_omap.c.. Maybe I don't remember correctly.
> 
> GPMC is easy :)

Sounds like you just got lucky! :)
 
> Basically, I have a device attached to a GPMC chip select and I need
> to read/write to it. The GPNC bit is fine, we'd just like to use the
> DMA controller to move the data.

That should work, at least there has been several memory-to-memory
dma test modules posted here over the years. Have you tried using
OMAP_DMA_NO_DEVICE for omap_request_dma? Also search for omap dmatest
or similar.

Tony
