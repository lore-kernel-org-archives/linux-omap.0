Return-Path: <SRS0=bNu4=EP=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883E5C2D0A3
	for <linux-omap@archiver.kernel.org>; Mon,  9 Nov 2020 10:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B83C2080C
	for <linux-omap@archiver.kernel.org>; Mon,  9 Nov 2020 10:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mewQUYVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgKIKuY (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:50:24 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:40964 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgKIKuY (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2020 05:50:24 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56E6CB2B;
        Mon,  9 Nov 2020 11:50:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1604919022;
        bh=GnoUeQgbf+aZv8fknGUgGHYuTFNpR2waFnJSIlAk5ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mewQUYVUd9mjm/JUSnIsWHUJBaE2DXd7m2QGwjS5AvF2MQzSKoXfQdugNqCpUFvCi
         rJIn4HaZ70mMzFXBRe5kdCX52Hs0b0OV4ytBWMBb4d+c5px/EDNrRc25fK5jgIvUlw
         CA6GR/oD8PkODgXjWh+tT34QFM229LcbgqBJUtbg=
Date:   Mon, 9 Nov 2020 12:50:18 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v3 38/56] drm/omap: panel-dsi-cm: fix remove()
Message-ID: <20201109105018.GI6029@pendragon.ideasonboard.com>
References: <20201105120333.947408-1-tomi.valkeinen@ti.com>
 <20201105120333.947408-39-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201105120333.947408-39-tomi.valkeinen@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi Tomi and Sebastian,

Thank you for the patch.

On Thu, Nov 05, 2020 at 02:03:15PM +0200, Tomi Valkeinen wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Do not try to reset the panel after DSI has been
> detached, since the DSI clocks may have been disabled
> at this point. The panel will be disabled and unprepared
> before being removed and a reset will be done when being
> probed again.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> index 086c7d71fe17..795db22d148d 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> @@ -622,9 +622,6 @@ static int dsicm_remove(struct mipi_dsi_device *dsi)
>  	if (ddata->extbldev)
>  		put_device(&ddata->extbldev->dev);
>  
> -	/* reset, to be sure that the panel is in a valid state */
> -	dsicm_hw_reset(ddata);
> -
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
