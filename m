From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCHv2 23/27] OMAPDSS: connector-dvi: Add DT support
Date: Tue, 17 Dec 2013 08:05:52 +0100
Message-ID: <20131217070551.GR24559@pengutronix.de>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
 <1387205794-32246-24-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45945 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab3LQHFx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 02:05:53 -0500
Content-Disposition: inline
In-Reply-To: <1387205794-32246-24-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

Hi Tomi,

On Mon, Dec 16, 2013 at 04:56:30PM +0200, Tomi Valkeinen wrote:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/displays-new/connector-dvi.c | 43 ++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/video/omap2/displays-new/connector-dvi.c b/drivers/video/omap2/displays-new/connector-dvi.c
> index b6c50904038e..d1204b1c5182 100644
>  
> +static const struct of_device_id dvic_of_match[] = {
> +	{ .compatible = "dvi-connector", },

Either the driver is too specific or the binding is too generic, but
having such a generic name for an omap specific driver seems wrong. Same
for panel-dpi, svideo-connector, composite-video-connector and hdmi-connector,

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
