From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: OMAP Audio
Date: Wed, 17 Feb 2010 19:45:01 +0200
Message-ID: <20100217194501.7e49ac0c.jhnikula@gmail.com>
References: <4B7AE1AD.7080400@mlbassoc.com>
	<201002171226.05108.peter.ujfalusi@nokia.com>
	<4B7BC86C.8040905@mlbassoc.com>
	<201002171317.27896.peter.ujfalusi@nokia.com>
	<4B7BDAB1.3020503@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50680 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab0BQRjw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 12:39:52 -0500
Received: by ewy19 with SMTP id 19so5873776ewy.21
        for <linux-omap@vger.kernel.org>; Wed, 17 Feb 2010 09:39:50 -0800 (PST)
In-Reply-To: <4B7BDAB1.3020503@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>

On Wed, 17 Feb 2010 05:01:53 -0700
Gary Thomas <gary@mlbassoc.com> wrote:

> > After looking at the TRM of OMAP, the sDMA has support for 8, 16 and 32 bit data
> > types. So I'm not really sure how to configure McBSP and sDMA in case of 24 bit
> > packed format.
> > I would go with a trial and error method and find it out how it is working...
> >
So it looks that the memory representation must be 32-bit.

> How about sending padded data (24 bits in 32) which is what my
> CODEC wants anyway?  Would this be easier to set up?  How?
> 
> (Again, I'm a bit fuzzy on how to tell omap_pcm_prepare that I
> need to be moving 24 or 32 bit chunks)
> 
Internal representation and link configuration are separate things:

DMA <-> McBSP rx/tx reg <- [FIFO] -> McBSP receiver/transmitter

As Peter found, due the DMA and McBSP FIFO, the DMA configuration must
be 32-bit. But I suppose the McBSP receiver/ransmitter could be
configured to transmit only 24-bits.

The OMAP35x Applications Processor Multi-Channel Buffered Serial Port
(McBSP) TRM (SPRUFD1C) seems to have some examples for different data
lengths than internal word length. Worth to look and try with trial and
error method using oscilloscope :-)


-- 
Jarkko
