From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Fri, 2 Dec 2011 12:25:58 +0000
Message-ID: <20111202122558.GM8245@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55503 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754341Ab1LBM0A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 07:26:00 -0500
Content-Disposition: inline
In-Reply-To: <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Fri, Dec 02, 2011 at 11:52:56AM +0200, Peter Ujfalusi wrote:

> +Required properties:
> +  - compatible : "ti,omap4-dmic"
> +  - ti,hwmods  : List of hwmod names associated with DMIC, in most case
> +		 it is "dmic".

Shouldn't there also be a regs property giving the register window?
