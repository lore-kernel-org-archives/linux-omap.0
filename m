From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 64/67] phy-generic.c:undefined reference
 to `usb_gadget_vbus_connect'
Date: Wed, 8 Jun 2016 20:25:11 +0800
Message-ID: <20160608122511.GA10029@shlinux2>
References: <87bn3ecwbz.fsf@linux.intel.com>
 <878tyicva6.fsf@linux.intel.com>
 <20160607015405.GB17095@shlinux2>
 <87wpm1basy.fsf@linux.intel.com>
 <20160607095008.GC17095@shlinux2>
 <87inxlb8nm.fsf@linux.intel.com>
 <20160608031732.GA5309@shlinux2>
 <87shwo9fge.fsf@linux.intel.com>
 <20160608101428.GA7653@shlinux2>
 <87bn3c9dj6.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87bn3c9dj6.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Chen <Peter.Chen-3arQi8VN3Tc@public.gmane.org>, John Youn <johnyoun-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 08, 2016 at 01:32:29PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> >> > Would you consider only keeps vbus and pull dp API at gadget.h, and move
> >> > out others gadget APIs which is dedicated for gadget function?
> >> 
> >> no, sorry :-) All these drivers depend on the gadget API to work. For
> >> host-only builds, they'll still work because of the stub implemented in
> >> gadget.h.
> >
> > Do you want these drivers to add dependency on GADGET at Kconfig
> > or not? If you want, we don't need stub at gadget.h since the gadget
> 
> just look at what the patch does:
> 
> if USB_GADGET=m, then NOP must be m too. if USB_GADGET=y, then NOP can
> be y or m.
> 
> > will be built if these driver is built. I assume you don't want, then
> > that's ok, we don't need to change anything on Kconfig to fix build
> > issue.
> 
> There was, anyway, a bug in my original patch in that it didn't provide
> stubs for cases were USB_GADGET=n. That bug is now fixed, I'll still
> wait a couple days for any 0-day build problems.
> 
> >> Also, did you test the version I've apended to previous email? I noticed
> >> that had one extra mistake which I correct in the version below:
> >> 
> >
> > Sorry, I did not try since I still have some questions for solution:)
> 
> heh. You're not even willing to try a patch, rather than complaining
> about pointless stuff all day. Thanks
> 

The reason why I did not try your patch is: I don't think the PHY needs
to depend on GADGET since your 1st patch like below:

+       depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
+       depends on NOP_USB_XCEIV

But look at your the newest patch, you have fixed it like below:
+ 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, NOP can't be
built-in

I agree with that since PHY can not depend on GADGET if it does not use
gadget APIs.

After trying your patch, you only fixed NOP PHY build issue (chipidea
build issue is fixed too), but without for other code. You may need to
fix all like my last grep:

b29397@shlinux2:~/work/projects/usb$ find . -name *.c | xargs grep -rn "usb_gadget_vbus_connect"
./drivers/phy/phy-twl4030-usb.c:559:		 * REVISIT usb_gadget_vbus_connect(...) as needed, ditto
./drivers/usb/phy/phy-gpio-vbus-usb.c:126:		usb_gadget_vbus_connect(gpio_vbus->phy.otg->gadget);
./drivers/usb/phy/phy-tahvo.c:89:				usb_gadget_vbus_connect(tu->phy.otg->gadget);
./drivers/usb/phy/phy-isp1301-omap.c:929:	usb_gadget_vbus_connect(isp->phy.otg->gadget);
./drivers/usb/phy/phy-isp1301-omap.c:1466:		usb_gadget_vbus_connect(otg->gadget);
./drivers/usb/phy/phy-generic.c:122:			usb_gadget_vbus_connect(otg->gadget);
./drivers/usb/phy/phy-generic.c:190:		usb_gadget_vbus_connect(gadget);
./drivers/usb/phy/phy-msm-usb.c:783:		usb_gadget_vbus_connect(phy->otg->gadget);
./drivers/usb/phy/phy-mv-usb.c:234:		usb_gadget_vbus_connect(otg->gadget);
./drivers/usb/chipidea/otg.c:133:		usb_gadget_vbus_connect(&ci->gadget);
./drivers/usb/chipidea/otg.c:138:		usb_gadget_vbus_connect(&ci->gadget);
./drivers/usb/chipidea/udc.c:1964:		usb_gadget_vbus_connect(&ci->gadget);
./drivers/usb/chipidea/otg_fsm.c:567:		usb_gadget_vbus_connect(&ci->gadget);
b29397@shlinux2:~/work/projects/usb$ find . -name *.c | xargs grep -rn "usb_gadget_vbus_disconnect"
./drivers/usb/phy/phy-gpio-vbus-usb.c:145:		usb_gadget_vbus_disconnect(gpio_vbus->phy.otg->gadget);
./drivers/usb/phy/phy-gpio-vbus-usb.c:200:		usb_gadget_vbus_disconnect(otg->gadget);
./drivers/usb/phy/phy-tahvo.c:108:				usb_gadget_vbus_disconnect(tu->phy.otg->gadget);
./drivers/usb/phy/phy-tahvo.c:165:		usb_gadget_vbus_disconnect(tu->phy.otg->gadget);
./drivers/usb/phy/phy-tahvo.c:175:		usb_gadget_vbus_disconnect(tu->phy.otg->gadget);
./drivers/usb/phy/phy-isp1301-omap.c:312:	return usb_gadget_vbus_disconnect(isp->phy.otg->gadget);
./drivers/usb/phy/phy-isp1301-omap.c:989:				usb_gadget_vbus_disconnect(otg->gadget);
./drivers/usb/phy/phy-isp1301-omap.c:1342:		usb_gadget_vbus_disconnect(otg->gadget);
./drivers/usb/phy/phy-generic.c:133:			usb_gadget_vbus_disconnect(otg->gadget);
./drivers/usb/phy/phy-fsl-usb.c:622:		usb_gadget_vbus_disconnect(otg->gadget);
./drivers/usb/phy/phy-msm-usb.c:786:		usb_gadget_vbus_disconnect(phy->otg->gadget);
./drivers/usb/phy/phy-mv-usb.c:236:		usb_gadget_vbus_disconnect(otg->gadget);
./drivers/usb/chipidea/otg.c:140:		usb_gadget_vbus_disconnect(&ci->gadget);
./drivers/usb/chipidea/otg_fsm.c:569:		usb_gadget_vbus_disconnect(&ci->gadget);
b29397@shlinux2:~/work/projects/usb$ find . -name *.c | xargs grep -rn "usb_gadget_connect"
./drivers/power/isp1704_charger.c:272:				usb_gadget_connect(isp->phy->otg->gadget);
./drivers/usb/gadget/udc/fsl_udc_core.c:1215: * this func is used by usb_gadget_connect/disconnet
./drivers/usb/gadget/udc/udc-core.c:262:		usb_gadget_connect(udc->gadget);
./drivers/usb/gadget/udc/udc-core.c:671:		usb_gadget_connect(udc->gadget);
./drivers/usb/chipidea/udc.c:1593: * this func is used by usb_gadget_connect/disconnet
b29397@shlinux2:~/work/projects/usb$ find . -name *.c | xargs grep -rn "usb_gadget_disconnect"
./drivers/power/isp1704_charger.c:302:			usb_gadget_disconnect(isp->phy->otg->gadget);
./drivers/power/isp1704_charger.c:504:		usb_gadget_disconnect(isp->phy->otg->gadget);
./drivers/usb/gadget/udc/udc-core.c:264:		usb_gadget_disconnect(udc->gadget);
./drivers/usb/gadget/udc/udc-core.c:502:	usb_gadget_disconnect(udc->gadget);
./drivers/usb/gadget/udc/udc-core.c:673:		usb_gadget_disconnect(udc->gadget);
./drivers/usb/gadget/composite.c:974: * Drivers must call usb_gadget_disconnect before calling this function
./drivers/usb/gadget/composite.c:2296: * the host, unless one of its components invokes usb_gadget_disconnect()

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
