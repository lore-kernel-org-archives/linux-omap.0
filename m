From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 0/3] NAND: OMAP: Fix and clean NAND driver
Date: Mon, 9 Nov 2009 15:45:50 +0530
Message-ID: <ce9ab5790911090215q7a626f8v6159a97dc70265c5@mail.gmail.com>
References: <ce9ab5790910292320x2eef0550pdc3fde5d616ea361@mail.gmail.com>
	<ce9ab5790910300142q6062c47p935ae967955f89f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:40376 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbZKIKQF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 05:16:05 -0500
Received: by fxm21 with SMTP id 21so90068fxm.21
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2009 02:16:10 -0800 (PST)
In-Reply-To: <ce9ab5790910300142q6062c47p935ae967955f89f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

Artem,
I just saw you have taken 2nd patch from this series to your tree .
Could you please be able to maintain this full series?

Tony,
You may want to look into 1st and 2nd patch in this series.

-vimal

On Fri, Oct 30, 2009 at 2:12 PM, Vimal Singh <vimal.newwork@gmail.com> =
wrote:
> Looping Linux-omap mailing list.
>
>
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Fri, 30 Oct 2009 11:34:14 +0530
> Subject: [PATCH 0/3] NAND: OMAP: Fix and clean NAND driver
>
> This patch series addresses some of the issues in omap nand driver.
>
> Vimal Singh (3):
> =A0Fixing compilation warning for 'nand/omap2.c'
> =A0NAND: OMAP: Fixing omap nand driver, compiled as module
> =A0NAND: OMAP: Simplifying HWECC and removing unnecessary macros
>
> =A0drivers/mtd/nand/omap2.c | =A0315 ++++++++++++++++----------------=
--------------
> =A01 files changed, 108 insertions(+), 207 deletions(-)
>
> --
> Regards,
> Vimal Singh
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
