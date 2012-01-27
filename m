From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH RFC 1/2] mtd : Prevent the NULL pointer access
Date: Fri, 27 Jan 2012 11:08:01 -0800
Message-ID: <CAN8TOE9a=OUcs-37RtDJE6ig-aZdFkSmfOrzL2PAyEgbQ+dJjw@mail.gmail.com>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
	<1327306361-9803-2-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64967 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab2A0TID convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 14:08:03 -0500
Received: by werb13 with SMTP id b13so1510421wer.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jan 2012 11:08:01 -0800 (PST)
In-Reply-To: <1327306361-9803-2-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Artem Bityutskiy <dedekind1@gmail.com>, David Woodhouse <dwmw2@infradead.org>

On Mon, Jan 23, 2012 at 12:12 AM, Shubhrajyoti D <shubhrajyoti@ti.com> =
wrote:
> This patch intends to fix the null pointer access.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> =A0drivers/mtd/mtdcore.c | =A0 =A05 +++--
> =A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 6ae9ca0..2b3bda7 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -118,8 +118,9 @@ static void mtd_release(struct device *dev)
> =A0static int mtd_cls_suspend(struct device *dev, pm_message_t state)
> =A0{
> =A0 =A0 =A0 =A0struct mtd_info *mtd =3D dev_get_drvdata(dev);
> -
> - =A0 =A0 =A0 return mtd_suspend(mtd);
> + =A0 =A0 =A0 if (mtd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mtd_suspend(mtd);
> + =A0 =A0 =A0 return 0;
> =A0}
>
> =A0static int mtd_cls_resume(struct device *dev)

=46orgot this patch was here; this fix is also covered in
l2-mtd-2.6.git, waiting for inclusion in the 3.3-rcX release cycle.
Thanks for the work though!

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
