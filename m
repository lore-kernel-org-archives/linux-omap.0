From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Sat, 21 May 2016 10:29:40 +0800
Message-ID: <20160521022940.GA15088@shlinux2>
References: <20160516092323.GD24609@shlinux2.ap.freescale.net>
 <57399839.90706@ti.com>
 <AM4PR04MB2130E149700361CBA3F6863389480@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573AD198.6030307@ti.com>
 <AM4PR04MB2130EF68F7ADD64607C6CD4389480@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573C6347.6080705@ti.com>
 <AM4PR04MB2130145869480748D06FE6E589490@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573C719F.5010107@ti.com>
 <AM4PR04MB2130926F9AE8EBFC0D19447689490@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573D6C1C.4090600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <573D6C1C.4090600-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org" <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "nsekhar-l0cyMroinI0@public.gmane.org" <nsekhar-l0cyMroinI0@public.gmane.org>, "b-liu-l0cyMroinI0@public.gmane.org" <b-liu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-fy+rA21nqHI@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 19, 2016 at 10:32:44AM +0300, Roger Quadros wrote:
> On 18/05/16 17:46, Jun Li wrote:
> > 
> > 
> >>>>
> >>>> I didn't want to have complex Kconfig so decided to have otg as
> >>>> built-in only.
> >>>> What do you want me to change in existing code? and why?
> >>>
> >>> Remove those stuff which only for pass diff driver config Like every
> >>> controller driver need a duplicated
> >>>
> >>> static struct otg_hcd_ops ci_hcd_ops = {
> >>>     ...
> >>> }
> >>
> >> This is an exception only. Every controller driver doesn't need to
> >> implement hcd_ops. It is implemented in the hcd core.
> >>
> >>>
> >>> And here is another example, for gadget connect, otg driver can
> >>> directly call to usb_udc_vbus_handler() in drd state machine, but you
> >>> create another interface:
> >>>
> >>> .connect_control = usb_gadget_connect_control,
> >>>
> >>> If the symbol is defined in one driver which is 'm', another driver
> >>> reference it should be 'm' as well, then there is no this kind of
> >>> problem as my understanding.
> >>
> >> That is fine as long as all are 'm'. but how do you solve the case when
> >> Gadget is built in and host is 'm'? OTG has to be built-in and you will
> >> need an hcd to gadget interface.
> > 
> > Hcd to gadget interface? Or you want to say otg to host interface?
> 
> Sorry, I meant to say host to otg interface.
> 
> > 
> > I think hcd and gadget are independent each other, now
> > 
> > Hcd --> otg; and gadget --> otg, (hcd and gadget use otg's symbol)
> 
> It is actually a circular dependency for both.
>  hcd <--> otg and gadget <--> otg
> 
> hcd -> otg for usb_otg_register/unregister_hcd
> otg -> hcd for usb_add/remove_hcd, usb_bus_start_enum, usb_control_msg, usb_hub_find_child
> 
> gadget -> otg for usb_otg_register/unregister_gadget
> otg -> gadget for usb_gadget_start/stop, usb_udc_vbus_handler
> 
> Now consider what will happen if I get rid of the otg_hcd and otg_gadget interfaces.
> 'y' means built-in, 'm' means module.
> 
> 1) hcd 'y', gadget 'y'
> otg has to be 'y' for proper build.
> 
> 2) hcd 'm', gadget 'm'
> otg has to be 'm' for proper build.
> 
> 3) hcd 'y', gadget 'm'
> Build will fail always.
> If otg is 'y', otg build will fail due to dependency on gadget.
> If otg is 'm', hcd build will fail due to dependency on otg.
> 
> 4) hcd 'm', gadget 'y'
> Build will fail always.
> If otg is 'y', otg build will fail due to dependency on hcd.
> If otg is 'm', gadget build will fails due to dependency on otg.
> 
> So I solve this problem by adding the otg_hcd_ops and otg_gadget_ops
> to remove otg->hcd and otg->gadget dependency.
> 
> Now we can address 3) and 4) like so
> 
> 3) hcd 'y', gadget 'm'
> otg has to be 'y' for proper build.
> 
> 4) hcd 'm', gadget 'y'
> otg has to be 'y' for proper build.
> 

How about this:
Moving usb_otg_register/unregister_hcd to host driver to remove
dependency hcd->otg. And moving usb_otg_get_data to common.c.

Delete the wait queue at usb-otg.c, and if calling usb_otg_get_data
returns NULL, the host/device driver's probe return -EPROBE_DEFER.
When the otg driver is probed successfully, the host/device will be
re-probed again, and usb_otg_register_hcd will be called again.

And let OTG depends on HCD && GADGET, and delete otg_hcd_ops and
otg_gadget_ops. Below build dependency issues can be fixed.
What do you think?

> 1) hcd 'y', gadget 'y'
> otg has to be 'y' for proper build.
> 
> 2) hcd 'm', gadget 'm'
> otg has to be 'm' for proper build.
> 
> 3) hcd 'y', gadget 'm'
> Build will fail always.
> If otg is 'y', otg build will fail due to dependency on gadget.
> If otg is 'm', hcd build will fail due to dependency on otg.
> 
> 4) hcd 'm', gadget 'y'
> Build will fail always.
> If otg is 'y', otg build will fail due to dependency on hcd.
> If otg is 'm', gadget build will fails due to dependency on otg.
-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
