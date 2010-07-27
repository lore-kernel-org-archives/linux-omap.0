From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: Issue with file transfers to a mass storage device on SMP system
Date: Tue, 27 Jul 2010 15:08:54 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43046 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab0G0JjC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 05:39:02 -0400
In-Reply-To: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mankad, Maulik Ojas" <x0082077@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Mankad, Maulik Ojas
> Sent: Tuesday, July 27, 2010 12:05 PM
> To: linux-usb@vger.kernel.org
> Cc: Shilimkar, Santosh; linux-arm-kernel@lists.infradead.org; linux-
> omap@vger.kernel.org
> Subject: Issue with file transfers to a mass storage device on SMP system
> 
> Hello,
> 
> I am working on OMAP4 which has two ARM Cortex A9 microprocessors (SMP
> system) with 2.6.35-rc5 kernel.
> 
> I have an issue whereby transferring a large file (>20MB) over USB (OMAP
> Mentor USB controller acts as USB host) to an attached USB thumb drive
> fails.
> 
> The USB analyzer trace shows that the 31 bytes CBW packet is corrupted and
> device responds with a STALL when this issue occurs.
> 
> Further it was found that the CBWCB field (the last 16 bytes which
> contains
> the command to be executed by the device) of the CBW packet was Zero in
> the
> failure case. Also the first 15 bytes of the CBW packet contained valid
> data.
> 
> The code snippet below from usb_stor_Bulk_transport () in
> drivers/usb/storage/transport.c looks to be a problem area.
> 
> /* copy the command payload */
> 
>  memset(bcb->CDB, 0, sizeof(bcb->CDB));
>  memcpy(bcb->CDB, srb->cmnd, bcb->Length);
> 
> Looks like when the issue occurs the memory (bcb->CDB) is not yet updated
> due to likely out of order execution due to SMP.
> 
As discussed, the main reason is the cache maintenance isn't done on
 "bcb->CDB"  buffers and hence the data remains in CPU write buffer instead of the physical memory on which DMA operates. 
In working scenario's, there might be a barrier in the path which is helping
you.

Regards,
Santosh
