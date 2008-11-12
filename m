From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Wed, 12 Nov 2008 14:11:28 -0800
Message-ID: <20081112221127.GZ3984@atomide.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <20081106170445.GU21736@atomide.com> <6ed0b2680811061219p40439337h2a6938009aa20522@mail.gmail.com> <200811062154.08843.david-b@pacbell.net> <6ed0b2680811070136m44b385cftf654c05cd9076798@mail.gmail.com> <6ed0b2680811100236m203939c9u521d2e1edea40f91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50507 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbYKLWLb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 17:11:31 -0500
Content-Disposition: inline
In-Reply-To: <6ed0b2680811100236m203939c9u521d2e1edea40f91@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [081110 02:37]:
> > +static int hsmmc2_set_power(struct device *dev, int slot, int power_on, int vdd)
> > +{
> > +	int ret;
> > +
> > +	struct hsmmc_controller *c = &hsmmc[1];
> > +
> > +	if (power_on) {
> > +		u32 reg;
> > +
> > +		reg = omap_ctrl_readl(c->control_devconf_offset);
> > +		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
> > +		omap_ctrl_writel(reg, c->control_devconf_offset);
> 
> This is not correct for pandora, it needs input clock from the
> transceiver, not loop back clock. Perhaps this can be controlled by
> platform data, or removed altogether and left for the bootloader?

Let's just pass that with the twl4030_hsmmc_info. Having the
bootloader initialize things adds unnecessary dependencies between
the kernel and bootloader version. Can you send a patch please?

Regards,

Tony
