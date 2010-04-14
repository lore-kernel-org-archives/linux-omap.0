From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] nand support on omap3 boards
Date: Wed, 14 Apr 2010 10:05:05 +0530
Message-ID: <t2hce9ab5791004132135j73583ea2n172704b5ed33dcec@mail.gmail.com>
References: <s-ghorai@ti.com> <1271180246-31779-2-git-send-email-s-ghorai@ti.com>
	<1271180246-31779-3-git-send-email-s-ghorai@ti.com> <1271180246-31779-4-git-send-email-s-ghorai@ti.com>
	<1271180246-31779-5-git-send-email-s-ghorai@ti.com> <1271180246-31779-6-git-send-email-s-ghorai@ti.com>
	<1271180246-31779-7-git-send-email-s-ghorai@ti.com> <1271180246-31779-8-git-send-email-s-ghorai@ti.com>
	<1271180246-31779-9-git-send-email-s-ghorai@ti.com> <1271180246-31779-10-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46529 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab0DNEf1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 00:35:27 -0400
Received: by bwz19 with SMTP id 19so253906bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 13 Apr 2010 21:35:25 -0700 (PDT)
In-Reply-To: <1271180246-31779-10-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org

You post this mail in previous thread. Do not do that. ($SUBJECT is
same as last one).
Post it in different thread.

And why this is not posted as a series?
In fact these patches should be posted in two set of patches:
1. patches related to IRQ mode support
2. patches related ROM code ecc layout

And IMHO, these patches should in revers order:
> =A0omap: NAND: ecc layout select from board file
> =A0omap: NAND: Making ecc layout as compatible with romcode ecc

One more thing all these patches should also be posted to MTD list. In
fact, most of these patches should go through mtd tree itself.

--=20
Regards,
Vimal Singh



On Tue, Apr 13, 2010 at 11:07 PM, Sukumar Ghorai <s-ghorai@ti.com> wrot=
e:
> =A0 The following set of patches applies on top of the Tony's master =
branch.
> =A0 And dependency on following series of patch -
>
>
> Sukumar Ghorai (3):
> =A0omap3: GPMC register definition at common location
> =A0omap3: NAND Prefetch in IRQ mode support
> =A0omap-3630 NAND: enable NAND io in prefetch-irq mode
> =A0omap: NAND: ecc layout select from board file
> =A0omap: NAND: Making ecc layout as compatible with romcode ecc
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
