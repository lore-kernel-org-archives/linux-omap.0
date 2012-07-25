From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 01/11] usb: musb: add musb->id to identify core
 instance
Date: Wed, 25 Jul 2012 10:23:28 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EAE5603@DBDE01.ent.ti.com>
References: <1342698367-12978-1-git-send-email-ajay.gupta@ti.com>
 <1342698367-12978-2-git-send-email-ajay.gupta@ti.com>
 <20120725074534.GQ3630@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120725074534.GQ3630-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> On Thu, Jul 19, 2012 at 05:15:57PM +0530, Ajay Kumar Gupta wrote:
> > diff --git a/drivers/usb/musb/musb_core.c
> > b/drivers/usb/musb/musb_core.c index 89d1871..3e09984 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> > @@ -99,6 +99,7 @@
> >  #include <linux/prefetch.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> > +#include <linux/idr.h>
> >
> >  #include "musb_core.h"
> >
> > @@ -114,6 +115,7 @@
> >
> >  #define MUSB_DRIVER_NAME "musb-hdrc"
> >  const char musb_driver_name[] = MUSB_DRIVER_NAME;
> > +static DEFINE_IDA(musb_ida);
> >
> >  MODULE_DESCRIPTION(DRIVER_INFO);
> >  MODULE_AUTHOR(DRIVER_AUTHOR);
> > @@ -130,6 +132,33 @@ static inline struct musb *dev_to_musb(struct
> > device *dev)
> >
> >
> > /*--------------------------------------------------------------------
> > -----*/
> >
> > +int musb_get_id(struct device *dev, gfp_t gfp_mask) {
> > +	int ret;
> > +	int id;
> > +
> > +	ret = ida_pre_get(&musb_ida, gfp_mask);
> > +	if (!ret) {
> > +		dev_err(dev, "failed to reserve resource for id\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret = ida_get_new(&musb_ida, &id);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to allocate a new id\n");
> > +		return ret;
> > +	}
> > +
> > +	return id;
> > +}
> > +
> > +void musb_put_id(struct device *dev, int id) {
> > +
> > +	dev_dbg(dev, "removing id %d\n", id);
> > +	ida_remove(&musb_ida, id);
> > +}
> 
> both of these should be EXPORT_SYMBOL_GPL() for cases when musb and glue are
> compiled as modules.

Sure. I will fix this.

Ajay
> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
