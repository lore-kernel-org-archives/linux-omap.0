From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/2] McSPI Slave and DMA,FIFO support
Date: Wed, 20 May 2009 11:34:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49CC007@dbde02.ent.ti.com>
References: <54322.10.24.255.18.1242799009.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43615 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbZETGEL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 02:04:11 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4K646W3025856
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 01:04:12 -0500
In-Reply-To: <54322.10.24.255.18.1242799009.squirrel@dbdmail.itg.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "V, Hemanth" <hemanthv@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hemanth,

> Signed-off-by: Hemanth V <hemanthv@ti.com>
>  arch/arm/mach-omap2/devices.c           |    5
>  arch/arm/plat-omap/include/mach/mcspi.h |   16 +
>  drivers/spi/omap2_mcspi.c               |  343 
> ++++++++++++++++++++++++++++----

drivers/spi/omap2_mcspi.c........ This should be separate patch since this has touching drivers directory.

How about arranging this series
[1/2]: OMAP platform specific changes ( arch/arm/plat-omap, arch/arm/mach-omap)
[2/2]: Drivers specific (drivers/spi)


Regards,
Santosh
 

