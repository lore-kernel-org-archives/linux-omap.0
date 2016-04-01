From: santosh shilimkar <santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Fri, 1 Apr 2016 11:15:29 -0700
Message-ID: <56FEBAC1.2040509@oracle.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com>
 <1457594332-7490-3-git-send-email-tqnguyen@apm.com>
 <87mvpgi02f.fsf@intel.com> <56FBDA0D.4030507@ti.com>
 <87egashxz8.fsf@intel.com>
 <CAKrQpSvgTm+OM+ffO4ZKwpb=J3ewKoWYA7ojE+WKBbiYKwdMqw@mail.gmail.com>
 <87k2kjgjjf.fsf@intel.com> <56FD3D2F.8070501@ti.com>
 <871t6pahg8.fsf@intel.com> <56FE4378.3030205@ti.com>
 <87shz58wbw.fsf@intel.com> <56FE54DB.5000201@ti.com>
 <878u0x8ru4.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <878u0x8ru4.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+Arnd, RMK,

On 4/1/2016 4:57 AM, Felipe Balbi wrote:
>
> Hi,
>
> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
>> On 04/01/2016 01:20 PM, Felipe Balbi wrote:

[...]

>> commit 7ace8fc8219e4cbbfd5b4790390d9a01a2541cdf
>> Author: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>> Date:   Mon Jul 13 18:10:05 2015 +0900
>>
>>      usb: gadget: udc: core: Fix argument of dma_map_single for IOMMU
>>
>>      The dma_map_single and dma_unmap_single should set "gadget->dev.parent"
>>      instead of "&gadget->dev" in the first argument because the parent has
>>      a udc controller's device pointer.
>>      Otherwise, iommu functions are not called in ARM environment.
>>
>>      Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>>      Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>
>> Above actually means that DMA configuration code can be dropped from
>> usb_add_gadget_udc_release() completely. Right?:
>
> true, but now I'm not sure what's better: copy all necessary bits from
> parent or just pass the parent device to all DMA API.
>
> Anybody to shed a light here ?
>
The expectation is drivers should pass the proper dev pointers and let 
core DMA code deal with it since it knows the per device dma properties.
RMK did massive series of patches to fix many drivers which were not
adhering to dma APIs.

Regrds,
Santosh

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
