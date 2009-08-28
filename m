From: Tony Lindgren <tony@atomide.com>
Subject: Re: [spi-devel-general] [RESEND][PATCH 0/2] McSPI Slave and DMA ,
	FIFO support
Date: Fri, 28 Aug 2009 09:10:07 -0700
Message-ID: <20090828161007.GL25828@atomide.com>
References: <42120.10.24.255.18.1245765231.squirrel@dbdmail.itg.ti.com> <200907021705.18048.david-b@pacbell.net> <007b01c9fe05$9e5baeb0$LocalHost@wipultra793> <200908272242.20636.david-b@pacbell.net> <060601ca27d7$d2a87df0$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56580 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZH1QKL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 12:10:11 -0400
Content-Disposition: inline
In-Reply-To: <060601ca27d7$d2a87df0$LocalHost@wipultra793>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: David Brownell <david-b@pacbell.net>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

* Hemanth V <hemanthv@ti.com> [090828 05:05]:
> ---- Original Message ----- From: "David Brownell" <david-b@pacbell.net>
>
>
>> On Sunday 05 July 2009, Hemanth V wrote:
>>> Do you see any major changes required to support
>>> slave mode in the SPI core driver.
>>
>> There *is* no such thing as a "SPI core driver"...
>>
> I was referring to
>
> spi.c - SPI init/core code
>
>>
>>> We are able to use the existing interface for slave mode also, but
>>> some APIs/ Structures could be made generic.
>>
>> Three things are obvious:
>>
>> - A spi_master is not a slave side driver!
>
> Yes a more generic or new structure would be good,
> but the current one does work for slave mode also.
>
>>
>> - Control model would need to be inverted
>>    * Chip select would be one input,
>>      not N outputs
>>    * No clock rate controls at all
>
> Conditional checks for slave/master mode have been added in
> the driver where required.
>
>>    * latency issues ... driver can't necessarily
>>      respond quickly enough to guarantee no data
>>      loss (FIFOs help)
>
> We currently support both FIFO and DMA for
> slave mode
>
>>    * Can't re-use /dev/spidev*
>>    * Request queue would have a very different role
>>
>> - Some primitives are likely missing, for flow
>>   control (when hardware has a READY handshake)
>>
>> I think a few proposals for how to handle slave
>> side have been circulated.
>
> So would it be possible to merge the slave support also for
> now, and could be modified to support the new slave interface
> as and when available.

In general it's not good to merge half implemented patches.

That's because it usually means that the work on getting
things cleaned up stops right there.

And then the community is left to deal with the mess.

So I recommend doing it clean from the start rather than
merging in hacks.

Tony
