From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: Multiple NAND flash chips on OMAP3
Date: Fri, 8 Jul 2011 16:44:03 +0300
Message-ID: <CANOLnOOyk0ztr-Wp4OjYm6pjjrqMYzaQMDuu3-U9dO-0m=PhNQ@mail.gmail.com>
References: <5448984682E7954C9BFF27F747A9C6CA4EAC62@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48811 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab1GHNoE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 09:44:04 -0400
Received: by iyb12 with SMTP id 12so1782760iyb.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 06:44:04 -0700 (PDT)
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA4EAC62@dolphin.TIGRIS.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, Jul 6, 2011 at 11:05 AM, Maximilian Schwerin
<Maximilian.Schwerin@tigris.de> wrote:
> I'm currently working on a beagleboard clone that has two NAND chips =
on
> OMAP3 CS0 and CS1. The flash on CS0 works as expected. What would be =
the
> correct way to get both chips to work?

You need to add another gpmc_nand_device in
arch/arm/mach-omap2/gpmc-nand.c with id 1 and fill it's
=2Edev.platform_data correctly.

If you plan to do a patch for mainline, it's probably best to make
gpmc_nand_init() to take an array of omap_nand_platform_data
structures and patch it to do platform_device_alloc() /
platform_device_register() for each one of them, dropping global
gpmc_nand_device.

>
> Thanks, Maximilian
>
--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
