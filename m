From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Thu, 31 Mar 2016 18:07:27 +0300
Message-ID: <56FD3D2F.8070501@ti.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com>
 <1457594332-7490-3-git-send-email-tqnguyen@apm.com>
 <87mvpgi02f.fsf@intel.com> <56FBDA0D.4030507@ti.com>
 <87egashxz8.fsf@intel.com>
 <CAKrQpSvgTm+OM+ffO4ZKwpb=J3ewKoWYA7ojE+WKBbiYKwdMqw@mail.gmail.com>
 <87k2kjgjjf.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k2kjgjjf.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>, "Thang Q. Nguyen" <tqnguyen@apm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches <patches@apm.com>, Santosh Shilimkar <ssantosh@kernel.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
List-Id: linux-omap@vger.kernel.org

On 03/31/2016 11:04 AM, Felipe Balbi wrote:
> "Thang Q. Nguyen" <tqnguyen@apm.com> writes:
>> [ text/plain ]
>> Thanks Grygorii for information.
>> I checked but do not see dma_init_dev_from_parent is used in
>> linux-next repository. Can you give me more information for what
>> branch I can checkout to use it for USB DWC3?
> 
> dma_init_dev_from_parent() is still a proposal ;-)
> 

Felipe,

After some experiments I came up with below fix (not common, but fixes USB
case on keystone 2). if you agree with proposed fix I'll send proper
patches to fix usb_add_gadget_udc_release() and dwc3_host_init() in the same
way.

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index c679f63..3fe1c65 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -17,6 +17,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/usb/xhci_pdriver.h>
+#include <linux/of_device.h>
 
 #include "core.h"
 
@@ -35,8 +36,6 @@ int dwc3_host_init(struct dwc3 *dwc)
        dma_set_coherent_mask(&xhci->dev, dwc->dev->coherent_dma_mask);
 
        xhci->dev.parent        = dwc->dev;
-       xhci->dev.dma_mask      = dwc->dev->dma_mask;
-       xhci->dev.dma_parms     = dwc->dev->dma_parms;
 
        dwc->xhci = xhci;
 
@@ -62,6 +61,12 @@ int dwc3_host_init(struct dwc3 *dwc)
        phy_create_lookup(dwc->usb3_generic_phy, "usb3-phy",
                          dev_name(&xhci->dev));
 
+       if (!dwc->dev->of_node) {
+               xhci->dev.dma_mask      = dwc->dev->dma_mask;
+               xhci->dev.dma_parms     = dwc->dev->dma_parms;
+       } else 
+               of_dma_configure(&xhci->dev, dwc->dev->of_node);
+
        ret = platform_device_add(xhci);
        if (ret) {
                dev_err(dwc->dev, "failed to register xHCI device\n");



-- 
regards,
-grygorii
