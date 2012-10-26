From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2 1/2] USB: dwc3-exynos: Add support for device tree
Date: Fri, 26 Oct 2012 13:44:38 +0200
Message-ID: <508A77A6.3080402@ti.com>
References: <1350377157-28465-1-git-send-email-gautam.vivek@samsung.com> <1350377157-28465-2-git-send-email-gautam.vivek@samsung.com> <20121016095333.GD5548@arwen.pp.htv.fi> <507D31B3.40707@ti.com> <20121016100838.GC17416@arwen.pp.htv.fi> <CAFp+6iG1SuJ=wO61=D_pTdRzkM+t62mN3b7=3cZiom8tigyaBQ@mail.gmail.com> <20121026081344.GC23501@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40347 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364Ab2JZLoz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 07:44:55 -0400
In-Reply-To: <20121026081344.GC23501@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Vivek Gautam <gautamvivek1987@gmail.com>, rob.herring@calxeda.com, kishon <kishon@ti.com>, av.tikhomirov@samsung.com, gregkh@linuxfoundation.org, devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org, Vivek Gautam <gautam.vivek@samsung.com>, linux-omap@vger.kernel.org

Hi Felipe,

On 10/26/2012 10:13 AM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Oct 25, 2012 at 11:37:33AM +0530, Vivek Gautam wrote:
>> Hi,
>>
>> On Tue, Oct 16, 2012 at 3:38 PM, Felipe Balbi <balbi@ti.com> wrote:
>>> Hi,
>>>
>>> On Tue, Oct 16, 2012 at 03:36:43PM +0530, kishon wrote:
>>>> Hi,
>>>>
>>>> On Tuesday 16 October 2012 03:23 PM, Felipe Balbi wrote:
>>>>> On Tue, Oct 16, 2012 at 02:15:56PM +0530, Vivek Gautam wrote:
>>>>>> This patch adds support to parse probe data for
>>>>>> dwc3-exynos driver using device tree.
>>>>>>
>>>>>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>>>>>> ---
>>>>>>  drivers/usb/dwc3/dwc3-exynos.c |   20 ++++++++++++++++++++
>>>>>>  1 files changed, 20 insertions(+), 0 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
>>>>>> index ca65978..d11ef49 100644
>>>>>> --- a/drivers/usb/dwc3/dwc3-exynos.c
>>>>>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
>>>>>> @@ -21,6 +21,7 @@
>>>>>>  #include <linux/clk.h>
>>>>>>  #include <linux/usb/otg.h>
>>>>>>  #include <linux/usb/nop-usb-xceiv.h>
>>>>>> +#include <linux/of.h>
>>>>>>
>>>>>>  #include "core.h"
>>>>>>
>>>>>> @@ -87,6 +88,8 @@ err1:
>>>>>>    return ret;
>>>>>>  }
>>>>>>
>>>>>> +static u64 dwc3_exynos_dma_mask = DMA_BIT_MASK(32);
>>>>>> +
>>>>>>  static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
>>>>>>  {
>>>>>>    struct dwc3_exynos_data *pdata = pdev->dev.platform_data;
>>>>>> @@ -103,6 +106,14 @@ static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
>>>>>>            goto err0;
>>>>>>    }
>>>>>>
>>>>>> +   /*
>>>>>> +    * Right now device-tree probed devices don't get dma_mask set.
>>>>>> +    * Since shared usb code relies on it, set it here for now.
>>>>>> +    * Once we move to full device tree support this will vanish off.
>>>>>> +    */
>>>>>> +   if (!pdev->dev.dma_mask)
>>>>>> +           pdev->dev.dma_mask = &dwc3_exynos_dma_mask;
>>>>>
>>>>> says who ?
>>>>>
>>>>> $ git grep -e dma_mask drivers/of/
>>>>> drivers/of/platform.c:  dev->dev.dma_mask = &dev->archdata.dma_mask;
>>>>> drivers/of/platform.c:  dev->archdata.dma_mask = 0xffffffffUL;
>>>>> drivers/of/platform.c:  dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>>>>> drivers/of/platform.c:  dev->dev.coherent_dma_mask = ~0;
>>>>> drivers/of/platform.c:  dev->dma_mask = ~0;
>>>>>
>>>>> -ECONFUSED
>>>>
>>>> dma_mask is set under some ifdef except for "dev->dma_mask = ~0;".
>>>> However I agree with you for coherent_dma_mask case.
>>>
>>> indeed. Should we try to patch that instead ?
>>>
>>> Rob, should we set dma_mask at the driver or do you have a nicer way to
>>> handle it ??
>>>
>> Can i have suggestions here please ? :)
> 
> Benoit, can you answer here since nobody else does ?

Well, I wish I could, but honestly I don't have a clue :-(

Benoit


