From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH 1/2] McSPI Slave and DMA,FIFO support
Date: Wed, 20 May 2009 11:36:56 +0530
Message-ID: <006c01c9d911$2edc9810$LocalHost@wipultra793>
References: <54322.10.24.255.18.1242799009.squirrel@dbdmail.itg.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B49CC007@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34126 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbZETGHH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 02:07:07 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4K670tk002574
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 01:07:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

Santosh,

----- Original Message ----- 
From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
To: "V, Hemanth" <hemanthv@ti.com>; <linux-omap@vger.kernel.org>
Sent: Wednesday, May 20, 2009 11:34 AM
Subject: RE: [PATCH 1/2] McSPI Slave and DMA,FIFO support



Hemanth,

> Signed-off-by: Hemanth V <hemanthv@ti.com>
>  arch/arm/mach-omap2/devices.c           |    5
>  arch/arm/plat-omap/include/mach/mcspi.h |   16 +
>  drivers/spi/omap2_mcspi.c               |  343
> ++++++++++++++++++++++++++++----

>> drivers/spi/omap2_mcspi.c........ This should be separate patch since 
>> this has touching drivers directory.

It would break compililation of the patch




