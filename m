From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [spi-devel-general] [RESEND][PATCH 0/2] McSPI Slave and DMA , FIFO support
Date: Fri, 28 Aug 2009 17:35:21 +0530
Message-ID: <060601ca27d7$d2a87df0$LocalHost@wipultra793>
References: <42120.10.24.255.18.1245765231.squirrel@dbdmail.itg.ti.com> <200907021705.18048.david-b@pacbell.net> <007b01c9fe05$9e5baeb0$LocalHost@wipultra793> <200908272242.20636.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44642 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbZH1MFk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 08:05:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, spi-devel-general@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org

---- Original Message ----- 
From: "David Brownell" <david-b@pacbell.net>


> On Sunday 05 July 2009, Hemanth V wrote:
>> Do you see any major changes required to support
>> slave mode in the SPI core driver.
> 
> There *is* no such thing as a "SPI core driver"...
> 
I was referring to

spi.c - SPI init/core code

> 
>> We are able to 
>> use the existing interface for slave mode also, but
>> some APIs/ Structures could be made generic.
> 
> Three things are obvious:
> 
> - A spi_master is not a slave side driver!

Yes a more generic or new structure would be good,
but the current one does work for slave mode also.

> 
> - Control model would need to be inverted
>    * Chip select would be one input,
>      not N outputs
>    * No clock rate controls at all

Conditional checks for slave/master mode have been added in
the driver where required.

>    * latency issues ... driver can't necessarily
>      respond quickly enough to guarantee no data
>      loss (FIFOs help)

We currently support both FIFO and DMA for
slave mode

>    * Can't re-use /dev/spidev*
>    * Request queue would have a very different role
> 
> - Some primitives are likely missing, for flow
>   control (when hardware has a READY handshake)
> 
> I think a few proposals for how to handle slave
> side have been circulated.

So would it be possible to merge the slave support also for
now, and could be modified to support the new slave interface
as and when available.

