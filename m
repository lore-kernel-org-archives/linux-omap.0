From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 10/10] OMAP4 : HDMI : Add HDMI structure in the
 board file for OMAP4 PANDA
Date: Tue, 15 Mar 2011 09:53:44 +0530
Message-ID: <1300163024.1946.14.camel@lappyti>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299753858-12222-2-git-send-email-mythripk@ti.com>
	 <1299753858-12222-3-git-send-email-mythripk@ti.com>
	 <1299753858-12222-4-git-send-email-mythripk@ti.com>
	 <1299753858-12222-5-git-send-email-mythripk@ti.com>
	 <1299753858-12222-6-git-send-email-mythripk@ti.com>
	 <1299753858-12222-7-git-send-email-mythripk@ti.com>
	 <1299753858-12222-8-git-send-email-mythripk@ti.com>
	 <1299753858-12222-9-git-send-email-mythripk@ti.com>
	 <1299753858-12222-10-git-send-email-mythripk@ti.com>
	 <1299753858-12222-11-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38284 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab1COEXx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 00:23:53 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2F4NolJ016235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 23:23:52 -0500
In-Reply-To: <1299753858-12222-11-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-10 at 04:44 -0600, K, Mythri P wrote:
> Adding  board file structure for display which adds the display
> structure with HDMI as the default driver when the display init
> is called.
> HDMI GPIO configurations are also done in this file.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |   74 ++++++++++++++++++++++++++++++++
>  1 files changed, 74 insertions(+), 0 deletions(-)

<snip>

> +static struct omap_dss_device *sdp4430_dss_devices[] = {
> +	&sdp4430_hdmi_device,
> +};
> +
> +static struct omap_dss_board_info sdp4430_dss_data = {
> +	.num_devices	= ARRAY_SIZE(sdp4430_dss_devices),
> +	.devices	= sdp4430_dss_devices,
> +	.default_device	= &sdp4430_hdmi_device,
> +};
> +
> +void omap_panda_display_init(void)
> +{
> +	sdp4430_hdmi_mux_init();
> +	omap_display_init(&sdp4430_dss_data);
> +}
> +

The sdp4430 structs and functions should be renamed to panda.

 Tomi


