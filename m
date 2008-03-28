From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAPFB: Check in suspend/resume if framebuffer device
	is initialized.
Date: Fri, 28 Mar 2008 12:40:27 +0200
Message-ID: <20080328104027.GX24896@atomide.com>
References: <1206532689-11902-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65171 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbYC1Kk3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 06:40:29 -0400
Content-Disposition: inline
In-Reply-To: <1206532689-11902-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jouni H=F6gander <jouni.hogander@nokia.com> [080326 13:59]:
> Check wether fbdev is NULL in suspend / resume functions. Fbdev is
> NULL, if there is no lcd or it is not enabled in configuration.

This one is missing Signed-off-by also.

Tony

> ---
>  drivers/video/omap/omapfb_main.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/om=
apfb_main.c
> index f66b81a..139c84c 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -1839,8 +1839,8 @@ static int omapfb_suspend(struct platform_devic=
e *pdev, pm_message_t mesg)
>  {
>  	struct omapfb_device *fbdev =3D platform_get_drvdata(pdev);
> =20
> -	omapfb_blank(VESA_POWERDOWN, fbdev->fb_info[0]);
> -
> +	if (fbdev !=3D NULL)
> +		omapfb_blank(VESA_POWERDOWN, fbdev->fb_info[0]);
>  	return 0;
>  }
> =20
> @@ -1849,7 +1849,8 @@ static int omapfb_resume(struct platform_device=
 *pdev)
>  {
>  	struct omapfb_device *fbdev =3D platform_get_drvdata(pdev);
> =20
> -	omapfb_blank(VESA_NO_BLANKING, fbdev->fb_info[0]);
> +	if (fbdev !=3D NULL)
> +		omapfb_blank(VESA_NO_BLANKING, fbdev->fb_info[0]);
>  	return 0;
>  }
> =20
> --=20
> 1.5.3.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
