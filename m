From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 6/9] OMAP4 : DSS2 : HDMI: HDMI panel driver addition
 in the DSS
Date: Mon, 7 Mar 2011 12:12:05 +0200
Message-ID: <1299492725.2281.154.camel@deskari>
References: <1299224907-11354-1-git-send-email-mythripk@ti.com>
	 <1299224907-11354-7-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49563 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753600Ab1CGKMQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 05:12:16 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p27ACGtb008998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 04:12:16 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p27ACFY6006917
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 04:12:15 -0600 (CST)
In-Reply-To: <1299224907-11354-7-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-03-04 at 01:48 -0600, K, Mythri P wrote:
> The panel driver(hdmi_omap4_panel.c) in omap2/dss acts as a controller
> to manage the enable and disable requests and synchronize audio and video.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/Kconfig            |    8 +
>  drivers/video/omap2/dss/Makefile           |    1 +
>  drivers/video/omap2/dss/hdmi_omap4_panel.c |  206 ++++++++++++++++++++++++++++
>  3 files changed, 215 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/hdmi_omap4_panel.c
> 
<snip>

> +static int hdmi_panel_suspend(struct omap_dss_device *dssdev)
> +{
> +	int r = 0;
> +
> +	mutex_lock(&hdmi.hdmi_lock);
> +
> +	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
> +			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED) {

Here you could check if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)

> +		r = -EINVAL;
> +		goto err;
> +	}
> +
> +	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
> +
> +	omapdss_hdmi_display_disable(dssdev);
> +
> +err:
> +	mutex_unlock(&hdmi.hdmi_lock);
> +
> +	return r;
> +}
> +
> +static int hdmi_panel_resume(struct omap_dss_device *dssdev)
> +{
> +	int r = 0;
> +
> +	mutex_lock(&hdmi.hdmi_lock);
> +
> +	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {

Here you should check if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED)

 Tomi


