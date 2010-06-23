From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] OMAP: DSS2: DMA optimization using scaler line buffers
Date: Wed, 23 Jun 2010 09:40:27 +0200
Message-ID: <4A679826-6BE6-4C52-BAF4-29CA3D5BF7EA@student.utwente.nl>
References: <FF55437E1F14DA4BAEB721A458B6701706BDA5F45D@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:41865 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab0FWHkd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 03:40:33 -0400
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BDA5F45D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nagarajan, Rajkumar" <x0133774@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


Op 23 jun 2010, om 07:18 heeft Nagarajan, Rajkumar het volgende geschreven:

> 
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -552,7 +552,7 @@ static int setup_vrfb_rotation(struct fb_info *fbi)
> 	omap_vrfb_setup(&rg->vrfb, rg->paddr,
> 			var->xres_virtual,
> 			var->yres_virtual,
> -			bytespp, yuv_mode);
> +			bytespp, mode, 0);

Shouldn't that be 'color_mode' instead of 'mode'?

regards,

Koen
