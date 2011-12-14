From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/10] include: platform_data: Platform data header for
 OMAP4 ASoC audio
Date: Wed, 14 Dec 2011 17:57:47 +0800
Message-ID: <20111214095745.GD3072@opensource.wolfsonmicro.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
 <1323856022-24053-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43065 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753673Ab1LNJ5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 04:57:52 -0500
Content-Disposition: inline
In-Reply-To: <1323856022-24053-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Wed, Dec 14, 2011 at 11:46:57AM +0200, Peter Ujfalusi wrote:

> +enum board_type {
> +	OMAP_ABE_TWL6040_SDP4430,
> +	OMAP_ABE_TWL6040_PANDA,
> +	OMAP_ABE_TWL6040_PANDA_ES,
> +};

It seems like it might better in the long run to make this feature based
rather than enumerating the individual boards - that means that if
boards mix and match the features or add features on the side of
additional designs (eg, external amplifiers that need power control)
it's easier to scale the options.
