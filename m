From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/3 v5] usb: musb: Add support for ti81xx platform
Date: Thu, 9 Feb 2012 11:30:55 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA9317F03C8@DBDE01.ent.ti.com>
References: <1328675212-29693-1-git-send-email-ajay.gupta@ti.com>
 <4F321320.8010709@ti.com> <20120209080822.GR1121@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36291 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755399Ab2BILbB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 06:31:01 -0500
In-Reply-To: <20120209080822.GR1121@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "B, Ravi" <ravibabu@ti.com>

Hi,
> On Wed, Feb 08, 2012 at 11:46:00AM +0530, Shubhrajyoti wrote:
> > On Wednesday 08 February 2012 09:56 AM, Ajay Kumar Gupta wrote:
> > > +static int dsps_musb_init(struct musb *musb) {
> > > +	struct device *dev = musb->controller;
> > > +	struct musb_hdrc_platform_data *plat = dev->platform_data;
> > > +	struct platform_device *pdev = to_platform_device(dev->parent);
> > > +	struct dsps_glue *glue = platform_get_drvdata(pdev);
> > > +	const struct dsps_musb_wrapper *wrp = glue->wrp;
> > > +	struct omap_musb_board_data *data = plat->board_data;
> > > +	void __iomem *reg_base = musb->ctrl_base;
> > > +	u32 rev, val;
> > > +	int status;
> > > +
> > > +	/* mentor core register starts at offset of 0x400 from musb base
> */
> > > +	musb->mregs += wrp->musb_core_offset;
> > > +
> > > +	/* NOP driver needs change if supporting dual instance */
> > > +	usb_nop_xceiv_register();
> > > +	musb->xceiv = otg_get_transceiver();
> > > +	if (!musb->xceiv)
> > > +		return -ENODEV;
> > > +
> > > +	status = pm_runtime_get_sync(dev);
> > > +	if (status < 0) {
> > > +		dev_err(dev, "pm_runtime_get_sync FAILED");
> > > +		goto err0;
> > > +	}
> > So you are doing a get_sync at init and you cut the clocks at exit
> only.
> > Any particular reason for that.

This is a platform glue layer and main io paths are in musb_core.c/musb_host.c
and musb_gadget.c. Host controller driver's bus_suspend/resume are in
musb_host.c.

What specific pm implementation are you looking for?

Ajay
> 
> that's a very good question. We're just adding a brand new file, which
> is clean and stuff... so we might as well start with good PM
> capabilities.
> 
> --
> balbi
