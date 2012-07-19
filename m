From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v3 07/11] usb: otg: nop: add dt support
Date: Thu, 19 Jul 2012 10:09:02 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EADDA97@DBDE01.ent.ti.com>
References: <1342676499-32507-1-git-send-email-ajay.gupta@ti.com>
	<1342676499-32507-8-git-send-email-ajay.gupta@ti.com>
 <CAAe_U6+Sn3wQ2bL22rLyP++=Fe7GadQcqCJx3icBOC1zO04e0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41383 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab2GSKJP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 06:09:15 -0400
In-Reply-To: <CAAe_U6+Sn3wQ2bL22rLyP++=Fe7GadQcqCJx3icBOC1zO04e0w@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>

Hi,
> > Added device tree support for nop transceiver driver and updated the
> > Documentation with device tree binding information for am33xx platform.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > ---
> >  .../devicetree/bindings/usb/am33xx-usb.txt         |    3 +++
> >  drivers/usb/otg/nop-usb-xceiv.c                    |   12 ++++++++++++
> >  2 files changed, 15 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> > index ca8fa56..9782585 100644
> > --- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> > +++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> > @@ -12,3 +12,6 @@ AM33XX MUSB GLUE
> >     represents PERIPHERAL.
> >   - power : Should be "250". This signifies the controller can supply upto
> >     500mA when operating in host mode.
> > +
> > +NOP USB PHY
> > + - compatible : Should be "nop-xceiv-usb"
> > diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-
> xceiv.c
> > index 2e5e889..102e7d8 100644
> > --- a/drivers/usb/otg/nop-usb-xceiv.c
> > +++ b/drivers/usb/otg/nop-usb-xceiv.c
> > @@ -27,6 +27,7 @@
> >   */
> >
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/usb/otg.h>
> > @@ -152,12 +153,23 @@ static int __devexit nop_usb_xceiv_remove(struct
> platform_device *pdev)
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id nop_xceiv_id_table[] = {
> > +       { .compatible = "nop-xceiv-usb" },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, nop_xceiv_id_table);
> > +#else
> > +#define nop_xceiv_id_table NULL
> > +#endif
> 
> The *#else* part is not needed as your *of_match_ptr* will take care of it.

Ok, I will update this.

Ajay
> 
> > +
> >  static struct platform_driver nop_usb_xceiv_driver = {
> >         .probe          = nop_usb_xceiv_probe,
> >         .remove         = __devexit_p(nop_usb_xceiv_remove),
> >         .driver         = {
> >                 .name   = "nop_usb_xceiv",
> >                 .owner  = THIS_MODULE,
> > +               .of_match_table = of_match_ptr(nop_xceiv_id_table),
> >         },
> >  };
> 
> Thanks
> Kishon
