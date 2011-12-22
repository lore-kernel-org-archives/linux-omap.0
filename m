From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 7/9] ASoC: omap-abe-twl6040: Configure card according
 to platform data
Date: Thu, 22 Dec 2011 13:08:38 +0000
Message-ID: <20111222130838.GR4546@opensource.wolfsonmicro.com>
References: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com>
 <1324557768-8216-8-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48315 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403Ab1LVNIl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 08:08:41 -0500
Content-Disposition: inline
In-Reply-To: <1324557768-8216-8-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Thu, Dec 22, 2011 at 02:42:46PM +0200, Peter Ujfalusi wrote:

> +#define twl6040_disconnect_pin(dapm, connected, pin)	\
> +	if (!connected)					\
> +		snd_soc_dapm_disable_pin(dapm, pin);
> +

This should be a function for legibility and type safety.
