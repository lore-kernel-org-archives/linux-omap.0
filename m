From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Fri, 1 Apr 2016 14:00:43 +0300
Message-ID: <56FE54DB.5000201@ti.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com>
 <1457594332-7490-3-git-send-email-tqnguyen@apm.com>
 <87mvpgi02f.fsf@intel.com> <56FBDA0D.4030507@ti.com>
 <87egashxz8.fsf@intel.com>
 <CAKrQpSvgTm+OM+ffO4ZKwpb=J3ewKoWYA7ojE+WKBbiYKwdMqw@mail.gmail.com>
 <87k2kjgjjf.fsf@intel.com> <56FD3D2F.8070501@ti.com>
 <871t6pahg8.fsf@intel.com> <56FE4378.3030205@ti.com>
 <87shz58wbw.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87shz58wbw.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/01/2016 01:20 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
>>> if of_dma_configure() does what you want, why don't you just stick it in
>>> dwc3-keystone.c and let the driver continue to copy things for now ?
>>> Something like below, perhaps ?
>>>
>>
>> I know (and i have patch to fix that which I'm going to send) that DMA config
>>   in dwc3-keystone.c is not correct and we are good till now just
>> because dwc3_keystone is not used for DMA operations directly.
>>
>> Now about xhci and friends:
>> dwc3_keystone *is created* from DT : of_platform_device_create() -> of_platform_device_create_pdata() -> of_dma_configure()
>> |- dwc3 *is created* from DT : of_platform_device_create() -> of_platform_device_create_pdata() -> of_dma_configure()
>>     |- [1] *creates* xhci dev manually : DMA configuration copied manually in dwc3_host_init()
>>     |- [2] *creates* usb_gadget dev manually: DMA configuration copied manually in usb_add_gadget_udc_release()
>>     |- *creates* usb_udc dev manually : not used for DMA operations directly (as I've checked)
>>
>> Now cases [1] & [2] introduces failures, because DMA configuration is not complete for
>> these devices.
> 
> right, then we just copy whatever's missing, right ? Until there's a
> generic way of copying these bits, I want to avoid introducing any of_*
> specific methodologies and prefer to have the manual copy.

Sry, I've found no other way (right now) to fix it, except by using of_dma_configure()
which will do all work in DT case (including calling of arch specific callbacks).
[it might be unsafe to just copy archdata, for example, as it might(will for arm)
 contain pointers] 

> 
>> I can confirm that if I fix [1] & [2] as above USB Device/Dual modes will start
>> working on K2E.

Above is for 4.1 kernel

> 
> cool, I'd be happy to take both patches ;-)
> 

ok. And seems gadget case is fixed already
commit 7ace8fc8219e4cbbfd5b4790390d9a01a2541cdf
Author: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Date:   Mon Jul 13 18:10:05 2015 +0900

    usb: gadget: udc: core: Fix argument of dma_map_single for IOMMU
    
    The dma_map_single and dma_unmap_single should set "gadget->dev.parent"
    instead of "&gadget->dev" in the first argument because the parent has
    a udc controller's device pointer.
    Otherwise, iommu functions are not called in ARM environment.
    
    Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
    Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Above actually means that DMA configuration code can be dropped from
usb_add_gadget_udc_release() completely. Right?:

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 4151597..e4e70e1 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -371,12 +371,6 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
        INIT_WORK(&gadget->work, usb_gadget_state_work);
        gadget->dev.parent = parent;
 
-#ifdef CONFIG_HAS_DMA
-       dma_set_coherent_mask(&gadget->dev, parent->coherent_dma_mask);
-       gadget->dev.dma_parms = parent->dma_parms;
-       gadget->dev.dma_mask = parent->dma_mask;
-#endif
