From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/21] ARM: OMAP: McBSP: Prepare for splitting into
	omap1 and omap2 code
Date: Tue, 17 Jun 2008 11:41:54 +0300
Message-ID: <20080617084153.GG13078@atomide.com>
References: <1212802253-17797-4-git-send-email-tony@atomide.com> <1212802253-17797-5-git-send-email-tony@atomide.com> <1212802253-17797-6-git-send-email-tony@atomide.com> <1212802253-17797-7-git-send-email-tony@atomide.com> <1212802253-17797-8-git-send-email-tony@atomide.com> <1212802253-17797-9-git-send-email-tony@atomide.com> <1212802253-17797-10-git-send-email-tony@atomide.com> <1212802253-17797-11-git-send-email-tony@atomide.com> <1212802253-17797-12-git-send-email-tony@atomide.com> <20080614081720.GK32122@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56168 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827AbYFQIlZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 04:41:25 -0400
Content-Disposition: inline
In-Reply-To: <20080614081720.GK32122@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Eduardo Valentin <eduardo.valentin@indt.org.br>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080614 11:17]:
> On Fri, Jun 06, 2008 at 06:30:43PM -0700, Tony Lindgren wrote:
> > +#if defined(CONFIG_OMAP_MCBSP) || defined(CONFIG_OMAP_MCBSP_MODULE)
> > +
> > +static struct platform_device omap_mcbsp_devices[OMAP_MAX_MCBSP_COUNT];
> > +static int mcbsps_configured;
> > +
> > +void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
> > +					int size)
> > +{
> > +	int i;
> > +
> > +	if (size > OMAP_MAX_MCBSP_COUNT) {
> > +		printk(KERN_WARNING "Registered too many McBSPs platform_data."
> > +			" Using maximum (%d) available.\n",
> > +			OMAP_MAX_MCBSP_COUNT);
> > +		size = OMAP_MAX_MCBSP_COUNT;
> > +	}
> > +
> > +	for (i = 0; i < size; i++) {
> > +		struct platform_device *new_mcbsp = &omap_mcbsp_devices[i];
> 
> Any reason this can't use the platform_device_alloc() API rather than
> having a static restriction on the number (coupled with the wastage of
> space for smaller 'size's ?)

I agree, this should be allocated. Eduardo, any comments?

Tony
