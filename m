From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v9 08/14] usb: otg: add OTG/dual-role core
Date: Sun, 12 Jun 2016 18:56:27 +0800
Message-ID: <20160612105627.GA32615@shlinux2>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-9-git-send-email-rogerq@ti.com>
 <20160608095336.GA4444@shlinux2>
 <5757EF7A.20604@ti.com>
 <20160608124204.GB10029@shlinux2>
 <575919BC.8080003@ti.com>
 <20160612062617.GC22054@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160612062617.GC22054@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Jun 12, 2016 at 02:26:17PM +0800, Peter Chen wrote:
> On Thu, Jun 09, 2016 at 10:24:44AM +0300, Roger Quadros wrote:
> > On 08/06/16 15:42, Peter Chen wrote:
> > > On Wed, Jun 08, 2016 at 01:12:10PM +0300, Roger Quadros wrote:
> > >> Hi,
> > >>
> > >> On 08/06/16 12:53, Peter Chen wrote:
> > >>> On Wed, Jun 08, 2016 at 12:03:40PM +0300, Roger Quadros wrote:
> > >>>> +int usb_otg_unregister(struct device *dev)
> > >>>> +{
> > >>>> +	struct usb_otg *otg;
> > >>>> +
> > >>>> +	mutex_lock(&otg_list_mutex);
> > >>>> +	otg = usb_otg_get_data(dev);
> > >>>> +	if (!otg) {
> > >>>> +		dev_err(dev, "otg: %s: device not in otg list\n",
> > >>>> +			__func__);
> > >>>> +		mutex_unlock(&otg_list_mutex);
> > >>>> +		return -EINVAL;
> > >>>> +	}
> > >>>> +
> > >>>> +	/* prevent unregister till both host & gadget have unregistered */
> > >>>> +	if (otg->host || otg->gadget) {
> > >>>> +		dev_err(dev, "otg: %s: host/gadget still registered\n",
> > >>>> +			__func__);
> > >>>
> > >>> You need to call mutex_unlock here
> > >>
> > >> Indeed. good catch.
> > >>>
> > >>>> +
> > >>>> +int usb_otg_gadget_ready(struct usb_gadget *gadget, bool ready)
> > >>>> +{
> > >>>
> > >>> What this API is for? Why need it in this version?
> > >>
> > >> we moved gadget to otg registration from udc_bind_to_driver() to usb_add_gadget_udc_release().
> > >> This means there is a window when gadget function driver (e.g. g_zero) is not loaded.
> > >> We don't want to start the gadget controller in that window.
> > >>
> > >> usb_otg_gadget_ready() is used by gadget core to notify the otg core when the function driver
> > >> is ready or not-ready.
> > >>
> > > 
> > > Why you need to move this from gadget's probe to udc's probe? Currently,
> > > the sequence of gadget and udc's probe is random, but udc_bind_to_driver
> > > is called when udc is ready.
> > > 
> > Because we need to support -EPROBE_DEFER at udc probe.
> > At udc_bind_to_driver there is no scope for -EPROBE_DEFER.
> > 
> 
> Why udc_bind_to_driver can't return -EPROBE_DEFER if register to OTG is
> failed?
> 
> > Another issue is that we need to register with otg and have otg->caps available
> > before driver->bind() is called in udc_bind_to_driver(). Else gadget function
> > will not have the correct OTG descriptor.
> > 
> 
> You can do register before calling driver->bind.
> 

Please skip my comments, I understand your changes now.

-- 

Best Regards,
Peter Chen
