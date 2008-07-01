From: "Kyungmin Park" <kmpark@infradead.org>
Subject: Re: [PATCH] MTD: OMAP2-NAND: Fix partition reading from board info
Date: Wed, 2 Jul 2008 08:27:02 +0900
Message-ID: <9c9fda240807011627v60428f9eh3c2bb17cdc8ce6ea@mail.gmail.com>
References: <DFEF307E035C8647B119E6A60DB62D4AE47475F8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:62464 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758614AbYGAX1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 19:27:05 -0400
Received: by py-out-1112.google.com with SMTP id p76so84193pyb.10
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2008 16:27:03 -0700 (PDT)
In-Reply-To: <DFEF307E035C8647B119E6A60DB62D4AE47475F8@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kamat, Nishant" <nskamat@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi,

It's should be sent to MTD list. and we also fix the NOR similar ways.
It's already posted but not committed.

Thank you,
Kyungmin Park

On Tue, Jul 1, 2008 at 11:32 PM, Kamat, Nishant <nskamat@ti.com> wrote:
>
> From: Nishant Kamat <nskamat@ti.com>
>
> MTD: OMAP2-NAND: Fix partition reading from board info
>
> The parse_mtd_partitions() function no longer returns
> a negative error in case cmdline is not passed.
> See commit: b0d06afb607
>
> Signed-off-by: Nishant Kamat <nskamat@ti.com>
> ---
>  drivers/mtd/nand/omap2.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-omap-ti.ldp/drivers/mtd/nand/omap2.c
> ===================================================================
> --- linux-omap-ti.ldp.orig/drivers/mtd/nand/omap2.c     2008-06-30 22:01:50.000000000 +0530
> +++ linux-omap-ti.ldp/drivers/mtd/nand/omap2.c  2008-06-30 22:03:34.446471469 +0530
> @@ -699,7 +699,7 @@
>        err = parse_mtd_partitions(&info->mtd, part_probes, &info->parts, 0);
>        if (err > 0)
>                add_mtd_partitions(&info->mtd, info->parts, err);
> -       else if (err < 0 && pdata->parts)
> +       else if (pdata->parts)
>                add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
>        else
>  #endif
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
