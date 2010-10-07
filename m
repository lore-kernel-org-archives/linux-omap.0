From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v5 3/3] OMAP: DSS2: OMAPFB: Allow usage of def_vrfb
 only for omap2,3
Date: Thu, 07 Oct 2010 16:00:23 +0300
Message-ID: <1286456423.28499.1057.camel@tubuntu.research.nokia.com>
References: <1286450155-1460-1-git-send-email-svadivu@ti.com>
	 <1286450155-1460-2-git-send-email-svadivu@ti.com>
	 <1286450155-1460-3-git-send-email-svadivu@ti.com>
	 <1286450155-1460-4-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:21023 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760523Ab0JGNA2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 09:00:28 -0400
In-Reply-To: <1286450155-1460-4-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: "hvaibhav@ti.com" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-10-07 at 13:15 +0200, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> For Non-VRFB devices/platforms (omap2, omap3 family) force it to the
> DMA based rotation.

This sounds a bit confusing, as if omap2 and omap3 are Non-VRFB devices.

And I'm not sure it's exactly correct to say "forcing to DMA rotation".
We're just disallowing the use of VRFB, not forcing to use DMA rotation.
Of course DMA rotation is currently the only other option, but still.

I'd put it:

VRFB is supported on OMAP2 and OMAP3 platforms. If VRFB rotation is not
supported by the hardware and the user requests VRFB rotation, print a
warning and ignore the request from the user.

> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-main.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
> index bddfca6..fcd9038 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2198,6 +2198,16 @@ static int omapfb_probe(struct platform_device *pdev)
>  		goto err0;
>  	}
>  
> +	/* TODO : Replace cpu check with omap_has_vrfb once HAS_FEATURE
> +	*	 available for OMAP2 and OMAP3
> +	*/
> +	if (def_vrfb && (!cpu_is_omap24xx()) && (!cpu_is_omap34xx())) {

The parenthesis are extra around !cpu_is_xxxx calls.

> +		def_vrfb = 0;
> +		dev_warn(&pdev->dev, "VRFB is not in this device,"
> +				"using DMA for rotation\n");

How about: "VRFB is not supported by the hardware, ignoring vrfb=y
module parameter".

Otherwise I think the patch set is ok. If you're fine with these
changes, I can make them while applying these to my tree. Or send a new
patch set, both are fine for me.

 Tomi


