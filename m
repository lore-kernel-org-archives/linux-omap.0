From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: UbiFS + HWECC(?) + BeagleBoard = fail
Date: Mon, 8 Nov 2010 13:08:44 +0200
Message-ID: <AANLkTino2WosBuZ8gucNR1NQwJFQHQvKnrX1AeFKdAfc@mail.gmail.com>
References: <87iq09wpi0.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60963 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab0KHLIp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 06:08:45 -0500
Received: by vws13 with SMTP id 13so1611985vws.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 03:08:44 -0800 (PST)
In-Reply-To: <87iq09wpi0.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "[AvataR]" <public.avatar@gmail.com>
Cc: linux-omap@vger.kernel.org, Sukumar Ghorai <s-ghorai@ti.com>

On Sun, Nov 7, 2010 at 9:40 AM, [AvataR] <public.avatar@gmail.com> wrote:
> Hi. After moving to upstream 2.6.3{5,6,7} kernels, i forced to use jffs2
> instead of ubifs, because of lot CRC errors. If i use prefetch/dma, i
> can attach to ubi, make volume, write data, reboot - and got lots of CRC
> errors. Without prefetch i just couldn't do anything to ubi.
>
> Looks like hw/sw bug in ubi

Looks like Sukumar's recent changes broke subpage reads that are
needed for UBI to operate. You can try commenting out #define
CONFIG_MTD_NAND_OMAP_HWECC in drivers/mtd/nand/omap2.c and disabling
MTD_NAND_OMAP_PREFETCH, with that it mostly works for me but sometimes
spits out ECC error or two.
