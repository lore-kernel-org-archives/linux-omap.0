From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: [RFC] Change ECC algorithm from userspace
Date: Fri, 28 Oct 2011 11:42:33 +0200
Message-ID: <CAAwP0s059H3BGhYbYLux2gR6ZNb+sFDue676OM2Evz5cA2q6DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46116 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab1J1Jmz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Oct 2011 05:42:55 -0400
Received: by ggnb1 with SMTP id b1so3511124ggn.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Oct 2011 02:42:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Hello,

We've a custom board using an ARM OMAP DM3730 whose ROM boot loader
only supports 1-bit ECC correction using Hamming algorithm.

So, in order to be able to boot from the NAND, we have to configure
the GPMC (OMAP's memory controller that interfaces with NAND devices)
to use 1-bit HW ECC and write the loader binary to the first NAND
sector. That way the ROM boot will take this sector as valid and load
the loader binary to RAM.

The problem is that the SLC NAND device that we are using has a
minimum required ECC of 4-bit correction per each 512 bytes.

I want to be able to use 1-bit ECC for the first partition where I
save the loader binary and has to be accessed by the ROM boot but use
a 4-bit ECC for my rootfs partition.

Does anyone have this same issue?

What is the best approach to store data in a NAND device using
different ECC techniques?

I've think of two approaches:

1- Adding an ioctl to mtdchar (something like ECCSETBITS) to change
the ECC technique used.
2- Use a platform data field to notify the omap2 nand driver that the
ROM boot only supports 1-bit ECC. So it can use a 1-bit ECC to write
and read the first 4 sectors but a 4-bit ECC for the rest.

Of course both approaches can only be used if the none of the nand
memory partitions are mounted.

Thank you and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
