From: "Talis, Gilles" <g-talis@ti.com>
Subject: RE: OMAP3 Slave McSPI driver
Date: Tue, 9 Feb 2010 14:39:28 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9E78226B7@dnce01.ent.ti.com>
References: <74583B8642AB8841B30447520659FCA9E782241C@dnce01.ent.ti.com>
 <00f001caa987$9981cc20$LocalHost@wipblrx0099946>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59034 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754437Ab0BINje convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 08:39:34 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <00f001caa987$9981cc20$LocalHost@wipblrx0099946>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "V, Hemanth" <hemanthv@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>

Thanks Hemanth,

I'll give it a try with 2.6.29 kernel. Do the patches support McSPI RX interrupt? Or McSPI FIFO full interrupt? Upon receipt of such interrupts, slave client could issue a spi_read.

Thanks
gilles


Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----

From: V, Hemanth
Sent: Tuesday, February 09, 2010 1:59 PM
To: Talis, Gilles; linux-omap@vger.kernel.org
Cc: spi-devel-general@lists.sourceforge.net
Subject: Re: OMAP3 Slave McSPI driver

----- Original Message -----
From: "Talis, Gilles" <g-talis@ti.com>
To: <linux-omap@vger.kernel.org>
Sent: Tuesday, February 09, 2010 3:06 PM
Subject: OMAP3 Slave McSPI driver


> Hi,
>
> My customer is using Android 2.6.29 kernel from OMAPZOOM and is looking
> for support for slave mode on the SPI driver.
> I saw there were patches for this feature sent to this list, but I was
> wondering if those patches were tested on 2.6.29.
>

These patches have not been specifically tested on 29 kernel, but you could
give it a shot. Pl also look at the latest patches (V2) posted.

> I am also looking for some kind of API usage guidelines. How to setup the
> slave mode and how is OMAP notified that data have been received from
> external master device? My customer plans to use this driver in interrupt
> mode (no DMA needed).
>

To set any mcspi controller to slave mode, you need to modify
arch/arm/mach-omap2/devices.c file and set mode to OMAP2_MCSPI_SLAVE.

Typically gpio is used by master to notify the slave that it is ready to
transfer data. On gpio interrupt slave client could issue spi_read/spi_write
commands.

Two modes are supported i.e PIO and DMA. Any specific reason not to use DMA
mode.

Thanks
Hemanth

> Thanks
> Gilels.
>
>
>
> Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve
> Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


