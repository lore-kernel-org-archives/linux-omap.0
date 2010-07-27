From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Issue with file transfers to a mass storage device on SMP system
Date: Tue, 27 Jul 2010 15:05:58 +0800
Message-ID: <AANLkTinmwh3ZetA78xk9B27tq4fgnxN8Qu5pt0TBpuLX@mail.gmail.com>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34679 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab0G0HF7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 03:05:59 -0400
In-Reply-To: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maulik <x0082077@ti.com>
Cc: linux-usb@vger.kernel.org, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

2010/7/27 Maulik <x0082077@ti.com>:
> Hello,
>
> I am working on OMAP4 which has two ARM Cortex A9 microprocessors (SM=
P
> system) with 2.6.35-rc5 kernel.
>
> I have an issue whereby transferring a large file (>20MB) over USB (O=
MAP
> Mentor USB controller acts as USB host) to an attached USB thumb driv=
e
> fails.
>
> The USB analyzer trace shows that the 31 bytes CBW packet is corrupte=
d and
> device responds with a STALL when this issue occurs.
>
> Further it was found that the CBWCB field (the last 16 bytes which co=
ntains
> the command to be executed by the device) of the CBW packet was Zero =
in the
> failure case. Also the first 15 bytes of the CBW packet contained val=
id
> data.
>
> The code snippet below from usb_stor_Bulk_transport () in
> drivers/usb/storage/transport.c looks to be a problem area.
>
> /* copy the command payload */
>
> =A0memset(bcb->CDB, 0, sizeof(bcb->CDB));
> =A0memcpy(bcb->CDB, srb->cmnd, bcb->Length);
>
> Looks like when the issue occurs the memory (bcb->CDB) is not yet upd=
ated
> due to likely out of order execution due to SMP.
>
> I have tried below workarounds that fixes the issue.
>
> (1)Enabling debug prints / adding delays fixes the issue.
> (2)Using nosmp in bootargs i.e. disabling SMP fixes the issue.
> (3)Using wmb() (Write memory barrier) before starting DMA transfer in=
 MUSB
> driver fixes the issue.

Seems it is one solution.

It should be caused by dma_alloc_coherent, which allocated uncached but
buffered coherent buffer, see discussions below:

          http://marc.info/?t=3D127918539100004&r=3D1&w=3D2

> (4)Using wmb() for only 31 bytes CBW packets after the memcpy(in stor=
age
> stack (transport.c)) fixes the issue.
> (5)Checking if last 16 bytes (of the 31 bytes CBW packet) are Zero or=
 not
> after the memcpy() also fixes the issue. i.e if you read back the mem=
ory,
> the memory seems to be updated.
>
> Has anyone seen such issue on a SMP system?
>
> Please comment on the need and the usage of a memory barrier in this =
case.
>
> Thanks,
> Maulik
>



--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
