From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 07/17] OMAP2,3: DSS2: Build omap_device for each DSS
 HWIP
Date: Mon, 3 Jan 2011 17:56:52 -0800
Message-ID: <20110104015652.GY7771@atomide.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
 <1294059069-26737-8-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:36384 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab1ADB5B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 20:57:01 -0500
Content-Disposition: inline
In-Reply-To: <1294059069-26737-8-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org

* Guruswamy Senthilvadivu <svadivu@ti.com> [110103 04:51]:
> +	char *omap2_oh_name[] = { "dss_dss", "dss_dispc", "dss_rfbi",
> +				"dss_venc" };
> +	char *omap3_oh_name[] = { "dss_dss", "dss_dispc", "dss_rfbi",
> +				"dss_venc", "dss_dsi1" };
> +	char *omap2_dev_name[] = { "omap_dss", "omap_dispc", "omap_rfbi",
> +				"omap_venc" };
> +	char *omap3_dev_name[] = { "omap_dss", "omap_dispc", "omap_rfbi",
> +				"omap_venc", "omap_dsi1" };
> +	char *(*oh_name)[];
> +	char *(*dev_name)[];
> +	int oh_count;
> +
> +	if (cpu_is_omap24xx()) {
> +		oh_name = &omap2_oh_name;
> +		dev_name = &omap2_dev_name;
> +		oh_count = ARRAY_SIZE(omap2_oh_name);
> +	} else {
> +		oh_name = &omap3_oh_name;
> +		dev_name = &omap3_dev_name;
> +		oh_count = ARRAY_SIZE(omap3_oh_name);
> +	}

Here it looks like you don't need to repeat the common names
"dss_dss", "dss_dispc", "dss_rfbi". Instead you can have a
common char *omap_oh_name[5] then set oh_count smaller based
on the omap type.

Regards,

Tony
