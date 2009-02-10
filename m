From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: musb OTG broken in 2.6.29-rc3?
Date: Tue, 10 Feb 2009 10:30:36 +0200
Message-ID: <20090210083026.GG3166@scadufax.research.nokia.com>
References: <5e088bd90902090940s3c6de0eqac55e21acd4490bc@mail.gmail.com> <19F8576C6E063C45BE387C64729E739403FA81B5E5@dbde02.ent.ti.com> <5e088bd90902092043u913d35axe658e784d4befb59@mail.gmail.com> <19F8576C6E063C45BE387C64729E739403FA81B610@dbde02.ent.ti.com> <20090210073525.GE3166@scadufax.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23308 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbZBJIov (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 03:44:51 -0500
Content-Disposition: inline
In-Reply-To: <20090210073525.GE3166@scadufax.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Steve Sakoman <sakoman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Tue, Feb 10, 2009 at 08:35:31AM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
> On Tue, Feb 10, 2009 at 05:47:16AM +0100, Ajay Kumar Gupta wrote:
> > > -----Original Message-----
> > > From: Steve Sakoman [mailto:sakoman@gmail.com]
> > > Sent: Tuesday, February 10, 2009 10:13 AM
> > > To: Gupta, Ajay Kumar
> > > Cc: linux-omap
> > > Subject: Re: musb OTG broken in 2.6.29-rc3?
> > >
> > > On Mon, Feb 9, 2009 at 8:05 PM, Gupta, Ajay Kumar <ajay.gupta@ti.com> wrote:
> > >
> > > >> Before I spend too much time debugging, has anyone else been
> > > >> successful with musb OTG in 2.6.29-rc3?  A quick search of this list
> > > >> didn't turn up any discussion of issues.
> > > >
> > > > It works fine on OMAP35x EVM too. I had to add a proc entry for session start
> > > > (Switching on the vBus).
> > >
> > > Could you give me a little more detail on what you had to do for
> > > session start?  Perhaps I have a similar issue on Overo.
> > It is same $ echo "F" >/proc/driver/musb_hdrc, which was earlier
> > In musb_procfs.c and now been removed.
> >
> > +       case 'F':
> > +               reg = musb_readb(mbase, MUSB_DEVCTL);
> > +               reg |= MUSB_DEVCTL_SESSION;
> > +               musb_writeb(mbase, MUSB_DEVCTL, reg);
> 
> a temp sysfs for that will help:
> 
> Steve, could you try the following
> 
> ==== cut here ====
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 2cc34fa..0ffd611 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1713,6 +1713,32 @@ musb_vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR(vbus, 0644, musb_vbus_show, musb_vbus_store);
> 
> +static ssize_t
> +musb_session_store(struct device *dev, struct device_attribute *attr,
> +               const char *buf, size_t n)
> +{
> +       struct musb     *musb = dev_to_musb(dev);
> +       unsigned short  session;
> +       u8              devctl;
> +
> +       if (sscanf(buf, "%hu", &session) != 1
> +                       || (session != 1) || (session != 0)) {

			ugg, this should be &&

here's the updated:

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2cc34fa..1ea7cfa 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1713,6 +1713,32 @@ musb_vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR(vbus, 0644, musb_vbus_show, musb_vbus_store);
 
+static ssize_t
+musb_session_store(struct device *dev, struct device_attribute *attr,
+               const char *buf, size_t n)
+{
+       struct musb     *musb = dev_to_musb(dev);
+       unsigned short  session;
+       u8              devctl;
+
+       if (sscanf(buf, "%hu", &session) != 1
+                       || ((session != 1) && (session != 0))) {
+               dev_err(dev, "value must be 1 on 0\n");
+               return -EINVAL;
+       }
+
+       devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
+       if (session)
+               devctl |= MUSB_DEVCTL_SESSION;
+       else
+               devctl &= ~MUSB_DEVCTL_SESSION;
+
+       musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+
+       return n;
+}
+static DEVICE_ATTR(session, 0644, NULL, musb_session_store);
+
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 
 /* Gadget drivers can't know that a host is connected so they might want
@@ -1813,6 +1839,7 @@ static void musb_free(struct musb *musb)
         */
 
 #ifdef CONFIG_SYSFS
+       device_remove_file(musb->controller, &dev_attr_session);
        device_remove_file(musb->controller, &dev_attr_mode);
        device_remove_file(musb->controller, &dev_attr_vbus);
 #ifdef CONFIG_USB_MUSB_OTG
@@ -2047,6 +2074,7 @@ bad_config:
        }
 
 #ifdef CONFIG_SYSFS
+       status = device_create_file(dev, &dev_attr_session);
        status = device_create_file(dev, &dev_attr_mode);
        status = device_create_file(dev, &dev_attr_vbus);
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
@@ -2061,6 +2089,7 @@ bad_config:
 
 fail2:
 #ifdef CONFIG_SYSFS
+       device_remove_file(musb->controller, &dev_attr_session);
        device_remove_file(musb->controller, &dev_attr_mode);
        device_remove_file(musb->controller, &dev_attr_vbus);
 #ifdef CONFIG_USB_MUSB_OTG

-- 
balbi
