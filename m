From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: RE: [PATCH] da8xx: Fix revision check on the da8xx driver
Date: Wed, 31 Oct 2012 03:51:35 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3E9E10D6@DBDE01.ent.ti.com>
References: <1351698984-4007-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351698984-4007-1-git-send-email-panto@antoniou-consulting.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, "Porter, Matt" <mporter@ti.com>, "Dill, Russ" <russ.dill@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 31, 2012 at 21:26:24, Pantelis Antoniou wrote:
> The revision check fails for the beaglebone; Add new revision ID.
> 
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> ---
>  drivers/video/da8xx-fb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 80665f6..866d804 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -1283,6 +1283,7 @@ static int __devinit fb_probe(struct platform_device *device)
>  		lcd_revision = LCD_VERSION_1;
>  		break;
>  	case 0x4F200800:
> +	case 0x4F201000:

Thanks for Correcting. This is the LCDC revision on am335x silicon in comparison
with to one read(0x4F200800) on emulator platform.

Acked-by: Manjunathappa, Prakash <prakash.pm@ti.com>

>  		lcd_revision = LCD_VERSION_2;
>  		break;
>  	default:
> -- 
> 1.7.12
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
