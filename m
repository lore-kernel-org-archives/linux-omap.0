From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Sat, 3 Dec 2011 11:22:06 +0000
Message-ID: <20111203112206.GE6043@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44837 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754498Ab1LCLWI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Dec 2011 06:22:08 -0500
Content-Disposition: inline
In-Reply-To: <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Fri, Dec 02, 2011 at 11:52:56AM +0200, Peter Ujfalusi wrote:

> @@ -0,0 +1,13 @@
> +* Texas Instruments OMAP4 Digital Microphone Module
> +
> +Required properties:
> +  - compatible : "ti,omap4-dmic"
> +  - ti,hwmods  : List of hwmod names associated with DMIC, in most case
> +		 it is "dmic".

Actually thinking about this some more I think what's concerning me is
the documentation as much as anything else - if it was just an internal,
unpublished interface of the OMAP core code which happened to use device
tree I probably wouldn't have worried about it churning.
