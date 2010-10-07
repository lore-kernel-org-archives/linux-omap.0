From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v1 06/16] OMAP3: hwmod DSS: Build omap_device for each
 DSS HWIP
Date: Thu, 7 Oct 2010 21:30:04 +0200
Message-ID: <20101007213004.178ef60b@surf>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
	<1286363699-9614-2-git-send-email-svadivu@ti.com>
	<1286363699-9614-3-git-send-email-svadivu@ti.com>
	<1286363699-9614-4-git-send-email-svadivu@ti.com>
	<1286363699-9614-5-git-send-email-svadivu@ti.com>
	<1286363699-9614-6-git-send-email-svadivu@ti.com>
	<1286363699-9614-7-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:57578 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab0JGTaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 15:30:17 -0400
In-Reply-To: <1286363699-9614-7-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hello Senthil,

On Wed,  6 Oct 2010 16:44:49 +0530
Guruswamy Senthilvadivu <svadivu@ti.com> wrote:

>  void __init omap_display_init(struct omap_dss_board_info
>  					*board_data)
>  {
> +	struct omap_hwmod *oh;
> +	struct omap_device *od;
> +	int l, i;
> +	struct omap_display_platform_data pdata;
> +	char *oh_name[] = {
> +			"dss_dss",
> +			"dss_dispc",
> +			"dss_dsi1",
> +			"dss_rfbi",
> +			"dss_venc"
> +			};

I think it's more common to write it this way:


        char *oh_name[] = { "dss_dss", "dss_dispc", "dss_dsi1",
                            "dss_rfbi", "dss_venc" };

but I understand that this is just a matter of taste.

> +
> +	for (i = 0; i < ARRAY_SIZE(oh_name); i++) {
> +		l = snprintf(oh_name[i], MAX_OMAP_DSS_HWMOD_NAME_LEN,
> +				 oh_name[i]);
> +		WARN(l >= MAX_OMAP_DSS_HWMOD_NAME_LEN,
> +			"String buffer overflow in DSS device setup\n");

Using snprintf() just to get the length of a string is a bit overkill.
strlen() is part of the kernel API :-)

However, about the name, see below.

> +
> +		oh = omap_hwmod_lookup(oh_name[i]);
> +		if (!oh) {
> +			pr_err("Could not look up %s\n", oh_name[i]);
> +			return ;

No space needed between return and the semi-colon.

> +		}
> +		strncpy(pdata.name, oh_name[i], sizeof(oh_name[i]));

Why do you need this name into the platform_data ? omap_device_build()
will already fill the omap_device->platform_device->name field with
exactly oh_name[i]. So your drivers can just do platform_device->name
to get the name if they need it.

> +		pdata.board_data		=       board_data;
> +		pdata.board_data->get_last_off_on_transaction_id = NULL;
> +		pdata.device_enable    =       omap_device_enable;
> +		pdata.device_idle      =       omap_device_idle;
> +		pdata.device_shutdown  =       omap_device_shutdown;

pdata is defined outside of the loop, so you're passing the same pdata
address to each omap_device_build() call. Therefore, there's no need to
initialize pdata at each iteration of the loop.

> +struct omap_display_platform_data {
> +	char name[MAX_OMAP_DSS_HWMOD_NAME_LEN];
> +	struct omap_dss_board_info *board_data;
> +	int (*device_enable)(struct platform_device *pdev);
> +	int (*device_shutdown)(struct platform_device *pdev);
> +	int (*device_idle)(struct platform_device *pdev);
> +};

I'm probably missing something, but I don't see those new
device_enable, device_shutdown, device_idle fields being used in the
following patches in your series. Did I look at the wrong place ?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
