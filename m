From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 9/9] ASoC: Kconfig: OMAP4: Enable support for
 PandaBoards
Date: Thu, 22 Dec 2011 13:26:59 +0000
Message-ID: <20111222132658.GT4546@opensource.wolfsonmicro.com>
References: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com>
 <1324557768-8216-10-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33392 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751671Ab1LVN1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 08:27:01 -0500
Content-Disposition: inline
In-Reply-To: <1324557768-8216-10-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Thu, Dec 22, 2011 at 02:42:48PM +0200, Peter Ujfalusi wrote:

>  config SND_OMAP_SOC_OMAP_ABE_TWL6040
>  	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
> -	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
> +	depends on TWL4030_CORE && SND_OMAP_SOC
> +	depends on MACH_OMAP_4430SDP || MACH_OMAP4_PANDA

Given that it's now a platform device and there's a reasonable
expectation that there will be lots of other boards derived from this
it'd seem sensible to just remove the machine dependencies so people
don't have to patch the Kconfig.  Otherwise it kind of defeats the point
of making the code generic.
