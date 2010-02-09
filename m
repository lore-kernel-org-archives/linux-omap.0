From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: OMAP3 Slave McSPI driver
Date: Tue, 9 Feb 2010 18:28:37 +0530
Message-ID: <00f001caa987$9981cc20$LocalHost@wipblrx0099946>
References: <74583B8642AB8841B30447520659FCA9E782241C@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56262 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513Ab0BIM6w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Feb 2010 07:58:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Talis, Gilles" <g-talis@ti.com>, linux-omap@vger.kernel.org
Cc: spi-devel-general@lists.sourceforge.net

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

