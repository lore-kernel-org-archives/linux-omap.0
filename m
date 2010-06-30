From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP2:OMAPFB: Fix error path
Date: Wed, 30 Jun 2010 11:50:44 +0300
Message-ID: <1277887844.2474.122.camel@tubuntu.research.nokia.com>
References: <AANLkTilje0umiNM2Tn7p2S5xhfEbEhtj6pIuSBMKvShi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37525 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328Ab0F3JKI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 05:10:08 -0400
In-Reply-To: <AANLkTilje0umiNM2Tn7p2S5xhfEbEhtj6pIuSBMKvShi@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Afzal Mohammed <lazfamam@gmail.com>
Cc: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>, "tj@kernel.org" <tj@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

Please send the patch as plaintext, without any HTML content.

Also, use the same patch subject as other patches for omapfb, in this
case "OMAP: DSS2: OMAPFB: ...", and include a bit more verbose
description.

 Tomi


On Tue, 2010-06-29 at 22:29 +0200, ext Afzal Mohammed wrote:
> 
> 
> sysfs file removed in error path of omapfb_create_framebuffers()
> 
> 
> Signed-off-by: Afzal Mohammed <lazfamam@gmail.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-main.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
> b/drivers/video/omap2/omapfb/omapfb-main.c
> index 4b4506d..2319b81 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -1945,6 +1945,7 @@ static int omapfb_create_framebuffers(struct
> omapfb2_device *fbdev)
>   r = omapfb_overlay_enable(ovl, 1);
>  
>   if (r) {
> + omapfb_remove_sysfs(fbdev);
>   dev_err(fbdev->dev,
>   "failed to enable overlay\n");
>   return r;
> -- 
> 1.7.0.4
> 
> 


