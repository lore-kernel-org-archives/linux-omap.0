From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 16/33] OMAPDSS: acx565akm panel: handle gpios in panel
 driver
Date: Wed, 13 Feb 2013 19:29:13 +0200
Message-ID: <20130213172913.GD21750@blackmetal.musicnaut.iki.fi>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
 <1360765345-19312-17-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:59639 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760180Ab3BMR3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 12:29:18 -0500
Content-Disposition: inline
In-Reply-To: <1360765345-19312-17-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Wed, Feb 13, 2013 at 07:52:08PM +0530, Archit Taneja wrote:
> +static struct panel_acx565akm_data *get_panel_data(struct omap_dss_device *dssdev)
> +{
> +	return (struct panel_acx565akm_data *) dssdev->data;
> +}
> +
>  static int acx_panel_probe(struct omap_dss_device *dssdev)
>  {
>  	int r;
>  	struct acx565akm_device *md = &acx_dev;
> +	struct panel_acx565akm_data *panel_data = get_panel_data(dssdev);

Why the get_panel_data function is needed, isn't the cast unnecessary?

A.
