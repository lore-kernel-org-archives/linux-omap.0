From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Mon, 10 Nov 2008 12:36:56 +0200
Message-ID: <6ed0b2680811100236m203939c9u521d2e1edea40f91@mail.gmail.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com>
	 <20081106170445.GU21736@atomide.com>
	 <6ed0b2680811061219p40439337h2a6938009aa20522@mail.gmail.com>
	 <200811062154.08843.david-b@pacbell.net>
	 <6ed0b2680811070136m44b385cftf654c05cd9076798@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.178]:39438 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbYKJKg6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 05:36:58 -0500
Received: by ik-out-1112.google.com with SMTP id c29so1844461ika.5
        for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 02:36:56 -0800 (PST)
In-Reply-To: <6ed0b2680811070136m44b385cftf654c05cd9076798@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

> +static int hsmmc2_set_power(struct device *dev, int slot, int power_on, int vdd)
> +{
> +	int ret;
> +
> +	struct hsmmc_controller *c = &hsmmc[1];
> +
> +	if (power_on) {
> +		u32 reg;
> +
> +		reg = omap_ctrl_readl(c->control_devconf_offset);
> +		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
> +		omap_ctrl_writel(reg, c->control_devconf_offset);

This is not correct for pandora, it needs input clock from the
transceiver, not loop back clock. Perhaps this can be controlled by
platform data, or removed altogether and left for the bootloader?
