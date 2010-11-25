From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] enabled vdda_dac regulator support tvout on rx51
Date: Thu, 25 Nov 2010 16:11:12 +0000
Message-ID: <20101125161112.GB15099@sirena.org.uk>
References: <1290700343-26640-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com> <1290700343-26640-2-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:33493 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab0KYQLT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 11:11:19 -0500
Content-Disposition: inline
In-Reply-To: <1290700343-26640-2-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, Nov 25, 2010 at 05:52:23PM +0200, Srikar wrote:

> +static struct regulator_consumer_supply rx51_vdac_supply[] = {
> +	{
> +#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)

The ifdefs here aren't really saving much...

> +		.supply	= "vdda_dac",
> +		.dev	= &rx51_display_device.dev,

dev_name is preferred, though I'm not sure if we'll ever get round to
phasing out plain dev.
