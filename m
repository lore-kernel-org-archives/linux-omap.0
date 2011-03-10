From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 6/9] OMAP4 : DSS2 : HDMI: HDMI panel driver addition
 in the DSS
Date: Thu, 10 Mar 2011 09:52:53 +0200
Message-ID: <1299743573.2017.16.camel@deskari>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	 <1299671118-20839-2-git-send-email-mythripk@ti.com>
	 <1299671118-20839-3-git-send-email-mythripk@ti.com>
	 <1299671118-20839-4-git-send-email-mythripk@ti.com>
	 <1299671118-20839-5-git-send-email-mythripk@ti.com>
	 <1299671118-20839-6-git-send-email-mythripk@ti.com>
	 <1299671118-20839-7-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37213 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754Ab1CJHw5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 02:52:57 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2A7quVS013399
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 01:52:56 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p2A7quQS006597
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 01:52:56 -0600 (CST)
In-Reply-To: <1299671118-20839-7-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2011-03-09 at 05:45 -0600, K, Mythri P wrote:
> The panel driver(hdmi_omap4_panel.c) in omap2/dss acts as a controller
> to manage the enable and disable requests and synchronize audio and video.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>

<snip>

> +static int hdmi_panel_probe(struct omap_dss_device *dssdev)
> +{
> +	DSSDBG("ENTER hdmi_panel_probe\n");
> +
> +	dssdev->panel.config = OMAP_DSS_LCD_TFT |
> +			OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
> +
> +	/*
> +	 * Initialize the timings to 1920 * 1080
> +	 * This is only for framebuffer update not for TV timing setting
> +	 * Setting TV timing will be done only on enable
> +	 */
> +	dssdev->panel.timings.x_res = 1920;
> +	dssdev->panel.timings.y_res = 1080;

This will cause the framebuffer to be initialized to 1920x1080,
regardless of the timings the hdmi driver will select.

I think you should either probe the display here to find what it
supports, and initialize the size accordingly, or if the display is not
connected, use some safe resolution most of the displays should support.
VGA probably.

And the timings selected here should also be used by the hdmi driver.
What happens now with my monitor is that I get a fb of 1920x1028, but
the hdmi driver doesn't like the modes my monitor gives via EDID, and
falls back to VGA -> messed up display.

Also, I'm getting "timeout waiting for EVSYNC" when I load or unload the
driver.

 Tomi


