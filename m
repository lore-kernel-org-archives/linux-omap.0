From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v3 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Mon, 4 Apr 2016 09:11:30 -0700
Message-ID: <57029232.1080103@oracle.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com>
 <1457594332-7490-3-git-send-email-tqnguyen@apm.com>
 <87mvpgi02f.fsf@intel.com> <56FBDA0D.4030507@ti.com>
 <87egashxz8.fsf@intel.com>
 <CAKrQpSvgTm+OM+ffO4ZKwpb=J3ewKoWYA7ojE+WKBbiYKwdMqw@mail.gmail.com>
 <87k2kjgjjf.fsf@intel.com> <56FD3D2F.8070501@ti.com>
 <871t6pahg8.fsf@intel.com> <56FE4378.3030205@ti.com>
 <87shz58wbw.fsf@intel.com> <56FE54DB.5000201@ti.com>
 <878u0x8ru4.fsf@intel.com> <56FEBAC1.2040509@oracle.com>
 <87oa9p7url.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87oa9p7url.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Thang Q. Nguyen" <tqnguyen@apm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches <patches@apm.com>, Santosh Shilimkar <ssantosh@kernel.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On 4/3/2016 11:28 PM, Felipe Balbi wrote:
> santosh shilimkar <santosh.shilimkar@oracle.com> writes:
>> +Arnd, RMK,
>>
>> On 4/1/2016 4:57 AM, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>> On 04/01/2016 01:20 PM, Felipe Balbi wrote:
>>
>> [...]
>>
>>>> commit 7ace8fc8219e4cbbfd5b4790390d9a01a2541cdf
>>>> Author: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>> Date:   Mon Jul 13 18:10:05 2015 +0900
>>>>
>>>>       usb: gadget: udc: core: Fix argument of dma_map_single for IOMMU
>>>>
>>>>       The dma_map_single and dma_unmap_single should set "gadget->dev.parent"
>>>>       instead of "&gadget->dev" in the first argument because the parent has
>>>>       a udc controller's device pointer.
>>>>       Otherwise, iommu functions are not called in ARM environment.
>>>>
>>>>       Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>>       Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>>
>>>> Above actually means that DMA configuration code can be dropped from
>>>> usb_add_gadget_udc_release() completely. Right?:
>>>
>>> true, but now I'm not sure what's better: copy all necessary bits from
>>> parent or just pass the parent device to all DMA API.
>>>
>>> Anybody to shed a light here ?
>>>
>> The expectation is drivers should pass the proper dev pointers and let
>> core DMA code deal with it since it knows the per device dma properties.
>
> okay, so how do you get proper DMA pointers with something like this:
>
> 	kdwc3_dma_mask = dma_get_mask(dev);
> 	dev->dma_mask = &kdwc3_dma_mask;
>
> This doesn't anything.
>
Drivers actually needs to touch dma_mask(s) only if the core DMA
code hasn't populated it it. I see Grygorii pointed out couple
of things already.

Reagrds,
Santosh
