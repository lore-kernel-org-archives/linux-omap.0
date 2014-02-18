From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/2] usb: musb: dsps, debugfs files
Date: Tue, 18 Feb 2014 09:30:21 -0800
Message-ID: <20140218173021.GA17368@kroah.com>
References: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
 <1389950556-6453-2-git-send-email-mpa@pengutronix.de>
 <20140218162054.GE9878@saruman.home>
 <20140218165911.GA17486@kroah.com>
 <20140218170335.GC28506@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47058 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbaBRR24 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Feb 2014 12:28:56 -0500
Content-Disposition: inline
In-Reply-To: <20140218170335.GC28506@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Markus Pargmann <mpa@pengutronix.de>, Bin Liu <binmlist@gmail.com>, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, kernel@pengutronix.de

On Tue, Feb 18, 2014 at 11:03:35AM -0600, Felipe Balbi wrote:
> On Tue, Feb 18, 2014 at 08:59:11AM -0800, Greg KH wrote:
> > On Tue, Feb 18, 2014 at 10:20:54AM -0600, Felipe Balbi wrote:
> > > On Fri, Jan 17, 2014 at 10:22:35AM +0100, Markus Pargmann wrote:
> > > > debugfs files to show the contents of important dsps registers.
> > > > 
> > > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > > ---
> > > >  drivers/usb/musb/musb_dsps.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 54 insertions(+)
> > > > 
> > > > diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> > > > index 593d3c9..d0a97d6 100644
> > > > --- a/drivers/usb/musb/musb_dsps.c
> > > > +++ b/drivers/usb/musb/musb_dsps.c
> > > > @@ -46,6 +46,8 @@
> > > >  #include <linux/of_irq.h>
> > > >  #include <linux/usb/of.h>
> > > >  
> > > > +#include <linux/debugfs.h>
> > > > +
> > > >  #include "musb_core.h"
> > > >  
> > > >  static const struct of_device_id musb_dsps_of_match[];
> > > > @@ -137,6 +139,26 @@ struct dsps_glue {
> > > >  	unsigned long last_timer;    /* last timer data for each instance */
> > > >  
> > > >  	struct dsps_context context;
> > > > +	struct debugfs_regset32 regset;
> > > > +	struct dentry *dbgfs_root;
> > > > +};
> > > > +
> > > > +static const struct debugfs_reg32 dsps_musb_regs[] = {
> > > > +	{ "revision",		0x00 },
> > > > +	{ "control",		0x14 },
> > > > +	{ "status",		0x18 },
> > > > +	{ "eoi",		0x24 },
> > > > +	{ "intr0_stat",		0x30 },
> > > > +	{ "intr1_stat",		0x34 },
> > > > +	{ "intr0_set",		0x38 },
> > > > +	{ "intr1_set",		0x3c },
> > > > +	{ "txmode",		0x70 },
> > > > +	{ "rxmode",		0x74 },
> > > > +	{ "autoreq",		0xd0 },
> > > > +	{ "srpfixtime",		0xd4 },
> > > > +	{ "tdown",		0xd8 },
> > > > +	{ "phy_utmi",		0xe0 },
> > > > +	{ "mode",		0xe8 },
> > > >  };
> > > >  
> > > >  static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
> > > > @@ -369,6 +391,30 @@ out:
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glue *glue)
> > > > +{
> > > > +	struct dentry *root;
> > > > +	struct dentry *file;
> > > > +	char buf[128];
> > > > +
> > > > +	sprintf(buf, "%s.dsps", dev_name(musb->controller));
> > > > +	root = debugfs_create_dir(buf, NULL);
> > > > +	if (!root)
> > > 
> > > wrong, you should be using IS_ERR()
> > 
> > !root is fine, IS_ERR() will fail if CONFIG_DEBUGFS is not enabled.
> 
> in that case, files will be created on parent directory right ?

If, for some reason, creating a directory fails and then creating a file
would succeed, yes, that will happen.

> If we pass a ERR_PTR(-ENODEV), otoh, we will try to dereference it in
> __create_file().

No, because -ENODEV will only happen if debugfs is not enabled, so no
dereference will ever happen.

Don't worry about checking return values from debugfs, it shouldn't be
needed.

thanks,

greg k-h
