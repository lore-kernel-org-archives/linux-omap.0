From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v3 3/3] DSS2 FB Allow usage of def_vrfb only for omap2,3
Date: Tue, 15 Jun 2010 15:33:04 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703042888F0@dbde02.ent.ti.com>
References: <1276169037-2598-1-git-send-email-svadivu@ti.com>
 <1276169037-2598-2-git-send-email-svadivu@ti.com>
 <1276169037-2598-3-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54343 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756930Ab0FOKDP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jun 2010 06:03:15 -0400
In-Reply-To: <1276169037-2598-3-git-send-email-svadivu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, tony@atomide.com

Tomi, 

> -----Original Message-----
> From: Guruswamy, Senthilvadivu 
> Sent: Thursday, June 10, 2010 4:54 PM
> To: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org; 
> tony@atomide.com; tomi.valkeinen@nokia.com; Hiremath, Vaibhav
> Cc: Guruswamy, Senthilvadivu
> Subject: [PATCH v3 3/3] DSS2 FB Allow usage of def_vrfb only 
> for omap2,3
> 
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Changes since v2:
> 	Added a check to warn the wrong usage of vrfb in 
> non-vrfb omap devices.
> 
> Force def_vrfb to 0 for non omap2, omap3 devices
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-main.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c 
> b/drivers/video/omap2/omapfb/omapfb-main.c
> index 4b4506d..0f79db8 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2128,6 +2128,16 @@ static int omapfb_probe(struct 
> platform_device *pdev)
>  		goto err0;
>  	}
>  
> +	/* TODO : Replace cpu check with omap_has_vrfb once HAS_FEATURE
> +	*	 available for OMAP2 and OMAP3
> +	*/
> +	if (def_vrfb && (!cpu_is_omap24xx()) && (!cpu_is_omap34xx())) {
> +		def_vrfb = 0;
> +		dev_warn(&pdev->dev, "VRFB is not in this device,"
> +				"using DMA for rotation\n");
> +	}
> +
> +
>  	mutex_init(&fbdev->mtx);
>
[Senthil]  All the comments received are incorporated in this v3.
I don't see any more comments on this patch series.  Is it
fine for you to take up this series of patches?
>  	fbdev->dev = &pdev->dev;
> -- 
> 1.6.3.3
> 
> 