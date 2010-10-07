From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v4 3/3] OMAP: DSS2: OMAPFB: Allow usage of def_vrfb only
 for omap2,3
Date: Thu, 7 Oct 2010 14:56:12 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404AA21D04F@dbde02.ent.ti.com>
References: <1286442535-28308-1-git-send-email-svadivu@ti.com>
 <1286442535-28308-2-git-send-email-svadivu@ti.com>
 <1286442535-28308-3-git-send-email-svadivu@ti.com>
 <1286442535-28308-4-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50607 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753689Ab0JGJ0U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 05:26:20 -0400
In-Reply-To: <1286442535-28308-4-git-send-email-svadivu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Guruswamy, Senthilvadivu
> Sent: Thursday, October 07, 2010 2:39 PM
> To: tomi.valkeinen@nokia.com; Hiremath, Vaibhav; linux-
> omap@vger.kernel.org
> Cc: Guruswamy, Senthilvadivu
> Subject: [PATCH v4 3/3] OMAP: DSS2: OMAPFB: Allow usage of def_vrfb only
> for omap2,3
> 
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Force def_vrfb to 0 for non omap2, omap3 devices
> 

Can we reword the commit description to something like,

"For Non-VRFB devices/platforms (omap2, omap3 family) force it to the DMA based rotation."

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
> @@ -2128,6 +2128,16 @@ static int omapfb_probe(struct platform_device
> *pdev)
>  		goto err0;
>  	}
> 
> +	/* TODO : Replace cpu check with omap_has_vrfb once HAS_FEATURE
> +	*	 available for OMAP2 and OMAP3
> +	*/

This patch may conflict with Archit HAS_FEATURE patch sets. And if I understand correctly it has almost making it to DSS2 tree.

> +	if (def_vrfb && (!cpu_is_omap24xx()) && (!cpu_is_omap34xx())) {
[Hiremath, Vaibhav] Any way we are forcing to DMA based rotation, then why to check for def_vrfb in the above condition. It can be something

if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
	def_vrfb = 0;
	...
}

Does it make sense to you?

Thanks,
Vaibhav

> +		def_vrfb = 0;
> +		dev_warn(&pdev->dev, "VRFB is not in this device,"
> +				"using DMA for rotation\n");
> +	}
> +
> +
>  	mutex_init(&fbdev->mtx);
> 
>  	fbdev->dev = &pdev->dev;
> --
> 1.6.3.3

