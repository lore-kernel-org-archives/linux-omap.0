From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/3 v5] usb: musb: Add support for ti81xx platform
Date: Mon, 13 Feb 2012 07:05:16 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA9317F7187@DBDE01.ent.ti.com>
References: <1328675212-29693-1-git-send-email-ajay.gupta@ti.com>
 <4F321320.8010709@ti.com> <20120209080822.GR1121@legolas.emea.dhcp.ti.com>
 <47CEF8C4B26E8C44B22B028A650E0EA9317F03C8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA9317F03C8-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> > On Wed, Feb 08, 2012 at 11:46:00AM +0530, Shubhrajyoti wrote:
> > > On Wednesday 08 February 2012 09:56 AM, Ajay Kumar Gupta wrote:
> > > > +static int dsps_musb_init(struct musb *musb) {
> > > > +	struct device *dev = musb->controller;
> > > > +	struct musb_hdrc_platform_data *plat = dev->platform_data;
> > > > +	struct platform_device *pdev = to_platform_device(dev-
> >parent);
> > > > +	struct dsps_glue *glue = platform_get_drvdata(pdev);
> > > > +	const struct dsps_musb_wrapper *wrp = glue->wrp;
> > > > +	struct omap_musb_board_data *data = plat->board_data;
> > > > +	void __iomem *reg_base = musb->ctrl_base;
> > > > +	u32 rev, val;
> > > > +	int status;
> > > > +
> > > > +	/* mentor core register starts at offset of 0x400 from musb
> base
> > */
> > > > +	musb->mregs += wrp->musb_core_offset;
> > > > +
> > > > +	/* NOP driver needs change if supporting dual instance */
> > > > +	usb_nop_xceiv_register();
> > > > +	musb->xceiv = otg_get_transceiver();
> > > > +	if (!musb->xceiv)
> > > > +		return -ENODEV;
> > > > +
> > > > +	status = pm_runtime_get_sync(dev);
> > > > +	if (status < 0) {
> > > > +		dev_err(dev, "pm_runtime_get_sync FAILED");
> > > > +		goto err0;
> > > > +	}
> > > So you are doing a get_sync at init and you cut the clocks at exit
> > only.
> > > Any particular reason for that.
> 
> This is a platform glue layer and main io paths are in
> musb_core.c/musb_host.c
> and musb_gadget.c. Host controller driver's bus_suspend/resume are in
> musb_host.c.
> 
> What specific pm implementation are you looking for?

The current patch calls pm_runtime_get_sync() for musb "device" and that
is anyway getting done in common core file musb_core.c.

Glue layer file need to call pm_runtime_get_sync() and x_put() for glue
"device" during init and exit.

I will resubmit this patch with above change.

Ajay

> 
> Ajay
> >
> > that's a very good question. We're just adding a brand new file, which
> > is clean and stuff... so we might as well start with good PM
> > capabilities.
> >
> > --
> > balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
