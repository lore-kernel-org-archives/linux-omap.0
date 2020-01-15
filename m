From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] OMAP: DSS2: remove non-zero check on variable r
Date: Wed, 15 Jan 2020 16:42:40 +0100
Message-ID: <6a3951c7-4b17-6371-24ab-17742aeaa464@samsung.com>
References: <CGME20191204152851epcas5p413006712eafa500de3013c2ce8a3bc02@epcas5p4.samsung.com>
        <20191204152847.1435188-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33030 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbgAOPmo (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jan 2020 10:42:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200115154242euoutp02691bfe8290c8baa1dc885c1ab318e713~qGccl6DIi1726017260euoutp02S
        for <linux-omap@vger.kernel.org>; Wed, 15 Jan 2020 15:42:42 +0000 (GMT)
In-Reply-To: <20191204152847.1435188-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org


On 12/4/19 4:28 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable r is being initialized to zero, so the check of a non-zero
> rv is redundant and can be removed.
> 
> It appears that the previous case statements set r to be -EINVAL
> and the "Fallthrough" comment afterwards suggested it was going
> to fall through to this non-zero check but won't because of the
> break statement. Remove the confusion by removing the Fallthrough
> comment too.
> 
> Addresses-Coverity: ("Logically dead code")
> Fixes: b39a982ddecf ("OMAP: DSS2: omapfb driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for v5.6, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> index 858c2c011d19..a2a2c1b205d9 100644
> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> @@ -1154,16 +1154,12 @@ static int _setcolreg(struct fb_info *fbi, u_int regno, u_int red, u_int green,
>  		   r = fbdev->ctrl->setcolreg(regno, red, green, blue,
>  		   transp, update_hw_pal);
>  		   */
> -		/* Fallthrough */
>  		r = -EINVAL;
>  		break;
>  	case OMAPFB_COLOR_RGB565:
>  	case OMAPFB_COLOR_RGB444:
>  	case OMAPFB_COLOR_RGB24P:
>  	case OMAPFB_COLOR_RGB24U:
> -		if (r != 0)
> -			break;
> -
>  		if (regno < 16) {
>  			u32 pal;
>  			pal = ((red >> (16 - var->red.length)) <<
> 
