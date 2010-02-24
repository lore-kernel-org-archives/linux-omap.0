From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: DMA example
Date: Thu, 25 Feb 2010 02:18:43 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C42E1C4B@dbde02.ent.ti.com>
References: <4B857F2F.7000201@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34132 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758041Ab0BXUsx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 15:48:53 -0500
In-Reply-To: <4B857F2F.7000201@balister.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Philip
> Balister
> Sent: Thursday, February 25, 2010 1:04 AM
> To: linux-omap@vger.kernel.org
> Subject: DMA example
> 
> I am trying to setup a dma operation to copy memory from GPMC address
> space into RAM. The only examples using the omap-dma api use hardware
> triggers.
> 
What you mean by GPMC address space. Are you trying to DMA data from NAND/NOR
to SDRAM/SRAM ?

> When I start a transfer, I end up with a DMA transaction error when I
> start the transfer.
> 
> Does anyone have a good example of a software transfer? Currently, I am
> tracing the omap dma api to see how things map into the registers ....
> 
> Philip
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
